USE classicmodels;

/* VARCHAR Data Type
MySQL VARCHAR is the variable-length string whose length can be up to 65,535. 
MySQL stores a VARCHAR value as a 1-byte or 2-byte length prefix plus actual data.
The length prefix specifies the number of bytes in the value. 
If a column requires less than 255 bytes, the length prefix is 1 byte. In case the column requires more than 255 bytes, 
the length prefix is two length bytes. */

-- We will create a new table that has two columns s1 and s2 with the length of 32765(+2 for length prefix) and 32766 (+2).
-- Note that 32765+2+32766+2=65535, which is the maximum row size.
CREATE TABLE IF NOT EXISTS varchar_test (
    s1 VARCHAR(32765) NOT NULL,
    s2 VARCHAR(32766) NOT NULL
);

-- The statement created the table successfully. However, if we increase the length of the s1 column by 1.
CREATE TABLE IF NOT EXISTS varchar_test_2 (
    s1 VARCHAR(32766) NOT NULL, -- error
    s2 VARCHAR(32766) NOT NULL
);

-- MySQL will issue the error message:
SHOW ERRORS;

-- If you insert a string whose length is greater than the length of a VARCHAR column,
-- MySQL will issue an error. Consider the following example:
CREATE TABLE item (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(3)
);

INSERT INTO item(title)
VALUES('ABCD');

SHOW ERRORS;

/* VARCHAR and spaces
MySQL does not pad space when it stores the VARCHAR values. 
Also, MySQL retains the trailing spaces when it inserts or selects VARCHAR values. */

-- See the following example:
INSERT INTO item(title)
VALUES('AB ');

SELECT 
    id, title, length(title)
FROM
    item;
    
/* However, MySQL will truncate the trailing spaces when,
inserting a VARCHAR value that contains trailing spaces which cause the column length exceeded. 
In addition, MySQL issues a warning. */

-- Let’s see the following example:
INSERT INTO item(title)
VALUES('ABC ');

SHOW WARNINGS;
-- This statement inserts a string whose length is 4 into the title column. 
-- MySQL still inserts the string,
-- however, it truncates the trailing space before inserting the value.

-- You can verify it by using the following query:
SELECT 
    title, LENGTH(title)
FROM
    item;

