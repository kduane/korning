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

db_connection do |conn|
  CSV.foreach("sales.csv", :headers => true) do |row|
    # get row data and define with variables
    # split employee into name and email
    # split customer into name and account_no
    # INSERT into:
        # customer table
          # name
          # account_no
          # NOTE: ensure no duplication
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
