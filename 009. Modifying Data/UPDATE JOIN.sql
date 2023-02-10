
/* UPDATE JOIN */
CREATE DATABASE IF NOT EXISTS empdb;

USE empdb;

-- create tables
CREATE TABLE merits (
    performance INT(11) NOT NULL,
    percentage FLOAT NOT NULL,
    PRIMARY KEY (performance)
);

CREATE TABLE employees (
    emp_id INT(11) NOT NULL AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    performance INT(11) DEFAULT NULL,
    salary FLOAT DEFAULT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT fk_performance FOREIGN KEY (performance)
        REFERENCES merits (performance)
);
-- insert data for merits table
INSERT INTO merits(performance,percentage)
VALUES(1,0),
      (2,0.01),
      (3,0.03),
      (4,0.05),
      (5,0.08);
-- insert data for employees table
INSERT INTO employees(emp_name,performance,salary)      
VALUES('Mary Doe', 1, 50000),
      ('Cindy Smith', 3, 65000),
      ('Sue Greenspan', 4, 75000),
      ('Grace Dell', 5, 125000),
      ('Nancy Johnson', 3, 85000),
      ('John Doe', 2, 45000),
      ('Lily Bush', 3, 55000);
      
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM merits;      

/* UPDATE JOIN example with INNER JOIN clause */
-- Suppose you want to adjust the salary of employees based on their performance.
-- The merit’s percentages are stored in the merits table, 
-- therefore, you have to use the UPDATE INNER JOIN statement to adjust the salary of employees,
-- in the employees table based on the percentage stored in the merits table.
UPDATE employees
        INNER JOIN
    merits ON employees.performance = merits.performance 
SET 
    salary = salary + salary * percentage;
    
SELECT * FROM employees;

/* UPDATE JOIN example with LEFT JOIN */
-- Suppose the company hires two more employees:
INSERT INTO employees(emp_name,performance,salary)
VALUES('Jack William',NULL,43000),
      ('Ricky Bond',NULL,52000);
      
SELECT * FROM employees;
-- Because these employees are new hires so their performance data is not available or NULL 

-- To increase the salary for new hires, you cannot use the UPDATE INNER JOIN  statement 
-- because their performance data is not available in the merit  table. This is why the UPDATE LEFT JOIN  comes to the rescue.
-- The UPDATE LEFT JOIN  statement basically updates a row in a table when it does not have a corresponding row in another table.
-- you can increase the salary for a new hire by 1.5%  using the following statement:
UPDATE employees
LEFT JOIN
    merits ON employees.performance = merits.performance 
SET 
    salary = salary + salary * 0.015
WHERE
    merits.percentage IS NULL;
    
SELECT * FROM employees;




