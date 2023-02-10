
/* Rename Table Using MySQL RENAME TABLE Statement */

-- First, we create a new database named hr that consists of two tables: 
-- employees and departments for the demonstration.
CREATE DATABASE IF NOT EXISTS hr;

-- use the data
USE hr;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100)
);

CREATE TABLE employees (
    id int AUTO_INCREMENT primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    department_id int not null,
    FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
);

-- Second, we insert sample data into both employees and departments tables:
INSERT INTO departments(dept_name)
VALUES('Sales'),('Markting'),('Finance'),('Accounting'),('Warehouses'),('Production');

INSERT INTO employees(first_name,last_name,department_id) 
VALUES('John','Doe',1),
		('Bush','Lily',2),
		('David','Dave',3),
		('Mary','Jane',4),
		('Jonatha','Josh',5),
		('Mateo','More',1);
        
-- Third, we review our data in the departments and employees tables:
SELECT * FROM departments;
SELECT * FROM employees;

/* Renaming a table referenced by a view */
-- we create a view named v_employee_info based on the employees and departments tables as follows:
CREATE VIEW v_employee_info as
    SELECT 
        id, first_name, last_name, dept_name
    from
        employees
            inner join
        departments USING (department_id);
-- The views use the inner join clause to join departments and employees tables.

-- The following SELECT statement returns all data from the v_employee_info view.
SELECT *
FROM v_employee_info;

-- Now we rename the employees to people table and query data from the v_employee_info view again.
RENAME TABLE employees TO people;

SHOW TABLES;

SELECT *
FROM v_employee_info;

-- MySQL returns the following error message:
SHOW ERRORS;

-- We can use the CHECK TABLE statement to check the status of the v_employee_info view as follows:
CHECK TABLE v_employee_info;

-- We need to manually change the v_employee_info view,
-- so that it refers to the people table instead of the employees table.

/* Renaming a table that has foreign keys referenced to 
The departments table links to the employees table using the department_id column. 
The department_id column in the employees table is the foreign key that references to the departments table.
If we rename the departments table, all the foreign keys
that point to the departments table will not be automatically updated. In such cases, we must drop and recreate the foreign keys manually.*/

RENAME TABLE departments TO depts;

SHOW TABLES;

DELETE FROM depts 
WHERE
    department_id = 1;
    
SHOW ERRORS;

/* Renaming multiple tables */
RENAME TABLE depts TO departments,
             employees TO people;
             
SHOW TABLES;
-- Note the RENAME TABLE statement is not atomic. It means that if any errors occurred, 
-- MySQL does a rollback all renamed tables to their old names.

/* Renaming tables using ALTER TABLE statement */
ALTER TABLE people 
RENAME TO employees;

SHOW TABLES;


