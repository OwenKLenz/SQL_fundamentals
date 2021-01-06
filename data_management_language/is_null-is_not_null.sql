SELECT part_number, device_id FROM parts
WHERE device_id IS NOT NULL;

SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;