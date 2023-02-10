USE classicmodels;
SHOW TABLES;

/* Export Table to CSV
The CSV stands for comma separated values. You often use the CSV file format
to exchange data between applications such as Microsoft Excel, Open Office, Google Docs, etc. 
Before exporting data, you must ensure that:
    The MySQL server’s process has the write access to the target folder that contains the target CSV file.
    The target CSV file must not exist. */
    
-- The following query selects cancelled orders from the  orders table:
SELECT 
    orderNumber, status, orderDate, requiredDate, comments
FROM
    orders
WHERE
    status = 'Cancelled';
    
-- To export this result set into a CSV file, you add some clauses to the query above as follows:
SELECT 
    orderNumber, status, orderDate, requiredDate, comments
FROM
    orders
WHERE
    status = 'Cancelled' 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cancelled_orders.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- The CSV file contains lines of rows in the result set. 
-- Each line is terminated by a sequence of carriage return and a line feed character
-- specified by the LINES TERMINATED BY '\r\n' clause.
-- Each line contains values of each column of the row in the result set.
-- Each value is enclosed by double quotation marks indicated by  FIELDS ENCLOSED BY '”' clause.
-- This prevents the value that may contain a comma (,) will be interpreted as the field separator.

/* Exporting data with column headings
It would be convenient if the CSV file contains the first line as the column headings
 so that the file is more understandable. */
 
 -- To add the column headings, you need to use the UNION statement as follows:
 (SELECT 'Order Number','Order Date','Status')
UNION 
(SELECT orderNumber,orderDate, status
FROM orders
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
FIELDS ENCLOSED BY '"' TERMINATED BY ';' ESCAPED BY '"'
LINES TERMINATED BY '\r\n');

