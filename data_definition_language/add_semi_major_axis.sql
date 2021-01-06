ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;

-- Further Exploration:
-- If we add a column with a NOT NULL constraint to a table that already holds data
-- an error will occur because all the preexisting values will have NULL for the
-- new column.

-- To fix this I would add the column with the NOT NULL constraint AND a 
-- default of 0. That way all existing rows will automatically be given a 
-- semi_major_axis of 0.
ALTER TABLE planets ADD COLUMN semi_major_axis numeric NOT NULL DEFAULT 0;