-- DEFINE YOUR DATABASE SCHEMA HERE
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS invoice;

CREATE TABLE customer (
  id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255),
  account_no VARCHAR(255)
);

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
  employee_name VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  product_name VARCHAR(255)
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
  employee_id INTEGER
);
