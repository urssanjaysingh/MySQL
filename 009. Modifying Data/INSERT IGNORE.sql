USE classicmodels;
SHOW TABLES;

/* When you use the INSERT statement to add multiple rows to a table, 
and if an error occurs during the processing, 
MySQL terminates the statement and returns an error. 
As the result, no rows are inserted into the table. */

/* INSERT IGNORE 
if you use the INSERT IGNORE statement, 
the rows with invalid data that cause the error are ignored and the rows with valid data are inserted into the table.*/

-- We will create a new table called subscribers for the demonstration.
CREATE TABLE subscribers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL UNIQUE
);
-- The UNIQUE constraint ensures that no duplicate email exists in the email column.

-- The following statement inserts a new row into the  subscribers table:
INSERT INTO subscribers(email)
VALUES('john.doe@gmail.com');

SELECT * FROM subscribers;

-- Let’s execute another statement that inserts two rows into the  subscribers table:
INSERT IGNORE INTO subscribers(email)
VALUES('john.doe@gmail.com'), 
      ('jane.smith@ibm.com');

-- when you use the INSERT IGNORE statement, instead of issuing an error, MySQL issued a warning in case an error occurs.
SHOW WARNINGS;

SELECT * FROM subscribers;

/* INSERT IGNORE and STRICT mode */
-- When the strict mode is on, 
-- MySQL returns an error and aborts the INSERT statement if you try to insert invalid values into a table.
-- However, if you use the INSERT IGNORE statement, MySQL will issue a warning instead of an error. 
-- In addition, it will try to adjust the values to make them valid before adding the value to the table.

-- First, we create a new table named tokens:
CREATE TABLE tokens (
    s VARCHAR(6)
);

DESCRIBE tokens;

-- Second, insert a string whose length is seven into the tokens table.
INSERT IGNORE INTO tokens VALUES('abcdefg');

-- MySQL truncated data before inserting it into the tokens table. In addition, it issues a warning.
SHOW WARNINGS;

SELECT * FROM tokens;







