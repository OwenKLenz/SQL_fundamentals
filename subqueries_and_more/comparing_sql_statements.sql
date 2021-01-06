EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
                  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
--                                                   QUERY PLAN                                                   
-- ---------------------------------------------------------------------------------------------------------------
--  Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.086..0.087 rows=1 loops=1)
--    ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.070..0.078 rows=6 loops=1)
--          Group Key: bids.bidder_id
--          ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.014..0.038 rows=26 loops=1)
--  Planning time: 0.110 ms
--  Execution time: 0.128 ms
-- (6 rows)

EXPLAIN ANALYZE  SELECT COUNT(bidder_id) AS max_bid FROM bids
                 GROUP BY bidder_id
                 ORDER BY max_bid DESC
                 LIMIT 1;
--                                                      QUERY PLAN                                                      
-- ---------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.130..0.132 rows=1 loops=1)
--    ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.124..0.125 rows=1 loops=1)
--          Sort Key: (count(bidder_id)) DESC
--          Sort Method: top-N heapsort  Memory: 25kB
--          ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.070..0.078 rows=6 loops=1)
--                Group Key: bidder_id
--                ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.013..0.037 rows=26 loops=1)
--  Planning time: 0.160 ms
--  Execution time: 0.176 ms
-- (9 rows)

-- The first query that uses a subquery is faster. One reason why is likely the 
-- fact the first query has 2 nodes, to the 2nd queries 3 nodes. More nodes 
-- probably generally = more time to complete.

-- The offending additional node appears to be the node at the top of the tree 
-- involved in sorting. This would come from the ORDER BY statement, which is 
-- an extra step that the first query doesn't use.

-- Removing the order by:

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
                GROUP BY bidder_id
                LIMIT 1;

--                                                                    QUERY PLAN                                                                    
-- -------------------------------------------------------------------------------------------------------------------------------------------------
--  Limit  (cost=0.15..0.55 rows=1 width=12) (actual time=0.029..0.030 rows=1 loops=1)
--    ->  GroupAggregate  (cost=0.15..80.35 rows=200 width=12) (actual time=0.026..0.027 rows=1 loops=1)
--          Group Key: bidder_id
--          ->  Index Only Scan using bidder_id_item_id_idx on bids  (cost=0.15..70.80 rows=1510 width=4) (actual time=0.011..0.017 rows=6 loops=1)
--                Heap Fetches: 6
--  Planning time: 0.109 ms
--  Execution time: 0.062 ms
-- (7 rows)

Results in a generally quicker time, even faster than the first query.

-- Further Exploration:
EXPLAIN ANALYZE SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
--                                                  QUERY PLAN                                                  
-- -------------------------------------------------------------------------------------------------------------
--  Seq Scan on items  (cost=0.00..25455.20 rows=880 width=40) (actual time=0.041..0.157 rows=6 loops=1)
--    SubPlan 1
--      ->  Aggregate  (cost=28.89..28.91 rows=1 width=8) (actual time=0.019..0.020 rows=1 loops=6)
--            ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.004..0.010 rows=4 loops=6)
--                  Filter: (item_id = items.id)
--                  Rows Removed by Filter: 22
--  Planning time: 0.134 ms
--  Execution time: 0.198 ms
-- (8 rows)

EXPLAIN ANALYZE SELECT items.name, count(bids.item_id)
FROM items INNER JOIN bids ON bids.item_id = items.id
GROUP BY items.id;

--                                                      QUERY PLAN                                                      
-- ---------------------------------------------------------------------------------------------------------------------
--  HashAggregate  (cost=66.44..75.24 rows=880 width=44) (actual time=0.186..0.196 rows=5 loops=1)
--    Group Key: items.id
--    ->  Hash Join  (cost=29.80..58.89 rows=1510 width=40) (actual time=0.081..0.154 rows=26 loops=1)
--          Hash Cond: (bids.item_id = items.id)
--          ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.017..0.041 rows=26 loops=1)
--          ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.033..0.034 rows=6 loops=1)
--                Buckets: 1024  Batches: 1  Memory Usage: 9kB
--                ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.010..0.018 rows=6 loops=1)
--  Planning time: 0.268 ms
--  Execution time: 0.358 ms
-- (10 rows)