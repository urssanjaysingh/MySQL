USE classicmodels;
SHOW TABLES;

/* Introduction to index
An index is a data structure such as B-Tree that improves the speed of data retrieval on a table,
-- at the cost of additional writes and storage to maintain it.
The query optimizer may use indexes to quickly locate data without having to scan,
	every row in a table for a given query.

When you create a table with a primary key or unique key, 
MySQL automatically creates a special index named PRIMARY. 
This index is called the clustered index.
The PRIMARY index is special because the index itself is stored together,
	with the data in the same table. 
The clustered index enforces the order of rows in the table.

Other indexes other than the PRIMARY index are called secondary indexes or non-clustered indexes. */

/*-- CREATE INDEX statement */
-- Typically, you create indexes for a table at the time of creation. 
-- For example, the following statement creates a new table with an index that consists of two columns c2 and c3.
CREATE TABLE t(
   c1 INT PRIMARY KEY,
   c2 INT NOT NULL,
   c3 INT NOT NULL,
   c4 VARCHAR(10),
   INDEX (c2,c3) 
);

-- to add a new index for the column c4, you use the following statement:
CREATE INDEX idx_c4 ON t(c4);

/* MySQL CREATE INDEX example */
-- The following statement finds employees whose job title is Sales Rep:
SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
-- We have 17 rows indicating that 17 employees whose job title is the Sales Rep.

-- To see how MySQL internally performed this query, 
-- you add the EXPLAIN clause at the beginning of the SELECT statement as follows:
EXPLAIN SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
-- As you can see, MySQL had to scan the whole table which consists of 23 rows,
-- to find the employees with the Sales Rep job title.

-- Now, let’s create an index for the  jobTitle column by using the CREATE INDEX statement:
CREATE INDEX jobTitle ON employees(jobTitle);

-- And execute the above statement again:
EXPLAIN SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
-- As you can see, MySQL just had to locate 17 rows from the  jobTitle index,
-- as indicated in the key column without scanning the whole table.

-- To show the indexes of a table, you use the SHOW INDEXES statement, for example:
SHOW INDEXES FROM employees;