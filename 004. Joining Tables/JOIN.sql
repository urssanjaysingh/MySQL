USE classicmodels;
SHOW TABLES;

/* A relational database consists of multiple related tables linking together using common columns, 
which are known as foreign key columns. */

-- creating two tables called members and committees
CREATE TABLE members (
	member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY(member_id)
);

CREATE TABLE committees (
	committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY(committee_id)
);

-- inserting some rows into tables
INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');

SELECT * FROM members;

SELECT * FROM committees;

/* -- INNER JOIN -- */
-- The inner join clause joins two tables based on a condition which is known as a join predicate.

/* If the join condition uses the equality operator (=) 
and the column names in both tables used for matching are the same, 
ayou can use the USING clause instead */

SELECT 
	m.member_id,
    m.name AS member,
    c.committee_id,
    c.name AS committee
FROM
	members AS m
INNER JOIN 
	committees c 
ON
	c.name = m.name;
    
-- Because both tables use the same column to match, you can use the USING clause
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN 
	committees c
USING(name);

/* -- LEFT JOIN -- */
/* the left join selects all data from the left table whether there are matching rows exist in the right table or not.
In case there are no matching rows from the right table found, 
the left join uses NULLs for columns of the row from the right table in the result set. */
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN 
	committees c 
USING(name);

-- To find members who are not the committee members, 
-- you add a WHERE clause and IS NULL operator as follows:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN 
	committees c 
USING(name)
WHERE 
	c.committee_id IS NULL;
    
/* -- RIGHT JOIN -- */
/* The right join clause selects all rows from the right table and matches rows in the left table. 
If a row from the right table does not have matching rows from the left table, 
the column of the left table will have NULL in the final result set. */
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN 
	committees c 
USING(name);

-- To find the committee members who are not in the members table, you use this query:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN 
	committees c 
USING(name)
WHERE 
	m.member_id IS NULL;
    
/* -- CROSS JOIN -- */
/* The cross join makes a Cartesian product of rows from the joined tables. 
The cross join combines each row from the first table, 
with every row from the right table to make the result set.
Suppose the first table has n rows and the second table has m rows. 
The cross join that joins the tables will return nxm rows. */
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
CROSS JOIN 
	committees c;