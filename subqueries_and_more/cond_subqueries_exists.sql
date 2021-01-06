SELECT name FROM bidders
WHERE EXISTS (SELECT bidder_id FROM bids WHERE bidder_id = bidders.id);

-- Further Exploration:
SELECT DISTINCT bidders.name FROM bidders JOIN bids ON bids.bidder_id = bidders.id ORDER BY bidders.id;

--       name       
-- -----------------
--  Alan Parker
--  James Quinn
--  Gwen Miller
--  Alison Walker
--  Alexis Jones
--  Taylor Williams