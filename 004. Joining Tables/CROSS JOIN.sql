USE classicmodels;
SHOW TABLES;

/* the CROSS JOIN clause returns a Cartesian product of rows from the joined tables.
In general, if each table has n and m rows respectively, the result set will have nxm rows. */

CREATE DATABASE IF NOT EXISTS salesdb;

USE salesdb;

CREATE TABLE products (
	id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(13, 2)
);

INSERT INTO products(product_name, price)
VALUES('iPhone', 699),
      ('iPad',599),
      ('Macbook Pro',1299);
      
SELECT * FROM products;

CREATE TABLE stores (
	id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100)
);

INSERT INTO stores(store_name)
VALUES('North'),
      ('South');
      
SELECT * FROM stores;

CREATE TABLE sales (
	product_id INT,
    store_id INT,
    quantity DECIMAL(13, 2) NOT NULL,
    sales_date DATE NOT NULL,
    PRIMARY KEY (product_id, store_id),
    FOREIGN KEY (product_id)
		REFERENCES products(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id)
		REFERENCES stores(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO sales(store_id,product_id,quantity,sales_date)
VALUES(1,1,20,'2017-01-02'),
      (1,2,15,'2017-01-05'),
      (1,3,25,'2017-01-05'),
      (2,1,30,'2017-01-02'),
      (2,2,35,'2017-01-05');

SELECT * FROM sales;

/* This statement returns total sales for each store and product, 
you calculate the sales and group them by store and product as follows: */
SELECT 
    store_name,
    product_name,
    SUM(quantity * price) AS revenue
FROM
    sales
        INNER JOIN
    products ON products.id = sales.product_id
        INNER JOIN
    stores ON stores.id = sales.store_id
GROUP BY store_name , product_name; 

/* if you want to know also which store had no sales of a specific product.
if you want to know also which store had no sales of a specific product. 
To solve the problem, you need to use the CROSS JOIN clause. */
SELECT 
    store_name, product_name
FROM
    stores AS a
        CROSS JOIN
    products AS b;
    
/* Next, join the result of the query above with a query that returns the total of sales 
by store and product. */
SELECT 
    b.store_name,
    a.product_name,
    IFNULL(c.revenue, 0) AS revenue
FROM
    products AS a
        CROSS JOIN
    stores AS b
        LEFT JOIN
    (SELECT 
        stores.id AS store_id,
        products.id AS product_id,
        store_name,
            product_name,
            ROUND(SUM(quantity * price), 0) AS revenue
    FROM
        sales
    INNER JOIN products ON products.id = sales.product_id
    INNER JOIN stores ON stores.id = sales.store_id
    GROUP BY stores.id, products.id, store_name , product_name) AS c ON c.store_id = b.id
        AND c.product_id= a.id
ORDER BY b.store_name;
