USE classicmodels;
SHOW TABLES;

/* SQL MINUS operator 
Unfortunately, MySQL does not support MINUS operator. However, you can use join to emulate it. */
CREATE TABLE t1 (
    id INT PRIMARY KEY
);

CREATE TABLE t2 (
    id INT PRIMARY KEY
);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4);

SELECT * FROM t1;
SELECT * FROM t2;

SELECT 
    id
FROM
    t1
LEFT JOIN
    t2 USING (id)
WHERE
    t2.id IS NULL;

