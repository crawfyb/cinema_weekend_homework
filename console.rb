require_relative('models/films')
require_relative('models/tickets')
require_relative('models/customers')

require('pry-byebug')

Film.delete_all
Customer.delete_all

film1 = Film.new({'title' => 'The Witches', 'price' => '10'})
film1.save

film2 = Film.new({'title' => 'Batman ', 'price' => '8'})
film2.save

film3 = Film.new({'title' => 'Star Wars', 'price' => '7'})
film3.save

film4 = Film.new({'title' => 'Indian Jones', 'price' => '9'})
film4.save

film4.title = "Indian Jones and the Raiders of the Lost Ark"
film4.update()

customer1 = Customer.new({'name' => 'Jarrod', 'funds' => 22})
customer1.save

customer2 = Customer.new({'name' => 'John', 'funds' => 100})
customer2.save

customer3 = Customer.new({'name' => 'Juan', 'funds' => 28})
customer3.save

customer4 = Customer.new({'name' => 'Zsolt', 'funds' => 34})
customer4.save

customer4.funds = 23
customer4.update()

ticket1 = Ticket.new ({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save

binding.pry
nil
