require_relative("../db/sql_runner")

class Ticket

attr_reader :id, :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def self.delete_all
  sql = "DELETE FROM tickets;"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM tickets;"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |ticket| Ticket.new(ticket)}
  return result
end

def save()
  sql = "INSERT INTO tickets
        (customer_id, film_id)
        VALUES
        ($1,$2)
        RETURNING id"
  values = [@customer_id, @film_id]
  ticket = SqlRunner.run(sql, values).first
  @id = ticket['id'].to_i
end

def delete()
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

end
