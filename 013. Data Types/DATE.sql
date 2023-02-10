USE classicmodels;

/* DATE data type 
MySQL DATE is one of  the five temporal data types used for managing date values. 
MySQL uses yyyy-mm-dd format for storing a date value. This format is fixed and it is not possible to change it.
For example, you may prefer to use mm-dd-yyyy format but you can’t. 
Instead, you follow the standard date format and use the DATE_FORMAT function to format the date the way you want. */

/* Date values with two-digit years 
MySQL stores the year of the date value using four digits. In case you use two-digit year values, 
MySQL still accepts them with the following rules:
    Year values in the range 00-69 are converted to 2000-2069.
    Year values in the range 70-99 are converted to 1970 – 1999.
However, a date value with two digits is ambiguous therefore you should avoid using it.*/

-- First, create a table named people with birth date column with DATE data type.
CREATE TABLE people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL
);

-- Next, insert a row into the people table.
INSERT INTO people(first_name,last_name,birth_date)
VALUES('John','Doe','1990-09-01');

-- Then, query the data from the people table.
SELECT 
    first_name, 
    last_name, 
    birth_date
FROM
    people;
    
-- After that, use the two-digit year format to insert data into the people table.
INSERT INTO people(first_name,last_name,birth_date)
VALUES('Jack','Daniel','01-09-01'),
      ('Lily','Bush','80-09-01');
-- In the first row, we used 01 (range 00-69) as the year, so MySQL converted it to 2001. 
-- In the second row, we used 80 (range 70-99) as the year, MySQL converted it to 1980.

-- We can query data from the people table to check whether data was converted based on the conversion rules.
SELECT 
    first_name, 
    last_name, 
    birth_date
FROM
    people;
    
/* DATE functions
MySQL provides many useful date functions that allow you to manipulate date effectively. */

-- To get the current date and time, you use NOW() function.
SELECT NOW();

-- To get only date part of a DATETIME value, you use the DATE() function.
SELECT DATE(NOW());

-- To get the current system date, you use CURDATE() function as follows:
SELECT CURDATE();

-- To format a date value, you use  DATE_FORMAT function.
-- The following statement formats the date asmm/dd/yyyy using the date format pattern %m/%d/%Y :
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') today;

-- To calculate the number of days between two date values, you use the DATEDIFF function as follows:
SELECT DATEDIFF('2015-11-04','2014-11-04') days;

-- To add a number of days, weeks, months, years, etc., to a date value, you use the DATE_ADD function:
SELECT 
    '2015-01-01' start,
    DATE_ADD('2015-01-01', INTERVAL 1 DAY) 'one day later',
    DATE_ADD('2015-01-01', INTERVAL 1 WEEK) 'one week later',
    DATE_ADD('2015-01-01', INTERVAL 1 MONTH) 'one month later',
    DATE_ADD('2015-01-01', INTERVAL 1 YEAR) 'one year later';
    
-- Similarly, you can subtract an interval from a date using the DATE_SUB function:
SELECT 
    '2015-01-01' start,
    DATE_SUB('2015-01-01', INTERVAL 1 DAY) 'one day before',
    DATE_SUB('2015-01-01', INTERVAL 1 WEEK) 'one week before',
    DATE_SUB('2015-01-01', INTERVAL 1 MONTH) 'one month before',
    DATE_SUB('2015-01-01', INTERVAL 1 YEAR) 'one year before';
    
-- If you want to get the day, month, quarter, and year of a date value, 
-- you can use the corresponding function DAY, MONTH, QUARTER, and YEAR as follows:
SELECT DAY('2000-12-31') day, 
       MONTH('2000-12-31') month, 
       QUARTER('2000-12-31') quarter, 
       YEAR('2000-12-31') year;

-- To get the week information week related functions. For example, 
-- WEEK function returns the week number,
-- WEEKDAY function returns the weekday index, and WEEKOFYEAR function returns the calendar week.
SELECT 
    WEEKDAY('2000-12-31') weekday,
    WEEK('2000-12-31') week,
    WEEKOFYEAR('2000-12-31') weekofyear;
    
-- The week function returns the week number with the zero-based index
-- if you don’t pass the second argument or if you pass 0. If you pass 1,
-- it will return week number with 1-indexed.
 SELECT 
    WEEKDAY('2000-12-31') weekday,
    WEEK('2000-12-31',1) week,
    WEEKOFYEAR('2000-12-31') weekofyear;
