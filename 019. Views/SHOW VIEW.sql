USE classicmodels;
SHOW TABLES;

/* MySQL Show View – using SHOW FULL TABLES statement
MySQL treats the views as tables with the type 'VIEW'. 
Therefore, to show all views in the current database, you use the SHOW FULL TABLES statement as follows: */

SHOW FULL TABLES 
WHERE table_type = 'VIEW';

-- If you want to show all views from another database, you can use the FROM or IN clause as follows:
-- For example, the following statement shows all views from the sys database:
SHOW FULL TABLES IN sys 
WHERE table_type='VIEW';

-- The following statement uses the LIKE clause to find all views from the sys database, whose names start with the waits:
SHOW FULL TABLES 
FROM sys
LIKE 'waits%';
