USE classicmodels;
SHOW TABLES;

/* A MySQL subquery is a query nested within another query such as SELECT, INSERT, UPDATE or DELETE. 
Also, a subquery can be nested within another subquery.
A MySQL subquery is called an inner query while the query that contains the subquery is called an outer query. 
A subquery can be used anywhere that expression is used and must be closed in parentheses. */

SELECT * FROM employees;

SELECT officeCode FROM offices WHERE country = 'USA';

SELECT 
	firstName, lastName
FROM
	employees
WHERE
	officeCode IN ( SELECT officeCode FROM offices WHERE country = 'USA' );
    
/* Using a MySQL subquery in the WHERE clause */
SELECT * FROM payments;

-- who has the highest payment.
SELECT MAX(amount) FROM payments;

-- MySQL subquery with comparison operators
SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount = ( SELECT MAX(amount) FROM payments );
    
-- First, get the average payment by using a subquery.
SELECT AVG(amount) FROM payments;

SELECT 
    customerNumber, 
    checkNumber, 
    amount
FROM
    payments
WHERE
    amount > ( SELECT AVG(amount) FROM payments );
    
/* MySQL subquery with IN and NOT IN operators */
SELECT * FROM customers;
SELECT * FROM orders;

SELECT DISTINCT customerNumber FROM orders;

-- find the customers who have not placed any orders as follows:
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN ( SELECT DISTINCT customerNumber FROM orders );
    
/* subquery in the FROM clause 
When you use a subquery in the FROM clause, the result set returned from a subquery is used as a temporary table. 
This table is referred to as a derived table or materialized subquery. */

SELECT 
	orderNumber, COUNT(orderNumber) AS items
FROM
	orderdetails
GROUP BY 
	orderNumber;

-- finds the maximum, minimum, and average number of items in sale orders
SELECT 
    MAX(items), 
    MIN(items), 
    FLOOR(AVG(items))
FROM
    (SELECT 
		orderNumber, COUNT(orderNumber) AS items
	FROM
		orderdetails
	GROUP BY 
		orderNumber) AS lineitems;
-- Note that the FLOOR() is used to remove decimal places from the average values of items.

/* correlated subquery 
Unlike a standalone subquery, a correlated subquery is a subquery that uses the data from the outer query. 
In other words, a correlated subquery depends on the outer query. */
SELECT * FROM products;

-- select products whose buy prices are greater than the average buy price of all products in each product line.
SELECT 
    productname, 
    buyprice
FROM
    products AS p1
WHERE
    buyprice > (SELECT 
					AVG(buyprice)
				FROM
					products
				WHERE
					productline = p1.productline);
/* In this example, both outer query and correlated subquery reference the same products table. 
Therefore, we need to use a table alias p1 for the products table in the outer query.
Unlike a regular subquery, you cannot execute a correlated subquery independently */

/* subquery with EXISTS and NOT EXISTS 
if the subquery returns any rows, EXISTS subquery returns TRUE, otherwise, it returns FALSE. */
SELECT * FROM orderdetails;
SELECT * FROM orders;

-- finds sales orders whose total values are greater than 60K.
SELECT 
    orderNumber, 
    SUM(priceEach * quantityOrdered) total
FROM
    orderdetails
INNER JOIN
    orders USING (orderNumber)
GROUP BY 
	orderNumber
HAVING 
	SUM(priceEach * quantityOrdered) > 60000;

-- You can use the query above as a correlated subquery to find customers 
-- who placed at least one sales order with the total value greater than 60K by using the EXISTS operator:
SELECT 
    customerNumber, 
    customerName
FROM
    customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
			FROM
				orderdetails
					INNER JOIN
				orders USING (orderNumber)
			WHERE
				customerNumber = customers.customerNumber
			GROUP BY 
				orderNumber
			HAVING 
				SUM(priceEach * quantityOrdered) > 60000);
                
