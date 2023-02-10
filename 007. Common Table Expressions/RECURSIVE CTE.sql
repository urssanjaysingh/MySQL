USE classicmodels;
SHOW TABLES;

/* A recursive common table expression (CTE) is a CTE that has a subquery which refers to the CTE name itself. 
The following illustrates the syntax of a recursive CTE:
WITH RECURSIVE cte_name AS (
    initial_query  -- anchor member
    UNION ALL
    recursive_query -- recursive member that references to the CTE name
)
SELECT * FROM cte_name; */

SELECT * FROM employees;

/* The  employees table has the reportsTo column that references to the employeeNumber column. 
The reportsTo column stores the ids of managers. 
The top manager does not report to anyone in the company’s organization structure, therefore, 
the value in the reportsTo column is NULL.
You can apply the recursive CTE to query the whole organization structure in the top-down manner as follows:
*/

-- First, form the anchor member by using the following query:
SELECT 
    employeeNumber, 
    reportsTo AS managerNumber, 
    officeCode
FROM
    employees
WHERE
    reportsTo IS NULL;
-- This query (anchor member) returns the top manager whose reportsTo is NULL.

-- Second, make the recursive member by reference to the CTE name, which is employee_paths in this case:
SELECT 
    e.employeeNumber, 
    e.reportsTo, 
    e.officeCode
FROM
    employees e
INNER JOIN 
	employee_paths ep 
ON 
	ep.employeeNumber = e.reportsTo;
-- This query ( recursive member) returns all direct reports of the manager(s) until there are no more direct reports. 
-- The if the recursive member returns no direct reports, the recursion stops.

-- Third, the query that uses the employee_paths CTE joins the result set returned by the CTE
-- with the offices table to make the final result set.
WITH RECURSIVE employee_paths AS
  ( SELECT employeeNumber,
           reportsTo managerNumber,
           officeCode, 
           1 lvl
   FROM employees
   WHERE reportsTo IS NULL
     UNION ALL
     SELECT e.employeeNumber,
            e.reportsTo,
            e.officeCode,
            lvl+1
     FROM employees e
     INNER JOIN employee_paths ep ON ep.employeeNumber = e.reportsTo )
SELECT employeeNumber,
       managerNumber,
       lvl,
       city
FROM employee_paths ep
INNER JOIN offices o USING (officeCode)
ORDER BY lvl, city;
