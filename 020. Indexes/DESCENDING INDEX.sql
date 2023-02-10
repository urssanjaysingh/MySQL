USE classicmodels;
SHOW TABLES;

/* Descending Index
A descending index is an index that stores key values in the descending order. */

-- The following statement creates a new table with an index:
DROP TABLE t;

CREATE TABLE t(
    a INT NOT NULL,
    b INT NOT NULL,
    INDEX a_asc_b_desc (a ASC, b DESC)
);

-- Starting from MySQL 8.0, the key values are stored in the descending order,
-- 	 if you use the DESC keyword in the index definition. 
-- The query optimizer can take advantage of descending index ,
	-- when descending order is requested in the query.
    
-- The following shows the table structure:
SHOW CREATE TABLE t;

/* MySQL descending Index example */

-- First, recreate the t table with four indexes in different orders:
DROP TABLE t;

CREATE TABLE t (
    a INT,
    b INT,
    INDEX a_asc_b_asc (a ASC , b ASC),
    INDEX a_asc_b_desc (a ASC , b DESC),
    INDEX a_desc_b_asc (a DESC , b ASC),
    INDEX a_desc_b_desc (a DESC , b DESC)
);

-- Second, use the following stored procedure to insert rows into the t table:
DELIMITER $$
CREATE PROCEDURE insertSampleData(
    IN rowCount INT, 
    IN low INT, 
    IN high INT
)
BEGIN
    DECLARE counter INT DEFAULT 0;
    REPEAT
        SET counter := counter + 1;
        -- insert data
        INSERT INTO t(a,b)
        VALUES(
            ROUND((RAND() * (high-low))+high),
            ROUND((RAND() * (high-low))+high)
        );
    UNTIL counter >= rowCount
    END REPEAT;
END $$    

DELIMITER ;
-- The stored procedure inserts a number of rows (rowCount) with the values,
-- between low and high into the a and b columns of the t table.

-- Let’s insert 100 rows into the t table with the random values between 1 and 10:
CALL insertSampleData(100,1,10);

-- Third, query data from the t table with different sort orders:

-- Sort the values in both columns a and b in ascending order:
EXPLAIN SELECT 
    *
FROM
    t
ORDER BY a , b; -- use index a_asc_b_asc

-- Sort the values in the column  a in ascending order and values in the column b in descending order:
EXPLAIN SELECT 
    *
FROM
    t
ORDER BY a , b DESC; -- use index a_asc_b_desc

-- Sort the values in the column  a in descending order and values in the column  b in ascending order:
EXPLAIN SELECT 
    *
FROM
    t
ORDER BY a DESC , b; -- use index a_desc_b_asc

-- Sort the values in both columns a and b in descending order:
EXPLAIN SELECT 
    *
FROM
    t
ORDER BY a DESC , b DESC; -- use index a_desc_b_desc
