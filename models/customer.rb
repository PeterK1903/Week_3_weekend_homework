require_relative("../db/sql_runner")

class Customer

attr_accessor :name, :funds
attr_reader :id

def initialize(options)
@id = options['id'].to_i if options['id']
@name = options['name']
@funds = options['funds'].to_i
end

def self.delete_all
  sql = "DELETE FROM customers;"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM customers;"
  customers = SqlRunner.run(sql)
  result = customers.map { |customer| Customer.new(customer)}
  return result
end

def save()
  sql = "INSERT INTO customers
        (name, funds)
        VALUES
        ($1,$2)
        RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE customers SET (name, funds) = ($1,$2) WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end

def films()
  sql = "SELECT films.* FROM films INNER JOIN
        tickets ON tickets.film_id = films.id WHERE tickets.customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  result = film_data.map {|film| Film.new(film)}
  return result
end

def tickets()
  sql = "SELECT * FROM tickets where customer_id = $1"
  values = [@id]
  ticket_data = SqlRunner.run(sql, values)
  return ticket_data.map{|ticket| Ticket.new(ticket)}
end

def remaining_cash()
  tickets = self.films()
  ticket_price = tickets.map{|ticket| ticket.price}
  total_price = ticket_price.sum
  return @funds - total_price
end

end
