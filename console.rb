require_relative('models/customer.rb')
require_relative('models/ticket.rb')
require_relative('models/film.rb')

require( 'pry-byebug' )

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Peter Kelly', 'funds' => '60'})
customer2 = Customer.new({'name' => 'Paul Kelly', 'funds' => '50'})
customer3 = Customer.new({'name' => 'Emma Kelly', 'funds' => '40'})

customer1.save
customer2.save
customer3.save
customer3.name = 'Emma Slimmings'
customer3.update

film1 = Film.new({'title' => 'Troy', 'price' => '5'})
film2 = Film.new({'title' => 'Toy Story', 'price' => '6'})
film3 = Film.new({'title' => 'The Little Rascals', 'price' => '7'})

film1.save
film2.save
film3.save
film2.title = 'Toy Story 2'
film2.update

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket5 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket6 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save

pry.binding
nil
