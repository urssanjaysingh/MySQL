USE classicmodels;
SHOW TABLES;

/* SHOW INDEXES command */
-- We will create a new table named contacts to demonstrate the SHOW INDEXES command:
DROP TABLE contacts;

CREATE TABLE contacts(
    contact_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    PRIMARY KEY(contact_id),
    UNIQUE(email),
    INDEX phone(phone) INVISIBLE,
    INDEX name(first_name, last_name) comment 'By first name and/or last name'
);

-- The following command returns all index information from the contacts table:
SHOW INDEXES FROM contacts;

-- To get the invisible indexes of the contacts table, you add a WHERE clause as follows:
SHOW INDEXES FROM contacts
WHERE visible = 'NO';
