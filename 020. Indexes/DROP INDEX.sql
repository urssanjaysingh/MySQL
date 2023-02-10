USE classicmodels;
SHOW TABLES;

/* DROP INDEX

	DROP INDEX index_name ON table_name
	[algorithm_option | lock_option];

The algorithm_option allows you to specify a specific algorithm used for the index removal. 
The following shows the syntax of the algorithm_option clause:

	ALGORITHM [=] {DEFAULT|INPLACE|COPY}
    
For the index removal, the following algorithms are supported:

COPY: The table is copied to the new table row by row, 
the DROP INDEX is then performed on the copy of the original table.

INPLACE: The table is rebuilt in place instead of copied to the new one. 

The lock_option controls the level of concurrent reads and writes on the table while the index is being removed.
The following shows the syntax of the lock_option:

	LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}
    
The following locking modes are supported:
DEFAULT: this allows you to have the maximum level of concurrency for a given algorithm. 
			First, it allows concurrent reads and writes if supported. 
			If not, allow concurrent reads if supported. If not, enforce exclusive access.
NONE: if the NONE is supported, you can have concurrent reads and writes. 
		Otherwise, MySQL issues an error.
SHARED: if the SHARED is supported, you can have concurrent reads, but not writes. 
		MySQL issues an error if the concurrent reads are not supported.
EXCLUSIVE: this enforces exclusive access.
 */

-- Let’s create a new table for the demonstration:
CREATE TABLE leads(
    lead_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    information_source VARCHAR(255),
    INDEX name(first_name,last_name),
    UNIQUE email(email),
    PRIMARY KEY(lead_id)
);

-- The following statement removes the name index from the leads table:
DROP INDEX name ON leads;

-- The following statement drops the email index from the leads table with a specific algorithm and lock:
DROP INDEX email ON leads
ALGORITHM = INPLACE 
LOCK = DEFAULT;

/* DROP PRIMARY KEY index */
-- The following statement creates a new table named twith a primary key:
CREATE TABLE t(
    pk INT PRIMARY KEY,
    c VARCHAR(10)
);

-- To drop the primary key index, you use the following statement:
DROP INDEX `PRIMARY` ON t;
