USE classicmodels;

/* BOOLEAN data type
MySQL does not have built-in Boolean type. However, it uses TINYINT(1) instead. 
To make it more convenient, MySQL provides BOOLEAN or BOOL as the synonym of TINYINT(1).
In MySQL, zero is considered as false, and non-zero value is considered as true. 
To use Boolean literals, you use the constants TRUE and FALSE that evaluate to 1 and 0 respectively.*/

-- To demonstrate this, let’s look at the following tasks table:
CREATE TABLE task (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN
);

-- Even though we specified the completed column as BOOLEAN, 
-- when we show the table definition, it is TINYINT(1) as follows:
DESCRIBE task;

-- The following statement inserts 2 rows into the tasks table:
INSERT INTO task(title,completed)
VALUES('Master MySQL Boolean type',true),
      ('Design database table',false); 
      
-- Before saving data into the Boolean column, MySQL converts it into 1 or 0.
SELECT 
	id, title, completed
FROM 
	task;
    
-- Because Boolean is TINYINT(1), you can insert value other than 1 and 0 into the Boolean column.
INSERT INTO task(title,completed)
VALUES('Test Boolean with a number',2);

SELECT 
	id, title, completed
FROM 
	task;
-- It is working fine.
   
-- If you want to output the result as true and false, you can use the IF function as follows:
SELECT 
    id, 
    title, 
    IF(completed, 'true', 'false') completed
FROM
    task;

/* BOOLEAN operators */
-- To get all completed tasks in the tasks table, you might come up with the following query:
SELECT 
    id, title, completed
FROM
    task
WHERE
    completed = TRUE;
-- s you see, it only returned the task with completed value 1. To fix it, you must use IS operator:
SELECT 
    id, title, completed
FROM
    task
WHERE
    completed IS TRUE;

-- To get the pending tasks, you use IS FALSE or IS NOT TRUE as follows:
SELECT 
    id, title, completed
FROM
    task
WHERE
    completed IS NOT TRUE;
