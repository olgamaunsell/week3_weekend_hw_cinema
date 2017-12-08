require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require( 'pry-byebug' )

# Delete all records from tables

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name' => 'Olgaaaa Maunsell',
  'funds' => '20'
})

customer2 = Customer.new({
  'name' => 'Lorna Noble',
  'funds' => '30'
})
# customer2 = Customer.new({
#   name: 'Lorna Noble',
#   funds:  '30'
# })

customer1.save()
customer2.save()

# Update customer

customer1.name = 'Olga Maunsell'

customer1.update()

#Delete customer

# customer2.delete()

#Return all customers

all_customers = Customer.all()

# Setup new films

film1 = Film.new({
  'title' => 'Reservoir Dogs',
  'price' => '8'
  })

film1.save()

film2 = Film.new({
  'title' => 'Pulp Fraction',
  'price' => '10'
  })

film2.save()

# Update film
film2.title = 'Pulp Fiction'

film2.update()

#Delete film

# film1.delete()

# Return all films

all_films = Film.all()

#Setup new tickets

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket1.save()
ticket2.save()

#Update ticket

ticket1.film_id = film2.id

ticket1.update()

# ticket2.delete()

# Return all tickets

all_tickets = Ticket.all()

binding.pry
nil