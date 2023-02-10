USE classicmodels;
SHOW TABLES;

/*  common table expression is a named temporary result set,
that exists only within the execution scope of a single SQL statement e.g.,SELECT, INSERT, UPDATE, or DELETE.
Similar to a derived table, a CTE is not stored as an object and last only during the execution of a query. 
WITH cte_name (column_list) AS (
    query
) 
SELECT * FROM cte_name; */

SELECT * FROM customers;

SELECT 
	customerName, state
FROM
	customers
WHERE
	country = 'USA';

WITH customers_in_usa AS (
    SELECT 
        customerName, state
    FROM
        customers
    WHERE
        country = 'USA'
) SELECT 
    customerName
 FROM
    customers_in_usa
 WHERE
    state = 'CA'
 ORDER BY 
	customerName;
