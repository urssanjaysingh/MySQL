USE classicmodels;
SHOW TABLES;

/* The BETWEEN operator is a logical operator that specifies whether a value is in a range or not. 
To negate the BETWEEN operator, we use the NOT operator */
SELECT 15 BETWEEN 10 AND 20;

SELECT 15 NOT BETWEEN 10 AND 20;

-- Using MySQL BETWEEN with number
SELECT * FROM products;

SELECT
	productCode,
    productName,
    buyPrice
FROM
	products
WHERE
	buyPrice BETWEEN 90 AND 100;
    
SELECT
	productCode,
    productName,
    buyPrice
FROM
	products
WHERE
	buyPrice NOT BETWEEN 90 AND 100;

-- Using MySQL BETWEEN operator with dates
SELECT * FROM orders;
/* To check if a value is between a date range, you should explicitly cast the value to the DATE type. */
SELECT 
   orderNumber,
   requiredDate,
   status
FROM 
   orders
WHERE 
   requiredDate BETWEEN 
     CAST('2003-01-01' AS DATE) AND 
     CAST('2003-01-31' AS DATE);
     