SELECT devices.name, count(parts.id) AS num_parts
  FROM devices INNER JOIN parts
  ON parts.device_id = devices.id GROUP BY devices.id;
