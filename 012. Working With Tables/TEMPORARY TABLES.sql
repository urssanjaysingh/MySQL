USE classicmodels;
SHOW TABLES;

/* Temporary Table */
/* A temporary table is very handy when it is impossible or expensive to query data
that requires a single SELECT statement with the JOIN clauses. 
In this case, you can use a temporary table to store the immediate result
and use another query to process it. */

-- CREATE TEMPORARY TABLE
CREATE TEMPORARY TABLE credits(
    customerNumber INT PRIMARY KEY,
    creditLimit DEC(10,2)
);

-- Then, insert rows from the customers table into the temporary table credits:
SELECT * FROM customers;

INSERT INTO credits(customerNumber,creditLimit)
SELECT customerNumber, creditLimit
FROM customers
WHERE creditLimit > 0;

-- Creating a temporary table whose structure based on a query
-- The following example creates a temporary table that stores the top 10 customers by revenue.
CREATE TEMPORARY TABLE top_customers
SELECT p.customerNumber, 
       c.customerName, 
       ROUND(SUM(p.amount),2) sales
FROM payments p
INNER JOIN customers c ON c.customerNumber = p.customerNumber
GROUP BY p.customerNumber
ORDER BY sales DESC
LIMIT 10;

-- Now, you can query data from the top_customers temporary table like querying from a permanent table:
SELECT 
    customerNumber, 
    customerName, 
    sales
FROM
    top_customers
ORDER BY sales;
