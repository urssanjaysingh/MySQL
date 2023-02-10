USE classicmodels;
SHOW TABLES;

/* When querying data from a table, you may get duplicate rows. 
To remove these duplicate rows, you use the DISTINCT clause in the SELECT statement. */
SELECT * FROM employees;

SELECT 
	DISTINCT lastName
FROM
	employees
ORDER BY 
	lastName;
    
-- MySQL DISTINCT with multiple columns
SELECT * FROM customers;

/* When you specify multiple columns in the DISTINCT clause, 
the DISTINCT clause will use the combination of values in these columns, 
to determine the uniqueness of the row in the result set. */
SELECT 
	DISTINCT state, city
FROM 
	customers
WHERE
	state IS NOT NULL
ORDER BY
	state, city;
