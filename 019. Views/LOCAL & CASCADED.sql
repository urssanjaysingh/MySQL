USE classicmodels;
SHOW TABLES;

/* Understanding LOCAL & CASCADED in WITH CHECK OPTION Clause
When you create a view with the WITH CHECK OPTION clause 
and issue a DML statement against the view such as INSERT, UPDATE, and DELETE, 
MySQL checks to ensure that the rows that are being changed are conformable to the definition of the view.

To determine the scope of the check, MySQL provides two options: LOCAL and CASCADED. 
If you don’t specify the keyword explicitly in the WITH CHECK OPTION clause, MySQL uses CASCADED by default. */

/*WITH CASCADED CHECK OPTION */
-- First, create a table named t1 with one column c whose data type is an integer.
DROP TABLE t1;

CREATE TABLE t1 (
    c INT
);

-- Next, create a view v1 based on the t1 table with the data in the c column greater than 10.
CREATE OR REPLACE VIEW v1 
AS
    SELECT 
        c
    FROM
        t1
    WHERE
        c > 10;
        
-- Because we did not specify the WITH CHECK OPTION, 
-- the following statement works even though it does not conform with the definition of the v1 view.
INSERT INTO v1(c) 
VALUES (5);

-- Then, create a view v2 based on the v1 view with WITH CASCADED CHECK OPTION clause.
CREATE OR REPLACE VIEW v2 
AS
    SELECT c FROM v1 
WITH CASCADED CHECK OPTION;

-- Now, insert a row with value 5 into the t1 table through the v2 view.
INSERT INTO v2(c) 
VALUES (5);

-- MySQL issued the following error message:
SHOW ERRORS;
-- It fails the new row that does not conform with the definition of v2 view.

-- After that, create a new view named v3 based on v2.
CREATE OR REPLACE VIEW v3 
AS
    SELECT c
    FROM v2
    WHERE c < 20;
    
-- Insert a new row into the t1 table through the v3 view with value 8.
INSERT INTO v3(c) 
VALUES (8);

-- MySQL issued the following error message:
SHOW ERRORS;
-- The insert statement fails even though the row seems to conform with the definition of the v3 view.
-- Because the view v3 is dependent on the v2 view, 
-- and the v2 view has the option WITH CASCADED CHECK OPTION.

-- However, the following insert statement works.
INSERT INTO v3(c) VALUES (30);
-- Because the v3 view does not have a WITH CHECK OPTION, and the statement conforms with the definition of the v2 view.

/* In conclusion, when a view uses a WITH CASCADED CHECK OPTION, 
MySQL checks the rules of the view and also the rules of the underlying views recursively. */

/* WITH LOCAL CHECK OPTION
Let’s use the same example above for the WITH LOCAL CHECK OPTION to see the differences. */
-- First, change the v2 view to use the WITH LOCAL CHECK OPTION instead.
ALTER VIEW v2 AS
    SELECT 
        c
    FROM
        v1 
WITH LOCAL CHECK OPTION;

-- Second, insert the same row that we did with the example above.
INSERT INTO v2(c) 
VALUES (5);

-- Because v2 view does not have any rules. The view v2 is dependent on the v1 view. 
-- However, v1 view does not specify a check option, 
-- therefore, MySQL skips checking the rules in v1 view.

-- Notice that this statement failed in the v2 view created with a WITH CASCADED CHECK OPTION.

-- Third, insert the same row to the t1 table through the v3 view.
INSERT INTO v3(c) VALUES (8);
-- It succeeds in this case because MySQL did not check the rules of v1 view
-- due to the WITH LOCAL CHECK OPTION of the v2 view.

-- Also, notice that this statement failed in the example that v2 created with a WITH CASCADED CHECK OPTION.

/* So if a view uses a WITH LOCAL CHECK OPTION, 
MySQL checks the rules of views that have a WITH LOCAL CHECK OPTION and a WITH CASCADED CHECK OPTION.
It is different from the view that uses a WITH CASCADED CHECK OPTION 
-- that MySQL checks the rules of all dependent views. */

