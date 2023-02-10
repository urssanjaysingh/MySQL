USE classicmodels;
SHOW TABLES;

/* View Processing Algorithms
The CREATE VIEW and ALTER VIEW statements have an optional clause: ALGORITHM. 
The algorithm determines how MySQL process a view,
 and can take one of three values MERGE, TEMPTABLE, and UNDEFINE. */
 
 /* MERGE 
 When you query from a MERGE view, MySQL processes the following steps:
    First, merge the input query with the SELECT statement in the view definition into a single query.
    Then, execute the combined query to return the result set.
Note that the combination of input query and the SELECT statement of the view definition,
 into a single query is referred to as view resolution. */
 
SELECT * FROM customers;

-- The following statement creates a view based on the customers table,
-- with the name contactPersons with the MERGE algorithm:
CREATE ALGORITHM=MERGE VIEW contactPersons(
    customerName, 
    firstName, 
    lastName, 
    phone
) AS
SELECT 
    customerName, 
    contactFirstName, 
    contactLastName, 
    phone
FROM customers;

-- Suppose that you issue the following statement:
SELECT * FROM contactPersons
WHERE customerName LIKE '%Co%';

-- MySQL performs these steps:
--    Convert view name contactPersons to table name customers.
--    Convert askterisk (*)  to a list column names customerName, firstName, lastName, phone, 
--		which corresponds to customerName, contactFirstName, contactLastName, phone.
--    Add the WHERE clause.

-- The resulting statement is:
SELECT 
    customerName, 
    contactFirstName, 
    contactLastName, 
    phone
FROM
    customers
WHERE
    customerName LIKE '%Co%';
    
/* TEMPTABLE
When you issue a query to a TEMPTABLE view, MySQL performs these steps:
    First, create a temporary table to store the result of the SELECT in the view definition.
    Then, execute the input query against the temporary table.
Note that TEMPTABLE views cannot be updatable. */

/* UNDEFINED
The UNDEFINED is the default algorithm when you create a view without specifying the ALGORITHM clause,
-- or you explicitly specify ALGORITHM=UNDEFINED. */
