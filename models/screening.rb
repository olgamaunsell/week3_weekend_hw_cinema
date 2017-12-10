require_relative('../db/sql_runner')
require( 'pry-byebug' )

class Screening

  attr_reader(:id)
  attr_accessor(:film_id, :screening_date, :screening_time, :capacity, :tickets_sold)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @screening_date = options['screening_date']
    @screening_time = options['screening_time']
    @capacity = options['capacity'].to_i
    @tickets_sold = options['tickets_sold'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
    (film_id, screening_date, screening_time, capacity, tickets_sold)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id"
    values = [@film_id, @screening_date, @screening_time, @capacity,@tickets_sold]
    new_screening = SqlRunner.run(sql,values).first()
    @id = new_screening['id'].to_i

  end

  def update()

    sql = "UPDATE screenings
    SET (film_id, screening_date, screening_time, capacity, tickets_sold)
    = ($1, $2, $3, $4, $5)
    WHERE id = $6"

    values = [@film_id, @screening_date, @screening_time, @capacity,@tickets_sold, @id]

    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def check_available_seats()
    return available_seats = @capacity - @tickets_sold
  end

  # Class methods
  def self.all()
    sql = "SELECT * FROM screenings"

    query_screenings = SqlRunner.run(sql)

    screenings = query_screenings.map{|screening| Screening.new(screening)}

    return screenings
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"

    SqlRunner.run(sql)
  end

  def self.find_screening(film_id, date, time)
    # Find screening that matches a film_id, date and time

    sql = "SELECT id FROM screenings
        WHERE screenings.film_id = $1 AND screenings.screening_date = $2 AND screenings.screening_time = $3"

    values = [film_id, date, time]
    sql_result = SqlRunner.run(sql, values)

    binding.pry
    found_screening = sql_result.map {|screening| Screening.new(screening)}

    # if found_screening == nil
    #   binding.pry
    #   return false
    # else
    #   binding.pry
    #   return found_screening[0]
    #
    # end
  end
  # helper method

  def self.map_items(screening_hashes)
    result = screening_hashes.map {|screening_hash|
    Screening.new(screening_hash)}
    return result
  end
end
