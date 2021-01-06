UPDATE parts
SET device_id = 1
WHERE id IN (7, 8);

-- Further Exploration:
UPDATE parts SET device_id = 2 
WHERE part_number IN (SELECT MIN(part_number) from parts);