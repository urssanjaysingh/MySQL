USE classicmodels;

/* DROP TABLE 
To remove existing tables, you use the MySQL DROP TABLE statement. */

/* -- Using MySQL DROP TABLE to drop a single table */
-- First, create a table named insurances for testing purpose:
CREATE TABLE insurances (
    id INT AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    effectiveDate DATE NOT NULL,
    duration INT NOT NULL,
    amount DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);

-- Second, use the DROP TABLE to delete the insurances table:
DROP TABLE insurances;

/* Using MySQL DROP TABLE to drop multiple tables */
-- First, create two tables named CarAccessories and CarGadgets:
CREATE TABLE CarAccessories (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE CarGadgets (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DEC(10 , 2 ) NOT NULL,
    PRIMARY KEY(id)
);

-- Second, use the DROP TABLE statement to drop the two tables:
DROP TABLE CarAccessories, CarGadgets;

/* MySQL DROP TABLE to drop a non-existing table */
 DROP TABLE IF EXISTS aliens;
 
 -- MySQL issued a warning instead:
 SHOW WARNINGS;
 
 /* DROP TABLE based on a pattern */
 -- Suppose that you have many tables whose names start with test in your database,
 -- and you want to remove all of them using a single DROP TABLE statement.
 
 -- First, create three tables test1,test2, test4 for demonstration:
 CREATE TABLE test1(
  id INT AUTO_INCREMENT,
  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS test2 LIKE test1;
CREATE TABLE IF NOT EXISTS test3 LIKE test1;

-- Suppose you that want to remove all test* tables.
-- Second, declare two variables that accept database schema,
-- and a pattern that you want to the tables to match:
-- set table schema and pattern matching for tables

SET @schema = 'classicmodels';
SET @pattern = 'test%';

-- Third, construct a dynamic DROP TABLE statement:
-- construct dynamic sql (DROP TABLE tbl1, tbl2...;)

SELECT CONCAT('DROP TABLE ',GROUP_CONCAT(CONCAT(@schema,'.',table_name)),';')
INTO @droplike
FROM information_schema.tables
WHERE @schema = database()
AND table_name LIKE @pattern;

/* Basically, the query instructs MySQL to go to the information_schema  table, 
which contains information on all tables in all databases, 
and to concatenate all tables in the database @schema ( classicmodels ),
that matches the pattern @pattern ( test% ) with the prefix DROP TABLE. 
The GROUP_CONCAT function creates a comma-separated list of tables. */

-- Fourth, display the dynamic SQL to verify if it works correctly:
-- display the dynamic sql statement
SELECT @droplike;

-- Fifth, execute the statement using a prepared statement  as shown in the following query:
-- execute dynamic sql
PREPARE stmt FROM @droplike;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Putting it all together.

-- set table schema and pattern matching for tables
SET @schema = 'classicmodels';
SET @pattern = 'test%';

-- build dynamic sql (DROP TABLE tbl1, tbl2...;)
SELECT CONCAT('DROP TABLE ',GROUP_CONCAT(CONCAT(@schema,'.',table_name)),';')
INTO @droplike
FROM information_schema.tables
WHERE @schema = database()
AND table_name LIKE @pattern;

-- display the dynamic sql statement
SELECT @droplike;

-- execute dynamic sql
PREPARE stmt FROM @droplike;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

/* So if you want to drop multiple tables that have a specific pattern in a database, 
you just use the script above to save time. 
All you need to do is replacing the pattern and the database schema in @pattern and @schema variables. */
