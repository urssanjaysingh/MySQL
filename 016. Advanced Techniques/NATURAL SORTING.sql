USE classicmodels;

/* Natural Sorting */

-- First, create a new table named items by using the following  CREATE TABLE statement:

DROP TABLE IF EXISTS items;

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_no VARCHAR(255) NOT NULL
);

-- Second, insert some rows into the items table:
INSERT INTO items(item_no)
VALUES ('1'),
       ('1C'),
       ('10Z'),
       ('2A'),
       ('2'),
       ('3C'),
       ('20D');
       
-- Third, query data from the items table sorted by the item_no:
SELECT 
    item_no
FROM
    items
ORDER BY item_no;
-- MySQL does not provide any built-in natural sorting syntax or function.
-- The ORDER BY clause sorts strings in a linear fashion i.e., one character a time, starting from the first character.

/* natural sorting */
-- If the item_no data is in fairly standard format, 
-- you can use the following query to perform natural sorting without changing the table structure.
SELECT 
    item_no
FROM
    items
ORDER BY CAST(item_no AS UNSIGNED) , item_no;
-- In this query, first, we convert item_no data into an unsigned integer using the type cast.
-- Second, we use the ORDER BY clause to sort the rows numerically first and alphabetically then.

-- Let’s take a look at another common set of data that we often have to deal with.
TRUNCATE TABLE items;

INSERT INTO items(item_no)
VALUES('A-1'),
      ('A-2'),
      ('A-3'),
      ('A-4'),
      ('A-5'),
      ('A-10'),
      ('A-11'),
      ('A-20'),
      ('A-30');
      
-- we can use the LENGTH function. Notice that LENGTH function returns the length of a string.
-- The idea is to sort the item_no data by length first and then by column value as the following query:
SELECT 
    item_no
FROM
    items
ORDER BY LENGTH(item_no) , item_no;

