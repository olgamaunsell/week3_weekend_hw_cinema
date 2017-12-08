require_relative('../db/sql_runner')

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (name,funds)
    VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    new_customer = SqlRunner.run(sql,values).first()
    @id = new_customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds)
    = ($1, $2)
    WHERE id = $3"

    values = [@name, @funds, @id]

    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


# Class methods
  def self.all()
    sql = "SELECT * FROM customers"

    query_customers = SqlRunner.run(sql)

    customers = query_customers.map{|customer| Customer.new(customer)}

    return customers
  end

  def self.delete_all()
    sql = "DELETE FROM customers"

    SqlRunner.run(sql)
  end

  def self.find(id)

  end









end
