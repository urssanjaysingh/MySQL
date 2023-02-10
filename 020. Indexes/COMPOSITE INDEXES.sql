USE classicmodels;
SHOW TABLES;

/* Composite Index
A composite index is an index on multiple columns. 
MySQL allows you to create a composite index that consists of up to 16 columns.
A composite index is also known as a multiple-column index. */

-- We will use the employees table in the sample database for the demonstration.
SELECT * FROM employees;

-- The following statement creates a composite index over the lastName and firstName columns:

CREATE INDEX name 
ON employees(lastName, firstName);

-- First, the name index can be used for lookups in the queries ,
-- that specify a lastName value because the lastName column is the leftmost prefix of the index.
-- Second, the name index can be used for queries that specify values,
-- for the combination of the lastName and firstName values.

-- The name index, therefore, is used for lookups in the following queries:

-- Find employees whose last name is Patterson
SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson';

-- This query uses the name index because the leftmost prefix of the index, 
-- which is the lastName column, is used for lookups.

-- You can verify this by adding the EXPLAIN clause to the query:
EXPLAIN SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson';

-- Find employees whose last name is Patterson and the first name is Steve:
SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson' AND
    firstName = 'Steve';

-- In this query, both lastName and firstName columns are used for lookups,
-- therefore, it uses the name index.

-- Let’s verify it:
EXPLAIN SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson' AND
    firstName = 'Steve';

-- Find employees whose last name is Patterson and first name is Steve or Mary:
SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson' AND
    (firstName = 'Steve' OR 
    firstName = 'Mary');

-- This query is similar to the second one which both lastName and firstName columns are used for lookups.

-- The following statement verifies the index usage:
EXPLAIN SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    lastName = 'Patterson' AND
    (firstName = 'Steve' OR 
    firstName = 'Mary');

-- The query optimizer cannot use the name index for lookups 
-- in the following queries because only the firstName column which is not the leftmost prefix of the index is used:
SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    firstName = 'Leslie';

-- Similarly, the query optimizer cannot use the name index,
--  for the lookups in the following query because either the firstName or lastName column is used for lookups.
SELECT 
    firstName, 
    lastName, 
    email
FROM
    employees
WHERE
    firstName = 'Anthony' OR
    lastName = 'Steve';
