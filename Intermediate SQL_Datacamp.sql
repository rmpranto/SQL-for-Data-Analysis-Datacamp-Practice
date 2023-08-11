----------------
#Selecting Data-Part 1
----------------
  
#Learning to COUNT
-------------------
--Count the total number of records in the people table, aliasing the result as count_records
  select count(*) as count_records from people;

--Count the number of records with a birthdate in the people table, aliasing the result as count_birthdate.
select count (birthdate) as count_birthdate from people;


--Count the records for languages and countries in the films table; alias as count_languages and count_countries.
select count(language) as count_languages, count(country) as count_countries from films;

#SELECT DISTINCT
----------------
--Return the unique countries represented in the films table using DISTINCT
select distinct country from films;

--Return the number of unique countries represented in the films table, aliased as count_distinct_countries.
select  count (distinct country) as count_distinct_countries from films;

-- Debug this code
SELECT certification
FROM films
LIMIT 5;

-- Rewrite this query
SELECT person_id, role  
FROM roles 
LIMIT 10;

--------------------------
#Filtering Records-Part 2
--------------------------
  
#Using WHERE with numbers
--------------------------
-- Select film_ids and imdb_score with an imdb_score over 7.0
select film_id, imdb_score
from reviews
where imdb_score >7.0

-- Select film_ids and facebook_likes for ten records with less than 1000 likes 
select film_id, facebook_likes
from reviews
where facebook_likes<1000
limit 10;

-- Count the records with at least 100,000 votes
select count(num_votes) as films_over_100K_votes
from reviews
where num_votes >= 100000;

#Using WHERE with text
------------------------
-- Count the Spanish-language films
select count(language) as count_spanish
from films
where language ='Spanish';

#Using AND OR BETWEEN
------------------------
#AND
-----
-- Select the title and release_year for all German-language films released before 2000
select title, release_year
from films
where release_year <2000 and language='German';

-- Update the query to see all German-language films released after 2000
SELECT title, release_year
FROM films
WHERE release_year > 2000
	AND language = 'German';

-- Select all records for German-language films released after 2000 and before 2010
SELECT *
FROM films
WHERE release_year > 2000
	AND release_year < 2010
	AND language = 'German';
#OR
---
--Find the title and year of films from the 1990 or 1999
select title, release_year
from films
where release_year=1990 or release_year=1999;

SELECT title, release_year,language
FROM films
WHERE (release_year = 1990 OR release_year = 1999)
-- Add a filter to see only English or Spanish-language films
and (language ='English' or language='Spanish');

--Finally, restrict the query to only return films worth more than $2,000,000 gross
SELECT title, release_year,gross
FROM films
WHERE (release_year = 1990 OR release_year = 1999)
	AND (language = 'English' OR language = 'Spanish')
and(gross >2000000);

