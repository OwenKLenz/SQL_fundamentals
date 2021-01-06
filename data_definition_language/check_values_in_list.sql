ALTER TABLE stars
ADD CONSTRAINT valid_spectral_types CHECK (spectral_type SIMILAR TO '[OBAFGKM]'),
ALTER COLUMN spectral_type SET NOT NULL;

-- Further Exploration:
-- Altering the schema with invalid or NULL values in the spectral_type column
-- will raise an error. To avoid this, first change all offending values to a
-- valid value and then make the schema change.

UPDATE stars
  SET spectral_type = 'O'
  WHERE spectral_type NOT IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')
     OR spectral_type IS NULL;