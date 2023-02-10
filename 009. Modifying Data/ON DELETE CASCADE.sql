/* ON DELETE CASCADE */

/* Suppose that we have two tables:buildings and rooms . 
In this database model, each building has one or many rooms. 
However, each room belongs to one only one building. */

-- When you delete a row from the buildings table, 
-- you also want to delete all rows in the rooms  table that references to the row in the buildings

-- The following are steps that demonstrate how the ON DELETE CASCADE referential action works.

-- Create the buildings table:
CREATE TABLE buildings (
    building_no INT PRIMARY KEY AUTO_INCREMENT,
    building_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Create the rooms table:
CREATE TABLE rooms (
    room_no INT PRIMARY KEY AUTO_INCREMENT,
    room_name VARCHAR(255) NOT NULL,
    building_no INT NOT NULL,
    FOREIGN KEY (building_no)
        REFERENCES buildings (building_no)
        ON DELETE CASCADE
);
-- Notice that the ON DELETE CASCADE  clause at the end of the foreign key constraint definition.

--  Insert rows into the buildings table:
INSERT INTO buildings(building_name,address)
VALUES('ACME Headquaters','3950 North 1st Street CA 95134'),
      ('ACME Sales','5000 North 1st Street CA 95134');
      
-- Query data from the buildings table:
SELECT * FROM buildings;

-- Insert rows into the rooms table:
INSERT INTO rooms(room_name,building_no)
VALUES('Amazon',1),
      ('War Room',1),
      ('Office of CEO',1),
      ('Marketing',2),
      ('Showroom',2);
      
-- Query data from the rooms table:
SELECT * FROM rooms;
-- We have three rooms that belong to building no 1 and two rooms that belong to the building no 2.

-- Delete the building with building no. 2:
DELETE FROM buildings 
WHERE building_no = 2;

SELECT * FROM buildings;

-- Query data from rooms table:
SELECT * FROM rooms;
-- As you can see, all the rows that reference to building_no 2 were automatically deleted.
