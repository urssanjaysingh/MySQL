
/* delete data from multiple tables using INNER JOIN or LEFT JOIN clause with the DELETE statement. */

/* DELETE JOIN with INNER JOIN */
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE t2 (
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL
);

INSERT INTO t1 VALUES (1),(2),(3);

INSERT INTO t2(id,ref) VALUES('A',1),('B',2),('C',3);

SELECT * FROM t1;
SELECT * FROM t2;

DELETE t1,t2 FROM t1
        INNER JOIN
    t2 ON t2.ref = t1.id 
WHERE
    t1.id = 1;
    
SELECT * FROM t1;
SELECT * FROM t2;

/* DELETE JOIN with LEFT JOIN */
SELECT * FROM customers;
SELECT * FROM orders;

-- We often use the LEFT JOIN clause in the SELECT statement to find rows in the left table,
-- that have or don’t have matching rows in the right table.
-- We can use DELETE statement with LEFT JOIN clause to clean up our customers master data.
-- The following statement removes customers who have not placed any order:
DELETE customers 
FROM customers
        LEFT JOIN
    orders ON customers.customerNumber = orders.customerNumber 
WHERE
    orderNumber IS NULL;
    
-- We can verify the delete by finding whether customers who do not have any order exists using the following query:
SELECT 
    c.customerNumber, 
    c.customerName, 
    orderNumber
FROM
    customers c
        LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE
    orderNumber IS NULL;

-- The query returned an empty result set which is what we expected.