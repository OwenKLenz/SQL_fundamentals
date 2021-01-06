INSERT INTO birds (name, age, species) VALUES
  ('Charlie', 3, 'Finch'),
  ('Allie', 5, 'Owl'),
  ('Jennifer', 3, 'Magpie'),
  ('Jamie', 4, 'Owl'),
  ('Roy', 8, 'Crow');

-- Further Exploration:
If you list values for each column starting from the left (in this case id, 
then name, etc.), they will automatically be added in a row to the table from
left to right. Any missing values will be set to NULL.

In situations where you are already explicitly declaring values for every
column, INSERTing data without a columns list would save you some typing.