require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@title, @price]
    films = SqlRunner.run(sql, values).first
    @id = films['id'].to_i
  end

  def update()
    sql = "UPDATE films SET title = $1
    WHERE id = $2"
    values = [@title, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    data = SqlRunner.run(sql, values)
    return data.map{|customer| Customer.new(customer)}
    # return Customer.map_items(customer_data)

  end



  def self.all()
 sql = "SELECT * FROM films"
 films = SqlRunner.run(sql)
 return films.map { |film| Film.new( film ) }
end

 def self.delete_all
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
 end

 def delete()
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end




end
