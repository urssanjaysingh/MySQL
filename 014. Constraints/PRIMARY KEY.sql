USE classicmodels;

/* Primary Key
A primary key is a column or a set of columns that uniquely identifies each row in the table.  
The primary key follows these rules:
    A primary key must contain unique values. If the primary key consists of multiple columns, 
		the combination of values in these columns must be unique.
    A primary key column cannot have NULL values. 
    Any attempt to insert or update NULL to primary key columns will result in an error. 
    Note that MySQL implicitly adds a NOT NULL constraint to primary key columns.
    A table can have one an only one primary key.
A primary key column often has the AUTO_INCREMENT attribute,
that automatically generates a sequential integer whenever you insert a new row into the table.*/
    
/* Define a PRIMARY KEY constraint in CREATE TABLE */

-- The following example creates a table named users whose primary key is the user_id column:
CREATE TABLE users(
   user_id INT AUTO_INCREMENT PRIMARY KEY,
   username VARCHAR(40),
   password VARCHAR(255),
   email VARCHAR(255)
);

DESCRIBE users;

-- This statement creates the roles table that has the PRIMARY KEY constraint as the table constraint:
CREATE TABLE roles(
   role_id INT AUTO_INCREMENT,
   role_name VARCHAR(50),
   PRIMARY KEY(role_id)
);

DESCRIBE roles;

-- In case the primary key consists of multiple columns, you must specify them at the end of the CREATE TABLE  statement.
-- You put a comma-separated list of primary key columns inside parentheses followed the PRIMARY KEY  keywords.

-- The following example creates the user_roles table whose primary key consists of two columns: user_id and role_id.
-- It defines the PRIMARY KEY constraint as the table constraint:
CREATE TABLE user_roles(
   user_id INT,
   role_id INT,
   PRIMARY KEY(user_id,role_id),
   FOREIGN KEY(user_id) 
       REFERENCES users(user_id),
   FOREIGN KEY(role_id) 
       REFERENCES roles(role_id)
);

DESCRIBE user_roles;
-- Note that the statement also created two foreign key constraints.

/* Define PRIMARY KEY constraints using ALTER TABLE */
-- If a table, for some reasons, does not have a primary key,
-- you can use the ALTER TABLEstatement to add a primary key to the table as follows:

-- First, create the pkdemos table without a primary key.
CREATE TABLE pkdemos(
   id INT,
   title VARCHAR(255) NOT NULL
);

DESCRIBE pkdemos;

-- Second, add a primary key to the pkdemos table using the ALTER TABLE statement:
ALTER TABLE pkdemos
ADD PRIMARY KEY(id);

DESCRIBE pkdemos;

/* PRIMARY KEY vs. UNIQUE KEY vs. KEY
KEY is the synonym for INDEX. 
You use the KEY when you want to create an index for a column or a set of columns,
that is not the part of a primary key or unique key.

A UNIQUE index ensures that values in a column must be unique. Unlike the PRIMARY index, 
MySQL allows NULL values in the UNIQUE index.
In addition, a table can have multiple UNIQUE indexes.*/

-- Suppose that username of users in the users table must be unique. To enforce thes rules,
-- you can define UNIQUE indexes for username columns as the following  statement:

-- Add a UNIQUE index for the username column:
ALTER TABLE users
ADD UNIQUE INDEX username_unique (username ASC) ;

DESCRIBE users;

