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

  def screenings()

    sql = "SELECT films.title, screenings.*
        FROM films
        INNER JOIN screenings
        ON films.id = screenings.film_id
        WHERE films.id = $1"

    values =[@id]
    query_film_screenings = SqlRunner.run(sql, values)

    return Screening.map_items(query_film_screenings)
    #how do I get it to return the film title aswell ?
  end

  def most_popular_screening()
    sql = "SELECT screenings.*
        FROM screenings
        INNER JOIN films
        ON films.id = screenings.film_id
        WHERE films.id = $1
        ORDER BY screenings.tickets_sold DESC limit 1"

    values =[@id]
    query_popular_screening = SqlRunner.run(sql, values)

    return Screening.map_items(query_popular_screening)

  end

# Class methods
  def self.all()
    sql = "SELECT * FROM films"

    query_films = SqlRunner.run(sql)

    films = Film.map_items(query_films)

    return films
  end

  def self.delete_all()
    sql = "DELETE FROM films"

    SqlRunner.run(sql)
  end

  def self.find(id)

  end

  # helper method

  def self.map_items(film_data)
    result = film_data.map {|film|
    Film.new(film)}
    return result
  end

  def Film.map_item(film_data)
   result = Film.map_items(film_data)
   return result.first
  end
end
