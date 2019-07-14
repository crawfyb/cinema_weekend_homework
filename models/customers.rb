require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql,values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.film_id = $1"
    values = [@id]
    data = SqlRunner.run(sql, values)
    return data.map{|film| Film.new(film)}
  end

  def buying_ticket(film)
    @funds -= film.price
    update
  end

  # def tickets
  #   sql = "SELECT * FROM tickets WHERE id = $1"
  #   values = [@customer_id]
  #   ticket = SqlRunner.run(sql, values).first
  #   return Ticket.new(ticket)
  # end

  # def movie()
  #   sql = "SELECT * FROM movies WHERE id = $1"
  #   values = [@movie_id]
  #   movie = SqlRunner.run(sql, values).first
  #   return Movie.new(movie)
  # end


  def self.all()
   sql = "SELECT * FROM customers"
   customers = SqlRunner.run(sql)
   return customers.map { |customer| Customer.new( customer ) }
 end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end




end
