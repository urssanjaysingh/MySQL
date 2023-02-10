USE classicmodels;
SHOW TABLES;

/* BEFORE UPDATE Trigger
MySQL BEFORE UPDATE triggers are invoked automatically before an update event occurs on the table associated with the triggers. */

-- First, create a new table called sales to store sales volumes:
DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

-- Second, insert some rows into the sales table:
INSERT INTO sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2003 Harley-Davidson Eagle Drag Bike',120, 2020,1),
    ('1969 Corvair Monza', 150,2020,1),
    ('1970 Plymouth Hemi Cuda', 200,2020,1);

-- Third, query data from the sales table to verify the insert:
SELECT * FROM sales;

-- The following statement creates a BEFORE UPDATE trigger on the sales table.
DELIMITER $$

CREATE TRIGGER before_sales_update
BEFORE UPDATE
ON sales FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The new quantity ',
                        NEW.quantity,
                        ' cannot be 3 times greater than the current quantity ',
                        OLD.quantity);
                        
    IF new.quantity > old.quantity * 3 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$

DELIMITER ;
-- If you update the value in the quantity column to a new value that is 3 times greater than the current value,
-- the trigger raises an error and stops the update.
-- Note that, in the BEFORE TRIGGER, you can access both old and new values of the columns
-- via OLD and NEW modifiers.

-- First, update the quantity of the row with id 1 to 150:
UPDATE sales 
SET quantity = 150
WHERE id = 1;

-- Second, query data from the sales table to verify the update:
SELECT * FROM sales;

-- Third, update the quantity of the row with id 1 to 500:
UPDATE sales 
SET quantity = 500
WHERE id = 1;

-- MySQL issued this error:
SHOW ERRORS;

/* AFTER UPDATE Trigger
MySQL AFTER UPDATE triggers are invoked automatically after an update event occurs
-- on the table associated with the triggers. */

-- First, create a table called Sales:
DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales (
    id INT AUTO_INCREMENT,
    product VARCHAR(100) NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    fiscalYear SMALLINT NOT NULL,
    fiscalMonth TINYINT NOT NULL,
    CHECK(fiscalMonth >= 1 AND fiscalMonth <= 12),
    CHECK(fiscalYear BETWEEN 2000 and 2050),
    CHECK (quantity >=0),
    UNIQUE(product, fiscalYear, fiscalMonth),
    PRIMARY KEY(id)
);

-- Second, insert sample data into the Sales table:
INSERT INTO Sales(product, quantity, fiscalYear, fiscalMonth)
VALUES
    ('2001 Ferrari Enzo',140, 2021,1),
    ('1998 Chrysler Plymouth Prowler', 110,2021,1),
    ('1913 Ford Model T Speedster', 120,2021,1);

-- Third, query data from the Sales table to display its contents:
SELECT * FROM Sales;

-- Finally, create a table that stores the changes in the quantity column from the sales table:
DROP TABLE IF EXISTS SalesChanges;

CREATE TABLE SalesChanges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    salesId INT,
    beforeQuantity INT,
    afterQuantity INT,
    changedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- The following statement creates an AFTER UPDATE trigger on the sales table:
DELIMITER $$

CREATE TRIGGER after_sales_update
AFTER UPDATE
ON sales FOR EACH ROW
BEGIN
    IF OLD.quantity <> new.quantity THEN
        INSERT INTO SalesChanges(salesId,beforeQuantity, afterQuantity)
        VALUES(old.id, old.quantity, new.quantity);
    END IF;
END$$

DELIMITER ;

-- If you update the value in the quantity column to a new value,
-- the trigger insert a new row to log the changes in the SalesChanges table.

/* Testing the MySQL AFTER UPDATE trigger */

-- First, update the quantity of the row with id 1 to 350:
UPDATE Sales 
SET quantity = 350
WHERE id = 1;
-- The after_sales_update was invoked automatically.

-- Second, query data from the SalesChanges table:
SELECT * FROM SalesChanges;

-- Third, increase the sales quantity of all rows to 10%:
UPDATE Sales 
SET quantity = CAST(quantity * 1.1 AS UNSIGNED);

-- Fourth, query data from the SalesChanges table:
SELECT * FROM SalesChanges;
-- The trigger fired three times because of the updates of the three rows.
