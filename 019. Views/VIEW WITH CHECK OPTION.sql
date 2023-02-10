USE classicmodels;
SHOW TABLES;

/* View & the WITH CHECK OPTION clause
Sometimes, you create a view to reveal the partial data of a table. 
However, a simple view is updatable therefore it is possible to update data,
 which is not visible through the view. This update makes the view inconsistent. 
 To ensure the consistency of the view, you use the WITH CHECK OPTION clause,
 when you create or modify the view.
The WITH CHECK OPTION prevents a view from updating or inserting rows that are not visible through it. */

-- First, create a view named vps based on the employees table to reveal employees
-- whose job titles are VP e.g., VP Sales, VP Marketing.
CREATE OR REPLACE VIEW vps AS
    SELECT 
        employeeNumber,
        lastname,
        firstname,
        jobtitle,
        extension,
        email,
        officeCode,
        reportsTo
    FROM
        employees
    WHERE
        jobTitle LIKE '%VP%';
        
-- Next, query data from the vps view using the following SELECT statement:
SELECT * FROM vps;

-- Because the vps is a simple view, it is updatable.

-- Then, insert a row into the employees table through the vps view.
INSERT INTO vps(
    employeeNumber,
    firstName,
    lastName,
    jobTitle,
    extension,
    email,
    officeCode,
    reportsTo
) 
VALUES(
    1703,
    'Lily',
    'Bush',
    'IT Manager',
    'x9111',
    'lilybush@classicmodelcars.com',
    1,
    1002
);

-- Notice that the newly created employee is not visible through the vps view because her job title is IT Manager,
-- which is not the VP. You can verify it using the following SELECT statement.
SELECT 
   * 
FROM 
   employees
ORDER BY 
   employeeNumber DESC;
-- This may not what we want because we just want to expose the VP employees only through the vps view,
-- not other employees.

-- To ensure the consistency of a view so that users can only display or update data that visible through the view,
-- you use the WITH CHECK OPTION when you create or modify the view.
CREATE OR REPLACE VIEW vps AS
    SELECT 
        employeeNumber,
        lastName,
        firstName,
        jobTitle,
        extension,
        email,
        officeCode,
        reportsTo
    FROM
        employees
    WHERE
        jobTitle LIKE '%VP%' 
WITH CHECK OPTION;

-- After that, insert a row into the employees table through the vps view:
INSERT INTO vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
VALUES(1704,'John','Smith','IT Staff','x9112','johnsmith@classicmodelcars.com',1,1703);

-- This time, MySQL rejected the insert and issued the following error message:
SHOW ERRORS;

-- Finally, insert an employee whose job title is SVP Marketing into the employees table,
-- through the vps view to see if it is allowed.
INSERT INTO vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
VALUES(1704,'John','Smith','SVP Marketing','x9112','johnsmith@classicmodelcars.com',1,1076);

-- You can verify the insert by querying data from the vps view.
SELECT * FROM vps;

