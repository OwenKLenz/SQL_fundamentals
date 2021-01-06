-- Initial Attempt:
SELECT items.name, count(bids.bidder_id)
FROM items LEFT OUTER JOIN bids ON bids.item_id = items.id
GROUP BY items.id
ORDER BY items.id;

-- With scalar subquery:
SELECT name, (SELECT count(item_id) FROM bids WHERE bids.item_id = items.id) FROM items;