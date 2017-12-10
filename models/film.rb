require_relative('../db/sql_runner')

class Film

  attr_reader(:id)
  attr_accessor(:title, :price)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (title,price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    new_film = SqlRunner.run(sql,values).first()
    @id = new_film['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title, price)
    = ($1, $2)
    WHERE id = $3"

    values = [@title, @price, @id]

    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    # Removed DISTINCT from sql to list all customers
    # that bought tickets for this film - is this correct ?

    sql = "SELECT customers.*
        FROM customers
        INNER JOIN tickets
        ON tickets.customer_id = customers.id
        WHERE tickets.film_id = $1"

    values =[@id]
    query_customers = SqlRunner.run(sql,values)

    return Customer.map_items(query_customers)

  end

  def customers_count()
    # Counts the number of customers going to see film
    return customers().count
  end

# Class methods
  def self.all()
    sql = "SELECT * FROM films"

    query_films = SqlRunner.run(sql)

    films = query_films.map{|film| Film.new(film)}

    return films
  end

  def self.delete_all()
    sql = "DELETE FROM films"

    SqlRunner.run(sql)
  end

  def self.find(id)

  end

  # helper method

  def self.map_items(film_hashes)
    result = film_hashes.map {|film_hash|
    Film.new(film_hash)}
    return result
  end
end
