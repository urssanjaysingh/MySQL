USE classicmodels;

/* TIME Data Type 
MySQL uses the 'HH:MM:SS' format for querying and displaying a time value that represents a time of day, which is within 24 hours. 
To represent a time interval between two events, MySQL uses the 'HHH:MM:SS' format, which is larger than 24 hours. */

-- First, create a new table named tests that consists of four columns: id, name, start_at, and end_at. 
-- The data types of the start_at and end_at columns are TIME.
CREATE TABLE tests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    start_at TIME,
    end_at TIME
);

-- Second, insert a row into the tests table.
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 1', '08:00:00','10:00:00');

-- Third, query data from the tests table.
SELECT 
    name, start_at, end_at
FROM
    tests;
-- Notice that we use 'HH:MM:SS' as the literal time value in the INSERT statement. 

/* TIME literals 
MySQL allows you to use the 'HHMMSS' format without delimiter ( : ) to represent time value. 
For example, '08:30:00' and '10:15:00' can be rewritten as '083000' and '101500'. */
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 2','083000','101500');

SELECT * FROM tests;

-- In addition to the string format, MySQL accepts the HHMMSS as a number that represents a time value. 
-- You can also use SS, MMSS. For example, instead of using '082000', you can use 082000 as follows:
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 3',082000,102000);

SELECT * FROM tests;

-- For the time interval, you can use the 'D HH:MM:SS' format where D represents days with a range from 0 to 34. 
-- A more flexible syntax is 'HH:MM', 'D HH:MM', 'D HH', or 'SS'. If you use the delimiter:, 
-- you can use 1 digit to represent hours, minutes, or seconds. For example, 9:5:0 can be used instead of '09:05:00'
INSERT INTO tests(name,start_at,end_at)
VALUES('Test 4','9:5:0',100500);

SELECT * FROM tests;

/* Useful MySQL TIME functions
MySQL provides several useful temporal functions for manipulating TIME data. */

/* current time
To get the current time of the database server, you use the CURRENT_TIME function. 
The CURRENT_TIME function returns the current time value as a string ( 'HH:MM:SS') 
or a numeric value ( HHMMSS) depending on the context where the function is used. */

-- The following statements illustrate the CURRENT_TIME function in both string and numeric contexts:
SELECT 
    CURRENT_TIME() AS string_now,
    CURRENT_TIME() + 0 AS numeric_now;
    
-- Adding and Subtracting time from a TIME value
-- To add a TIME value to another TIME value, you use the ADDTIME function.
-- To subtract a TIME value from another TIME value, you use  the SUBTIME function.
-- The following statement adds and subtracts 2 hours 30 minutes to and from the current time.
SELECT 
    CURRENT_TIME(),
    ADDTIME(CURRENT_TIME(), 023000),	
    SUBTIME(CURRENT_TIME(), 023000);
    
-- In addition, you can use the TIMEDIFF() function to get a difference between two TIME values.
SELECT 
    TIMEDIFF(end_at, start_at)
FROM
    tests;
    
/* Formatting MySQL TIME values
Although MySQL uses 'HH:MM:SS' when retrieving and displaying the a TIME value, 
you can display the TIME value in your preferred way using the TIME_FORMAT function. */
SELECT 
    name,
    TIME_FORMAT(start_at, '%h:%i %p') start_at,
    TIME_FORMAT(end_at, '%h:%i %p') end_at
FROM
    tests;
-- In the time format string above:
 --    %h means two-digit hours from 0 to 12.
 --    %i means two-digit minutes from 0 to 60.
 --    %p means AM or PM.
 
/* Getting UTC time value */
-- To get the UTC time, you use UTC_TIME function as follows:
SELECT 
   CURRENT_TIME(), 
   UTC_TIME();
    