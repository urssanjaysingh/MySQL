USE classicmodels;
SHOW TABLES;

/* INSERT INTO SELECT 
Besides using row values in the VALUES clause, 
you can use the result of a SELECT statement as the data source for the INSERT statement. */

-- INSERT INTO SELECT
CREATE TABLE suppliers (
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);

DESCRIBE suppliers;

SELECT * FROM customers;

-- Suppose all customers from California, USA become the company’s suppliers. 
-- The following query finds all customers who locate in California, USA
SELECT 
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM
    customers
WHERE
    country = 'USA' AND state = 'CA';
    
/* Second, use the INSERT INTO ... SELECT statement to insert customers who locate in California USA,
from the customers table into the  suppliers table: */
INSERT INTO suppliers (
    supplierName, 
    phone, 
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    customerNumber
)
SELECT 
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state ,
    postalCode,
    country,
    customerNumber
FROM 
    customers
WHERE 
    country = 'USA' AND 
    state = 'CA';

SELECT * FROM suppliers;

/* SELECT statement in the VALUES list */
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;

-- First, create a new table called stats:
CREATE TABLE stats (
    totalProduct INT,
    totalCustomer INT,
    totalOrder INT
);

INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES(
	(SELECT COUNT(*) FROM products),
	(SELECT COUNT(*) FROM customers),
	(SELECT COUNT(*) FROM orders)
);

SELECT * FROM stats;