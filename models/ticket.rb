require_relative('../db/sql_runner')

class Ticket

  attr_reader(:id)
  attr_accessor(:customer_id, :film_id)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id,film_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    new_ticket = SqlRunner.run(sql,values).first()
    @id = new_ticket['id'].to_i

  end

  def update()
    # doesn't seem right to be able to update the customer_id
    # an existing record ?
    sql = "UPDATE tickets
    SET (customer_id, film_id)
    = ($1, $2)
    WHERE id = $3"

    values = [@customer_id, @film_id, @id]

    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Class methods
    def self.all()
      sql = "SELECT * FROM tickets"

      query_tickets = SqlRunner.run(sql)

      tickets = query_tickets.map{|ticket| Ticket.new(ticket)}

      return tickets
    end

    def self.delete_all()
      sql = "DELETE FROM tickets"

      SqlRunner.run(sql)
    end

    def self.find(id)

    end
end
