USE classicmodels;

/* CHAR Data Type
The CHAR data type is a fixed-length character type in MySQL.
You often declare the CHAR type with a length that specifies the maximum number of characters that you want to store. 
For example, CHAR(20) can hold up to 20 characters.
If the data that you want to store is a fixed size, then you should use the CHAR data type.
The length of the CHAR data type can be any value from 0 to 255. */

-- First, creates a table with a CHAR column.
CREATE TABLE mysql_char_test (
    status CHAR(3)
);
-- The data type of the  status column is CHAR . And it can hold up to 3 characters.

-- Second, insert two rows into the mysql_char_test table.
INSERT INTO mysql_char_test(status)
VALUES('Yes'),('No');

-- Third, use the length function to get the length of each CHAR value.
SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;
    
-- Fourth, inserts a CHAR value with the leading and trailing spaces.
INSERT INTO mysql_char_test(status)
VALUES(' Y ');

-- Finally, query the inserted values, you will see that MySQL removes the trailing spaces.
SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;

/* Comparing MySQL CHAR values 
MySQL does not consider trailing spaces when comparing CHAR values,
using the comparison operator such as =, <>, >, <, etc.
Notice that the LIKE operator does consider the trailing spaces, 
when you do pattern matching with CHAR values.*/

-- In the previous example, we stored the value Y with both leading and trailing spaces. 
-- However, when we execute the following query:
SELECT * 
FROM mysql_char_test
WHERE status = 'Y';
-- MySQL returns no row because it does not consider the trailing space.
-- To match with the ‘ Y ‘, we need to remove the trailing space as follows:
SELECT *
FROM mysql_char_test
WHERE status = ' Y';

/* CHAR and UNIQUE index 
If the CHAR column has a UNIQUE index and you insert a value that is different from an existing value in a number of trailing spaces, 
MySQL will reject the changes because of duplicate-key error. */

-- First, create a unique index for the status column of the mysql_char_test table.
CREATE UNIQUE INDEX uidx_status 
ON mysql_char_test(status);

-- Second, insert a new row into the mysql_char_test table.
INSERT INTO mysql_char_test(status)
VALUES('N');

-- Third, insert the following value will cause a duplicate key error.
INSERT INTO mysql_char_test(status)
VALUES('N ');

SHOW ERRORS;
