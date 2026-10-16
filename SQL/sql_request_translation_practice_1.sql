
-- Practice work to build the SQL request translation skills. 

-- I'll be using a sample dataset of customers, products, and orders from a fictional grocery store - https://www.kaggle.com/datasets/nudratabbas/sql-practice-dataset-1-easy-queries?select=products+%281%29.csv

-- Data check following uploading into SQL Server Management Studio.

SELECT TOP 10*
FROM dbo.[sample_data_customers];

SELECT TOP 10 *
FROM master.dbo.[sample_data_orders]

SELECT TOP 10 *
FROM [sample_data_products];

-- 1. Single Table SELECT queries:  

-- 1.1 list every customers customer_id, city, and signup_date.
SELECT customer_id, 
    city, 
    signup_date
FROM dbo.[sample_data_customers];

-- 1.2 Find all orders placed after March 1st, 2024. 

SELECT *
FROM master.dbo.[sample_data_orders]
WHERE order_date > '2024-03-01';

-- 2. Aggregation (GROUP BY) queries: list each customer's total orders (customer_id and count of orders).

-- 2.1 Get each customer's total number of orders. 

SELECT customer_id, 
    COUNT(*) AS total_orders
FROM master.dbo.[sample_data_orders]
GROUP BY customer_id;

-- 2.2 Find the total revenue per customer sorted from highest to lowest. 

SELECT orders.customer_id,
    CAST(ROUND(SUM(products.price * orders.quantity), 2)AS DECIMAL (10, 2)) AS total_revenue
FROM dbo.[sample_data_orders] AS orders
RIGHT JOIN dbo.[sample_data_products] AS products
ON orders.product_id = products.product_id
GROUP BY orders.customer_id
ORDER BY total_revenue DESC;

-- Had Claude assess my work. 2.2 above I incorrectly used Right Join
-- which combined orders ONTO products (needed all the products shown regardless)
-- of when they'd been ordered. Corrected query below. 

SELECT orders.customer_id,
    CAST(ROUND(SUM(products.price * orders.quantity), 2)AS DECIMAL (10, 2)) AS total_revenue
FROM dbo.[sample_data_products] AS products
LEFT JOIN dbo.[sample_data_orders] AS orders
ON products.product_id = orders.product_id 
WHERE orders.customer_id IS NOT NULL
GROUP BY orders.customer_id
ORDER BY total_revenue DESC;

-- On the above query, follow up with question regarding CAST and the (10, 2) in the DECIMAL data type. 
--Why 10? That's the length? And we don't need to declare the datatype? 

-- 3. FILTERING & JOINS:

-- 3.1 List customers who have never placed an order. 

SELECT *
FROM dbo.[sample_data_customers] AS customers
LEFT JOIN dbo.[sample_data_orders] AS orders
ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL;

-- 3.2 Find the average order value (total) per city. 

SELECT customers.city,
    CAST(ROUND(AVG(products.price * orders.quantity), 2) AS DECIMAL(10, 2)) AS average_order_value
FROM dbo.[sample_data_customers] AS customers
JOIN dbo.[sample_data_orders] AS orders
ON customers.customer_id = orders.customer_id
JOIN dbo.[sample_data_products] AS products
ON orders.product_id = products.product_id
GROUP BY customers.city;

-- 4. Product Level Analysis: 

-- 4.1 List the top 5 products by total quantity sold. 

SELECT p.product_name,
    SUM(o.quantity) AS total_order_quantity
FROM dbo.[sample_data_products] as p
JOIN dbo.[sample_data_orders] AS o
ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_order_quantity DESC;

-- 4.2 Find Customers who signed up in 2023 but have zero orders in 2024. 

SELECT c.customer_id,
    SUM(o.quantity) AS number_of_orders
FROM dbo.[sample_data_customers] AS c
LEFT JOIN dbo.[sample_data_orders] AS o
    ON c.customer_id = o.customer_id
    AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
WHERE c.signup_date BETWEEN '2023-01-01' AND '2023-12-31'
AND o.quantity IS NULL
GROUP BY c.customer_id;

-- 5. Single Table + Sorting: List all customers, sorted by signup date (ASC)

SELECT *
FROM dbo.[sample_data_customers]
ORDER BY signup_date ASC;

-- 6. Aggregation with DISTINCT: How many distinct cities do your customers come from? 

SELECT DISTINCT city    
FROM dbo.[sample_data_customers];

-- 7. Aggregation with Filtering (HAVING): Find product categories that have total sales (SUM(total)) greater than $5,000.

SELECT p.category,
    CAST(ROUND(SUM(p.price * o.quantity), 2) AS DECIMAL (10,2)) AS total_sales
FROM dbo.[sample_data_products] AS p
LEFT JOIN dbo.[sample_data_orders] AS o
ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(p.price * o.quantity) > 5000;

-- 8. Date Math: Find the average time (in days) between a customer's isgnup date and their first order. 

SELECT AVG(DATEDIFF(day,c.signup_date, o.order_date)) AS avg_days_between_order_signup
FROM dbo.[sample_data_customers] AS c
JOIN dbo.[sample_data_orders] AS o
ON c.customer_id = o.customer_id;

-- 9 Complex Condition: LIst customers who have placed at least 2 orders and spent more than $500 in total. 

SELECT c.customer_id,
    COUNT(*) AS number_of_orders,
    CAST(ROUND(SUM(p.price * o.quantity), 5) AS DECIMAL (10,2)) AS order_total
FROM dbo.[sample_data_customers] AS c
JOIN dbo.[sample_data_orders] AS o
    ON c.customer_id = o.customer_id
JOIN dbo.[sample_data_products] AS p
ON o.product_id = p.product_id
GROUP BY 
    c.customer_id
HAVING SUM(p.price * o.quantity) >= 500
AND COUNT(*) >= 2;

-- 10. Self Referential: Find customers who live in the same city as another customer. 

SELECT c1.city,
    c1.customer_id,
    c2.customer_id
FROM dbo.[sample_data_customers] AS c1
JOIN dbo.[sample_data_customers] AS c2
ON c1.city = c2.city
WHERE c1.city = c2.city
    AND c1.customer_id != c2.customer_id
GROUP BY c1.city, c1.customer_id, c2.customer_id;


-- 11. Window Function Preview: 

-- 12. NULL Handling: 
