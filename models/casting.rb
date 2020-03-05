require_relative("../db/sql_runner")
require_relative("movie")
require_relative("star")

class Casting

  attr_reader :id
  attr_accessor :star_id, :movie_id, :fee

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @star_id = options['star_id'].to_i
    @movie_id = options['movie_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO casting
    (
      star_id,
      movie_id,
      fee
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@star_id, @movie_id, @fee]
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
  end

  def stars
    sql= "select * from stars
          where stars.id =$1"
    values = [@star_id]
    star=SqlRunner.run(sql,values).first
    return star.new(star)
  end

  def movie
    sql = "select * from movies
    where movies.id=$1"
    values = [@amovie_id]
    movies =SqlRunner.run(sql,values).first
    return movie.new(movie)
  end

  def update
  sql = "UPDATE casting SET movie_id = $1,star_id=$2,fee=$3 WHERE id = $4"
  values = [@movie_id,@star_id,@fee,@id]
  SqlRunner.run(sql, values)
end

  def self.all()
    sql = "SELECT * FROM casting"
    castings = SqlRunner.run(sql)
    result = castings.map { |casting| Casting.new( casting ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM casting"
    SqlRunner.run(sql)
  end

end
