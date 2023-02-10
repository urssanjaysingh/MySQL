USE classicmodels;
SHOW TABLES;

/* Stored Procedures
By definition, a stored procedure is a segment of declarative SQL statements stored inside the MySQL Server. */

-- The following SELECT statement returns all rows in the table customers
SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;
-- If you want to save this query on the database server for execution later,
-- one way to do it is to use a stored procedure.

-- The following CREATE PROCEDURE statement creates a new stored procedure that wraps the query above:
DELIMITER $$

CREATE PROCEDURE GetCustomers()
BEGIN
	SELECT
		customerName,
        city,
        state,
        postalCode,
        country
	FROM
		customers
	ORDER BY
		customerName;
END$$
DELIMITER ;
-- In this example, we have just created a stored procedure with the name GetCustomers().

-- Once you save the stored procedure, you can invoke it by using the CALL statement:
CALL GetCustomers();
-- And the statement returns the same result as the query.

/* A stored procedure can have parameters so you can pass values to it and get the result back.
For example, you can have a stored procedure that returns customers by country and city. 
In this case, the country and city are parameters of the stored procedure.
A stored procedure may contain control flow statements such as IF, CASE, and LOOP,
	that allow you to implement the code in the procedural way. */
    
/* Delimiter 
When writing SQL statements, you use the semicolon (;) to separate two statements.
MySQL Workbench or mysql program uses the delimiter (;),
	to separate statements and executes each statement separately.
However, a stored procedure consists of multiple statements separated by a semicolon (;).
If you use a MySQL client program to define a stored procedure that contains semicolon characters, 
the MySQL client program will not treat the whole stored procedure as a single statement, 
	but many statements.
Therefore, you must redefine the delimiter temporarily,
	so that you can pass the whole stored procedure to the server as a single statement. */
    
-- To redefine the default delimiter, you use the DELIMITER command:
-- 		DELIMITER delimiter_character
-- The delimiter_character may consist of a single character or multiple characters e.g., // or $$. 
-- However, you should avoid using the backslash (\) because it’s the escape character in MySQL.

-- For example, the following statement changes the current delimiter to //:
DELIMITER //

-- Once changing the delimiter, you can use the new delimiter to end a statement as follows:
SELECT * FROM customers //

-- To change the delimiter to the default one, which is a semicolon (;), you use the following statement:
DELIMITER ;

/* Using MySQL DELIMITER for stored procedures
Typically, a stored procedure contains multiple statements separated by semicolons (;).
To compile the whole stored procedure as a single compound statement, 
	you need to temporarily change the delimiter from the semicolon (;)
		to another delimiter such as $$ or //
*/
DELIMITER $$

CREATE PROCEDURE sp_name()
BEGIN
  -- statements
END $$

DELIMITER ;
-- In this code:
--   First, change the default delimiter to $$.
--  Second, use (;) in the body of the stored procedure and $$ after the END keyword to end the stored procedure.
--  Third, change the default delimiter back to a semicolon (;)

/* CREATE PROCEDURE statement */
-- This query returns all products in the products table
SELECT * FROM products;

-- The following statement creates a new stored procedure that wraps the query:
DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT *  FROM products;
END //

DELIMITER ;

/* Executing a stored procedure */
-- To execute a stored procedure, you use the CALL statement
-- This example illustrates how to call the GetAllProducts() stored procedure:
CALL GetAllProducts();

/* DROP PROCEDURE
-- The DROP PROCEDURE statement deletes a stored procedure created by the CREATE PROCEDURE statement. */

-- First, create a new stored procedure that returns employee and office information:
DELIMITER $$

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT 
        firstName, 
        lastName, 
        city, 
        state, 
        country
    FROM employees
    INNER JOIN offices using (officeCode);
    
END$$

DELIMITER ;

-- Second, use the DROP PROCEDURE to delete the GetEmployees() stored procedure:
DROP PROCEDURE GetEmployees;

/* DROP PROCEDURE with the IF EXISTS */

-- The following example drops a stored procedure that does not exist:
DROP PROCEDURE abc;

-- MySQL issued the following error:
SHOW ERRORS;

-- This statement drops the same non-existing stored procedure, but with IF EXISTS option:
DROP PROCEDURE IF EXISTS abc;

-- This time MySQL issued a warning.
SHOW WARNINGS;

/* Stored Procedure Variables
A variable is a named data object whose value can change during the stored procedure execution. 
You typically use variables in stored procedures to hold immediate results. 
These variables are local to the stored procedure.
Before using a variable, you must declare it. */

/* Declaring variables
DECLARE is permitted only inside a BEGIN ... END compound statement and must be at its start, before any other statements.  */
-- To declare a variable inside a stored procedure, you use the DECLARE  statement
-- If you declare a variable without specifying a default value, its value is NULL.

-- The following example declares a variable named totalSale with the data type DEC(10,2) and default value 0.0  as follows:

-- ->> DECLARE totalSale DEC(10,2) DEFAULT 0.0;

-- MySQL allows you to declare two or more variables that share the same data type using a single DECLARE statement. 
-- The following example declares two integer variables  x and  y, and set their default values to zero.

-- ->> DECLARE x, y INT DEFAULT 0;

/* Assigning variables */
-- Once a variable is declared, it is ready to use. To assign a variable a value, you use the SET statement:

-- ->> DECLARE total INT DEFAULT 0;
-- ->> SET total = 10;

-- In addition to the SET statement, you can use the SELECT INTO statement,
-- to assign the result of a query to a variable as shown in the following example:

-- ->> DECLARE productCount INT DEFAULT 0;

-- ->> SELECT COUNT(*) INTO productCount FROM products;

/* Variable scopes
A variable has its own scope that defines its lifetime. 
If you declare a variable inside a stored procedure, 
it will be out of scope when the END statement of stored procedure reaches.
When you declare a variable inside the block BEGIN END, 
it will be out of scope if the END is reached. 
A variable whose name begins with the @ sign is a session variable. 
It is available and accessible until the session ends. */

/* Putting it all together
The following example illustrates how to declare and use a variable in a stored procedure: */
DELIMITER $$

CREATE PROCEDURE GetTotalOrder()
BEGIN
	DECLARE totalOrder INT DEFAULT 0;
    
    SELECT COUNT(*) 
    INTO totalOrder
    FROM orders;
    
    SELECT totalOrder;
END$$

DELIMITER ;

-- How it works.
-- First, declare a variable totalOrder with a default value of zero. 
-- This variable will hold the number of orders from the orders table.
-- Second, use the SELECT INTO  statement to assign the variable totalOrder the number of orders selected from the orders table:
-- Third, select the value of the variable totalOrder.

-- This statement calls the stored procedure GetTotalOrder():
CALL GetTotalOrder();

/* Stored Procedure Parameters
Often, stored procedures have parameters. 
The parameters make the stored procedure more useful and reusable. 
A parameter in a stored procedure has one of three modes: IN,OUT, or INOUT.

-- >> IN parameters
IN is the default mode. When you define an IN parameter in a stored procedure, 
the calling program has to pass an argument to the stored procedure.
In addition, the value of an IN parameter is protected. 
It means that even you change the value of the IN parameter inside the stored procedure, 
its original value is unchanged after the stored procedure ends. 
In other words, the stored procedure only works on the copy of the IN parameter.

-- >> OUT parameters
The value of an OUT parameter can be changed inside the stored procedure,
	and its new value is passed back to the calling program.
Notice that the stored procedure cannot access the initial value of the OUT parameter when it starts.

-- >> INOUT parameters
An INOUT  parameter is a combination of IN and OUT parameters. 
It means that the calling program may pass the argument, 
	and the stored procedure can modify the INOUT parameter, 
    and pass the new value back to the calling program.	
*/

/* The IN parameter example */
-- The following example creates a stored procedure that,
-- finds all offices that locate in a country specified by the input parameter countryName:

DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255)
)
BEGIN
	SELECT * 
 	FROM offices
	WHERE country = countryName;
END //

DELIMITER ;

-- In this example, the countryName is the IN parameter of the stored procedure.

-- Suppose that you want to find offices locating in the USA, 
-- you need to pass an argument (USA) to the stored procedure as shown in the following query:
CALL GetOfficeByCountry('USA');

-- To find offices in France, you pass the literal string France to the GetOfficeByCountry stored procedure as follows:
CALL GetOfficeByCountry('France')

-- Because the countryName is the IN parameter, you must pass an argument. 
-- If you don’t do so, you’ll get an error

/* The OUT parameter example */
-- The following stored procedure returns the number of orders by order status.

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$

DELIMITER ;

-- The stored procedure GetOrderCountByStatus() has two parameters:
-- 		The orderStatus: is the IN parameter specifies the status of orders to return.
-- 		The total: is the OUT parameter that stores the number of orders in a specific status.

-- To find the number of orders that already shipped, 
-- you call GetOrderCountByStatus and pass the order status as of Shipped, 
-- and also pass a session variable ( @total ) to receive the return value.
CALL GetOrderCountByStatus('Shipped',@total);

SELECT @total;

-- To get the number of orders that are in-process, 
-- you call the stored procedure GetOrderCountByStatus as follows:
CALL GetOrderCountByStatus('in process',@total);

SELECT @total AS  total_in_process;

/* The INOUT parameter example */
-- The following example demonstrates how to use an INOUT parameter in a stored procedure:

DELIMITER $$

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$

DELIMITER ;

-- In this example, 
-- the stored procedure SetCounter() accepts one INOUT parameter ( counter ) and one IN parameter ( inc ). 
-- It increases the counter ( counter ) by the value of specified by the inc parameter.

-- These statements illustrate how to call the SetSounter stored procedure:
SET @counter = 1;

CALL SetCounter(@counter,1); -- 2

CALL SetCounter(@counter,1); -- 3

CALL SetCounter(@counter,5); -- 8

SELECT @counter; -- 8

/* Alter Stored Procedures
Sometimes, you may want to alter a stored procedure by adding or removing parameters or even changing its body.
To make such changes, you must drop ad re-create the stored procedure using the DROP PROCEDURE and CREATE PROCEDURE statements. */

/* Listing Stored Procedures */
/* Listing stored procedures using SHOW PROCEDURE STATUS statement
The SHOW PROCEDURE STATUS statement shows all characteristic of stored procedures including stored procedure names. 
It returns stored procedures that you have a privilege to access. */

SHOW PROCEDURE STATUS;

-- If you just want to show stored procedures in a particular database,
-- you can use a WHERE clause in the  SHOW PROCEDURE STATUS as shown in the following statement:

-- For example, this statement lists all stored procedures in the sample database classicmodels:
SHOW PROCEDURE STATUS WHERE db = 'classicmodels';

-- In case you want to find stored procedures whose names contain a specific word, 
-- you can use the LIKE clause as follows:

-- The following statement shows all stored procedure whose names contain the wordOrder:
SHOW PROCEDURE STATUS LIKE '%Order%'

