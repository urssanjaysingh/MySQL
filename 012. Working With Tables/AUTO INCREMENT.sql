USE classicmodels;
SHOW TABLES;
/* To create a sequence in MySQL automatically, you set the AUTO_INCREMENT attribute for a column, 
which typically is a primary key column. */

-- The following statement creates a table named employees that has the emp_no column is an AUTO_INCREMENT column:
CREATE TABLE employee (
    emp_no INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

/* The starting value of an AUTO_INCREMENT column is 1 and it is increased by 1,
when you insert a NULLvalue into the column or when you omit its value in the INSERT statement. */

-- First, insert two new rows into the employees table:
INSERT INTO employee(first_name,last_name)
VALUES('John','Doe'),
      ('Mary','Jane');
      
SELECT * FROM employee;     

-- Third, delete the second employee whose emp_no is 2:
DELETE FROM employee
WHERE emp_no = 2;

SELECT * FROM employee; 

-- Fourth, insert a new employee:
INSERT INTO employee(first_name,last_name)
VALUES('Jack','Lee');

SELECT * FROM employee; 
-- The new row has emp_no  3.

-- Fifth, update an existing employee with emp_no 3 to 1:
UPDATE employee
SET 
    first_name = 'Joe',
    emp_no = 10
WHERE
    emp_no = 3;

SELECT * FROM employee; 

-- Sixth, insert a new employee after updating the sequence number to 10:
INSERT INTO employee(first_name,last_name)
VALUES('Wang','Lee');

SELECT * FROM employee; 




