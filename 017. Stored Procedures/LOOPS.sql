USE classicmodels;
SHOW TABLES;

/* LOOP statement
The LOOP statement allows you to execute one or more statements repeatedly.
Here is the basic syntax of the LOOP statement:

	[begin_label:] LOOP
		statement_list
	END LOOP [end_label]
    
The LOOP can have optional labels at the beginning and end of the block.
The LOOP executes the statement_list repeatedly. The statement_list may have one or more statements,
	each terminated by a semicolon (;) statement delimiter.

Typically, you terminate the loop when a condition is satisfied by using the LEAVE statement. 
This is the typical syntax of the LOOP statement used with LEAVE statement:

	[label]: LOOP
		...
		-- terminate the loop
		IF condition THEN
			LEAVE [label];
		END IF;
		...
	END LOOP;
    
The LEAVE statement immediately exits the loop. 
It works like the break statement in other programming languages like PHP, C/C++, and Java.

In addition to the LEAVE statement,
	you can use the ITERATE statement to skip the current loop iteration and start a new iteration.
The ITERATE is similar to the continue statement in PHP, C/C++, and Java. */

/* LOOP statement example */
-- The following statement creates a stored procedure that uses a LOOP loop statement:
DROP PROCEDURE LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str, x ,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

/* In this example:
The stored procedure constructs a string from the even numbers e.g., 2, 4, and 6.
The loop_label  before the LOOPstatement for using with the ITERATE and LEAVE statements.
If the value of  x is greater than 10, the loop is terminated because of the LEAVEstatement.
If the value of the x is an odd number, the ITERATE ignores everything below it and starts a new loop iteration.
If the value of the x is an even number, the block in the ELSEstatement will build the result string from even numbers.
*/

-- The following statement calls the stored procedure:
CALL LoopDemo();

/* WHILE Loop
The WHILE loop is a loop statement that executes a block of code repeatedly as long as a condition is true.
Here is the basic syntax of the WHILE statement:

		[begin_label:] WHILE search_condition DO
			statement_list
		END WHILE [end_label]

The WHILE checks the search_condition at the beginning of each iteration.
If the search_condition evaluates to TRUE, 
	the WHILE executes the statement_list as long as the search_condition is TRUE.
The WHILE loop is called a pre-test loop,
 because it checks the search_condition before the statement_list executes. */

/* WHILE loop statement example */

-- First, create a table namedcalendars which stores dates and derived date information,
-- such as day, month, quarter, and year:
CREATE TABLE calendars(
    id INT AUTO_INCREMENT,
    fulldate DATE UNIQUE,
    day TINYINT NOT NULL,
    month TINYINT NOT NULL,
    quarter TINYINT NOT NULL,
    year INT NOT NULL,
    PRIMARY KEY(id)
);

DESCRIBE calendars;

-- Second, create a new stored procedure to insert a date into the calendars table:

DELIMITER $$

CREATE PROCEDURE InsertCalendar(dt DATE)
BEGIN
    INSERT INTO calendars(
        fulldate,
        day,
        month,
        quarter,
        year
    )
    VALUES(
        dt, 
        EXTRACT(DAY FROM dt),
        EXTRACT(MONTH FROM dt),
        EXTRACT(QUARTER FROM dt),
        EXTRACT(YEAR FROM dt)
    );
END$$

DELIMITER ;

-- Third, create a new stored procedure LoadCalendars() 
-- that loads a number of days starting from a start date into the calendars table.

DELIMITER $$

CREATE PROCEDURE LoadCalendars(
    startDate DATE, 
    day INT
)
BEGIN
    
    DECLARE counter INT DEFAULT 1;
    DECLARE dt DATE DEFAULT startDate;

    WHILE counter <= day DO
        CALL InsertCalendar(dt);
        SET counter = counter + 1;
        SET dt = DATE_ADD(dt,INTERVAL 1 day);
    END WHILE;

END$$

DELIMITER ;

-- The stored procedure LoadCalendars() accepts two arguments:
-- startDate is the start date inserted into the calendars table.
-- day is the number of days that will be loaded starting from the startDate.

-- In the LoadCalendars() stored procedure:
-- First, declare a counter and dt variables for keeping immediate values. 
-- The default values of counter and dt are 1 and startDate respectively.

-- Then, check if the counter is less than or equal day, if yes:
-- Call the stored procedure InsertCalendar() to insert a row into the calendars table.
-- Increase the counter by one. Also, increase the dt by one day using the DATE_ADD() function.

-- The WHILE loop repeatedly inserts dates into the calendars table until the counter is equal to day.

-- The following statement calls the stored procedure LoadCalendars() to load 31 days,
-- into the calendars table starting from January 1st 2019.
CALL LoadCalendars('2019-01-01',31);

SELECT * FROM calendars;

/* REPEAT Loop

	[begin_label:] REPEAT
		statement
	UNTIL search_condition
	END REPEAT [end_label]

The REPEAT statement executes one or more statements until a search condition is true.
The REPEAT checks the search_condition after the execution of statement, 
	therefore, the statement always executes at least once. 
    This is why the REPEAT is also known as a post-test loop. */
    
/* REPEAT loop example */
-- This statement creates a stored procedure called RepeatDemo  
-- that uses the REPEAT statement to concatenate numbers from 1 to 9:

DELIMITER $$

CREATE PROCEDURE RepeatDemo()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';
    
    REPEAT
        SET result = CONCAT(result,counter,',');
        SET counter = counter + 1;
    UNTIL counter >= 10
    END REPEAT;
    
    -- display result
    SELECT result;
END$$

DELIMITER ;

-- In this stored procedure:
-- First, declare two variables counter and result and set their initial values to 1 and blank.
-- The counter variable is used for counting from 1 to 9 in the loop.
-- And the result variable is used for storing the concatenated string after each loop iteration.
-- Second, append counter value to the result variable using the CONCAT() function
-- until the counter is greater than or equal to 10.

-- The following statement calls the RepeatDemo() stored procedure:
CALL RepeatDemo();

/* LEAVE
The LEAVE statement exits the flow control that has a given label.
The following shows the basic syntax of the LEAVE statement:
	LEAVE label;
In this syntax, you specify the label of the block that you want to exit after the LEAVE keyword.

If the label is the outermost of the stored procedure  or function block, 
LEAVE terminates the stored procedure or function.
The following statement shows how to use the LEAVE statement to exit a stored procedure:
CREATE PROCEDURE sp_name()
sp: BEGIN
    IF condition THEN
        LEAVE sp;
    END IF;
    -- other statement
END$$
 */

SELECT * FROM customers;

-- For example, this statement creates a new stored procedure,
-- that checks the credit of a given customer in the customers table

DELIMITER $$

CREATE PROCEDURE CheckCredit(
    inCustomerNumber int
)
sp: BEGIN
    
    DECLARE customerCount INT;

    -- check if the customer exists
    SELECT 
        COUNT(*)
    INTO customerCount 
    FROM
        customers
    WHERE
        customerNumber = inCustomerNumber;
    
    -- if the customer does not exist, terminate
    -- the stored procedure
    IF customerCount = 0 THEN
        LEAVE sp;
    END IF;
    
    -- other logic
    -- ...
END$$

DELIMITER ;

/* Using LEAVE statement in loops 
The LEAVE statement allows you to terminate a loop.

The general syntax for the LEAVE statement when using in the LOOP, REPEAT and WHILE statements.

-->> Using LEAVE with the LOOP statement:

[label]: LOOP
    IF condition THEN
        LEAVE [label];
    END IF;
    -- statements
END LOOP [label];

-->> Using LEAVE with the REPEAT statement:

[label:] REPEAT
    IF condition THEN
        LEAVE [label];
    END IF;
    -- statements
UNTIL search_condition
END REPEAT [label];

-->> Using LEAVE with the WHILE statement:

[label:] WHILE search_condition DO
    IF condition THEN
        LEAVE [label];
    END IF;
    -- statements
END WHILE [label];

The LEAVE causes the current loop specified by the label to be terminated. 
If a loop is enclosed within another loop, 
	you can break out of both loops with a single LEAVE statement. */

-- The following stored procedure generates a string of integer,
-- with the number from 1 to a random number between 4 and 10:

DELIMITER $$

CREATE PROCEDURE LeaveDemo(OUT result VARCHAR(100))
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE times INT;
    -- generate a random integer between 4 and 10
    SET times  = FLOOR(RAND()*(10-4+1)+4);
    SET result = '';
    disp: LOOP
        -- concatenate counters into the result
        SET result = concat(result,counter,',');
        
        -- exit the loop if counter equals times
        IF counter = times THEN
            LEAVE disp; 
        END IF;
        SET counter = counter + 1;
    END LOOP;
END$$

DELIMITER ;

-- This statement calls the LeaveDemo procedure:
CALL LeaveDemo(@result);

SELECT @result;

