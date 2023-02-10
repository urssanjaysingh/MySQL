USE classicmodels;
SHOW TABLES;

/* DROP VIEW
The DROP VIEW statement deletes a view completely from the database.  */

/* DROP VIEW – drop a view */
SELECT * FROM payments;
SELECT * FROM customers;

-- This statement creates a view named customerPayments based on the customers and payments tables:
CREATE VIEW customerPayments 
AS
    SELECT 
        customerName, 
        SUM(amount) payment
    FROM
        customers
    INNER JOIN payments 
        USING (customerNumber)
    GROUP BY 
        customerName;
        
-- This example uses the DROP VIEW statement to drop the customerPayments view:
DROP VIEW IF EXISTS customerPayments;

/* DROP VIEW – drop multiple views */
SELECT * FROM offices;
SELECT * FROM employees;

-- This statement creates a view named employeeOffices based on the employees and offices tables:
CREATE VIEW employeeOffices AS
    SELECT 
        firstName, lastName, addressLine1, city
    FROM
        employees
            INNER JOIN
        offices USING (officeCode);
        
-- The following statement uses the DROP VIEW statement to delete two views employeeOffices and eOffices:
DROP VIEW employeeOffices, eOffices;

-- MySQL issued the following error:
SHOW ERRORS;

-- Let’s add the IF EXISTS option like this:
DROP VIEW IF EXISTS employeeOffices, eOffices;

-- MySQL issued a warning instead:
SHOW WARNINGS;

SELECT * FROM productlines;
SELECT * FROM products;

-- This statement creates a new view named productCatalogs based on the products and productLines tables:
CREATE VIEW productCatalogs AS
    SELECT 
        productLine, productName, msrp
    FROM
        products
            INNER JOIN
        productLines USING (productLine);

-- The following example uses the DROP VIEW statement to delete the employeeOffices and productCatalogs views:

DROP VIEW employeeOffices, productCatalogs;
-- MySQL deleted the views completely.
