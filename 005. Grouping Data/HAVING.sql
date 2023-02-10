USE classicmodels;
SHOW TABLES;

/* The HAVING clause is used in the SELECT statement to specify filter conditions for a group of rows or aggregates.
The HAVING clause is often used with the GROUP BY clause to filter groups based on a specified condition. */

SELECT * FROM orderdetails;

-- find which order has total sales greater than 1000 
-- and contain more than 600 items by using the HAVING clause
SELECT 
	orderNumber,
    SUM(quantityOrdered) AS itemCount,
    SUM(priceEach * quantityOrdered) AS total
FROM
	orderdetails
GROUP BY
	orderNumber
HAVING 
	total > 1000 AND itemCount > 600;
    
