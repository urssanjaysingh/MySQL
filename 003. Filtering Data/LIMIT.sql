USE classicmodels;
SHOW TABLES;

/* The LIMIT clause is used in the SELECT statement to constrain the number of rows to return. 
The LIMIT clause accepts one or two arguments. 
The values of both arguments must be zero or positive integers. */

SELECT * FROM customers;

-- Using MySQL LIMIT to get the highest or lowest rows
SELECT 
	customerNumber,
    customerName,
    creditLimit
FROM
	customers
ORDER BY
	creditLimit DESC
LIMIT 5;
    
SELECT 
    customerNumber, 
    customerName, 
    creditLimit
FROM
    customers
ORDER BY 
	creditLimit, customerNumber
LIMIT 5;

/* Using MySQL LIMIT clause for pagination
When you display data on the screen, you often want to divide rows into pages,
where each page contains a limited number of rows like 10 or 20. */

SELECT * FROM customers;

-- get rows of page 1 which contains the first 10 customers
SELECT 
	customerNumber,
	customerName
FROM
	customers
ORDER BY 
	customerNumber
LIMIT 10;

-- get the rows of the second page that include rows 11 – 20 
SELECT 
    customerNumber, 
    customerName
FROM
    customers
ORDER BY customerNumber   
LIMIT 10, 10;

/* Using MySQL LIMIT to get the nth highest or lowest value */
SELECT * FROM customers ORDER BY creditLimit DESC;

-- For example, the following finds the customer who has the second-highest credit */
SELECT
	customerName,
    creditLimit
FROM
	customers
ORDER BY
	creditLimit DESC
LIMIT 1, 1;

/* MySQL LIMIT & DISTINCT clauses 
If you use the LIMIT clause with the DISTINCT clause, 
MySQL immediately stops searching when it finds the number of unique rows specified in the LIMIT clause.*/
SELECT DISTINCT
    state
FROM
    customers
WHERE
    state IS NOT NULL
LIMIT 5;
