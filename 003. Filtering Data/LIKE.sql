USE classicmodels;
SHOW TABLES;

/* The LIKE operator is a logical operator that tests whether a string contains a specified pattern or not. 
MySQL provides two wildcard characters for constructing patterns: percentage % and underscore _ 
    The percentage ( % ) wildcard matches any string of zero or more characters.
    The underscore ( _ ) wildcard matches any single character.\
For example, s% matches any string starts with the character s such as sun and six. 
The se_ matches any string starts with  se and is followed by any character such as see and sea.*/

/* Using MySQL LIKE operator with the percentage (%) wildcard */
SELECT * FROM employees;

-- find employees whose first names start with the letter a
SELECT
	employeeNumber,
    firstName,
    lastName
FROM
	employees
WHERE
	firstName LIKE 'a%';
    
-- find employees whose last names end with the literal string on
SELECT 
    employeeNumber, 
    firstName,
    lastName
FROM
    employees
WHERE
    lastName LIKE '%on';
    
-- To check if a string contains a substring, 
-- you can use the percentage ( % ) wildcard at the beginning and the end of the substring.
SELECT 
    employeeNumber,
    firstName,
    lastName 
FROM
    employees
WHERE
    lastname LIKE '%on%';

/* Using MySQL LIKE operator with underscore( _ ) wildcard 
To find employees whose first names start with the letter T , end with the letter m, 
and contain any single character between e.g., Tom , Tim, you use the underscore (_) wildcard*/

SELECT 
    employeeNumber, 
    firstName,
    lastName
FROM
    employees
WHERE
    firstname LIKE 'T_m';
    
/* The MySQL allows you to combine the NOT operator with the LIKE operator 
to find a string that does not match a specific pattern. */

-- search for employees whose last names don’t start with the letter B
SELECT 
    employeeNumber, 
    firstName
    lastName
FROM
    employees
WHERE
    lastName NOT LIKE 'B%';
    
/* MySQL LIKE operator with the ESCAPE clause */
SELECT * FROM products;

/* For example, if you want to find products whose product codes contain the string _20 , 
you can use the pattern %\_20% with the default escape character */
SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%\_20%';

/* Alternatively, you can specify a different escape character e.g., $ using the ESCAPE clause */
SELECT 
    productCode, 
    productName
FROM
    products
WHERE
    productCode LIKE '%$_20%' ESCAPE '$';
