-------------------------------
Introducing Inner Joins- part 1
---------------------------------

SELECT * 
FROM cities
-- Inner join to countries
inner join countries
-- Match on country codes
on cities.country_code=countries.code;


-- Select name fields (with alias) and region 
SELECT cities.name AS city, countries.name AS country, region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;


-- Select fields with aliases
select e.year,e.inflation_rate,name,year,inflation_rate
FROM countries AS c
-- Join to economies (alias e)
inner join  economies as e
-- Match on code field using table aliases
on e.code=e.code;


-- Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e
-- Match on code field using table aliases
ON c.code = e.code;


-- Select country and language names, aliased
select c.name as country,l.name as language
-- From countries (aliased)
from countries as c
-- Join to languages (aliased)
inner join languages as l
-- Use code as the joining field with the USING keyword
using (code);


-- Rearrange SELECT statement, keeping aliases
SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l
USING(code)
-- Order the results by language
order by language;

--Multiple joins
----------------
-- Select relevant fields
--Perform an inner join of countries AS c (left) with populations AS p (right), on code. Select name, year and fertility_rate.

SELECT name, year, fertility_rate
-- Inner join countries and populations, aliased, on code
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code;

--Chain another inner join to your query with the economies table AS e, using code.Select name, and using table aliases, select year and unemployment_rate from economies.
-- Select fields
SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
-- Join to economies (as e)
INNER JOIN economies AS e

  
  SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
-- Add an additional joining condition such that you are also joining on year
	AND e.year = p.year;
-- Match on country code
ON c.code = e.code;

------------------------------------------------
Outer Joins, Cross Joins and Self Joins- part 2
------------------------------------------------

