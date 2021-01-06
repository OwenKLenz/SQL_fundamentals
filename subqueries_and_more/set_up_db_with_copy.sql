CREATE DATABASE auction;
\c auction

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6, 2) NOT NULL,
  sales_price numeric(6, 2)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id INT NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id INT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6, 2) NOT NULL
);

CREATE INDEX bidder_id_item_id_idx ON bids(bidder_id, item_id);

\copy bidders from 'bidders.csv' HEADER CSV
\copy items from 'items.csv' HEADER CSV
\copy bids from 'bids.csv' HEADER CSV