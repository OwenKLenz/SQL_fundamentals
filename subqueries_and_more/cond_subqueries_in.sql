SELECT name AS "Bid on items"
  FROM items WHERE items.id IN 
    (SELECT item_id FROM bids);
