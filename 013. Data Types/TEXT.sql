USE classicmodels;

/* TEXT Data Type
Besides CHAR and VARCHAR character types, MySQL provides us with TEXT type that has more features which CHAR and VARCHAR cannot cover.
The TEXT is useful for storing long-form text strings that can take from 1 byte to 4 GB. 
We often find the TEXT data type for storing article body in news sites, product description in e-commerce sites.
Different from CHAR and VARCHAR, you don’t have to specify a storage length when you use a TEXT type for a column. 
Also, MySQL does not remove or pad spaces when retrieve or insert text data like CHAR and VARCHAR. */

/* TINYTEXT – 255 Bytes (255 characters) */

CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    summary TINYTEXT
);
-- In this example, we created a new table named articles that has a summary column with the data type is TINYTEXT.

DESCRIBE articles;

/* TEXT – 64KB (65,535 characters) */
-- The TEXT data type can hold up to 64 KB that is equivalent to 65535 (2^16 – 1) characters.
-- TEXT also requires 2 bytes overhead.
-- The TEXT can hold the body of an article. Consider the following example:
ALTER TABLE articles 
ADD COLUMN body TEXT NOT NULL
AFTER summary;
-- In this example, we added the body column with TEXT datatype to the articles table using the ALTER TABLE statement.

DESCRIBE articles;

/* MEDIUMTEXT – 16MB (16,777,215 characters) 
It requires 3 bytes overhead. */
-- The MEDIUMTEXT is useful for storing quite large text data like the text of a book, white papers, etc. For example:
CREATE TABLE whitepapers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    body MEDIUMTEXT NOT NULL,
    published_on DATE NOT NULL
); 

/* LONGTEXT – 4GB (4,294,967,295 characters)
The LONGTEXT can store text data up to 4 GB, which is a lot. It requires 4 bytes overhead. */
