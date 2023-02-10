USE classicmodels;
SHOW TABLES;

/* When you use the SELECT statement to query data from a table, the order of rows in the result set is unspecified. 
To sort the rows in the result set, you add the ORDER BY clause to the SELECT statement. */

/* Using MySQL ORDER BY clause to sort the result set by one column */
SELECT * FROM customers;

-- ascending order
SELECT
	contactFirstname,
	contactLastname
FROM
	customers
ORDER BY
	contactFirstname;
    
-- descending order
SELECT
	contactFirstname,
	contactLastname
FROM
	customers
ORDER BY
	contactFirstname DESC;
    
-- Using MySQL ORDER BY clause to sort the result set by multiple columns
SELECT 
	contactFirstname,
    contactLastname
FROM 
	customers
ORDER BY
	contactFirstname ASC,
    contactLastname DESC;
    
-- Using MySQL ORDER BY clause to sort a result set by an expression
SELECT * FROM orderdetails;

SELECT ALL
	orderNumber,
    orderlinenumber,
    quantityOrdered * priceEach AS subtotal
FROM
	orderdetails
ORDER BY
	subtotal DESC;
    
/* Using MySQL ORDER BY clause to sort data using a custom list
FIELD(str, str1, str2, ...)
The FIELD() function returns the position of the str in the str1, str2, … list. 
If the str is not in the list, the FIELD() function returns 0. */
SELECT * FROM orders;

SELECT 
    orderNumber, status
FROM
    orders
ORDER BY 
	FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');
