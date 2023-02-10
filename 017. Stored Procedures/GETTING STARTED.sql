USE classicmodels;
SHOW TABLES;

/* Stored Function
A stored function is a special kind stored program that returns a single value.
Different from a stored procedure, you can use a stored function in SQL statements wherever an expression is used. 
This helps improve the readability and maintainability of the procedural code. 
To create a stored function, you use the CREATE FUNCTION statement. */

/* CREATE FUNCTION syntax:

DELIMITER $$

CREATE FUNCTION function_name(
    param1,
    param2,…
)
RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
END $$

DELIMITER ;

-- By default, all parameters are the IN parameters. 
You cannot specify IN , OUT or INOUT modifiers to parameters

-- Third, specify the data type of the return value in the RETURNS statement, 
which can be any valid MySQL data types.

-- Fourth, specify if a function is deterministic or not using the DETERMINISTIC keyword.
A deterministic function always returns the same result for the same input parameters,
whereas a non-deterministic function returns different results for the same input parameters.
If you don’t use DETERMINISTIC or NOT DETERMINISTIC, MySQL uses the NOT DETERMINISTIC option by default.

-- Fifth, write the code in the body of the stored function in the BEGIN END block. 
Inside the body section, you need to specify at least one RETURN statement. 
The RETURN statement returns a value to the calling programs.
 */
 
-- Let’s take the example of creating a stored function. We will use the customers table
SELECT * FROM customers;

-- The following CREATE FUNCTION statement creates a function that returns the customer level based on credit:
DELIMITER $$

CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$
DELIMITER ;

-- you can view all stored functions in the current classicmodels database
-- by using the SHOW FUNCTION STATUS as follows:
SHOW FUNCTION STATUS 
WHERE db = 'classicmodels';

/* Calling a stored function in an SQL statement */
-- The following statement uses the CustomerLevel stored function:
SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;
    
/* Calling a stored function in a stored procedure */
DROP PROCEDURE GetCustomerLevel;

-- The following statement creates a new stored procedure that calls the CustomerLevel() stored function:
DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  customerNo INT,  
    OUT customerLevel VARCHAR(20)
)
BEGIN

	DECLARE credit DEC(10,2) DEFAULT 0;
    
    -- get credit limit of a customer
    SELECT 
		creditLimit 
	INTO credit
    FROM customers
    WHERE 
		customerNumber = customerNo;
    
    -- call the function 
    SET customerLevel = CustomerLevel(credit);
END$$

DELIMITER ;

-- The following illustrates how to call the GetCustomerLevel() stored procedure:
CALL GetCustomerLevel(-131,@customerLevel);

SELECT @customerLevel;

/* DROP FUNCTION statement */
-- We’ll use the orders table in the sample database for the demonstration.
SELECT * FROM orders;

-- First, create a new function called OrderLeadTime that calculates the number of days,
-- between ordered date and required date:
DELIMITER $$

CREATE FUNCTION OrderLeadTime (
    orderDate DATE,
    requiredDate DATE
) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN requiredDate - orderDate;
END$$

DELIMITER ;

-- Second, use the DROP FUNCTION statement to drop the function OrderLeadTime:
DROP FUNCTION OrderLeadTime;

-- Third, use the DROP FUNCTION to drop a non-existing function:
DROP FUNCTION IF EXISTS NonExistingFunction;

-- MySQL issued a warning:
SHOW WARNINGS;

/* Listing Stored Functions */

/* Listing stored functions using SHOW FUNCTION STATUS statement
The SHOW FUNCTION STATUS is like the SHOW PROCEDURE STATUS but for the stored functions. */

-- The SHOW FUNCTION STATUS statement returns all characteristics of stored functions.
SHOW FUNCTION STATUS;

-- this statement shows all stored functions in the sample database classicmodels:
SHOW FUNCTION STATUS 
WHERE db = 'classicmodels';

-- If you want to find the stored functions whose names contain a specific word, 
-- you can use the LIKE clause:
-- The following statement shows all stored functions whose names contain the word Customer:
SHOW FUNCTION STATUS LIKE '%Customer%';
