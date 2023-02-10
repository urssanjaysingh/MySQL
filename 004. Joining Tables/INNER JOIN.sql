USE classicmodels;
SHOW TABLES;

/* The INNER JOIN matches each row in one table with every row in other tables 
and allows you to query rows that contain columns from both tables. */

SELECT * FROM products;

SELECT * FROM productlines;

/* Suppose you want to get:
    The productCode and productName from the products table.
    The textDescription of product lines from the productlines table. */
SELECT 
    productCode, 
    productName, 
    textDescription
FROM
    products
INNER JOIN 
	productlines USING (productline);

-- INNER JOIN with GROUP BY 
SELECT * FROM orderdetails;
SELECT * FROM orders;

SELECT 
    orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders
INNER JOIN 
	orderdetails USING (orderNumber)
GROUP BY 
	orderNumber;
    
-- Joining three tables
SELECT * FROM products;
SELECT * FROM orderdetails;
SELECT * FROM orders;

SELECT 
    orderNumber,
    orderDate,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN 
	orderdetails USING (orderNumber)
INNER JOIN
    products USING (productCode)
ORDER BY 
    orderNumber, 
    orderLineNumber;
    
-- Joining four tables;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM customers;

 SELECT 
    orderNumber,
    orderDate,
    customerName,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN orderdetails 
    USING (orderNumber)
INNER JOIN products 
    USING (productCode)
INNER JOIN customers 
    USING (customerNumber)
ORDER BY 
    orderNumber, 
    orderLineNumber;
    
-- INNER JOIN using other operators
SELECT * FROM products;
SELECT * FROM orderdetails;

SELECT 
    orderNumber, 
    productName, 
    msrp, 
    priceEach
FROM
    products p
INNER JOIN orderdetails o 
   ON p.productcode = o.productcode
      AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';