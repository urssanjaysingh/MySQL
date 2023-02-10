USE classicmodels;
SHOW TABLES;

/* BEFORE DELETE Trigger
MySQL BEFORE DELETE triggers are fired automatically before a delete event occurs in a table. */
-- First, create a new table called Salaries that stores salary information of employees
DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0
);

-- Second, insert some rows into the Salaries table:
INSERT INTO salaries(employeeNumber,validFrom,amount)
VALUES
    (1002,'2000-01-01',50000),
    (1056,'2000-01-01',60000),
    (1076,'2000-01-01',70000);

-- Third, create a table that stores the deleted salary:
DROP TABLE IF EXISTS SalaryArchives;    

CREATE TABLE SalaryArchives (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employeeNumber INT UNIQUE,
    validFrom DATE NOT NULL,
    amount DEC(12 , 2 ) NOT NULL DEFAULT 0,
    deletedAt TIMESTAMP DEFAULT NOW()
);

-- The following BEFORE DELETE trigger inserts a new row into the SalaryArchives table,
-- before a row from the Salaries table is deleted.
DELIMITER $$

CREATE TRIGGER before_salaries_delete
BEFORE DELETE
ON salaries FOR EACH ROW
BEGIN
    INSERT INTO SalaryArchives(employeeNumber,validFrom,amount)
    VALUES(OLD.employeeNumber,OLD.validFrom,OLD.amount);
END$$    

DELIMITER ;

/* Testing the MySQL BEFORE DELETE trigger */
-- First, delete a row from the Salaries table:
DELETE FROM salaries 
WHERE employeeNumber = 1002;

-- Second, query data from the SalaryArchives table:
SELECT * FROM SalaryArchives;    
-- The trigger was invoked and inserted a new row into the SalaryArchives table.

-- Third, delete all rows from the Salaries table:
DELETE FROM salaries;

-- Finally, query data from the SalaryArchives table:
SELECT * FROM SalaryArchives;

/* AFTER DELETE Trigger
MySQL AFTER DELETE  triggers are automatically invoked after a delete event occurs on the table. */

-- First, create a new table called Salaries:
DROP TABLE IF EXISTS Salaries;

CREATE TABLE Salaries (
    employeeNumber INT PRIMARY KEY,
    salary DECIMAL(10,2) NOT NULL DEFAULT 0
);

-- Second, insert some rows into the Salaries table:
INSERT INTO Salaries(employeeNumber,salary)
VALUES
    (1002,5000),
    (1056,7000),
    (1076,8000);

-- Third, create another table called SalaryBudgets that stores the total of salaries from the Salaries table:
DROP TABLE IF EXISTS SalaryBudgets;

CREATE TABLE SalaryBudgets(
    total DECIMAL(15,2) NOT NULL
);

-- Fourth, use the SUM() function to get the total salary from the Salaries table
-- and insert it into the SalaryBudgets table:
INSERT INTO SalaryBudgets(total)
SELECT SUM(salary) 
FROM Salaries;

-- Finally, query data from the SalaryBudgets table:
SELECT * FROM SalaryBudgets;        

-- The following AFTER DELETE trigger updates the total salary in the SalaryBudgets table,
-- after a row is deleted from the Salaries table:
CREATE TRIGGER after_salaries_delete
AFTER DELETE
ON Salaries FOR EACH ROW
UPDATE SalaryBudgets 
SET total = total - old.salary;

/* Testing the MySQL AFTER DELETE trigger */
-- First, delete a row from the Salaries table:
DELETE FROM Salaries
WHERE employeeNumber = 1002;

-- Second, query total salary from the SalaryBudgets table:
SELECT * FROM SalaryBudgets;    

-- Third, delete all rows from the salaries table:
DELETE FROM Salaries;

-- Finally, query the total from the SalaryBudgets table:
SELECT * FROM SalaryBudgets;    
-- The trigger updated the total to zero.
