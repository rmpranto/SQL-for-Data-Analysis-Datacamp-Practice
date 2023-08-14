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

SELECT 
    c1.name AS city,
    code,
    c2.name AS country,
    region,
    city_proper_pop
FROM cities AS c1
-- Perform an inner join with cities as c1 and countries as c2 on country code
INNER JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code DESC;


SELECT c1.name AS city, code, c2.name AS country,region, city_proper_pop
FROM cities AS c1
-- Join right table (with alias)
left join countries as c2
ON c1.country_code = c2.code
ORDER BY code DESC;\

SELECT name, region, gdp_percapita
FROM countries AS c
LEFT JOIN economies AS e
-- Match on code fields
ON c.code=e.code
-- Filter for the year 2010
where year=2010
order by year desc;

-- Select region, and average gdp_percapita as avg_gdp
select region,avg(gdp_percapita) as  avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
-- Group by region
GROUP BY region;


SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
GROUP BY region
-- Order by descending avg_gdp
order by avg_gdp desc
-- Return only first 10 records
limit 10;

--Perform a full join with countries (left) and currencies (right).Filter for the North America region or NULL country names.
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
full join  currencies
USING (code)
-- Where region is North America or name is null
WHERE region='North America' or name is NULL
ORDER BY region;


--Complete the FULL JOIN with countries as c1 on the left and languages as l on the right, using code to perform this join.Next, chain this join with another FULL JOIN, placing currencies on the right, joining on code again.
SELECT c1.name AS country, region, l.name AS language,basic_unit, frac_unit
FROM countries as c1 
-- Full join with languages (alias as l)
FULL JOIN languages as l 
USING(code)
-- Full join with currencies (alias as c2)
FULL JOIN currencies AS c2
USING(code)
WHERE region LIKE 'M%esia';

SELECT c.name AS country, l.name AS language
-- Inner join countries as c with languages as l on code
FROM countries AS c
inner join languages as l
on c.code=l.code
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');


SELECT c.name AS country, l.name AS language
FROM countries AS c        
-- Perform a cross join to languages (alias as l)
cross join languages as l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');

--You will determine the names of the five countries and their respective regions with the lowest life expectancy for the year 2010. Use your knowledge about joins, filtering, sorting and limiting to create this list!

SELECT c.name AS country,region,life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
inner join populations as p 
ON c.code = p.country_code
-- Filter for only results in the year 2010
where year ='2010'
-- Sort by life_exp
order by life_exp
-- Limit to five records
limit  5;


-- Select aliased fields from populations as p1
select p1.country_code,p1.size as size2010,p2.size as size2015
-- Join populations as p1 to itself, alias as p2, on country code
from populations as p1 
inner join populations as p2
on p1.country_code=p2.country_code
-- Filter such that p1.year is always five years before p2.year
and p1.year=p2.year-5;

------------------------------------------------
Set Theory for SQL Joins- part 3
------------------------------------------------
-- Select all fields from economies2015
select * from economies2015   
-- Set operation
union
-- Select all fields from economies2019
select * from economies2019
ORDER BY code, year;

	
-- Query that determines all pairs of code and year from economies and populations, without duplicates
select code,year
from economies
union
select country_code,year
from populations;

-- Return all cities with the same name as a country
select name
from countries
intersect
select name
from cities;

-- Return all cities that do not have the same name as a country
select name
from cities
except
select name 
from countries
ORDER BY name;


------------------------------------------------
 Subqueries-part 3
------------------------------------------------

-- Select country code for countries in the Middle East
select code,region
from countries
where region in(
    select region
    from countries
    where region='Middle East');

--Create a semi join out of the two queries you've written, which filters unique languages returned in the first query for only those languages spoken in the 'Middle East'
SELECT DISTINCT name
FROM languages
-- Add syntax to use bracketed subquery below as a filter
WHERE code IN
  (SELECT code
  FROM countries
  WHERE region = 'Middle East')
ORDER BY name;


SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN
    (SELECT code
    FROM currencies);

--The answer from your query has now been nested into another query; use this calculation to filter populations for all records where life_expectancy is 1.15 times higher than average.
SELECT *
FROM populations
-- Filter for only those populations where life expectancy is 1.15 times higher than average
WHERE life_expectancy > 1.15 *
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015) 
    AND year = 2015;

--get the urban area population for capital cities only. You'll use the countries and cities tables displayed in the console to help identify columns of interest as you build your query.
-- Select relevant fields from cities table
SELECT name, country_code, urbanarea_pop
FROM cities
-- Filter using a subquery on the countries table
WHERE name IN
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;


-- Find top nine countries with the most cities
SELECT countries.name AS country, COUNT(*) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code
GROUP BY country
-- Order by count of cities as cities_num
ORDER BY cities_num DESC, country
LIMIT 9;


SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
   FROM cities
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;


-- Select local_name and lang_num from appropriate tables
SELECT local_name, sub.lang_num
FROM countries,
    (SELECT code, COUNT(*) AS lang_num
     FROM languages
     GROUP BY code) AS sub
-- Where codes match    
WHERE countries.code = sub.code
ORDER BY lang_num DESC;


-- Select relevant fields
select code, inflation_rate,unemployment_rate 
from economies
WHERE year = 2015 
  AND code NOT IN
-- Subquery returning country codes filtered on gov_form
	(select code
   from countries
    where code = 'Republic' or code='Monarchy')
ORDER BY inflation_rate;


--Suppose you're interested in analyzing inflation and unemployment rate for certain countries in 2015. You are not interested in countries with "Republic" or "Monarchy" as their form of government, but are interested in all other forms of government, such as emirate federations, socialist states, and commonwealths.
-- Select relevant fields
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code NOT IN
-- Subquery returning country codes filtered on gov_form
    (SELECT code
     FROM countries
     WHERE (gov_form LIKE '%Monarchy%' OR gov_form LIKE '%Republic%'))
ORDER BY inflation_rate;



--Your task is to determine the top 10 capital cities in Europe and the Americas by city_perc, a metric you'll calculate. city_perc is a percentage that calculates the "proper" population in a city as a percentage of the total population in the wider metro area, as follows:
--city_proper_pop / metroarea_pop * 100Do not use table aliasing in this exercise.

-- Select fields from cities
select cities.name, country_code, city_proper_pop,metroarea_pop, city_proper_pop / metroarea_pop * 100 AS city_perc
-- Use subquery to filter city name
from cities
where cities.name in
(select capital
from countries
where (continent = 'Europe' OR continent LIKE '%America'))
-- Add filter condition such that metroarea_pop does not have null values
and metroarea_pop IS NOT NULL
-- Sort and limit the result
Order by city_perc desc
limit 10
