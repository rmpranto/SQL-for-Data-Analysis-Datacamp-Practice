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

--Between
----------
-- Select the title and release_year for films released between 1990 and 2000
select title, release_year
from films
where release_year between  1990 and 2000;

SELECT title, release_year,budget
FROM films
WHERE release_year BETWEEN 1990 AND 2000
-- Narrow down your query to films with budgets > $100 million
	and budget >100000000;


SELECT title, release_year,language
FROM films
WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000
-- Restrict the query to only Spanish-language films
	and language ='Spanish';

SELECT title, release_year,language
FROM films
WHERE release_year BETWEEN 1990 AND 2000
	AND budget > 100000000
-- Amend the query to include Spanish or French-language films
	AND (language='Spanish'or language='French');

--LIKE and NOT LIKE
------------------------
-- Select the names that start with B
select name
from people
where name like 'B%';

-- Select the names that have r as the second letter
SELECT name
FROM people
where name like '_r%';

-- Select names that don't start with A
SELECT name
FROM people
WHERE name NOT LIKE 'A%';

--WHERE IN
---------
-- Find the title and release_year for all films over two hours in length released in 1990 and 2000
SELECT title, release_year
FROM films
WHERE release_year IN (1990, 2000)
	AND duration > 120;

-- Find the title and language of all films in English, Spanish, and French
select title, language
from films
where language in ('English','Spanish','French');

-- Find the title, certification, and language all films certified NC-17 or R that are in English, Italian, or Greek
select title,certification,language
from films
where certification='NC-17' OR certification= 'R' and language in('English','Italian','Greek');

-- Count the unique titles
SELECT COUNT (DISTINCT title) AS nineties_english_films_for_teens
FROM films
-- Filter to release_years to between 1990 and 1999
WHERE release_year between 1990 AND 1999
-- Filter to English-language films
	and language='English'
-- Narrow it down to G, PG, and PG-13 certifications
	and certification IN ('G','PG','PG-13');

--NULL
--------
-- List all film titles with missing budgets
SELECT title as no_budget_info,budget 
from films
where budget is null;
	
-- Count the number of films we have language data for
select count(films) as count_language_known
from films
where language is not null;

--------------------------
#Aggregate Functions-Part 3
--------------------------
--#SUM, MIN, MAX, AVG, COUNT
	
-- Query the sum of film durations
select sum(duration) as total_duration
from films;

-- Calculate the average duration of all films
select avg(duration) as average_duration
from films;

-- Find the latest release_year
select max(release_year) as latest_year
from films;

-- Find the duration of the shortest film
select  min(duration) as shortest_film
from films;

--Combining aggregate functions with WHERE
------------------------------------------
-- Calculate the sum of gross from the year 2000 or later
select sum(gross) as total_gross
from films
where release_year >=2000;

-- Calculate the average gross of films that start with A
select avg(gross) as avg_gross_A
from films
where title  like'A%';

-- Calculate the lowest gross film in 1994select avg(gross) as avg_gross_A
select min(gross) as lowest_gross
from films
where release_year=1994;

-- Calculate the highest gross film released between 2000-2012
select max(gross) as highest_gross
from films
where release_year between 2000 and 2012; 

Using ROUND()
--------------
-- Round the average number of facebook_likes to one decimal place
select round(avg (facebook_likes),1) as avg_facebook_likes
from reviews;

-- Calculate the average budget rounded to the thousands
select round(avg(budget),-3) as avg_budget_thousands
from films;

#--Using arithmetic
--------------------
-- Calculate the title and duration_hours from films
SELECT title,(duration/60.0) as duration_hours
FROM films;

-- Calculate the percentage of people who are no longer alive
SELECT count(deathdate)* 100.0 / count(*) AS percentage_dead
FROM people;

-- Find the number of decades in the films table
SELECT (MAX(release_year) - MIN(release_year)) / 10.0 AS number_of_decades
FROM films;

--Rounding
------------
-- Round duration_hours to two decimal places
SELECT title, round(duration / 60.0,2 )AS duration_hours
FROM films;

--------------------------
#Sorting and Grouping-Part 3
--------------------------
-- Select name from people and sort alphabetically
select name from people
order by name asc;

-- Select the title and duration from longest to shortest film
select title, duration
from films
order by duration desc;

-- Select the release year, duration, and title sorted by release year and duration
select release_year, duration,title
from films
order by release_year,duration;

-- Select the certification, release year, and title sorted by certification and release year
select certification, release_year,title
from films
order by certification asc,release_year desc;





