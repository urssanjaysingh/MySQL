USE classicmodels;
SHOW TABLES;

/* CURSOR
To handle a result set inside a stored procedure, you use a cursor.
A cursor allows you to iterate a set of rows returned by a query and process each row individually.
MySQL cursor is read-only, non-scrollable and asensitive.
    Read-only: you cannot update data in the underlying table through the cursor.
    Non-scrollable: you can only fetch rows in the order determined by the SELECT statement. 
					You cannot fetch rows in the reversed order. 
                    In addition, you cannot skip rows or jump to a specific row in the result set.
	Asensitive: There are two kinds of cursors: asensitive cursor and insensitive cursor. 
				An asensitive cursor points to the actual data, 
                whereas an insensitive cursor uses a temporary copy of the data.
*/

/* Working with MySQL cursor *
-- DECLARE statement:
DECLARE cursor_name CURSOR FOR SELECT_statement; 

-- Next, open the cursor by using the OPEN statement. 
-- The OPEN statement initializes the result set for the cursor, 
-- therefore, you must call the OPEN statement before fetching rows from the result set.
OPEN cursor_name;

-- Then, use the FETCH statement to retrieve the next row pointed by the cursor
-- and move the cursor to the next row in the result set.
FETCH cursor_name INTO variables list;

-- After that, check if there is any row available before fetching it.
-- Finally, deactivate the cursor and release the memory associated with it  using the CLOSE statement:
CLOSE cursor_name;
*/

SELECT * FROM employees;

-- We’ll develop a stored procedure that creates an email list of all employees in the employees table
-- First, declare some variables, a cursor for looping over the emails of employees, 
-- and a NOT FOUND handler:
-- Next, open the cursor by using the OPEN statement:
-- Then, iterate the email list, and concatenate all emails where each email is separated by a semicolon(;):
-- After that, inside the loop, we used the finished variable to check if there is an email in the list to terminate the loop.
-- Finally, close the cursor using the CLOSE statement:

-- The createEmailList stored procedure is as follows:
DELIMITER $$
CREATE PROCEDURE createEmailList (
	INOUT emailList varchar(4000)
)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE emailAddress varchar(100) DEFAULT "";

	-- declare cursor for employee email
	DEClARE curEmail 
		CURSOR FOR 
			SELECT email FROM employees;

	-- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;

	OPEN curEmail;

	getEmail: LOOP
		FETCH curEmail INTO emailAddress;
		IF finished = 1 THEN 
			LEAVE getEmail;
		END IF;
		-- build email list
		SET emailList = CONCAT(emailAddress,", ",emailList);
	END LOOP getEmail;
	CLOSE curEmail;

END$$
DELIMITER ;

-- You can test the createEmailList stored procedure using the following script:
SET @emailList = ""; 

CALL createEmailList(@emailList);

SELECT @emailList;