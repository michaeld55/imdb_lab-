
require_relative("star.rb")
require_relative("casting.rb")


class Movie



    attr_reader :id
    attr_accessor :title, :genre, :budget

    def initialize( options )
      @id = options['id'].to_i if options['id']
      @title = options['title']
      @genre = options['genre']
      @budget=options['budget'].to_i
    end

    def save()
      sql = "INSERT INTO movies
      (
        title,
        genre
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@title, @genre]
      location = SqlRunner.run( sql, values ).first
      @id = location['id'].to_i
    end

    def update
    sql = "UPDATE movies SET title = $1,genre=$2 WHERE id = $3"
    values = [@title,@genre,@id]
    SqlRunner.run(sql, values)
  end

     def stars
       sql ="select * from stars
       inner join casting
      on casting.star_id=stars.id  where movie_id=$1"
       values = [@id]
      stars =SqlRunner.run(sql,values)
      result=stars.map {|star| Star.new(star)}
      return result
     end

     def remaining_budget
       sql='select casting.fee from casting
       where movie_id=$1'
       values=[@id]
       fees=SqlRunner.run(sql,values)

       # result=fees.map {|fee|fee}
       fees = fees.reduce(0) {|total,fee| total+fee['fee'].to_i}
       return remaining_budget = @budget-fees

     end


    def self.all()
      sql = "SELECT * FROM movies"
      movies = SqlRunner.run(sql)
      result = movies.map { |movie| Movie.new( movie ) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM movies"
      SqlRunner.run(sql)
    end

  end
