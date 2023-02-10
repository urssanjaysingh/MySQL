USE classicmodels;
SHOW TABLES;

/* LEFT JOIN returns all rows from the left table,
regardless of whether a row from the left table has a matching row from the right table or not.
If there is no match, the columns of the row from the right table will contain NULL. */

SELECT * FROM customers;
SELECT * FROM orders;

SELECT
	customerNumber,
	customerName,
	orderNumber,
	status
FROM
	customers
LEFT JOIN 
	orders USING (customerNumber);
    
-- find unmatched rows
SELECT
	customerNumber,
	customerName,
	orderNumber,
	status
FROM
	customers
LEFT JOIN 
	orders USING (customerNumber)
WHERE 
	orderNumber IS NULL;
    
-- Joining three tables;
SELECT 
    lastName, 
    firstName, 
    customerName, 
    checkNumber, 
    amount
FROM
    employees
LEFT JOIN 
	customers ON employeeNumber = salesRepEmployeeNumber
LEFT JOIN 
	payments USING(customerNumber)
ORDER BY 
    customerName, 
    checkNumber;
    
-- Condition in WHERE clause vs. ON clause
SELECT 
    orderNumber, 
    customerNumber, 
    productCode
FROM
    orders
LEFT JOIN 
	orderDetails USING (orderNumber)
WHERE
    orderNumber = 10123;

SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;
