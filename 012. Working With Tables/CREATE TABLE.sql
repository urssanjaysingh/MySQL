USE classicmodels;
SHOW TABLES;

/* The CREATE TABLE statement allows you to create a new table in a database. */
-- The following statement creates a new table named tasks:

/* First, you specify the name of the table that you want to create after the CREATE TABLE  keywords. 
The table name must be unique within a database. The IF NOT EXISTS is optional. 
It allows you to check if the table that you create already exists in the database. 
If this is the case, MySQL will ignore the whole statement and will not create any new table. */

CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    status TINYINT NOT NULL,
    priority TINYINT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* The task_id is an auto-increment column. 
If you use the INSERT statement to insert a new row into the table without specifying a value for the task_id column, 
MySQL will automatically generate a sequential integer for the task_id starting from 1. */

/* The title column is a variable character string column whose maximum length is 255. 
It means that you cannot insert a string whose length is greater than 255 into this column. 
The NOT NULL constraint indicates that the column does not accept NULL */

/* The created_at is a TIMESTAMP column that accepts the current time as the default value. */

-- Once you execute the CREATE TABLE statement to create the tasks table, 
-- you can view its structure by using the DESCRIBE statement:
DESCRIBE tasks;

/* CREATE TABLE with a foreign key primary key */
CREATE TABLE IF NOT EXISTS checklists (
    todo_id INT AUTO_INCREMENT,
    task_id INT,
    todo VARCHAR(255) NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (todo_id , task_id),
    FOREIGN KEY (task_id)
        REFERENCES tasks (task_id)
        ON UPDATE RESTRICT ON DELETE CASCADE
);

/* The table checklists has a primary key that consists of two columns. 
Therefore, we used a table constraint to define the primary key:
PRIMARY KEY (todo_id , task_id)
In addition, the task_id is the foreign key column that references to the task_id column of the table tasks, 
we used a foreign key constraint to establish this relationship:
FOREIGN KEY (task_id) 
    REFERENCES tasks (task_id) 
    ON UPDATE RESTRICT 
    ON DELETE CASCADE */









