# Use this file to import the sales information into the
# the database.
require 'csv'
require "pg"
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "korning")
    yield(connection)
  ensure
    connection.close
  end
end

csv_records = CSV.readlines('sales.csv', headers: true)

customers = csv_records.map { |record| record["customer_and_account_no"] }.uniq
customers.each do |customer|
  # split customer into name and account_no
  customer_name = customer.split(' ')[0]
  account_no = customer.split(' ')[-1]
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT customer_name FROM customer WHERE customer_name=$1',
      [customer_name]
    )
      # NOTE: ensure no duplication
    if result.to_a.empty?
      # INSERT into # customer table
            # name
            # account_no
      sql = "INSERT INTO customer (customer_name, account_no) VALUES ($1, $2)"
      conn.exec_params(sql, [customer_name, account_no])
    end
  end
end

employees = csv_records.map { |record| record["employee"] }.uniq
employees.each do |employee|
  # split employee into name and email
  employee_name = employee.split(' ')[0]
  email = employee.split(' ')[-1]
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT employee_name FROM employee WHERE employee_name=$1',
      [employee_name]
    )
      # NOTE: ensure no duplication
    if result.to_a.empty?
      # INSERT into # employee table
            # name
            # email
      sql = "INSERT INTO employee (employee_name, email) VALUES ($1, $2)"
      conn.exec_params(sql, [employee_name, email])
    end
  end
end


products = csv_records.map {|record| record["product_name"]}
# product table
  # product_name
products.each do |product|
  db_connection do |conn|
    result = conn.exec_params(
      'SELECT product_name FROM product WHERE product_name=$1',
      [product]
    )
    # NOTE: ensure no duplication
    if result.to_a.empty?
      conn.exec_params(
        'INSERT INTO product (product_name) VALUES ($1)',
        [product]
      )
    end
  end
end


db_connection do |conn|
  csv_records.each do |record|
    # gather foreign keys from:
        # customer
    customer_name = record["customer_and_account_no"].split(' ')[0]
    customer_id = conn.exec_params(
      'SELECT id FROM customer WHERE customer_name=$1',
      [customer_name]
    )[0]["id"]

    # gather foreign keys from:
        # employee
    employee_name = record["employee"].split(' ')[0]
    employee_id = conn.exec_params(
      'SELECT id FROM employee WHERE employee_name=$1',
      [employee_name]
    )[0]["id"]

    # gather foreign keys from:
        # product
    product_name = record["product_name"]
    product_id = conn.exec_params(
      'SELECT id FROM product WHERE product_name=$1',
      [product_name]
    )[0]["id"]

    # populate invoice table
    invoice_no = record["invoice_no"]
        # invoice_no
    sale_date = record["sale_date"]
        # sale_date
    units_sold = record["units_sold"]
        # units_sold
    sale_amount = record["sale_amount"]
        # sale_amount
    invoice_frequency = record["invoice_frequency"]
        # invoice_frequency
    # the id's are gathered above
        # product_id
        # customer_id
        # employee_id
    result = conn.exec_params(
      'SELECT invoice_no FROM invoice WHERE invoice_no=$1',
      [invoice_no]
    )

    if result.to_a.empty?
      conn.exec_params(
        'INSERT INTO invoice (invoice_no, sale_date, units_sold, sale_amount, invoice_frequency, product_id, customer_id, employee_id)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)',
        [invoice_no, sale_date, units_sold, sale_amount, invoice_frequency, product_id, customer_id, employee_id]
      )
    end
  end
end
