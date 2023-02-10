USE classicmodels;

/* ENUM
ENUM is a string object whose value is chosen from a list of permitted values defined at the time of column creation.
The ENUM data type provides the following advantages:
    Compact data storage. MySQL ENUM uses numeric indexes (1, 2, 3, …) to represents string values.
    Readable queries and output. */

-- Suppose, we have to store ticket information with the priority: low, medium, and high. 

-- To assign the priority column the ENUM type, you use the following CREATE TABLE statement:
CREATE TABLE tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    priority ENUM('Low', 'Medium', 'High') NOT NULL
);

DESCRIBE tickets;

-- The priority column will accept only three values Low, Medium and High.
-- Behind the scenes, MySQL maps each enumeration member to a numeric index.
-- In this case, Low, Medium, and High are map to 1, 2 and 3 respectively.

-- To insert data into an ENUM column, you use the enumeration values in the predefined list.
INSERT INTO tickets(title, priority)
VALUES('Scan virus for computer A', 'High');

SELECT * FROM tickets;

-- Besides the enumeration values, 
-- you can use the numeric index of the enumeration member for inserting data into an ENUM column.
-- For instance, the following statement inserts a new ticket with the Low priority:
INSERT INTO tickets(title, priority)
VALUES('Upgrade Windows OS for all computers', 1);

SELECT * FROM tickets;

-- Let’s add some more rows to the tickets table:
INSERT INTO tickets(title, priority)
VALUES('Install Google Chrome for Mr. John', 'Medium'),
      ('Create a new user for the new employee David', 'High');  
      
SELECT * FROM tickets;

-- Because we defined the priority as a NOT NULL column,
-- when you insert a new row without specifying the value for the priority column,
-- MySQL will use the first enumeration member as the default value.
INSERT INTO tickets(title)
VALUES('Refresh the computer of Ms. Lily');

SELECT * FROM tickets;

/* Filtering MySQL ENUM values */
-- The following statement gets all high priority tickets:
SELECT *
FROM tickets
WHERE
    priority = 'High';
    
-- Because the enumeration member ‘High’ is mapped to 3, the following query returns the same result set:
SELECT *
FROM tickets
WHERE
    priority = 3;
    
/* Sorting MySQL ENUM values
MySQL sorts ENUM values based on their index numbers. 
Therefore, the order of member depends on how they were defined in the enumeration list. */

-- The following query selects the tickets and sorts them by the priority from High to Low:
SELECT 
    title, priority
FROM
    tickets
ORDER BY priority DESC;

/* ENUM has the following disadvantages:
    Changing enumeration members requires rebuilding the entire table using the ALTER TABLE statement,
    which is expensive in terms of resources and time. */
    