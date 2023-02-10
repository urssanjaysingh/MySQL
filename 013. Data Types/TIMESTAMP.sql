USE classicmodels;

/* TIMESTAMP data type
The MySQL TIMESTAMP is a temporal data type that holds the combination of date and time. 
The format of a TIMESTAMP is YYYY-MM-DD HH:MM:SS which is fixed at 19 characters.
The TIMESTAMP value has a range from '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC. 
When you insert a TIMESTAMP value into a table, MySQL converts it from your connection’s time zone to UTC for storing.
When you query a TIMESTAMP value, MySQL converts the UTC value back to your connection’s time zone.*/

-- First, created a new table named test_timestamp that has a TIMESTAMP column: t1;
CREATE TABLE test_timestamp (
    t1  TIMESTAMP
);

-- Second, set the session’s time zone to ‘+00:00’ UTC by using the SET time_zone statement.
SET time_zone='+00:00';

-- Third, insert a TIMESTAMP value into the test_timestamp table.
INSERT INTO test_timestamp(t1)
VALUES('2008-01-01 00:00:01');

-- Fourth, select the TIMESTAMP value from the test_timestamp table.
SELECT t1 FROM test_timestamp;

-- Fifth, set the session’s time zone to a different time zone to see what value we will get from the database server:
SET time_zone ='+03:00';

-- Finally, query data from the table:
SELECT t1 FROM test_timestamp;
-- As you see, we received a different time value adjusted to the new time zone.

/* Automatic initialization and updating for TIMESTAMP columns */
-- First, creates a table named  category:
CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- In the category table, the created_at column is a TIMESTAMP column whose default value is set to CURRENT_TIMESTAMP.

DESCRIBE category;

-- Second, inserts a new row into the category table without specifying the value for the created_at column:
INSERT INTO category(name) 
VALUES ('A');

SELECT * FROM category;
-- As you can see from the output, MySQL used the timestamp at the time of inserting as a default value for the created_at column.

-- So a TIMESTAMP column can be automatically initialized to the current timestamp
-- for inserted rows that specify no value for the column.
-- This feature is called automatic initialization.

-- Third, add a new column named updated_at to the category table.
ALTER TABLE category
ADD COLUMN updated_at 
  TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP;
-- The default value of the updated_at column is CURRENT_TIMESTAMP.
-- And, we have a new clause ON UPDATE CURRENT_TIMESTAMP, 
-- that follows the DEFAULT CURRENT_TIMESTAMP clause. 

-- Let’s see its effect.
DESCRIBE category;

-- Fourth, inserts a new row into the category table.
INSERT INTO category(name)
VALUES('B');

-- Fifth, query data from the category table:
SELECT * FROM category;

-- Sixth, update the value in the column name of the row id 2:
UPDATE category
SET name = 'B+'
WHERE id = 2;

-- Seventh, query data from the category table to check the update:
SELECT *
FROM category
WHERE id = 2;

-- Notice that the value in the updated_at column changed to the timestamp at the time the row was updated.
-- The ability of a TIMESTAMP column to be automatically updated to the current timestamp
-- when the value in any other column in the row changed from its current value is called automatic updating.

-- Note that if you execute the UPDATE statement to update the same value for the name column,
-- the updated_at column will not be updated.
UPDATE category 
SET name = 'B+'
WHERE id = 2;

SELECT *
FROM category
WHERE id = 2;
