USE classicmodels;
SHOW TABLES;

/* DROP COLUMN
In some situations, you want to remove one or more columns from a table. 
In such cases, you use the ALTER TABLE DROP COLUMN statement */

-- First,  create a table named posts for the demonstration.
CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    excerpt VARCHAR(400),
    content TEXT,
    created_at DATETIME,
    updated_at DATETIME
);

DESCRIBE posts;

-- Next, use the ALTER TABLE DROP COLUMN statement to remove the excerpt column:
ALTER TABLE posts
DROP COLUMN excerpt;

DESCRIBE posts;

-- After that, use the ALTER TABLE DROP COLUMN statement to drop the created_at and updated_at columns:
ALTER TABLE posts
DROP COLUMN created_at,
DROP COLUMN updated_at;

DESCRIBE posts;

/* drop a column which is a foreign key
If you remove the column that is a foreign key, 
MySQL will issue an error. */

-- First, create a table named categories:
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Second, add a column named category_id to the posts table.
ALTER TABLE posts 
ADD COLUMN category_id INT NOT NULL;

-- Third, make the category_id column as a foreign key column of that references to the id column of the categories table.
ALTER TABLE posts 
ADD CONSTRAINT fk_cat 
FOREIGN KEY (category_id) 
REFERENCES categories(id);

-- Fourth, drop the category_id column from the posts table.
ALTER TABLE posts
DROP COLUMN category_id;

-- MySQL issued an error message:
SHOW ERRORS;
-- To avoid this error, you must remove the foreign key constraint before dropping the column.