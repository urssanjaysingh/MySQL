USE classicmodels;
SHOW TABLES;

/* UNIQUE Index To Prevent Duplicates */
-- Suppose, you want to manage contacts in an application. 
-- You also want that email of every contact in the contacts table must be unique.
-- To enforce this rule, you create a unique constraint in the CREATE TABLE statement as follows:

DROP TABLE contacts;

CREATE TABLE IF NOT EXISTS contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    UNIQUE KEY unique_email (email)
);

-- If you use the SHOW INDEXES statement, you will see that MySQL created a UNIQUE index for email column.
SHOW INDEXES FROM contacts;

-- Let’s insert a row into the contacts table.
INSERT INTO contacts(first_name,last_name,phone,email)
VALUES('John','Doe','(408)-999-9765','john.doe@mysqltutorial.org');

-- Now if you try to insert a row whose email is john.doe@mysqltutorial.org, 
-- you will get an error message.
INSERT INTO contacts(first_name,last_name,phone,email)
VALUES('Johny','Doe','(408)-999-4321','john.doe@mysqltutorial.org');

SHOW ERRORS;

-- Suppose you want the combination of first_name, last_name, and  phone is also unique among contacts.
-- In this case, you use the CREATE INDEX statement to create a UNIQUE index for those columns as follows:
CREATE UNIQUE INDEX idx_name_phone
ON contacts(first_name,last_name,phone);

-- Adding the following row into the contacts table causes an error,
-- because the combination of the first_name, last_name, and phone already exists.
INSERT INTO contacts(first_name,last_name,phone,email)
VALUES('john','doe','(408)-999-9765','john.d@mysqltutorial.org');

SHOW ERRORS;
