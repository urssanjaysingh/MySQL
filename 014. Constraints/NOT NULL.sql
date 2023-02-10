USE classicmodels;

/* NOT NULL Constraint
The NOT NULL constraint is a column constraint that ensures values stored in a column are not NULL. */

-- The following CREATE TABLE statement creates the tasks_1 table:

CREATE TABLE tasks_1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

DESCRIBE tasks_1;

/* In the tasks table, we explicitly define the title and start_date columns with NOT NULL constraints. 
The id column has the PRIMARY KEY constraint, therefore, it implicitly includes a NOT NULL constraint.
The end_date column can have NULL values, assuming that when you create a new task, 
you may not know when the task can be completed. */

/* It’s a good practice to have the NOT NULL constraint in every column of a table. */

/* NOT NULL constraint to an existing column */
-- The following statement inserts some rows into the tasks table for the demonstration.
INSERT INTO tasks_1(title ,start_date, end_date)
VALUES('Learn MySQL NOT NULL constraint', '2017-02-01','2017-02-02'),
      ('Check and update NOT NULL constraint to your database', '2017-02-01',NULL);

-- First, use the IS NULL operator to find rows with NULLs in the column end_date :
SELECT * 
FROM tasks_1
WHERE end_date IS NULL;  

-- Second, update the NULL values to non-null values.
UPDATE tasks_1
SET 
    end_date = start_date + 7
WHERE
    end_date IS NULL;
    
-- This query verifies the update:
SELECT * FROM tasks_1;

-- Third, add a NOT NULL constraint to the end_date column using the following ALTER TABLE statement:
ALTER TABLE tasks_1 
CHANGE 
    end_date 
    end_date DATE NOT NULL;
    
-- Let’s verify the change by using the DESCRIBE statement:
DESCRIBE tasks_1;

/* Drop a NOT NULL constraint */
-- the following statement removes the NOT NULL constraint from the end_date column in the tasks table:
ALTER TABLE tasks_1
MODIFY 
    end_date DATE NOT NULL;
    
-- ensure that the statement actually removed the NOT NULL constraint,
DESCRIBE tasks_1;
