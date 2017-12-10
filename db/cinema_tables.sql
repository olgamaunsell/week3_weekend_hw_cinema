DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
  );

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
  );

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  screening_date date,
  screening_time VARCHAR(255),
  capacity INT2,
  tickets_sold INT2
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
  );
