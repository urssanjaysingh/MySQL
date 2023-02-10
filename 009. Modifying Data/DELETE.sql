USE classicmodels;
SHOW TABLES;

CREATE TABLE MANAGERS (
  MANAGER_ID varchar(45) NOT NULL,
  FIRST_NAME varchar(45) NOT NULL,
  LAST_NAME varchar(45) NOT NULL,
  PRIMARY KEY (MANAGER_ID)
);

INSERT INTO MANAGERS(MANAGER_ID,FIRST_NAME, LAST_NAME)
VALUES
(08276,'Brad','Craven'),
(19222,'Kraig','Boucher'),
(23003,'Enrique','Sizemore'),
(80460,'Letha','Wahl'),
(86849,'Harlan','Ludwig');

SELECT * FROM MANAGERS;

/* To delete data from a table, you use the MySQL DELETE statement. */
DELETE FROM MANAGERS
WHERE MANAGER_ID = 8276;

SELECT * FROM MANAGERS;

/* DELETE and LIMIT clause */
-- If you want to limit the number of rows to delete, use the LIMIT clause as follows:
DELETE FROM MANAGERS
LIMIT 2;

SELECT * FROM MANAGERS;

-- To delete all rows from the employees table, you use the DELETE statement without the WHERE clause as follows:
DELETE FROM MANAGERS;

SELECT * FROM MANAGERS;
