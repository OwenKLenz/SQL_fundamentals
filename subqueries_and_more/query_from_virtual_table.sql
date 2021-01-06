SELECT max(count)
FROM (SELECT count(id) FROM bids GROUP BY bidder_id) AS bids_for_each_bidder;
