-- To create a new database in MySQL, you use the CREATE DATABASE statement

-- display the current databases available on the server using the SHOW DATABASES statement. This step is optional.
SHOW DATABASES;

-- Then, issue the CREATE DATABASE command with a database name e.g., testdb and press Enter:
CREATE DATABASE testdb;

-- After that, use the SHOW CREATE DATABASE command to review the created database:
SHOW CREATE DATABASE testdb;

-- Finally, select the newly created database to work with by using the USE statement:
USE testdb;
