SELECT DISTINCT customers.* FROM customers
  LEFT OUTER JOIN customers_services
    ON customers.id = customers_services.customer_id
  WHERE customers_services.service_id IS NULL;

-- Further Exploration:
SELECT customers.*, services.* FROM customers
  LEFT OUTER JOIN customers_services
    ON customers.id = customers_services.customer_id
  FULL OUTER JOIN services
    ON customers_services.service_id = services.id
  WHERE customers.id IS NULL OR services.id IS NULL;