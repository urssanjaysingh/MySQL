USE classicmodels;
SHOW TABLES;

/* In other words, the RIGHT JOIN returns all rows from the right table,
regardless of having matching rows from the left table or not. */

SELECT * FROM customers;
SELECT * FROM employees;

SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN 
	employees 
ON 
	salesRepEmployeeNumber = employeeNumber
ORDER BY 
	employeeNumber;
    
-- find unmatching rows
SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN 
	employees 
ON 
	salesRepEmployeeNumber = employeeNumber
WHERE 
	customerNumber is NULL
ORDER BY 
	employeeNumber;
    