USE classicmodels;
SHOW TABLES;

-- Using the MySQL SELECT statement to retrieve data from all columns
SELECT * FROM employees;

-- Using the MySQL SELECT statement to retrieve data from a single column 
SELECT lastName
FROM employees;

-- Using the MySQL SELECT statement to query data from multiple columns 
SELECT 
	firstName,
    lastName,
    jobTitle
FROM 
	employees;
    
