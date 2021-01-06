ALTER TABLE stars ALTER COLUMN distance TYPE numeric;

-- Further Exploration:
-- It shouldn't make any difference to change the data type from integer to 
-- numeric with numbers integer values already in the column because integer 
-- values are already valid float numbers. However, if we were to try to alter
-- the column data type from float to integer while there were float values in 
-- the column, we would lose everything to the right of the decimal (all values 
-- get rounded down).