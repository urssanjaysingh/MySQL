USE classicmodels;
SHOW TABLES;

/* The MySQL OR operator is a logical operator that combines two Boolean expressions.
If both A and B are not NULL, the OR operator returns 1 (true) if either A or B is non-zero.
If both A and B are zero (false), the OR operator returns zero.
When A and / or B is NULL, the OR operator returns 1 (true) if either A or B is non-zero. Otherwise, it returns NULL. */

SELECT
	1 OR 1,
    1 OR 0, 
    0 OR 1,
    0 OR 0,
    1 OR NULL,
    0 OR NULL,
    NULL OR NULL;
    
/* Since the AND operator has higher precedence than the OR operator, 
MySQL evaluates the AND operator before the OR operator. */
SELECT 1 OR 0 AND 0;

-- To change the order of evaluation, you use the parentheses. 
SELECT (1 OR 0) AND 0;

SELECT * FROM customers;

SELECT 
	customerName,
    country,
    creditLimit
FROM
	customers
WHERE
	country = ('USA' OR country = 'France') AND creditLimit > 100000;


    
