
/* DEFAULT constraint'
MySQL DEFAULT constraint allows you to specify a default value for a column. */

CREATE TABLE cart_items 
(
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DEC(5,2) NOT NULL,
    sales_tax DEC(5,2) NOT NULL DEFAULT 0.1,
    CHECK(quantity > 0),
    CHECK(sales_tax >= 0) 
);
-- The sales_tax column has a default value 0.1 (10%). 

-- The following statement shows the cart_items table:
DESC cart_items;

-- The following INSERT statement adds a new item to the cart_items table:
INSERT INTO cart_items(name, quantity, price)
VALUES('Keyboard', 1, 50);
-- In this example, the INSERT statement doesn’t provide a value for the sales_tax column.
-- The sales_tax column useS the default value specified in the DEFAULT constraint:

SELECT * FROM cart_items;

-- Also, you can explicitly use the DEFAULT keyword when you insert a new row into the cart_items table:
INSERT INTO cart_items(name, quantity, price, sales_tax)
VALUES('Battery',4, 0.25 , DEFAULT);

SELECT * FROM cart_items;

/* Adding a DEFAULT constraint to a column */
DESC cart_items;

-- The following example adds a DEFAULT constraint to the quantity column of the cart_itesm table:
ALTER TABLE cart_items
ALTER COLUMN quantity SET DEFAULT 1;

DESC cart_items;

-- The following statement inserts a new row into the cart_items table without specifying a value for the quantity column:
INSERT INTO cart_items(name, price, sales_tax)
VALUES('Maintenance services',25.99, 0);

-- The value of the quantity column will default to 1:
SELECT * FROM cart_items;

/* Removing a DEFAULT constraint from a column */
-- The following example removes the DEFAULT constraint from the quantity column of the cart_items table:
ALTER TABLE cart_items
ALTER COLUMN quantity DROP DEFAULT;

-- And here’s the new cart_items structure:
DESC cart_items;
