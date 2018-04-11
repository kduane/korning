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

products = csv_records.map {|record| record[""]}



db_connection do |conn|
  CSV.foreach("sales.csv", :headers => true) do |row|
    # get row data and define with variables
    # split employee into name and email

        # employee table
          # employee_name
          # email
          # NOTE: ensure no duplication
        # product table
          # product_name
          # NOTE: ensure no duplication

    # gather foreign keys from:
        # customer
        # employee
        # product

    # populate invoice table
        # invoice_no
        # sale_date
        # units_sold
        # sale_amount
        # invoice_frequency
        # product_id
        # customer_id
        # employee_id

  end
end
