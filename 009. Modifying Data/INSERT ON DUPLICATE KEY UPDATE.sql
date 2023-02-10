USE classicmodels;
SHOW TABLES;

/* INSERT ON DUPLICATE KEY UPDATE 
When you insert a new row into a table if the row causes a duplicate in UNIQUE index or PRIMARY KEY, 
MySQL will issue an error.
However, if you specify the ON DUPLICATE KEY UPDATE option in the INSERT statement, 
MySQL will update the existing row with the new values instead. */

-- First, create a table named devices to store the network devices:
CREATE TABLE devices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

DESCRIBE devices;

-- Next, insert rows into the devices table.
INSERT INTO devices(name)
VALUES('Router F1'),('Switch 1'),('Switch 2');

-- Then, query the data from the devices table to verify the insert:
SELECT * FROM devices;

-- Now, we have three rows in the devices table.
-- After that, insert one more row into the devices table.
INSERT INTO devices(name) 
VALUES ('Printer');

SELECT * FROM devices;

-- Finally, insert a row with a duplicate value in the id column.
INSERT INTO devices(id,name) 
VALUES 
   (4,'Printer') 
ON DUPLICATE KEY UPDATE name = 'Central Printer';

SELECT * FROM devices;
-- Because a row with id 4 already exists in the devices table, 
-- the statement updates the name from Printer to Central Printer.
