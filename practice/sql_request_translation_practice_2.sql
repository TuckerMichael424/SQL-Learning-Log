-- 1. List every product name and the total quantity ever ordered. 
-- Includ products that have never been ordered - show NULL for those. 

SELECT DISTINCT p.product_name,
    SUM(o.quantity)
FROM dbo.sample_data_products AS p
LEFT JOIN dbo.sample_data_orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Claude's input: DISTINCT is redundant bc GROUP BY is doing the work. 
-- Also add an alias for aggregate quantity 

-- Corrected Query: 

SELECT p.product_name,
    SUM(o.quantity) AS total_quantity
FROM dbo.sample_data_products AS p
LEFT JOIN dbo.sample_data_orders AS o
ON p.product_id = o.product_id
GROUP BY p.product_name;

------------------------------------------------------------------------------------

-- 2. List each customer's ID and their total number of orders.
-- Only include customers who have placed at least 1 order.

SELECT c.customer_id,
    COUNT(*) AS total_orders
FROM dbo.sample_data_customers AS c
JOIN dbo.sample_data_orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC;

-- Claude's input: Correct. No changes

------------------------------------------------------------------------------------

-- 3. List every customer ID, city, and their total spending (price x quantity). 
-- Sort by highest spenders descending. 

SELECT c.customer_id,
    c.city,
    CAST(ROUND(SUM(p.price * o.quantity), 2) AS DECIMAL (10,2)) AS total_spending
FROM dbo.sample_data_customers AS c
JOIN dbo.sample_data_orders AS o
    ON c.customer_id = o.customer_id
JOIN dbo.sample_data_products AS p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.city
ORDER BY SUM(p.price * o.quantity) DESC;

-- Very confused about initial error with c.city needing to be in aggregate function - why?
-- I want to list the column, not do calculations/aggregations on it. So why do I need to? 

-- Claude's input: Correct. Regarding question - every select column needs to be in aggregate function
-- or in GROUP BY. No exceptions. 

-- "Here's why that rule exists. Imagine three customers all in Chicago:

customer_id | city    | spending
1           | Chicago | $200
2           | Chicago | $400
3           | Chicago | $150

-- When you GROUP BY customer_id, SQL creates one pile per customer. Each pile has exactly one city value 
-- — so SQL knows what to display. No problem.

-- But if you forgot c.city in GROUP BY and only grouped by customer_id — SQL would still know. 
-- It's *unambiguous* because each customer has one city.

-- The issue is SQL doesn't assume that. It requires you to be explicit. If a column isn't aggregated and isn't in GROUP BY, SQL refuses because it theoretically could have multiple values per group — even if in practice it doesn't.

------------------------------------------------------------------------------------

-- 4. Find all products that have never been ordered. Only show the product name and category. 

SELECT p.product_name,
    p.category
FROM dbo.sample_data_products AS p
JOIN dbo.sample_data_orders AS o
    ON p.product_id = o.product_id
WHERE o.product_id
GROUP BY p.product_id;

-- Struggling with WHERE clause to filter for products that haven't been ordered. Use NULL? But how? 
-- Also - again with the select column needing to be in an aggregate function! 
-- I don't understand why this needs to happen. 

-- Claude's input: Incorrect - 
-- A) Wrong join. Use LEFT JOIN (joining products matching rows from orders onto products table). We're looking for whether the product_id 
-- appears in the orders table. Only need matching columns for that. 

-- B) WHERE o.product_id incomplete. "Only keep rows where there was no matching order" = WHERE o.product_id IS NULL;

-- C) No GROUP BY needed. No math involved, only checking a IS/ISNT condition. 

-- Corrected query: 

SELECT p.product_name,
    p.category
FROM dbo.sample_data_products AS p
LEFT JOIN dbo.sample_data_orders AS o
    ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

-- 5. List 
