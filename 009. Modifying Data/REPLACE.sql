
/* MySQL REPLACE */

/* -- REPLACE to insert a new row */

-- First, create a new table named cities as follows:
CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    population INT NOT NULL
);

-- Next, insert some rows into the cities table:
INSERT INTO cities(name,population)
VALUES('New York',8008278),
	  ('Los Angeles',3694825),
	  ('San Diego',1223405);
      
SELECT * FROM cities;

-- After that, use the REPLACE statement to update the population of the Los Angeles city to 3696820.
REPLACE INTO cities(id,population)
VALUES(2,3696820);

SELECT * FROM cities;
-- REPLACE statement deleted the row with id 2
-- and inserted a new row with the same id 2 and population 3696820. 
-- Because no value is specified for the name column, it was set to NULL.

/* REPLACE statement to update a row */
-- REPLACE statement to update the population of the Phoenix city to 1768980:
REPLACE INTO cities
SET id = 4,
    name = 'Phoenix',
    population = 1768980;
    
SELECT * FROM cities;

/* REPLACE to insert data from a SELECT statement */
-- The following statement uses the REPLACE INTO statement to copy a row within the same table:
REPLACE INTO 
    cities(name,population)
SELECT 
    name,
    population 
FROM 
   cities 
WHERE id = 1;

SELECT * FROM cities;