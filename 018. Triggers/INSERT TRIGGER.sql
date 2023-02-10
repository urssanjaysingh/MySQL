USE classicmodels;
SHOW TABLES;

/* BEFORE INSERT triggers 
MySQL BEFORE INSERT triggers are automatically fired before an insert event occurs on the table. */

-- First, create a new table called WorkCenters:
DROP TABLE IF EXISTS WorkCenters;

CREATE TABLE WorkCenters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL
);

-- Second, create another table called WorkCenterStats,
-- that stores the summary of the capacity of the work centers:
DROP TABLE IF EXISTS WorkCenterStats;

CREATE TABLE WorkCenterStats(
    totalCapacity INT NOT NULL
);

-- The following trigger updates the total capacity in the WorkCenterStats table,
-- before a new work center is inserted into the WorkCenter table:
DELIMITER $$

CREATE TRIGGER before_workcenters_insert
BEFORE INSERT
ON WorkCenters FOR EACH ROW
BEGIN
    DECLARE rowcount INT;
    
    SELECT COUNT(*) 
    INTO rowcount
    FROM WorkCenterStats;
    
    IF rowcount > 0 THEN
        UPDATE WorkCenterStats
        SET totalCapacity = totalCapacity + new.capacity;
    ELSE
        INSERT INTO WorkCenterStats(totalCapacity)
        VALUES(new.capacity);
    END IF; 

END $$

DELIMITER ;

-- inside the trigger body, we check if there is any row in the WorkCenterStats table.
-- If the table WorkCenterStats has a row, the trigger adds the capacity to the totalCapacity column.
-- Otherwise, it inserts a new row into the WorkCenterStats table.

/* Testing the MySQL BEFORE INSERT trigger */
-- First, insert a new row into the WorkCenter table:
INSERT INTO WorkCenters(name, capacity)
VALUES('Mold Machine',100);

-- Second, query data from the WorkCenterStats table:
SELECT * FROM WorkCenterStats;    
-- The trigger has been invoked and inserted a new row into the WorkCenterStats table.

-- Third, insert a new work center:
INSERT INTO WorkCenters(name, capacity)
VALUES('Packing',200);

-- Finally, query data from the WorkCenterStats:
SELECT * FROM WorkCenterStats;
-- The trigger has updated the total capacity from 100 to 200 as expected.

/*
Note that to properly maintain the summary table WorkCenterStats, 
you should also create triggers to handle update and delete events on the WorkCenters table. */

/* AFTER INSERT triggers
MySQL AFTER INSERT triggers are automatically invoked after an insert event occurs on the table. */

-- First, create a new table called members:
DROP TABLE IF EXISTS members;

CREATE TABLE members (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    birthDate DATE,
    PRIMARY KEY (id)
);

-- Second, create another table called reminders that stores reminder messages to members.
DROP TABLE IF EXISTS reminders;

CREATE TABLE reminders (
    id INT AUTO_INCREMENT,
    memberId INT,
    message VARCHAR(255) NOT NULL,
    PRIMARY KEY (id , memberId)
);

-- The following statement creates an AFTER INSERT trigger,
-- that inserts a reminder into the reminders table, if the birth date of the member is NULL.
DELIMITER $$

CREATE TRIGGER after_members_insert
AFTER INSERT
ON members FOR EACH ROW
BEGIN
    IF NEW.birthDate IS NULL THEN
        INSERT INTO reminders(memberId, message)
        VALUES(new.id,CONCAT('Hi ', NEW.name, ', please update your date of birth.'));
    END IF;
END$$

DELIMITER ;

/* Testing the MySQL AFTER INSERT trigger */
-- First, insert two rows into the members table:
INSERT INTO members(name, email, birthDate)
VALUES
    ('John Doe', 'john.doe@example.com', NULL),
    ('Jane Doe', 'jane.doe@example.com','2000-01-01');

-- Second, query data from the members table:
SELECT * FROM members;    

-- Third, query data from reminders table:
SELECT * FROM reminders;    
-- We inserted two rows into the members table. However, only the first row that has a birth date value NULL, 
-- therefore, the trigger inserted only one row into the reminders table.
