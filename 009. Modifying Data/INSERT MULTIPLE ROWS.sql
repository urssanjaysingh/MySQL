USE classicmodels;
SHOW TABLES;

/* INSERT multiple rows */

-- First, create a new table called projects for the demonstration:
CREATE TABLE projects(
	project_id INT AUTO_INCREMENT, 
	name VARCHAR(100) NOT NULL,
	start_date DATE,
	end_date DATE,
	PRIMARY KEY(project_id)
);

DESCRIBE projects;

-- Second, use the INSERT multiple rows statement to insert two rows into the projects table:
INSERT INTO 
	projects(name, start_date, end_date)
VALUES
	('AI for Marketing','2019-08-01','2019-12-31'),
	('ML for Sales','2019-05-15','2019-11-20');
    
SELECT * FROM projects;
