USE classicmodels;

/* UNIQUE Constraint
Sometimes, you want to ensure values in a column or a group of columns are unique. 
For example, email addresses of users in the users table, 
or phone numbers of customers in the customers table should be unique. 
To enforce this rule, you use a UNIQUE constraint. */

-- DROP suppliers if it exist
DROP TABLE suppliers;

-- First, creates a new table named suppliers with the two UNIQUE constraints:
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT uc_name_address UNIQUE (name , address)
);
-- In this example, the first UNIQUE constraint is defined for the phone column:
-- And the second constraint is for both name and address columns:

DESCRIBE suppliers;

-- Second, insert a row into the suppliers table.
INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-2476',
       '4000 North 1st Street');
       
SELECT * FROM suppliers;
       
-- Third, attempt to insert a different supplier,
-- but has the phone number that already exists in the suppliers table.
INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-2476','3000 North 1st Street');

-- MySQL issued an error:
SHOW ERRORS;

-- Fourth, change the phone number to a different one and execute the insert statement again.
INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-3333','3000 North 1st Street');

-- Fifth, insert a row into the suppliers table with values that already exist in the columns name and address :
INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-1111',
       '4000 North 1st Street');
       
-- MySQL issued an error because the UNIQUE constraint uc_name_address was violated.
SHOW ERRORS;

/* UNIQUE constraints and indexes
When you define a unique constraint, MySQL creates a corresponding UNIQUE index
and uses this index to enforce the rule. */

-- The SHOW CREATE TABLE statement shows the definition of the suppliers table:
SHOW CREATE TABLE suppliers;
-- As you can see from the output, 
-- MySQL created two UNIQUE indexes on the suppliers table: phone and uc_name_address.

-- The following SHOW INDEX statement displays all indexes associated with the suppliers table.
SHOW INDEX FROM suppliers;

/* Drop a unique constraint */
-- following statement drops the uc_name_address constraint on the suppliers table:
DROP INDEX uc_name_address ON suppliers;

-- Execute the SHOW INDEX statement again to verify if the uc_name_unique constraint has been removed.
SHOW INDEX FROM suppliers;

/* Add new unique constraint */
-- This statement adds a UNIQUE constraint uc_name_address back to the suppliers table:
ALTER TABLE suppliers
ADD CONSTRAINT uc_name_address 
UNIQUE (name,address);

SHOW INDEX FROM suppliers;
