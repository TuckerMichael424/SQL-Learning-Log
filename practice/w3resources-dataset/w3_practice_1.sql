
-- 1. Calculate total purchase amount of all orders

SELECT SUM(o.purch_amt) AS total_order_amount
FROM dbo.w3r_orders AS o;

-- 2. Find the total purchase amount of all orders placed by each customer. Show customer ID and total amount. 

SELECT SUM(o.purch_amt) AS total_order_amount,
    o.customer_id
FROM dbo.w3r_orders AS o
GROUP BY o.customer_id;

-- 3. Find the highest purchase amount ordered by each customer. Show customer ID and their max amount. 

SELECT MAX(o.purch_amt) AS max_amount,
    o.customer_id
FROM dbo.w3r_orders AS o
GROUP BY o.customer_id;

-- 4. Find the highest purchase amount by date. Show the date and the max amount. 

SELECT MAX(o.purch_amt) AS max_purch_amt,
    o.ord_date
FROM dbo.w3r_orders AS o
GROUP BY o.ord_date;

-- 5. Find the highest purchase amout ordered by each customer on each date. Sow customer id, date, and max. 

SELECT o.customer_id,
    o.ord_date,
    MAX(o.purch_amt) AS max_purch_amt
FROM dbo.w3r_orders AS o
GROUP BY o.customer_id, o.ord_date
ORDER BY o.customer_id;

-- 6. Find the average purchase amount of all orders. 

SELECT AVG(o.purch_amt) AS avg_purch_amt
FROM dbo.w3r_orders AS o;

-- 7. Count how many customers placed at least one order. 

SELECT COUNT(o.ord_no) AS ord_count,
    o.customer_id
FROM dbo.w3r_orders AS o
GROUP BY o.customer_id
HAVING o.ord_no > 1;

-- 8. Find the number of salesmen currently working in each city. Show city and count of salesmen. 

SELECT s.city,
    COUNT(s.salesman_id) AS num_salesmen
FROM dbo.w3r_salesman AS s
GROUP BY s.city;

-- 9. Find the average price of items in each manufacturer/company group. Show company code and avg price, rounded to 2 decimal places. 

SELECT i.PRO_COM,
    CAST(ROUND(AVG(i.PRO_PRICE), 2) AS DECIMAL (10,2)) AS avg_manf_price
FROM dbo.w3r_item_mast AS i
GROUP BY i.PRO_COM;

-- 10. Find the total allotment budget given to each department. Show dept name and total allotment. 

SELECT d.DPT_NAME,
    CAST(ROUND(SUM(d.DPT_ALLOTMENT), 2) AS DECIMAL (10,2)) AS ttl_dpt_allt
FROM dbo.w3r_emp_department AS d
GROUP BY d.DPT_NAME;