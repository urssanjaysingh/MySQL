USE classicmodels;
SHOW TABLES;

/* The WHERE clause allows you to specify a search condition for the rows returned by a query. 
The search_condition is a combination of one or more expressions using the logical operator AND, OR and NOT. */

SELECT * FROM employees;

-- Using WHERE clause with equality operator
SELECT 
	firstName,
    lastName,
    jobTitle
FROM
	employees
WHERE
	jobTitle = 'Sales Rep';

-- Using WHERE clause with the AND operator
SELECT
	firstName,
    lastName,
    jobTitle,
    officeCode
FROM
	employees
WHERE
	jobTitle = 'Sales Rep' AND officeCode = 1;
    
-- Using WHERE clause with OR operator
SELECT
	firstName,
    lastName,
    jobTitle,
    officeCode
FROM
	employees
WHERE
	jobTitle = 'Sales Rep' OR officeCode = 1;
    
-- Using WHERE clause with BETWEEN operator
SELECT 
	firstName,
    lastName,
    officeCode
FROM
	employees
WHERE
	officeCode BETWEEN 1 AND 3;
    
-- Using WHERE clause with LIKE operator
SELECT
	firstName,
    lastName
FROM
	employees
WHERE
	lastName LIKE '%son';
    
-- Using WHERE clause with the IN operator
SELECT
	firstName,
    lastName,
    officeCode
FROM
	employees
WHERE
	officeCode IN (1, 2, 3);
    
-- Using MySQL WHERE clause with the IS NULL operator
/* To check if a value is NULL or not, you use the IS NULL operator, not the equal operator (=). 
The IS NULL operator returns TRUE if a value is NULL.  */
SELECT 
	firstName,
	lastName,
    reportsTo
FROM
	employees
WHERE
	reportsTo IS NULL;

-- Using WHERE clause with comparison operators
-- <>(Not Operator)
SELECT
	firstName,
    lastName,
    jobTitle
FROM
	employees
WHERE
	jobTitle <> 'Sales Rep';
    
SELECT
	firstName,
    lastName,
    officeCode
FROM
	employees
WHERE
	officeCode > 5;

SELECT
	firstName,
    lastName,
    officeCode
FROM
	employees
WHERE
	officeCode <= 4;
