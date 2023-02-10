USE classicmodels;
SHOW TABLES;

/* The INSERT statement allows you to insert one or more rows into a table. */

-- Let’s create a new table named tasks for practicing the INSERT statement.
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    priority TINYINT NOT NULL DEFAULT 3,
    description TEXT,
    PRIMARY KEY (task_id)
);

DESCRIBE tasks;

-- The following statement inserts a new row into the tasks table:
INSERT INTO tasks(title,priority)
VALUES('Learn MySQL INSERT Statement', 1);

SELECT * FROM tasks;

/* In this example, we specified the values for only title and priority columns. 
For other columns, MySQL uses the default values.
The task_id column is an AUTO_INCREMENT column. 
It means that MySQL generates a sequential integer whenever a row is inserted into the table.
The start_date, due_date, and description columns use NULL as the default value. */

-- Inserting rows using default value 
INSERT INTO tasks(title,priority)
VALUES('Understanding DEFAULT keyword in INSERT statement',DEFAULT);

SELECT * FROM tasks;

-- Inserting dates into the table 
-- To insert a literal date value into a column, you use the following format:
-- 'YYYY-MM-DD'
INSERT INTO tasks(title, start_date, due_date)
VALUES('Insert date into table','2018-01-09','2018-09-15');

SELECT * FROM tasks;

-- It is possible to use expressions in the VALUES clause. 
-- For example, the following statement adds a new task using, 
-- the current date for start date and due date columns:
INSERT INTO tasks(title,start_date,due_date)
VALUES('Use current date for the task',CURRENT_DATE(),CURRENT_DATE());

SELECT * FROM tasks;

-- Inserting multiple rows
INSERT INTO tasks(title, priority)
VALUES
	('My first task', 1),
	('It is the second task',2),
	('This is the third task of the week',3);
    
 SELECT * FROM tasks;   

