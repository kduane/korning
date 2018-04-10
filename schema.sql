-- DEFINE YOUR DATABASE SCHEMA HERE

CREATE TABLE customer (
  id SERIAL PRIMARY KEY,
  customer VARCHAR(255),
  account_no VARCHAR(255)
);

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  employee VARCHAR(255)
);

CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  product_name VARHAR(255)
);

CREATE TABLE invoice (
  id SERIAL PRIMARY KEY,
  invoice_no INTEGER,
  sale_date DATE,
  units_sold INTEGER,
  sale_amount MONEY,
  invoice_frequency VARCHAR(50),
  product_id INTEGER,
  customer_id INTEGER,
  employee_id INTEGER,
);
