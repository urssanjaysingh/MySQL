USE classicmodels;
SHOW TABLES;

/* Prefix Index */
-- We will use the products table from the sample database for the demonstration.

SELECT * FROM products;

-- The following query finds the products whose names start with the string 1970:
SELECT 
    productName, 
    buyPrice, 
    msrp
FROM
    products
WHERE
    productName LIKE '1970%';

-- Because there is no index for the  productName column, 
-- the query optimizer has to scan all rows to return the result,
-- as shown in the output of the EXPLAIN statement below:
EXPLAIN SELECT 
    productName, 
    buyPrice, 
    msrp
FROM
    products
WHERE
    productName LIKE '1970%';

DESCRIBE products;
-- If you often find the products by the product name, then you should create an index for this column,
--  because it will be more efficient for searches.
-- The size of the product name column is 70 characters. We can use the column prefix key parts.

-- The next question is how do you choose the length of the prefix? For doing this,
-- you can investigate the existing data. 
-- The goal is to maximize the uniqueness of the values in the column when you use the prefix.
-- To do this, you follow these steps:

-- Step 1. Find the number of rows in the table:

SELECT
   COUNT(*)
FROM
   products;
   
-- Step2. Evaluate different prefix length until you can achieve the reasonable uniqueness of rows:

SELECT
   COUNT(DISTINCT LEFT(productName, 20)) unique_rows
FROM
   products;
-- As shown in the output, 20 is a good prefix length in this case,
-- because if we use the first 20 characters of the product name for the index,
-- all product names are unique.

-- Let’s create an index with the prefix length 20 for the productName column:

CREATE INDEX idx_productname 
ON products(productName(20));

-- And execute the query that finds products whose name starts with the string 1970 again:

EXPLAIN SELECT 
    productName, 
    buyPrice, 
    msrp
FROM
    products
WHERE
    productName LIKE '1970%';
-- Now, the query optimizer uses the newly created index which is much faster,
-- and more efficient than before.
