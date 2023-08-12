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
