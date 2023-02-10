USE classicmodels;

/* TRUNCATE TABLE 
The MySQL TRUNCATE TABLE statement allows you to delete all data in a table. */

-- First, create a new table named books for the demonstration:
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

DESCRIBE books;

-- insert some data
INSERT INTO books(id, title)
VALUES 
	(1, 'ABC'),
    (2, 'XYZ');
    
SELECT * FROM books;

-- Finally, use the TRUNCATE TABLE statement to delete all rows from the books table:
TRUNCATE TABLE books;

DESCRIBE books;
