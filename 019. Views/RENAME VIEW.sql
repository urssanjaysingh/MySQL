USE classicmodels;
SHOW TABLES;

/* Rename View
In MySQL, views and tables share the same namespace. 
Therefore, you can use the RENAME TABLE statement to rename a view. */

/* Renaming a view using the RENAME TABLE statement */
-- First, create a new view called productLineSales for the demonstration:

CREATE VIEW productLineSales AS
SELECT 
    productLine, 
    SUM(quantityOrdered) totalQtyOrdered
FROM
    productLines
        INNER JOIN
    products USING (productLine)
        INNER JOIN
    orderdetails USING (productCode)
GROUP BY productLine;

-- Second, rename the view productLineSales to productLineQtySales:

RENAME TABLE productLineSales 
TO productLineQtySales;

-- Third, use the SHOW FULL TABLES to check if the view has been renamed successfully:

SHOW FULL TABLES WHERE table_type = 'VIEW';