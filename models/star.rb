require_relative("movie.rb")
require_relative("casting.rb")


class Star



    attr_reader :id
    attr_accessor :first_name, :last_name

    def initialize( options )
      @id = options['id'].to_i if options['id']
      @first_name = options['first_name']
      @last_name = options['last_name']
    end

    def save()
      sql = "INSERT INTO stars
      (
        first_name,
        last_name
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@first_name, @last_name]
      location = SqlRunner.run( sql, values ).first
      @id = location['id'].to_i
    end

    def update
    sql = "UPDATE stars SET first_name = $1,last_name=$2 WHERE id = $3"
    values = [@first_name,@last_name,@id]
    SqlRunner.run(sql, values)
  end

  def movies
    sql ="select * from movies
    inner join casting
   on casting.movie_id=movies.id  where star_id=$1"
    values = [@id]
   movies =SqlRunner.run(sql,values)
   result=movies.map {|movie| Movie.new(movie)}
   return result
  end


    def self.all()
      sql = "SELECT * FROM stars"
      stars = SqlRunner.run(sql)
      result = stars.map { |star| Star.new( star ) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM stars"
      SqlRunner.run(sql)
    end

  end
