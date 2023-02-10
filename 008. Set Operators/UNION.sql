USE classicmodels;
SHOW TABLES;

/* MySQL UNION operator allows you to combine two or more result sets of queries into a single result set. */
/* UNION vs. JOIN
A JOIN combines result sets horizontally, a UNION appends result set vertically. */

SELECT * FROM customers;
SELECT * FROM employees;

-- Suppose that you want to combine the first name and last name of employees and customers into a single result set, 
-- you can use the UNION operator as follows:
SELECT 
    firstName, 
    lastName
FROM
    employees 
UNION 
SELECT 
    contactFirstName, 
    contactLastName
FROM
    customers;
-- As you can see from the output, 
-- the MySQL UNION uses the column names of the first SELECT statement for the column headings of the output.

-- If you want to use other column headings, 
-- you need to use column aliases explicitly in the first SELECT statement as shown in the following example:
SELECT 
    CONCAT(firstName,' ',lastName) fullname
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName,' ',contactLastName)
FROM
    customers;

/* UNION and ORDER BY */
SELECT 
    concat(firstName,' ',lastName) fullname
FROM
    employees 
UNION 
SELECT 
    concat(contactFirstName,' ',contactLastName)
FROM
    customers
ORDER BY 
	fullname;

-- To differentiate between employees and customers, you can add a column as shown in the following query:
SELECT 
    CONCAT(firstName, ' ', lastName) AS fullname, 
    'Employee' as contactType
FROM
    employees 
UNION SELECT 
    CONCAT(contactFirstName, ' ', contactLastName),
    'Customer' as contactType
FROM
    customers
ORDER BY 
    fullname;
