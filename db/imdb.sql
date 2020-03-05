drop table if exists casting;
DROP TABLE  if exists movies;
DROP TABLE  if exists stars;


CREATE TABLE movies  (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  budget int
);

CREATE TABLE stars (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

create table casting (
  id serial primary key,
  movie_id int references movies(id) on delete cascade,
  star_id int references stars(id) on delete cascade,
  fee int
);
