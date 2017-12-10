require_relative('../db/sql_runner')
require( 'pry-byebug' )

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

  # def buy_film_ticket(film, date, time)
  def buy_film_ticket(film, screening)
    # Creates ticket, reduces customer's wallet by
    # price of film and returns customer's wallet amount
    # screening = Screening.find_screening(film.id, date, time)
    # available_seats = screening.check_available_seats
    #
    # if available_seats == 0
    #   return "No seats available"
    # end

    new_ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id,
      'screening_id' => screening.id})

    new_ticket.save()

    #update tickets sold

    screening.tickets_sold += 1
    screening.update()

    @funds -= film.price

    update()
    # Not sure what to return ?
    return @funds
  end

  def films
    # Removed DISTINCT from sql to list all films
    # customers has bought tickets for - is this correct ?
    # e.g. customer buys 2 tickets for a film

    sql = "SELECT films.*
        FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        WHERE tickets.customer_id = $1"

    values =[@id]
    query_films = SqlRunner.run(sql,values)

    return Film.map_items(query_films)

  end

  def tickets_count
    # Counts the number of tickets bought by customer
    return films().count
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

  # helper method

  def self.map_items(customer_hashes)
    result = customer_hashes.map {|customer_hash|
    Customer.new(customer_hash)}
    return result
  end

end
