USE classicmodels;
SHOW TABLES;

/* Sometimes, column names are so technical that make the query’s output very difficult to understand. 
To give a column a descriptive name, you can use a column alias. */
SELECT * FROM employees;

SELECT
	concat_ws(', ', firstName, lastName) AS 'Full Name'
FROM
	employees;
    
/* In MySQL, you can use the column alias in the ORDER BY, GROUP BY and HAVING clauses to refer to the column. */
-- With ORDER BY 
SELECT
	CONCAT_WS(', ', lastName, firstname) `Full name`
FROM
	employees
ORDER BY
	`Full name`;

SELECT * FROM orderdetails;

-- With GROUP BY
SELECT 
	orderNumber AS 'Order no.',
    SUM(priceEach * quantityOrdered) AS Total
FROM
	orderdetails
GROUP BY
	'Order no.'
HAVING
	total > 60000;
    
/* Alias for table */
SELECT 
    e.firstName, 
    e.lastName
FROM
    employees AS e
ORDER BY e.firstName;