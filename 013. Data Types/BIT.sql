USE classicmodels;

/* BIT data type
The BIT type that allows you to store bit values. Here is the syntax:
	BIT(n)
	The BIT(n) can store up to n-bit values. The n can range from 1 to 64.
The default value of n is 1 if you skip it. */

/* To specify a bit value literal, you use b'val' or 0bval notation, 
which val is a binary value that contains only 0 and 1.
The leading b can be written as B, for example: b01 *

-- The following statement creates a new table named working_calendars that has the days column is BIT(7): */
CREATE TABLE working_calendars(
    y INT,
    w INT,
    days BIT(7),
    PRIMARY KEY(y,w)
);
-- The values in column days indicate whether the day is a working day or day off i.e., 1: working day and 0: day off.

-- Suppose that Saturday and Friday of the first week of 2017 are not the working days, 
-- you can insert a row into the working_calendars table:
INSERT INTO working_calendars(y,w,days)
VALUES(2017,1,B'1111100');

SELECT 
	y, w , days
FROM 
	working_calendars;
-- As you see, the bit value in the  days column is converted into an integer.
-- To represent it as bit values, you use the BIN function:
SELECT 
    y, w , bin(days)
FROM
    working_calendars;
    
/* If you insert a value to a BIT(n) column that is less than n bits long,
MySQL will pad zeros on the left of the bit value.
Suppose the first day of the second week is off, you can insert 01111100 into the  days column. 
However, the 111100 value will also work because MySQL will pad one zero to the left. */
INSERT INTO working_calendars(y,w,days)
VALUES(2017,2,B'111100');

SELECT 
    y, w , bin(days)
FROM
    working_calendars; 
-- As you can see, MySQL removed the leading zeros prior to returning the result. 
-- To display it correctly, you can use the LPAD function:
SELECT 
    y, w , lpad(bin(days),7,'0')
FROM
    working_calendars;
