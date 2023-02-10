USE classicmodels;
SHOW TABLES;

/* MySQL doesn’t have a built-in Boolean type. Instead, 
it uses the number zero as FALSE and non-zero values as TRUE.
The AND operator is a logical operator that combines two or more Boolean expressions 
and returns 1, 0, or NULL. */

SELECT 
	1 AND 1, 
    1 AND 0,
    0 AND 1, 
    0 AND 0, 
    0 AND NULL,
    NULL AND NULL;
    
SELECT * FROM customers;

SELECT 
	customerName,
    country,
    state,
    creditLimit
FROM
	customers
WHERE 
	country = 'USA' AND state = 'CA' AND creditLimit > 100000;
    