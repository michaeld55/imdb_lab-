
require_relative("db/sql_runner")

require_relative( 'models/movie' )
require_relative( 'models/star' )
require_relative( 'models/casting' )

require( 'pry-byebug' )

# Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({ 'title' => 'The Shining','genre'=>'horror','budget'=>50 })
movie1.save()
movie2 = Movie.new({ 'title' => 'The Labyrinth','genre'=>'Fantasy','budget'=>50 })
movie2.save()

movie1.title= 'The Birds'
movie1.update


 star1 = Star.new({ 'first_name' => 'Jack', 'last_name' => 'Nicholson'})
 star1.save()
 star2 = Star.new({ 'first_name' => 'David', 'last_name' => 'Bowie'})
 star2.save()

 star1.first_name='Fred'
 star1.update

casting1 = Casting.new({ 'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 5})
 casting1.save()
 casting2 = Casting.new({ 'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 8})
casting2.save()

casting1.fee= 10
casting1.update

binding.pry
nil
