USE classicmodels;
SHOW TABLES;

/* INTERSECT operator 
The INTERSECT operator is a set operator that returns only distinct rows of two queries or more queries.
The INTERSECT operator compares the result sets of two queries and returns the distinct rows that are output by both queries.
 Unfortunately, MySQL does not support the INTERSECT operator. However, you can emulate the INTERSECT operator. */

SELECT id FROM t1;
SELECT id FROM t2;

-- Emulate INTERSECT using DISTINCT and INNER JOIN clause
SELECT DISTINCT 
   id 
FROM t1
   INNER JOIN t2 USING(id);
   
-- Emulate INTERSECT using IN and subquery
SELECT DISTINCT id
FROM t1
WHERE id IN (SELECT id FROM t2);