ALTER TABLE planets
  ADD COLUMN 
    star_id integer NOT NULL REFERENCES stars(id);