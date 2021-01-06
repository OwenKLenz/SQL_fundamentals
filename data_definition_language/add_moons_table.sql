CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL,
  semi_major_axis INT CHECK (semi_major_axis > 0),
  mass numeric CHECK (mass > 0),
  moon_id integer NOT NULL,
  FOREIGN KEY planet_id REFERENCES planets(id)
);

-- Interesting Note:
-- You can ensure that two moons with the same designation aren't entered for the
-- same planet_id by creating a unique constraint that checks two columns:
ALTER TABLE moons ADD UNIQUE(designation, planet_id);
-- This way each moon will be checked to make sure that no other moon has the
-- same designation + planet_id combo.