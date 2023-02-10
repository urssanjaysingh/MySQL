/* MySQL transactions */

/* MySQL provides us with the following important statement to control transactions:
-- To start a transaction, you use the START TRANSACTION  statement. The BEGIN or  BEGIN WORK are the aliases of the START TRANSACTION.
-- To commit the current transaction and make its changes permanent,  you use the COMMIT statement.
-- To roll back the current transaction and cancel its changes, you use the ROLLBACK statement.
-- To disable or enable the auto-commit mode for the current transaction, you use the SET autocommit statement.

/* By default, MySQL automatically commits the changes permanently to the database. 
To force MySQL not to commit changes automatically, you use the following statement: 
SET autocommit = 0; OR SET autocommit = OFF
You use the following statement to enable the autocommit mode explicitly:
SET autocommit = 1; OR SET autocommit = ON; */

USE classicmodels;
SHOW TABLES;

SELECT * FROM orders;
SELECT * FROM orderdetails;

/* COMMIT example */

-- 1. start a new transaction
START TRANSACTION;

-- 2. Get the latest order number
SELECT 
    @orderNumber:=MAX(orderNUmber)+1
FROM
    orders;

-- 3. insert a new order for customer 145
INSERT INTO orders(orderNumber,
                   orderDate,
                   requiredDate,
                   shippedDate,
                   status,
                   customerNumber)
VALUES(@orderNumber,
       '2005-05-31',
       '2005-06-10',
       '2005-06-11',
       'In Process',
        145);
        
-- 4. Insert order line items
INSERT INTO orderdetails(orderNumber,
                         productCode,
                         quantityOrdered,
                         priceEach,
                         orderLineNumber)
VALUES(@orderNumber,'S18_1749', 30, '136', 1),
      (@orderNumber,'S18_2248', 50, '55.09', 2); 
      
-- 5. commit changes    
COMMIT;

-- To get the newly created sales order, you use the following query:
SELECT 
    a.orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber,
    orderLineNumber,
    productCode,
    quantityOrdered,
    priceEach
FROM
    orders a
        INNER JOIN
    orderdetails b USING (orderNumber)
WHERE
    a.ordernumber = 10426;
    
/* ROLLBACK example */
SET autocommit=0;

-- Assume we have created a table with name Players in MySQL database
CREATE TABLE Players(
   ID INT,
   First_Name VARCHAR(255),
   Last_Name VARCHAR(255),
   Date_Of_Birth date,
   Place_Of_Birth VARCHAR(255),
   Country VARCHAR(255),
   PRIMARY KEY (ID)
);

-- Now, we will insert 3 records in Players table using INSERT statements
insert into Players values
	(1, 'Shikhar', 'Dhawan', DATE('1981-12-05'), 'Delhi', 'India'),
	(2, 'Jonathan', 'Trott', DATE('1981-04-22'), 'CapeTown', 'SouthAfrica'),
	(3, 'Kumara', 'Sangakkara', DATE('1977-10-27'), 'Matale', 'Srilanka');

SELECT * FROM Players;

-- Following query saves the changes 
COMMIT;

-- Now, let us add more records using the INSERT statements 
insert into Players values
	(4, 'Virat', 'Kohli', DATE('1988-11-05'), 'Delhi', 'India'),
	(5, 'Rohit', 'Sharma', DATE('1987-04-30'), 'Nagpur', 'India'),
	(6, 'Ravindra', 'Jadeja', DATE('1988-12-06'), 'Nagpur', 'India'),
	(7, 'James', 'Anderson', DATE('1982-06-30'), 'Burnley', 'England');

SELECT * FROM Players;

-- Following statement reverts the changes after the last commit.
ROLLBACK;

SELECT * FROM Players;
-- All the changes done past the last commit will be reverted if we rollback a transaction. 
-- Since we have inserted the last 4 records after commit, they will be reverted at the time of roll back.
