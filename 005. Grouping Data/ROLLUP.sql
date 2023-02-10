USE classicmodels;
SHOW TABLES;

/* A grouping set is a set of columns to which you want to group.
The ROLLUP generates multiple grouping sets based on the columns
or expressions specified in the GROUP BY clause. 
The ROLLUP clause generates not only the subtotals but also the grand total of the order values.*/

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

/* creates a new table named sales that stores the order values summarized by product lines and years. */
CREATE TABLE sales
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);
    
SELECT * FROM sales;

SELECT 
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline 
WITH ROLLUP;
    
/* The ROLLUP clause generates the grand total of the order values at the end of result set 
If you have more than one column specified in the GROUP BY clause, 
the ROLLUP clause assumes a hierarchy among the input columns. */
SELECT 
    productLine, 
    orderYear,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    productline, 
    orderYear 
WITH ROLLUP;

/* The ROLLUP generates the subtotal row every time the product line changes 
and the grand total at the end of the result. 
The hierarchy in this case is: productLine > orderYear
If you reverse the hierarchy, The ROLLUP generates the subtotal every time the year changes
and the grand total at the end of the result set 
The hierarchy in this case is: orderYear > productLine */
SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;

/* The GROUPING() function 
To check whether NULL in the result set represents the subtotals or grand totals, you use the GROUPING() function.
The GROUPING() function returns 1 when NULL occurs in a supper-aggregate row, otherwise, it returns  */
SELECT 
    orderYear,
    productLine, 
    SUM(orderValue) totalOrderValue,
    GROUPING(orderYear),
    GROUPING(productLine)
FROM
    sales
GROUP BY 
    orderYear,
    productline
WITH ROLLUP;

/* The GROUPING(orderYear) returns 1 when NULL in the orderYear column occurs in a super-aggregate row, 0 otherwise.
Similarly, the GROUPING(productLine) returns 1 when NULL in the productLine column occurs in a super-aggregate row, 0 otherwise. */

/* We often use GROUPING() function to substitute meaningful labels,
for super-aggregate NULL values instead of displaying it directly. 
The following example shows how to combine the IF() function with the GROUPING() function
to substitute labels for the super-aggregate NULL values in orderYear and productLine columns */
SELECT 
    IF(GROUPING(orderYear),
        'All Years',
        orderYear) orderYear,
    IF(GROUPING(productLine),
        'All Product Lines',
        productLine) productLine,
    SUM(orderValue) totalOrderValue
FROM
    sales
GROUP BY 
    orderYear , 
    productline 
WITH ROLLUP;
