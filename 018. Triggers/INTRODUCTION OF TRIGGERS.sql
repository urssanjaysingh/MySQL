USE classicmodels;
SHOW TABLES;

/* Triggers
In MySQL, a trigger is a stored program invoked automatically
in response to an event such as insert, update, or delete that occurs in the associated table.

For example, if a table has 100 rows inserted, updated, or deleted, 
		the trigger is automatically invoked 100 times for the 100 rows affected. */
    
/* CREATE TRIGGER */
-- Let’s start creating a trigger in MySQL to log the changes of the employees table.
SELECT * FROM employees;

-- First, create a new table named employees_audit to keep the changes to the employees table:
CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- Next, create a BEFORE UPDATE trigger that is invoked before a change is made to the employees table.
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();
     
-- Inside the body of the trigger, we used the OLD keyword to access values of the columns,
-- employeeNumber and lastname of the row affected by the trigger.

-- Then, show all triggers in the current database by using the SHOW TRIGGERS statement:
SHOW TRIGGERS;

-- After that, update a row in the employees table:
UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;
    
-- Finally, query the employees_audit table to check if the trigger was fired by the UPDATE statement:
SELECT * FROM employees_audit;

/* DROP TRIGGER  */
-- First, create a table called billings for demonstration:
CREATE TABLE billings (
    billingNo INT AUTO_INCREMENT,
    customerNo INT,
    billingDate DATE,
    amount DEC(10 , 2 ),
    PRIMARY KEY (billingNo)
);

-- Second, create a new trigger called BEFORE UPDATE that is associated with the billings table:
DELIMITER $$
CREATE TRIGGER before_billing_update
    BEFORE UPDATE 
    ON billings FOR EACH ROW
BEGIN
    IF new.amount > old.amount * 10 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'New amount cannot be 10 times greater than the current amount.';
    END IF;
END$$    
DELIMITER ;

-- The trigger activates before any update. 
-- If the new amount is 10 times greater than the current amount, the trigger raises an error.
-- Third, show the triggers:
SHOW TRIGGERS;

-- Fourth, drop the before_billing_update trigger:
DROP TRIGGER before_billing_update;

-- Finally, show the triggers again to verify the removal:
SHOW TRIGGERS;