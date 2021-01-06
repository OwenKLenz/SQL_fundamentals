SELECT c.name, string_agg(s.description, ', ') AS services
FROM customers c
  LEFT OUTER JOIN customers_services cs
    ON c.id = cs.customer_id
  LEFT JOIN services s
    ON cs.service_id = s.id
  GROUP BY c.name;

-- Further Exploration:
SELECT CASE lag(c.name) OVER (ORDER BY c.name)
         WHEN c.name THEN NULL
         ELSE c.name
       END,
       s.description
FROM customers c
  LEFT OUTER JOIN customers_services cs
    ON c.id = cs.customer_id
  LEFT JOIN services s
    ON cs.service_id = s.id;

-- The lag() window function returns the value of the previous row for the specified column (customers.name in this case).
-- OVER is used to specify the connection between rows that lag() will use to determine the "previous" row.
-- In this case, the connection is the ORDER of names (alphabetic), so lag() will return the value of the (last non-null) name in above it.
-- If (case statement) the lag()ed name matches the current name, we want to display NULL because we've already displayed the name of the customer for their services and we don't want to display it again for their services.
-- If the lag()ed name DOESN'T match, we want to display the name, because we've reached a new customer's services.