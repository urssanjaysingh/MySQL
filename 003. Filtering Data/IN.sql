USE classicmodels;
SHOW TABLES;

/* The IN operator allows you to determine if a value matches any value in a list of values. */
SELECT 1 IN (1,2,3);

SELECT * FROM offices;

SELECT 
	officeCode,
    city,
    phone,
    country
FROM
	offices
WHERE
	country IN ('USA', 'France');
