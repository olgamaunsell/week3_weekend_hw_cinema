require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')
require( 'pry-byebug' )

# Delete all records from tables

Ticket.delete_all()
Screening.delete_all()
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
# Customer1 buys 2 tickets for film2
ticket3 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })

ticket4 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

#Update ticket

# ticket1.film_id = film2.id

# ticket1.update()

# ticket2.delete()

# Show which films a customer has booked to see,

cust1_films = customer1.films()

# which customers are coming to see one film.

film2_customers = film2.customers()

# Customer buys film ticket - returns customer wallet amount ?

customer1_wallet = customer1.buy_film_ticket(film2)

# Return all tickets

all_tickets = Ticket.all()

# Check how many tickets were bought by a customer

cust1_tix_count = customer1.tickets_count()

# Check how many customers are going to watch
# a certain film

film2_cust_count = film2.customers_count()

# Advanced extensions:
#
#
# Create new screening

film1screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_date' => 'December 11 2017',
  'screening_time' => '19:00',
  'capacity' => '10',
  'tickets_sold' => '9'
  })

film1screening1.save()

film2screening1 = Screening.new({
  'film_id' => film2.id,
  'screening_date' => 'December 11 2017',
  'screening_time' => '21:00',
  'capacity' => '20',
  'tickets_sold' => '15'
  })

film2screening1.save()

#Update screening

film1screening1.screening_time = '19:30'
film1screening1.capacity = '12'

film1screening1.update()

# delete screening

# film1screening1.delete()

# Return all screenings

all_screenings = Screening.all()

# Create a screenings table that lets us know what time films are showing

# Write a method that finds out what is the most popular time (most tickets sold) for a given film
# Limit the available tickets for screenings.
# Add any other extensions you think would be great to have at a cinema!


binding.pry
nil
