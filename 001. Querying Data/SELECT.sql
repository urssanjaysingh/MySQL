USE classicmodels;

/* SELECT statement without the FROM clause */
SELECT 1+1;

/* MySQL has many built-in functions like string, date, and Math functions. 
And you can use the SELECT statement to execute these functions. */

-- The NOW() function returns the current date & time of the server on which MySQL runs.
SELECT NOW();

-- The CONCAT() function accepts one or more strings and concatenates them into a single string.
SELECT CONCAT('Sanjay',' ','Singh');

/* By default, MySQL uses the expression specified in the SELECT clause as the column name of the result set. 
To change a column name of the result set, you can use a column alias */

SELECT CONCAT('Sanjay',' ','Singh') AS Name;

-- If the column alias contains spaces, you need to place it inside quotes
SELECT CONCAT('Sanjay',' ','Singh') AS 'Full Name';
