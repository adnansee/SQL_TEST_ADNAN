CREATE database MovieDB;
USE MovieDB;
CREATE TABLE movie
(
    movie_id        integer primary key auto_increment,
    mov_title       char(50),
    mov_year        integer,
    mov_time        integer,
    mov_lang        char(50),
    mov_dt_rel      date,
    mov_rel_country char(50)
);

CREATE TABLE movie_genres
(
    mov_id integer references movie (movie_id),
    gen_id integer references genres (gen_id)
);

CREATE TABLE genres
(
    gen_id    integer primary key auto_increment,
    gen_title char(20)
);

CREATE TABLE rating
(
    mov_id       integer references movie (movie_id),
    rev_id       integer references reviewer (rev_id),
    rev_stars    integer,
    num_o_rating integer
);

CREATE TABLE reviewer
(
    rev_id   integer primary key auto_increment,
    rev_name char(30)
);

CREATE TABLE movie_direction
(
    dir_id integer references director (dir_id),
    mov_id integer references movie (movie_id)
);

CREATE TABLE director
(
    dir_id    integer primary key auto_increment,
    dir_fname char(20),
    die_lname char(20)
);

CREATE TABLE actor
(
    act_id    integer primary key auto_increment,
    act_fname char(20),
    act_lname char(20)
);

CREATE TABLE movie_cast
(
    act_id integer references actor (act_id),
    mov_id integer references movie (movie_id),
    role   char(30)
);

#####################################################


describe MovieDB.actor;
select *
from movie;

#INSERT MOVIES
INSERT INTO movie(movie_id, mov_title, mov_year, mov_time, mov_lang, mov_dt_rel, mov_rel_country)
values (1, 'Pearl Harbor', 2001, 183, 'ENG', '2001-05-25', 'USA')
        ,
       (2, 'Jumanji', 1995, 104, 'ENG', '1995-12-15', 'USA'),
       (3, 'Brave Heart', 1995, 178, 'ENG', '1995-05-24', 'USA'),
       (4, 'Black Hawk Down', 2001, 144, 'ENG', '2001-01-18', 'USA'),
       (5, 'Gladiator', 2001, 144, 'ENG', '2001-05-05', 'USA'),
       (6, 'Armegadon', 1999, 129, 'ENG', '1999-06-01', 'USA'),
       (7, 'The Lost World', 1997, 129, 'ENG', '1997-05-23', 'USA'),
       (8, 'AI', 2001, 146, 'ENG', '2001-06-29', 'USA'),
       (9, 'Titanic', 1997, 197, 'ENG', '1997-12-19', 'USA'),
       (10, 'Twister', 1996, 113, 'ENG', '1996-05-10', 'USA');
delete
from movie;

#INSERT ACTOR

INSERT INTO actor(act_id, act_fname, act_lname)
VALUES (1, 'Leo', 'DiCaprio'),
       (2, 'Woody', 'Allen'),
       (3, 'Leo', 'DiCaprio');

DELETE
from rating;
#INSERT DIRECTOR
INSERT INTO director(dir_id, dir_fname, die_lname)
VALUES (1, 'Michal', 'Bay'),
       (2, 'Robert', 'Louis'),
       (3, 'Sherpa', 'SHIER');
#INSERT MOVIE DIRECTION
INSERT INTO movie_direction(dir_id, mov_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (1, 4);

#INSERT REVIEWER
INSERT INTO reviewer(rev_id, rev_name)
VALUES (1, 'ROTTEN TOMATOES'),
       (2, 'IMDB'),
       (3, '5STARS');

#MOVIE GENRE
INSERT INTO genres(gen_title)
VALUES ('ACTION'),
       ('DRAMA'),
       ('MYSTRY');

#INSERT MOVIE_CAST
INSERT INTO movie_cast(act_id, mov_id, role)
VALUES (1, 1, 'MAIN HERO/HEROIEN'),
       (2, 2, 'Villan'),
       (3, 3, 'DOG');
DELETE
FROM movie_cast;

#INSERT RATING
INSERT INTO rating(mov_id, rev_id, rev_stars, num_o_rating)
VALUES (1, 1, 8, 2),
       (2, 2, 7, 3),
       (3, 3, 5, 4),
       (4, 4, 1, 2),
       (5, 5, 2, 3),
       (6, 6, 5, 1),
       (7, 7, 2, 3),
       (8, 8, 5, 6),
       (9, 9, 5, 3),
       (10, 10, NULL, 2);
delete
from rating;
#INSERT GENRE

INSERT INTO movie_genres(mov_id, gen_id)
VALUES (1, 1),
       (2, 2),
       (3, 3);

#NAME AND YEAR

SELECT mov_title, mov_year
from movie;

# FILM REL DATE 1999

SELECT *
FROM movie
where mov_year = 1999;

# BEFORE 1999
SELECT *
FROM movie
where mov_year < 1998;

# REVIEWERS WHERE LESS THEN 7 rating
SELECT *
FROM movie
         JOIN rating r on movie.movie_id = r.mov_id
where rev_stars < 7;


#NO REVIEWS
SELECT *
FROM movie
         JOIN rating r on movie.movie_id = r.mov_id
where rev_stars is null;


#TITLE WITH ID 5,7,9
SELECT *
FROM movie
where movie_id = 5
   or movie_id = 7
   or movie_id = 9;

#
SELECT movie.mov_title, rev_name
FROM movie,
     reviewer
         join rating r on reviewer.rev_id = r.rev_id
         join movie m on r.mov_id = m.movie_id;


#WOODY ALLEN AS MAIN ACTOR
SELECT actor.act_id
FROM actor
where act_fname LIKE 'Woody';

#10 SUBQUERY


#11
SELECT *
FROM movie
where mov_rel_country <> 'UK';

#12
select *
FROM movie
         join rating r on movie.movie_id = r.mov_id
where rev_stars < 3
order by rev_stars;

#13
select mov_title, rev_name
from movie
         join rating r on movie.movie_id = r.mov_id
         join reviewer r2 on r.rev_id = r2.rev_id
order by mov_title;

#14
select movie.mov_title, rev_stars
from movie,
     rating
         join movie m on rating.mov_id = m.movie_id;


#15
SELECT *
from movie
         join movie_cast mc on movie.movie_id = mc.mov_id
         join actor a on mc.act_id = a.act_id
where act_fname LIKE 'Leo';

#16
select act_fname
from actor
         join movie_cast mc on actor.act_id = mc.act_id
         join movie m on mc.mov_id = m.movie_id
;

#17
select die_lname from director
join movie_direction md on director.dir_id = md.dir_id
join movie m on md.mov_id = m.movie_id
join movie_genres mg on m.movie_id = mg.mov_id
join genres g on mg.gen_id = g.gen_id
;

#18
select *
FROM movie
         join movie_genres mg on movie.movie_id = mg.mov_id
         join genres g on mg.gen_id = g.gen_id;


#19
select movie.mov_title, movie.mov_year, movie.mov_dt_rel, movie.mov_time, dir_fname, die_lname
FROM movie,
     director
         join movie_direction md on director.dir_id = md.dir_id
         join movie m on md.mov_id = m.movie_id
where m.mov_year < 2000;


#20 with rating 2, 5 because the rating of 3 and 4 was not inserted for any movie so i used other examples
select *
from movie
         join rating r on movie.movie_id = r.mov_id
where rev_stars = 2
   or rev_stars = 5;
