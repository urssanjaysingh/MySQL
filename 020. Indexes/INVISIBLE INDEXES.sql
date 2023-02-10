USE classicmodels;
SHOW TABLES;

/* Invisible Index
The invisible indexes allow you to mark indexes as unavailable for the query optimizer. 
MySQL maintains the invisible indexes and keeps them up to date,
 when the data in the columns associated with the indexes changes. */
 
 SELECT * FROM employees;
-- For example, the following statement creates an index on the extension column of the employees table,
-- in the sample database and marks it as an invisible index:
CREATE INDEX extension 
ON employees(extension) INVISIBLE;

-- For example, to make the extension index visible, you use the following statement:
ALTER TABLE employees
ALTER INDEX extension VISIBLE; 

-- In addition, you can use the SHOW INDEXES command to display all indexes of a table:
SHOW INDEXES FROM employees;

/* invisible index and primary key
The index on the primary key column cannot be invisible. 
If you try to do so, MySQL will issue an error.
In addition, an implicit primary key index also cannot be invisible.
 When you defines a UNIQUE index on a NOT NULL column of a table that does not have a primary key,
 MySQL implicitly understands that this column is the primary key column,
 and does not allow you to make the index invisible. */
 
 -- First, create a new table with a UNIQUE index on a NOT NULL column:
DROP TABLE discounts;

CREATE TABLE discounts (
    discount_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    amount DEC(5 , 2 ) NOT NULL DEFAULT 0,
    UNIQUE discount_id(discount_id)
);

-- Second, try to make the discount_id index invisible:

ALTER TABLE discounts
ALTER INDEX discount_id INVISIBLE;

-- MySQL issued the following error message:
SHOW ERRORS;

