/* The  LOAD DATA INFILE statement allows you to read data from a text file
and import the file’s data into a database table very fast.
Before importing the file, you need to prepare the following:
    A database table to which the data from the file will be imported.
    A CSV file with data that matches with the number of columns of the table and the type of data in each column.
    The account, which connects to the MySQL database server, has FILE and INSERT privileges. */

-- We use CREATE TABLE statement to create the discounts table as follows:
CREATE TABLE discounts (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    expired_date DATE NOT NULL,
    amount DECIMAL(10 , 2 ) NULL,
    PRIMARY KEY (id)
);

-- The following statement imports data from the  discounts.csv file into the discounts table.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/discounts.csv' 
INTO TABLE discounts 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- The field of the file is terminated by a comma indicated by  FIELD TERMINATED BY ',' 
-- and enclosed by double quotation marks specified by ENCLOSED BY '" ‘.
-- Each line of the CSV file is terminated by a newline character indicated by LINES TERMINATED BY '\n' .
-- Because the file has the first line that contains the column headings, 
-- which should not be imported into the table, 
-- therefore we ignore it by specifying  IGNORE 1 ROWS option.

SHOW ERRORS;
-- move your csv file to the path specified by following statement if secure_file_priv error occurs
SHOW VARIABLES LIKE "secure_file_priv";

-- Now, we can check the discounts table to see whether the data is imported.
SELECT * FROM discounts;

/* Transforming data while importing
Sometimes the format of the data does not match the target columns in the table. 
In simple cases, you can transform it by using the SET clause in the  LOAD DATA INFILE statement. */

-- Suppose the expired date column in the  discount_2.csv file is in  mm/dd/yyyy format.
-- When importing data into the discounts table,
-- we have to transform it into MySQL date format by using str_to_date() function as follows:
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/discounts_2.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(title,@expired_date,amount)
SET expired_date = STR_TO_DATE(@expired_date, '%m/%d/%Y');
