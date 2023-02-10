USE classicmodels;
SHOW TABLES;

/* UPDATE
The UPDATE statement updates data in a table. 
It allows you to change the values in one or more columns of a single row or multiple rows. */
SELECT * FROM employees;

/* Using MySQL UPDATE to modify values in a single column */

-- we will update the email of Mary Patterson to the new email mary.patterso@classicmodelcars.com.
-- First, find Mary’s email from the employees table using the following SELECT statement:
SELECT 
    firstname, 
    lastname, 
    email
FROM
    employees
WHERE
    employeeNumber = 1056;
    
-- Second, update the email address of Mary to the new email mary.patterson@classicmodelcars.com :
UPDATE employees 
SET 
    email = 'mary.patterson@classicmodelcars.com'
WHERE
    employeeNumber = 1056;

-- Third,  execute the SELECT statement again to verify the change:
SELECT 
    firstname, 
    lastname, 
    email
FROM
    employees
WHERE
    employeeNumber = 1056;
    
/* MySQL UPDATE to modify values in multiple columns */
-- To update values in the multiple columns, you need to specify the assignments in the SET clause. 
-- For example, the following statement updates both last name and email columns of employee number 1056:
UPDATE employees 
SET 
    lastname = 'Hill',
    email = 'mary.hill@classicmodelcars.com'
WHERE
    employeeNumber = 1056;

-- Let’s verify the changes:
SELECT 
    firstname, 
    lastname, 
    email
FROM
    employees
WHERE
    employeeNumber = 1056;
    
/* Using MySQL UPDATE to replace string  */
SELECT * FROM employees;

-- The following example updates the domain parts of emails of all Sales Reps with office code 6:
UPDATE employees
SET email = REPLACE(email,'@classicmodelcars.com','@mysqltutorial.org')
WHERE
   jobTitle = 'Sales Rep' AND
   officeCode = 6;
-- In this example, the REPLACE() function replaces @classicmodelcars.com in the email column with @mysqltutorial.org.

