USE classicmodels;

/* JSON Data Type
JSON column cannot have a default value. In addition, a JSON column cannot be indexed directly. 
Instead, you can create an index on a generated column that contains values extracted from the JSON column. */

-- Suppose, we have to track the visitors and their actions on our website.
-- Some visitors may just view the pages and other may view the pages and buy the products.

-- To store this information, we will create a new table called events.

CREATE TABLE events( 
  id int auto_increment primary key, 
  event_name varchar(255), 
  visitor varchar(255), 
  properties json, 
  browser json
);

DESCRIBE events;

-- Each event in the events table has an id that uniquely identifies the event.
-- An event also has a name e.g., pageview, purchase, etc., The visitor column is used to store the visitor information.
-- The properties and browser columns are the JSON columns. 
-- They are used to store properties of an event and specification of the browser that visitors use to browse the website.

-- Let’s insert some data into the events table:
INSERT INTO events(event_name, visitor,properties, browser) 
VALUES (
  'pageview', 
   '1',
   '{ "page": "/" }',
   '{ "name": "Safari", "os": "Mac", "resolution": { "x": 1920, "y": 1080 } }'
),
('pageview', 
  '2',
  '{ "page": "/contact" }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 2560, "y": 1600 } }'
),
(
  'pageview', 
  '1',
  '{ "page": "/products" }',
  '{ "name": "Safari", "os": "Mac", "resolution": { "x": 1920, "y": 1080 } }'
),
(
  'purchase', 
   '3',
  '{ "amount": 200 }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1600, "y": 900 } }'
),
(
  'purchase', 
   '4',
  '{ "amount": 150 }',
  '{ "name": "Firefox", "os": "Windows", "resolution": { "x": 1280, "y": 800 } }'
),
(
  'purchase', 
  '4',
  '{ "amount": 500 }',
  '{ "name": "Chrome", "os": "Windows", "resolution": { "x": 1680, "y": 1050 } }'
);

-- To pull values out of the JSON columns, you use the column path operator ( ->).
SELECT 
	id, browser->'$.name' browser
FROM 
	events;
-- Notice that data in the browser column is surrounded by quote marks.

-- To remove the quote marks, you use the inline path operator (->>) as follows:
SELECT 
	id, browser->>'$.name' browser
FROM 
	events;

-- To get the browser usage, you can use the following statement:
SELECT 
	browser->>'$.name' browser, count(browser)
FROM 
	events
GROUP BY 
	browser->>'$.name';
    
-- To calculate the total revenue by the visitor, you use the following query:
SELECT
	visitor, SUM(properties->>'$.amount') AS revenue
FROM 
	events
WHERE 
	properties->>'$.amount' > 0
GROUP BY 
	visitor;
