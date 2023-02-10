
/* Foreign Key 
A foreign key is a column or group of columns in a table that links to a column or group of columns in another table. 
The foreign key places constraints on data in the related tables, which allows MySQL to maintain referential integrity.
A table can have more than one foreign key where each foreign key references to a primary key of the different parent tables. */

SELECT * FROM customers;
SELECT * FROM orders;

DESCRIBE customers;
DESCRIBE orders;

/* Each customer can have zero or many orders and each order belongs to one customer.
The relationship between customers table and orders table is one-to-many. 
And this relationship is established by the foreign key in the orders table specified by the customerNumber column. */

/* Self-referencing foreign key */
SELECT * FROM employees;

DESCRIBE employees;

-- The reportTo column is a foreign key that refers to the employeeNumber column
-- which is the primary key of the employees table.
-- The foreign key on the column reportTo is known as a recursive or self-referencing foreign key.

/* The reference_option determines action which MySQL will take,
when values in the parent key columns are deleted (ON DELETE) or updated (ON UPDATE).

CASCADE: if a row from the parent table is deleted or updated, 
	the values of the matching rows in the child table automatically deleted or updated.
SET NULL:  if a row from the parent table is deleted or updated, 
	the values of the foreign key column (or columns) in the child table are set to NULL.
RESTRICT:  if a row from the parent table has a matching row in the child table, 
	MySQL rejects deleting or updating rows in the parent table.
    
If you don’t specify the ON DELETE and ON UPDATE clause, the default action is RESTRICT. */

/* RESTRICT & NO ACTION actions */
-- Let’s create a new database called fkdemo for the demonstration.
CREATE DATABASE fkdemo;
USE fkdemo;

-- Inside the fkdemo database, create two tables categories and products:
CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
);

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
);

-- The categoryId in the products table is the foreign key column,
-- that refers to the categoryId column in the  categories table.
-- Because we don’t specify any ON UPDATE and ON DELETE clauses, 
-- the default action is RESTRICT for both update and delete operation.

--  Insert two rows into the categories table:
INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');
    
-- Select data from the categories table:
SELECT * FROM categories;

-- Insert a new row into the products table:
INSERT INTO products(productName, categoryId)
VALUES('iPhone',1);

SELECT * FROM products;
-- It works because the categoryId 1 exists in the categories table.

-- Attempt to insert a new row into the products table with a categoryId value does not exist in the categories table:
INSERT INTO products(productName, categoryId)
VALUES('iPad',3);

-- MySQL issued the following error:
SHOW ERRORS;

-- Update the value in the categoryId column in the categories table to 100:
UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;
  
-- MySQL issued this error:
SHOW ERRORS;

-- Because of the RESTRICT option, you cannot delete or update categoryId 1 
-- since it is referenced by the productId 1 in the products table.

/* CASCADE action */

-- Drop the products table: 
DROP TABLE products;

-- Create the products table with the ON UPDATE CASCADE and ON DELETE CASCADE options for the foreign key:
CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT NOT NULL,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
    REFERENCES categories(categoryId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Insert four rows into the products table:
INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);

-- Select data from the products table:
SELECT * FROM products;

-- Update categoryId 1 to 100 in the categories table:
UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

-- Verify the update:
SELECT * FROM categories;

-- Get data from the products table:
SELECT * FROM products;
-- As you can see, two rows with value 1 in the categoryId column of the products table
-- were automatically updated to 100 because of the ON UPDATE CASCADE action.

-- Delete categoryId 2 from the categories table:
DELETE FROM categories
WHERE categoryId = 2;

-- Verify the deletion:
SELECT * FROM categories;

-- Check the products table:
SELECT * FROM products;
-- All products with categoryId 2 from the products table were automatically deleted
-- because of the ON DELETE CASCADE action.

/* SET NULL action */
-- Drop both categories and products tables:
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;

-- Create the categories and products tables:
CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
);

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
        ON UPDATE SET NULL
        ON DELETE SET NULL 
);
-- The foreign key in the products table changed to ON UPDATE SET NULL and ON DELETE SET NULL options.

-- Insert rows into the categories table:
INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');
    
SELECT * FROM categories;

-- Insert rows into the products table:
INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);
    
SELECT * FROM products;

-- Update categoryId from 1 to 100 in the categories table:
UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

-- Verify the update:
SELECT * FROM categories;

-- Select data from the products table:
SELECT * FROM products;

-- The rows with the categoryId 1 in the products table were automatically set to NULL,
-- due to the ON UPDATE SET NULL action.

-- Delete the categoryId 2 from the categories table:
DELETE FROM categories 
WHERE categoryId = 2;

-- Check the products table:
SELECT * FROM products;
-- The values in the categoryId column of the rows with categoryId 2 in the products table were automatically set to NULL,
-- due to the ON DELETE SET NULL action.

/* Drop MySQL foreign key constraints */
-- drops the foreign key constraint of the products table:
ALTER TABLE products 
DROP FOREIGN KEY fk_category;

-- To ensure that the foreign key constraint has been dropped, you can view the structure of the products table:
SHOW CREATE TABLE products;

/* Disabling foreign key checks
Sometimes, it is very useful to disable foreign key checks e.g., 
when you import data from a CSV file into a table. If you don’t disable foreign key checks, 
you have to load data into a proper order 
i.e., you have to load data into parent tables first and then child tables, 
which can be tedious. However, if you disable the foreign key checks, 
you can load data into tables in any order. */

-- To disable foreign key checks, you use the following statement:
SET foreign_key_checks = 0;

-- And you can enable it by using the following statement:
SET foreign_key_checks = 1;

-- First, create a new table named countries:
CREATE TABLE countries(
    country_id INT AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(country_id)
);

-- Second, create another table named cities:
CREATE TABLE cities(
    city_id INT AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY(city_id),
    FOREIGN KEY(country_id) 
		REFERENCES countries(country_id)
);
-- The table cities has a foreign key constraint that refers to the column country_id of the table countries.

-- Third, insert a new row into the cities table:
INSERT INTO cities(city_name, country_id)
VALUES('New York',1);

-- MySQL issued the following error:
SHOW ERRORS;

-- Fourth, disable foreign key checks:
SET foreign_key_checks = 0;

-- Fifth, insert a new row into the cities table:
INSERT INTO cities(city_name, country_id)
VALUES('New York',1);
-- This time the INSERT statement executed successfully due to the foreign key check disabled.

SELECT * FROM cities;

-- Sixth, re-enable foreign key constraint check:
SET foreign_key_checks = 1;

-- Finally, insert a row into the countries table whose value in the column country_id is 1,
-- to make the data consistent in both tables:
INSERT INTO countries(country_id, country_name)
VALUES(1,'USA');

SELECT * FROM countries;

/* Drop tables that have foreign key constraints
Suppose that you want to drop the countries and cities tables. */

-- First, drop the table countries :
DROP TABLE countries;

-- MySQL issued this error:
SHOW ERRORS;
-- To fix this, you have two options:
  --  Drop the table cities first and then remove the table countries.
  --  Disable foreign key checks and drop tables in any sequence.

-- Second, disable the foreign key check:
SET foreign_key_checks = 0;

-- Third, drop both tables countries and cities:
DROP TABLE countries;
DROP TABLE cities;
-- Both statements executed successfully.

-- Finally, enable the foreign key check:
SET foreign_key_checks = 1;

