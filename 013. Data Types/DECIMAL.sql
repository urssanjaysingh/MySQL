USE classicmodels;

/* DECIMAL data type is used to store exact numeric values in the database. 
We often use the DECIMAL data type for columns that preserve exact precision e.g., money data in accounting systems.
To define a column whose data type is DECIMAL you use the following syntax:
	column_name  DECIMAL(P,D);
In the syntax above:
    P is the precision that represents the number of significant digits. 
    D is the scale that that represents the number of digits after the decimal point. */
    
-- First, create a new table named materials with three columns: id, description, and cost.
CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    cost DECIMAL(19 , 4 ) NOT NULL
);

-- Second, insert data into the materials table.
INSERT INTO materials(description,cost)
VALUES('Bicycle', 500.34),('Seat',10.23),('Break',5.21);

-- Third, query data from the materials table.
SELECT *
FROM materials;

-- Fourth, change the cost column to include  the ZEROFILL attribute.
ALTER TABLE materials
MODIFY cost DECIMAL(19,4) zerofill;

-- Fifth, query the materials table again.
SELECT *
FROM materials;

