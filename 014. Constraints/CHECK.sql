/* CHECK Constraint 
You can specify a CHECK constraint as a table constraint or column constraint.
A table CHECK constraint can reference multiple columns,
while the column CHECK constraint can refer to the only column where it is defined.*/

/* MySQL CHECK constraint – column constraint */

-- This statement creates a new parts table:
CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);
-- In this statement, we have two column CHECK constraints: 
-- one for the cost column and the other for the price column.
-- Because we did not explicitly specify the names for the CHECK constraints, 
-- MySQL automatically generated names for them.

-- To view the table definition with the CHECK constraint name, you use the SHOW CREATE TABLE statement:
SHOW CREATE TABLE parts;
-- As you can see clearly from the output, 
-- MySQL generated the check constraint parts_chk_1 and parts_chk_2.

-- This statement inserts a new row into the parts table:
INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',0,-100);

-- MySQL issued an error:
SHOW ERRORS;
-- Because the value of the price column is negative,
-- which causes the expression price > 0 evaluates to FALSE that results in a constraint violation.

/* MySQL CHECK constraint – table constraint */
-- First, drop the parts table:
DROP TABLE IF EXISTS parts;

-- Then, create a new parts table with one more table CHECK constraint:
CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);
-- The following new clause defines a table CHECK constraint,
-- that ensures the price is always greater than or equal to cost:
		-- CONSTRAINT parts_chk_price_gt_cost CHECK(price >= cost)
		-- Code language: SQL (Structured Query Language) (sql)
-- Because we explicitly specify the name for the CHECK constraint,
-- MySQL just creates the new constraint with the specified name.

-- Here is the definition of the parts table:
SHOW CREATE TABLE parts;

-- This statement attempts to insert a new part whose price is less than cost:
INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',200,100);

-- Here is the error due to the constraint violation:
SHOW ERRORS;




