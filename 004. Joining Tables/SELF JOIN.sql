USE classicmodels;
SHOW TABLES;

/* there is a special case that you need to join a table to itself, 
which is known as a self join.
The self join is often used to query hierarchical data,
or to compare a row with other rows within the same table. */

SELECT * FROM employees;

-- self join using INNER JOIN clause
SELECT 
    CONCAT(m.firstName, ', ', m.lastName) AS Manager,
    CONCAT(e.firstName, ', ', e.lastName) AS 'Direct report'
FROM
    employees e
INNER JOIN 
	employees m 
    ON m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;
-- The output only shows the employees who have a manager. However, 
-- you don’t see the President because his name is filtered out due to the INNER JOIN clause.

/* self join using LEFT JOIN clause */
-- The President is the employee who does not have any manager 
-- or value in the reportsTo column is NULL .
SELECT 
    IFNULL(CONCAT(m.firstname, ', ', m.lastname),
            'Top Manager') AS 'Manager',
    CONCAT(e.firstname, ', ', e.lastname) AS 'Direct report'
FROM
    employees e
LEFT JOIN employees m ON 
    m.employeeNumber = e.reportsto
ORDER BY 
    manager DESC;
    
-- self join to compare successive rows
/* By using the MySQL self join, you can display a list of customers,
who locate in the same city by joining the customers table to itself. */
SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN 
	customers c2 ON c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;
