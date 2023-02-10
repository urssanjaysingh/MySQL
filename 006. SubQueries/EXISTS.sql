USE classicmodels;
SHOW TABLES;

/* The EXISTS operator is a Boolean operator that returns either true or false. 
The EXISTS operator is often used to test for the existence of rows returned by the subquery.
If the subquery returns at least one row, the EXISTS operator returns true, otherwise, it returns false. 
In addition, the EXISTS operator terminates further processing immediately once it finds a matching row, 
which can help improve the performance of the query. */

SELECT * FROM customers;
SELECT * FROM orders;

-- find the customer who has at least one order
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS
    (
		SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customernumber
	);
       
-- find customers who do not have any orders
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    NOT EXISTS
    ( 
		SELECT 
            1
        FROM
            orders
        WHERE
            orders.customernumber = customers.customernumber
	);
            
/* UPDATE EXISTS */
SELECT * FROM offices;
SELECT * FROM employees;

-- finds employees who work at the office in San Franciso
SELECT 
    employeenumber, 
    firstname, 
    lastname, 
    extension
FROM
    employees
WHERE
    EXISTS
    ( 
        SELECT 
            1
        FROM
            offices
        WHERE
            city = 'San Francisco' 
            AND 
			offices.officeCode = employees.officeCode
	);
    
-- adds the number 1 to the phone extension of employees who work at the office in San Francisco
UPDATE employees 
SET 
    extension = CONCAT(extension, '1')
WHERE
    EXISTS
    ( 
        SELECT 
            1
        FROM
            offices
        WHERE
            city = 'San Francisco'
			AND 
            offices.officeCode = employees.officeCode
	);
    
/* INSERT EXISTS */
SELECT * FROM customers;
SELECT * FROM orders;

-- Suppose that you want to archive customers 
-- who don’t have any sales order in a separate table. To do this, you use these steps:

-- First, create a new table for archiving the customers by copying the structure from the customers table
CREATE TABLE customers_archive 
LIKE customers;

DESCRIBE customers_archive;

-- Second, insert customers who do not have any sales order into the customers_archive table
INSERT INTO customers_archive
SELECT * 
FROM customers
WHERE 
	NOT EXISTS
    ( 
	SELECT 
		1
	FROM
       orders
	WHERE
       orders.customernumber = customers.customernumber
	);
  
-- Third, query data from the customers_archive table to verify the insert operation.
SELECT * FROM customers_archive;

/* DELETE EXISTS */
SELECT * FROM customers;

-- One final task in archiving the customer data is to delete the customers that exist in the customers_archive table from the customers table.
-- To do this, you use the EXISTS operator in WHERE clause of the DELETE statement as follows:
DELETE FROM customers
WHERE 
	EXISTS
    ( 
		SELECT 
			1
		FROM
			customers_archive a
		
		WHERE
			a.customernumber = customers.customerNumber
	);

SELECT * FROM customers;










