#Introduction to SQL_Datacamp
--------------------------------------------
--Use SQL to return a result set of all book titles included in the books table.
select title from books; 

--Select both the title and author fields from books.
select title, author from books;

--Select all fields from the books table.
select * from books;

--Write SQL code that returns a result set with just one column listing the unique authors in the books table.
select distinct author from books;

-- Select unique authors and genre combinations from the books table
SELECT distinct author, genre  
FROM books;

-- Alias author so that it becomes unique_author
SELECT DISTINCT author as unique_author
FROM books;

--Add a single line of code that saves the results of the written query as a view called library_authors.
create view library_authors AS
SELECT DISTINCT author AS unique_author
FROM books;

--Using PostgreSQL, select the genre field from the books table; limit the number of results to 10.
select genre
from books
limit 10;



