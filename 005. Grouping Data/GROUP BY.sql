USE classicmodels;
SHOW TABLES;

/* The GROUP BY clause returns one row for each group. In other words, it reduces the number of rows in the result set. */
SELECT * FROM orders;

/* Suppose you want to group values of the order’s status into subgroups, 
you use the GROUP BY clause with the status column */
SELECT 
    status
FROM
    orders
GROUP BY 
	status;

-- Using MySQL GROUP BY with aggregate functions
-- if you want to know the number of orders in each status, 
-- you can use the COUNT function with the GROUP BY clause as follows
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY 
	status;
    
SELECT * FROM orders;
SELECT * FROM orderdetails;

-- To get the total amount of all orders by status, 
-- you join the orders table with the orderdetails table 
-- and use the SUM function to calculate the total amount.
SELECT 
    status, 
    SUM(quantityOrdered * priceEach) AS amount
FROM
    orders
INNER JOIN 
	orderdetails USING (orderNumber)
GROUP BY 
    status;
    
-- returns the order numbers and the total amount of each order.
SELECT 
    orderNumber,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orderdetails
GROUP BY 
    orderNumber;
    
/* MySQL GROUP BY with HAVING clause */
-- To filter the groups returned by GROUP BY clause, you use a  HAVING clause.
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY 
    year
HAVING 
    year > 2003;
