USE classicmodels;
SHOW TABLES;

/* VIEW
By definition, a view is a named query stored in the database catalog.
Note that a view does not physically store the data a view is referred to as a virtual table. */

/* CREATE VIEW */
SELECT * FROM orderdetails;

-- This statement uses the CREATE VIEW statement to create a view that represents total sales per order.
CREATE VIEW salePerOrder AS
    SELECT 
        orderNumber, 
        SUM(quantityOrdered * priceEach) total
    FROM
        orderDetails
    GROUP by orderNumber
    ORDER BY total DESC;
  
-- If you use the SHOW TABLE command to view all tables in the classicmodels database, 
-- you will see the viewsalesPerOrder is showing up in the list.
SHOW TABLES;

-- To know which object is a view or table, you use the SHOW FULL TABLES command as follows:
SHOW FULL TABLES;

-- If you want to query total sales for each sales order, 
-- you just need to execute a simple SELECT  statement against the SalePerOrder  view as follows:
SELECT * FROM salePerOrder;

/* Creating a view based on another view */
-- For example, you can create a view called bigSalesOrder based on the salesPerOrder view,
-- to show every sales order whose total is greater than 60,000 as follows:
CREATE VIEW bigSalesOrder AS
    SELECT 
        orderNumber, 
        ROUND(total,2) as total
    FROM
        salePerOrder
    WHERE
        total > 60000;
        
-- Now, you can query the data from the bigSalesOrder view as follows:
SELECT 
    orderNumber, 
    total
FROM
    bigSalesOrder;
    
/* Creating a view with join example
The following example uses the CREATE VIEW statement to create a view based on multiple tables. 
It uses the INNER JOIN clauses to join tables. */

CREATE OR REPLACE VIEW customerOrders AS
SELECT 
    orderNumber,
    customerName,
    SUM(quantityOrdered * priceEach) total
FROM
    orderDetails
INNER JOIN orders o USING (orderNumber)
INNER JOIN customers USING (customerNumber)
GROUP BY orderNumber;

-- This statement selects data from the customerOrders view:
SELECT * FROM customerOrders 
ORDER BY total DESC;

/* Creating a view with a subquery */
-- The following example uses the CREATE VIEW statement to create a view whose SELECT statement uses a subquery. 
-- The view contains products whose buy prices are higher than the average price of all products.
CREATE VIEW aboveAvgProducts AS
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM
        products
    WHERE
        buyPrice > (
            SELECT 
                AVG(buyPrice)
            FROM
                products)
    ORDER BY buyPrice DESC;

-- This query data from the aboveAvgProducts is simple as follows:
SELECT * FROM aboveAvgProducts;

/* Creating a view with explicit view */
-- This statement uses the CREATE VIEW statement to create a new view,
-- based on the customers and orders tables with explicit view columns:
CREATE VIEW customerOrderStats (
   customerName , 
   orderCount
) 
AS
    SELECT 
        customerName, 
        COUNT(orderNumber)
    FROM
        customers
            INNER JOIN
        orders USING (customerNumber)
    GROUP BY customerName;
    
-- This query returns data from the customerOrderStats view:
SELECT 
    customerName,
    orderCount
FROM
    customerOrderStats
ORDER BY 
	orderCount, 
    customerName;
