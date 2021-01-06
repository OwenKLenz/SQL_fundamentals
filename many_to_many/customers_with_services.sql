SELECT customers.*
FROM
  customers INNER JOIN customers_services
    ON customers.id = customers_services.customer_id
  GROUP BY customers.id;

-- Or:

SELECT distinct customers.*
FROM
  customers INNER JOIN customers_services
    ON customers.id = customers_services.customer_id;