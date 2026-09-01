-- SQL Customer & Sales Analytics
-- Basic Sales Analysis

-- Q1. Find total revenue
SELECT SUM(amount) AS total_revenue
FROM orders;

-- Q2. Find total number of orders
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Q3. Find average order value
SELECT AVG(amount) AS average_order_value
FROM orders;

-- Q4. Find highest order amount
SELECT MAX(amount) AS highest_order
FROM orders;

-- Q5. Find lowest order amount
SELECT MIN(amount) AS lowest_order
FROM orders;

-- Q6. Find total revenue by region
SELECT
    region,
    SUM(amount) AS revenue
FROM orders
GROUP BY region
ORDER BY revenue DESC;

-- Q7. Find total orders by region
SELECT
    region,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY region
ORDER BY total_orders DESC;

-- Q8. Find revenue by category
SELECT
    category,
    SUM(amount) AS revenue
FROM orders
GROUP BY category
ORDER BY revenue DESC;

-- Q9. Find average order value by category
SELECT
    category,
    AVG(amount) AS average_order_value
FROM orders
GROUP BY category;

-- Q10. Find top 10 orders by amount
SELECT *
FROM orders
ORDER BY amount DESC
LIMIT 10;
