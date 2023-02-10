USE classicmodels;
SHOW TABLES;

/* Generated Columns - GENERATED ALWAYS
Columns are generated because the data in these columns are computed based on predefined expressions. */

-- For example, you have the contacts with the following structure:
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- To get the full name of a contact, you use the CONCAT() function as follows:
SELECT 
    id, 
    CONCAT(first_name, ' ', last_name), 
    email
FROM
    contacts;
-- This is not the most beautiful query yet.

-- By using the MySQL generated column, you can recreate the contacts table as follows:
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    fullname varchar(101) GENERATED ALWAYS AS (CONCAT(first_name,' ',last_name)),
    email VARCHAR(100) NOT NULL
);
-- The GENERATED ALWAYS as (expression) is the syntax for creating a generated column.

-- To test the fullname column, you insert a row into the contacts table.
INSERT INTO contacts(first_name,last_name, email)
VALUES('john','doe','john.doe@mysqltutorial.org');

SELECT *
FROM contacts;

SELECT * FROM products;
-- The data from quantityInStock and buyPrice columns 
-- allow us to calculate the stock’s value per SKU using the following expression:
-- quantityInStock * buyPrice

/* However, we can add a stored generated column named stock_value to the products table,
using the following ALTER TABLE ...ADD COLUMN statement: */
ALTER TABLE products
ADD COLUMN stockValue DOUBLE 
GENERATED ALWAYS AS (buyprice*quantityinstock) STORED;
-- STORED IS THE TYPE OF GENERATED COLUMN

SELECT * FROM products;

-- Now, we can query the stock value directly from the products table.
SELECT 
    productName, 
    ROUND(stockValue, 2) stock_value
FROM
    products;
