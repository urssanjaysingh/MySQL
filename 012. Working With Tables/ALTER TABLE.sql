USE classicmodels;
SHOW TABLES;

/* ALTER TABLE 
learn how to use the MySQL ALTER TABLE statement to add a column, 
alter a column, rename a column, drop a column and rename a table. */

-- Let’s create a table named vehicles for the demonstration:
CREATE TABLE vehicles (
    vehicleId INT,
    year INT NOT NULL,
    make VARCHAR(100) NOT NULL,
    PRIMARY KEY(vehicleId)
);

DESCRIBE vehicles;

/* ALTER TABLE – Add columns to a table */

-- Add a column to a table
ALTER TABLE vehicles
ADD model VARCHAR(100) NOT NULL;

DESCRIBE vehicles;

-- Add multiple columns to a table
ALTER TABLE vehicles
ADD color VARCHAR(50),
ADD note VARCHAR(255);

DESCRIBE vehicles;

/* ALTER TABLE – Modify columns */

-- Modify a column
-- Suppose that you want to change the note column a NOT NULL column with a maximum of 100 characters.
ALTER TABLE vehicles 
MODIFY note VARCHAR(100) NOT NULL;

DESCRIBE vehicles;

-- Modify multiple columns
-- first, modify the data type of the year column from INT to SMALLINT
-- second, modify the color column by setting the maximum length to 20, 
-- removing the NOT NULL constraint, and changing its position to appear after the make column.
ALTER TABLE vehicles 
MODIFY year SMALLINT NOT NULL,
MODIFY color VARCHAR(20) NULL AFTER make;

DESCRIBE vehicles;

/* ALTER TABLE – Rename a column in a table */
-- rename the column note to vehicleCondition:
ALTER TABLE vehicles 
CHANGE COLUMN note vehicleCondition VARCHAR(100) NOT NULL;

DESCRIBE vehicles;

/* ALTER TABLE – Drop a column */
-- remove the vehicleCondition column from the vehicles table:
ALTER TABLE vehicles
DROP COLUMN vehicleCondition;

DESCRIBE vehicles;

/* ALTER TABLE – Rename table */
-- renames the vehicles table to cars:
ALTER TABLE vehicles 
RENAME TO cars; 

DESCRIBE cars;