USE classicmodels;
SHOW TABLES;

/* Updatable Views
you can use the INSERT or UPDATE statement to insert or update rows of the base table through the updatable view.
 In addition, you can use DELETE statement to remove rows of the underlying table through the view.
 
 However, to create an updatable view, the SELECT statement that defines the view must not contain any of the following elements:
    Aggregate functions such as MIN, MAX, SUM, AVG, and COUNT.
    DISTINCT
    GROUP BY clause.
    HAVING clause.
    UNION or UNION ALL clause.
    Left join or outer join.
    Subquery in the SELECT clause or in the WHERE clause that refers to the table appeared in the FROM clause.*/
    
/* updatable view example */
SELECT * FROM offices;
-- First, we create a view named officeInfo  based on the offices  table. 

-- The view refers to three columns of the offices  table:officeCode phone,  and city.
CREATE VIEW officeInfo
 AS 
   SELECT officeCode, phone, city
   FROM offices;
   
-- Next, we can query data from the officeInfo view using the following statement:
SELECT *
FROM officeInfo;

-- Then, we can change the phone number of the office with officeCode 4 ,
-- through the officeInfo view using the following UPDATE statement.
UPDATE officeInfo 
SET 
    phone = '+33 14 723 5555'
WHERE
    officeCode = 4;

-- Finally, to verify the change,
-- we can query the data from the officeInfo  view by executing the following query:
SELECT *
FROM officeInfo
WHERE officeCode = 4;

/* Removing rows through the view
First, we create a table named items, insert some rows into the items table, 
and create a view that contains items whose prices are greater than 700. */

-- create a new table named items
DROP TABLE items;

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(11 , 2 ) NOT NULL
);

-- insert data into the items table
INSERT INTO items(name,price) 
VALUES('Laptop',700.56),('Desktop',699.99),('iPad',700.50) ;

-- create a view based on items table
CREATE VIEW LuxuryItems AS
    SELECT 
        *
    FROM
        items
    WHERE
        price > 700;
        
-- query data from the LuxuryItems view
SELECT 
    *
FROM
    LuxuryItems;
    
-- Second, we use the DELETE statement to remove a row with id value 3.
DELETE FROM LuxuryItems 
WHERE
    id = 3;
    
-- Third, let’s check the data through the view again.
SELECT 
    *
FROM
    LuxuryItems;
    
-- Fourth, we can also query the data from the base table items to verify,
-- if the DELETE statement actually deleted the row.
SELECT 
    *
FROM
    items;
 -- As you see, the row with id 3 was removed from the base table.   

























