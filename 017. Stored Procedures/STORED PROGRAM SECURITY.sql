USE classicmodels;
SHOW TABLES;

/* Stored Object Access Control
In MySQL, stored routines (stored procedures and functions), triggers, events, and views
	execute within a security context which determines their privileges.
MySQL uses DEFINER and SQL SECURITY characteristics to control these privileges. */

/* The DEFINER attribute
When you define a stored routine such as a stored procedure or function,
	you can optionally specify the DEFINER attribute, which is the name of a MySQL account:
If you skip the DEFINER attribute, the default is the current user account. */

/* SQL SECURITY DEFINER
When you use the SQL SECURITY DEFINER for a stored object, 
it will execute in definer security context with the privilege of the user specified in by the DEFINER attribute. */

/* SQL SECURITY INVOKER
If you use the SQL SECURITY INVOKER for a stored routine or view, 
it will operate within the privileges of the invoker. */

/* Stored object access control example */

-- First, create a new database called testdb:
CREATE DATABASE testdb;

-- Second, select the database testdb to work with:
USE testdb;

-- Third, create a new table called messages:
CREATE TABLE messages (
    id INT AUTO_INCREMENT,
    message VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

-- Fourth, create a stored procedure that inserts a new row into the messages table:
DELIMITER $$

CREATE DEFINER = root@localhost PROCEDURE InsertMessage( 
    msg VARCHAR(100)
)
SQL SECURITY DEFINER
BEGIN
    INSERT INTO messages(message)
    VALUES(msg);
END$$

DELIMITER ;

-- In this stored procedure, the definer is root@localhost that is the superuser,
-- which has all privileges.
-- The SQL Security is set to the definer. 
-- It means that any user account which calls this stored procedure,
-- will execute with all privileges of the definer i.e., root@localhost user account.

-- Fifth, create a new user named dev@localhost:
CREATE USER dev@localhost 
IDENTIFIED BY 'Abcd1234';

-- Sixth, grant the EXECUTE privilege to dev@localhost,
-- so that it can execute any stored procedure in the testdb database:
GRANT EXECUTE ON testdb.* 
TO dev@localhost;

-- Seventh, use the dev@localhost to log in to the MySQL Server:
mysql -u dev@localhost -p

-- Eight, use the SHOW DATABASES to display the database that dev@localhost can access:
show databases;

-- Ninth, select the testdb database:
use testdb;

-- Tenth, call the InsertMessage procedure to insert a row into the messages table:
call InsertMessage('Hello World');

-- Even though dev@localhost does not have any privilege on the messages table,
-- it can insert a new row into that table successfully via the stored procedure,
-- because the stored procedure executes in the security context of the root@localhost user account.

-- Eleventh, go to the root’s session and create a stored procedure that updates the messages table:
DELIMITER $$

CREATE DEFINER=root@localhost 
PROCEDURE UpdateMessage( 
    msgId INT,
    msg VARCHAR(100)
)
SQL SECURITY INVOKER
BEGIN
    UPDATE messages
    SET message = msg
    WHERE id = msgId;
END$$

DELIMITER ;

-- The UpdateMessage has the security context of INVOKER who will call this stored procedure.

-- Twelfth, go to the dev@localhost‘s session and call the UpdateMessage() stored procedure:
call UpdateMessage(1,'Good Bye');

-- This time the UpdateMessage() stored procedure executes,
-- with the privileges of the caller which is dev@localhost.

-- Because dev@localhost does not have any privileges on the messages table, 
-- MySQL issues an error and rejects the update.

