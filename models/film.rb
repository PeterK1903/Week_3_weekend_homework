require_relative("../db/sql_runner")

class Film

attr_accessor :title, :price
attr_reader :id

def initialize(options)
@id = options['id'].to_i if options['id']
@title = options['title']
@price = options['price'].to_i
end


def self.delete_all
  sql = "DELETE FROM films;"
  SqlRunner.run(sql)
end

def self.all()
  sql = "SELECT * FROM films;"
  films = SqlRunner.run(sql)
  result = films.map { |film| Film.new(film)}
  return result
end

def save()
  sql = "INSERT INTO films
        (title, price)
        VALUES
        ($1,$2)
        RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run(sql, values).first
  @id = film['id'].to_i
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE films SET (title, price) = ($1,$2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def customers
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.film_id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  result = customer_data.map {|customer| Customer.new(customer)}
  return result
end

end
