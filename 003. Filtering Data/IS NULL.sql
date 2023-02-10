USE classicmodels;
SHOW TABLES;

/* To test whether a value is NULL or not, you use the  IS NULL operator. 
If the value is NULL, the expression returns true. Otherwise, it returns false. */

SELECT * FROM customers;

-- find customers who do not have a sales representative
SELECT 
    customerName, 
    country, 
    salesrepemployeenumber
FROM
    customers
WHERE
    salesrepemployeenumber IS NULL;
    
-- get the customers who have a sales representative
SELECT 
    customerName, 
    country, 
    salesrepemployeenumber
FROM
    customers
WHERE
    salesrepemployeenumber IS NOT NULL;
