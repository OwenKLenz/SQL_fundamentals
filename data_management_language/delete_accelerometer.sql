-- Redefine the foreign key from the parts table to ON DELETE CASCADE, then 
-- deleting the accelerometer from the devices table will cascade and delete all 
-- rows in the parts table that reference the accelerometer.

ALTER TABLE parts 
DROP CONSTRAINT parts_device_id_fkey;

ALTER TABLE parts 
  ADD CONSTRAINT parts_device_id_fkey 
  FOREIGN KEY (device_id)
    REFERENCES devices(id) ON DELETE CASCADE;

DELETE FROM devices
WHERE name = 'Accelerometer';