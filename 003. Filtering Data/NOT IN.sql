USE classicmodels;
SHOW TABLES;

/* The NOT operator negates the IN operator, 
The NOT IN operator returns one if the value doesn’t equal any value in the list. Otherwise, it returns 0. */
SELECT 1 NOT IN (1,2,3);

SELECT * FROM offices;

SELECT
	officeCode,
    city,
    phone
FROM
	offices
where
	country NOT IN ('USA', 'France');