USE classicmodels;
/* TABLE LOCKING */

/* A lock is a flag associated with a table. 
-- MySQL allows a client session to explicitly acquire a table lock,
-- for preventing other sessions from accessing the same table during a specific period. */

--  let’s create a table named messages for practicing with the table locking statements.
CREATE TABLE messages ( 
    id INT NOT NULL AUTO_INCREMENT, 
    message VARCHAR(100) NOT NULL, 
    PRIMARY KEY (id) 
);

/* READ Locks 
The session that holds the READ lock can only read data from the table, but cannot write. 
And other sessions cannot write data to the table until the READ lock is released. 
The write operations from another session will be put into the waiting states until the READ lock is released.*/

-- First, connect to the database in the first session 
-- and use the CONNECTION_ID() function to get the current connection id as follows:
SELECT CONNECTION_ID();

-- Then, insert a new row into the messages table.
INSERT INTO messages(message) 
VALUES('Hello');

SELECT * FROM messages;

-- After that, acquire a lock using the LOCK TABLE statement.
LOCK TABLE messages READ;

-- Finally, try to insert a new row into the messages table:
INSERT INTO messages(message) 
VALUES('Hi');

-- MySQL issued the following error:
SHOW ERRORS;
-- So once the READ lock is acquired, you cannot write data to the table within the same session.

/* Write Locks 
    The only session that holds the lock of a table can read and write data from the table.
    Other sessions cannot read data from and write data to the table until the WRITE lock is released.*/

-- First, acquire a WRITE lock from the first session.
LOCK TABLE messages WRITE;

-- Then, insert a new row into the messages table.
INSERT INTO messages(message) 
VALUES('Good Morning');

-- Next, query data from the messages table.
SELECT * FROM messages;
-- So when WRITE lock is acquired, you can write data to the table within the same session.

/* Read vs. Write locks
    Read locks are “shared” locks that prevent a write lock is being acquired but not other read locks.
    Write locks are “exclusive ” locks that prevent any other lock of any kind.
*/
