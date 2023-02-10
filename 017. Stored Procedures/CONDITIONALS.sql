USE classicmodels;
SHOW TABLES;

/* IF Statement
The IF statement has three forms: simple IF-THEN statement, 
IF-THEN-ELSE statement, and IF-THEN-ELSEIF- ELSE statement.  */

/* simple IF-THEN statement
		IF condition THEN 
		   statements;
		END IF;  
specify a condition to execute the code between the IF-THEN and END IF . 
 If the condition evaluates to TRUE, the statements between IF-THEN and END IF will execute. 
 Otherwise, the control is passed to the next statement following the END IF. */
 
SELECT * FROM customers;

-- See the following GetCustomerLevel() stored procedure.

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL(10,2) DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    END IF;
END$$

DELIMITER ;

-- The stored procedure GetCustomerLevel() accepts two parameters: pCustomerNumber and pCustomerLevel.
-- First, select creditLimit of the customer specified by the pCustomerNumber,
-- from the customers table and store it in the local variable credit.
-- Then, set value for the OUT parameter pCustomerLevel to PLATINUM,
-- if the credit limit of the customer is greater than 50,000.

-- This statement finds all customers that have a credit limit greater than 50,000:
SELECT 
    customerNumber, 
    creditLimit
FROM 
    customers
WHERE 
    creditLimit > 50000
ORDER BY 
    creditLimit DESC;
    
-- call the GetCustomerLevel() stored procedure for customer 141 
-- and show the value of the OUT parameter pCustomerLevel:
CALL GetCustomerLevel(141, @level);

SELECT @level;
-- Because the customer 141 has a credit limit greater than 50,000, 
-- its level is set to PLATINUM as expected.

/* IF-THEN-ELSE statement
In case you want to execute other statements when the condition in the IF branch does not evaluate to TRUE, 
you can use the IF-THEN-ELSE statement as follows:
		IF condition THEN
		   statements;
		ELSE
		   else-statements;
		END IF;	
In this syntax, if the condition evaluates to TRUE, the statements between IF-THEN and ELSE execute. 
Otherwise, the else-statements between the ELSE and END IF execute. */

-- Let’s modify the GetCustomerLevel() stored procedure.

-- First, drop the GetCustomerLevel() stored procedure:
DROP PROCEDURE GetCustomerLevel;

-- Then, create the GetCustomerLevel() stored procedure with the new code:

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSE
        SET pCustomerLevel = 'NOT PLATINUM';
    END IF;
END$$

DELIMITER ;

-- In this new stored procedure, we include the ELSE branch.
-- If the credit is not greater than 50,000,
-- we set the customer level to NOT PLATINUM in the block between ELSE and END IF.

-- This query finds customers that have credit limit less than or equal 50,000:
SELECT 
    customerNumber, 
    creditLimit
FROM 
    customers
WHERE 
    creditLimit <= 50000
ORDER BY 
    creditLimit DESC;

-- call the stored procedure for customer number 447  
-- and show the value of the OUT parameter pCustomerLevel:
CALL GetCustomerLevel(447, @level);

SELECT @level;
-- The credit limit of the customer 447 is less than 50,000, therefore, the statement in the ELSE branch executes
-- and sets the value of the OUT parameter pCustomerLevel to NOT PLATINUM.

/*  IF-THEN-ELSEIF-ELSE statement */

-- We will modify the GetCustomerLevel() stored procedure to use the IF-THEN-ELSEIF-ELSE statement.

-- First, drop the GetCustomerLevel() stored procedure:
DROP PROCEDURE GetCustomerLevel;

-- Then, create the new GetCustomerLevel() stored procedure that uses the the IF-THEN-ELSEIF-ELSE statement.

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    IN  pCustomerNumber INT, 
    OUT pCustomerLevel  VARCHAR(20))
BEGIN
    DECLARE credit DECIMAL DEFAULT 0;

    SELECT creditLimit 
    INTO credit
    FROM customers
    WHERE customerNumber = pCustomerNumber;

    IF credit > 50000 THEN
        SET pCustomerLevel = 'PLATINUM';
    ELSEIF credit <= 50000 AND credit > 10000 THEN
        SET pCustomerLevel = 'GOLD';
    ELSE
        SET pCustomerLevel = 'SILVER';
    END IF;
END $$

DELIMITER ;

-- In this stored procedure:
-- If the credit is greater than 50,000, the level of the customer is PLATINUM.
-- If the credit is less than or equal 50,000 and greater than 10,000, then the level of customer is GOLD.
-- Otherwise, the level of the customer is SILVER.

-- These statements call the stored procedure GetCustomerLevel() and show the level of the customer 447:
CALL GetCustomerLevel(447, @level); 

SELECT @level;

/* CASE Statement
Besides the IF statement, 
MySQL provides an alternative conditional statement called the CASE statement,
	for constructing conditional statements in stored procedures. 
The CASE statements make the code more readable and efficient.
The CASE statement has two forms: simpleCASE and searched CASE statements. */

/* Simple CASE statement 
-- To avoid the error when the  case_value does not equal any when_value,
-- you can use an empty BEGIN END block in the ELSE clause as follows:
CASE case_value
    WHEN when_value1 THEN ...
    WHEN when_value2 THEN ...
    ELSE 
        BEGIN
        END;
END CASE; 
*/

/* Simple CASE statement example */
-- The following stored procedure illustrates how to use the simple CASE statement:

DELIMITER $$

CREATE PROCEDURE GetCustomerShipping(
	IN  pCustomerNUmber INT, 
	OUT pShipping VARCHAR(50)
)

BEGIN
    DECLARE customerCountry VARCHAR(100);

	SELECT 
		country
	INTO 
		customerCountry 
	FROM 
		customers
	WHERE
		customerNumber = pCustomerNUmber;

    CASE customerCountry
		WHEN  'USA' THEN
		   SET pShipping = '2-day Shipping';
		WHEN 'Canada' THEN
		   SET pShipping = '3-day Shipping';
		ELSE
		   SET pShipping = '5-day Shipping';
	END CASE;
END$$

DELIMITER ;

-- This statement calls the stored procedure and passes the customer number 112:
CALL GetCustomerShipping(112, @shipping);

-- The following statement returns the shipping time of the customer 112:
SELECT @shipping;

/* Searched CASE statement
The simple CASE statement only allows you to compare a value with a set of distinct values.
To perform more complex matches such as ranges, you use the searched CASE statement. 
The searched CASE statement is equivalent to the IF  statement, 
however, it’s much more readable than the IF statement. */

/* Searched CASE statement example */
-- The following example demonstrates how to use a searched CASE statement,
-- to find customer level SILVER , GOLD or PLATINUM based on customer’s credit limit.

DELIMITER $$

CREATE PROCEDURE GetDeliveryStatus(
	IN pOrderNumber INT,
    OUT pDeliveryStatus VARCHAR(100)
)

BEGIN
	DECLARE waitingDay INT DEFAULT 0;
    
    SELECT 
		DATEDIFF(requiredDate, shippedDate)
	INTO waitingDay
	FROM orders
    WHERE orderNumber = pOrderNumber;
    
    CASE 
		WHEN waitingDay = 0 THEN 
			SET pDeliveryStatus = 'On Time';
        WHEN waitingDay >= 1 AND waitingDay < 5 THEN
			SET pDeliveryStatus = 'Late';
		WHEN waitingDay >= 5 THEN
			SET pDeliveryStatus = 'Very Late';
		ELSE
			SET pDeliveryStatus = 'No Information';
	END CASE;	
END$$
DELIMITER ;

-- This statement uses the stored procedure GetDeliveryStatus() to get the delivery status of the order 10100 :
CALL GetDeliveryStatus(10100, @delivery);

SELECT @delivery;

