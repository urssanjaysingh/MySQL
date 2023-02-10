/* Selecting a MySQL Database Using USE Statement */

/* When you log in to a MySQL database server using the mysql client tool without specifying a database name, 
MySQL server will set the current database to NULL. */

-- Start MySQL server and EXECUTE the following statement
SELECT database();
-- It retruns NULL. It means the current database is not set.

-- In this case, you need to find which databases are available on your server by using the show databases statement:
SHOW DATABASES;

-- To select a database to work with, you use the USE statement
USE classicmodels;

-- To verify it, you can use the select database() statement:
SELECT database();
