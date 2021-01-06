INSERT INTO devices (name) VALUES ('Holy Hand Grenade of Antioch');
INSERT INTO parts (part_number, device_id) VALUES (43, 3);

SELECT name FROM devices
ORDER BY created_at
LIMIT 1;
--      name
-- ---------------
--  Accelerometer
-- (1 row)