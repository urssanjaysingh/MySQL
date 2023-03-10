
/* MySQL prepared statement */
/* The prepared statement takes advantage of client/server binary protocol. 
It passes the query that contains placeholders (?) to the MySQL Server as the following example:
SELECT * 
FROM products 
WHERE productCode = ?;
Since the prepared statement uses placeholders (?), 
this helps avoid many variants of SQL injection hence make your application more secure. 
In order to use MySQL prepared statement, you use three following statements:
    PREPARE – prepare a statement for execution.
    EXECUTE – execute a prepared statement prepared by the PREPARE statement.
    DEALLOCATE PREPARE – release a prepared statement. */

SELECT * FROM products;

-- First, prepare a statement that returns the product code and name of a product specified by product code:
PREPARE stmt1 FROM 
	'SELECT 
   	    productCode, 
		productName 
	FROM products
        WHERE productCode = ?';
        
-- Second, declare a variable named pc, stands for product code, and set its value to 'S10_1678':
SET @pc = 'S10_1678'; 

-- Third, execute the prepared statement:
EXECUTE stmt1 USING @pc;

-- Fourth, assign the pc variable another product code:
SET @pc = 'S12_1099';

-- Fifth, execute the prepared statement with the new product code:
EXECUTE stmt1 USING @pc;

-- Finally, release the prepared statement:
DEALLOCATE PREPARE stmt1;