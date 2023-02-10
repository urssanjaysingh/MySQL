USE classicmodels;
SHOW TABLES;

/* INT stands for the integer that is a whole number. 
An integer can be written without a fractional component e.g., 1, 100, 4, -10, and it cannot be 1.2, 5/3, etc. 
An integer can be zero, positive, and negative. */

/* Using MySQL INT for a column */
-- Because integer type represents exact numbers, 
-- you usually use it as the primary key of a table. In addition, 
-- the INT column can have an AUTO_INCREMENT attribute.

-- First, create a new table named items with an integer column as the primary key:
CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_text VARCHAR(255)
);

-- Next, the following INSERT statement inserts three rows into the items table.
INSERT INTO 
    items(item_text)
VALUES
    ('laptop'), 
    ('mouse'),
    ('headphone');

-- Then, query data from the items table using the following SELECT statement:
SELECT * FROM items;

-- After that, insert a new row whose value of the item_id column is specified explicitly.
INSERT INTO items(item_id,item_text)
VALUES(10,'Server');

SELECT * FROM items;

-- Since the current value of the item_id column is 10, the sequence is reset to 11. 
-- If you insert a new row, the AUTO_INCREMENT column will use 11 as the next value.
INSERT INTO items(item_text)
VALUES('Router');

SELECT * FROM items;

/* Using MySQL INT UNSIGNED */
-- First, create a table called classes that has the column total_member with the unsigned integer data type:
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    total_member INT UNSIGNED,
    PRIMARY KEY (class_id)
);

-- Second, insert a new row into the classes table:
INSERT INTO classes(name, total_member)
VALUES('Weekend',100);

-- Third, attempt to insert a negative value into the total_member column:
INSERT INTO classes(name, total_member)
VALUES('Fly',-50);

-- MySQL issued the following error:
SHOW ERRORS;

/* INT with the display width attribute 
The display width is wrapped inside parentheses following the INT keyword,
e.g., INT(5) specifies an INT with the display width of five digits.*/

/* INT with the ZEROFILL attribute
In addition to the display width attribute, MySQL provides a non-standard ZEROFILL attribute. 
In this case, MySQL replaces spaces with zero. */

-- First, create a table named zerofill_tests :
CREATE TABLE zerofill_tests(
    id INT AUTO_INCREMENT PRIMARY KEY,
    v1 INT(2) ZEROFILL,
    v2 INT(3) ZEROFILL,
    v3 INT(5) ZEROFILL
);

-- Second, insert a new row into the zerofill_tests table.
INSERT INTO zerofill_tests(v1,v2,v3)
VALUES(1,6,9);

-- Third, query data from the zerofill_tests table.
SELECT 
    v1, v2, v3
FROM
    zerofill_tests;
-- The v1 column has a display width 2 including ZEROFILL.Its value is 1 therefore, you see 01 in the output. MySQL replaces the first space by 0.
-- The v2 column has a display with 3 including ZEROFILL. Its value is 6 therefore, you see 00 as the leading zeros.
-- The v3 column has the display width 5 with ZEROFILL, while its value is 9, therefore MySQL pads 0000 at the beginning of the number in the output.

/* Note that if you use ZEROFILL attribute for an integer column, 
MySQL will automatically add an UNSIGNED attribute to the column. */