USE classicmodels;
SHOW TABLES;

/* Error Handling in Stored Procedures 
Following is the syntax of the MySQL HANDLER Statement -
DECLARE handler_action HANDLER
	FOR condition_value
    statement

The handler_action is the action to be performed when the given conditions are satisfied.
You can provide the following as values for handler actions.
	CONTINUE - The current program will continue execution of the procedure.
	EXIT - This terminates the execution of the procedure.

The condition_value is the condition to be satisfied, you can pass multiple condition values.
You can provide the following as values for condition value.
	SQLWARNING, NOT FOUND, SQLEXCEPTION
*/

CREATE TABLE tutorials (
	ID INT PRIMARY KEY,
    TITLE VARCHAR(100),
    AUTHOR VARCHAR(40),
    DATE VARCHAR(40)
);

INSERT INTO tutorials
VALUES
	(1, 'Java', 'Krishna', '2019-09-01'),
    (2, 'JFreeCharts', 'Satish', '2019-05-01'),
    (3, 'JavaSpring', 'Amit', '2019-05-01'),
    (4, 'Android', 'Ram', '2019-03-01'),
    (5, 'Cassandra', 'Pruthvi', '2019-04-06');

-- let us create another table to back up the data -

	CREATE TABLE backup (
		ID INT,
        TITLE VARCHAR(100),
        AUTHOR VARCHAR(40),
        DATE VARCHAR(40)
	);
    
-- following is procedure demonstrates the usage of the handler statement, 
-- it backups the contents of the tutorials table to the backup table using cursors

DELIMITER //

CREATE PROCEDURE ExampleProc()
	BEGIN
		DECLARE done INT DEFAULT 0;
        DECLARE tutorialID INTEGER;
        DECLARE tutorialTitle, tutorialAuthor, tutorialDate VARCHAR(20);
        DECLARE cur CURSOR FOR SELECT * FROM tutorials;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        OPEN cur;
        label: LOOP
			FETCH cur INTO tutorialID, tutorialTitle, tutorialAuthor, tutorialDate;
            INSERT INTO backup VALUES(tutorialID, tutorialTitle, tutorialAuthor, tutorialDate);
            IF done = 1 THEN LEAVE label;
            END IF;
		END LOOP;
        CLOSE cur;
	END //

DELIMITER ;

CALL ExampleProc;

-- if you verify the contents of the backup table you can see the inserted records
SELECT * FROM backup;

/* Raising Error Conditions with MySQL SIGNAL / RESIGNAL Statements
You use the SIGNAL statement to return an error or warning condition to the caller,
	from a stored program e.g., stored procedure, stored function, trigger or event. 
*/

-- The following stored procedure adds an order line item into an existing sales order.
-- It issues an error message if the order number does not exist.
DELIMITER $$

CREATE PROCEDURE AddOrderItem(
		         in orderNo int,
			 in productCode varchar(45),
			 in qty int, 
                         in price double, 
                         in lineNo int )
BEGIN
	DECLARE C INT;

	SELECT COUNT(orderNumber) INTO C
	FROM orders 
	WHERE orderNumber = orderNo;

	-- check if orderNumber exists
	IF(C != 1) THEN 
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Order No not found in orders table';
	END IF;
	-- more code below
	-- ...
END $$

DELIMITER ;

/* First, it counts the orders with the input order number that we pass to the stored procedure.
Second, if the number of order is not 1, it raises an error with  SQLSTATE 45000 
along with an error message saying that order number does not exist in the orders table.
Notice that 45000 is a generic SQLSTATE value that illustrates an unhandled user-defined exception. */

-- If we call the stored procedure  AddOrderItem() and pass a nonexistent order number, 
-- we will get an error message.

CALL AddOrderItem(10, 'S10_1678', 1, 95.7, 1);

/* RESIGNAL statement 
Besides the SIGNAL  statement, MySQL also provides the RESIGNAL  statement used to raise a warning or error condition. */

-- The following stored procedure changes the error message before issuing it to the caller.
DELIMITER $$

CREATE PROCEDURE Divide(IN numerator INT, IN denominator INT, OUT result double)
BEGIN
	DECLARE division_by_zero CONDITION FOR SQLSTATE '22012';

	DECLARE CONTINUE HANDLER FOR division_by_zero 
	RESIGNAL SET MESSAGE_TEXT = 'Division by zero / Denominator cannot be zero';
	-- 
	IF denominator = 0 THEN
		SIGNAL division_by_zero;
	ELSE
		SET result := numerator / denominator;
	END IF;
END $$

DELIMITER ;

-- Let’s call the  Divide() stored procedure.
CALL Divide(10,0,@result);
