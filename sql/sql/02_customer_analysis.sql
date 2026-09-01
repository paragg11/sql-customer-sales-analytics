-- SQL Customer & Sales Analytics
-- Customer Analysis

-- Q11. Find total spending by customer
SELECT
    customer_id,
    SUM(amount) AS total_spending
FROM orders
GROUP BY customer_id
ORDER BY total_spending DESC;


-- Q12. Find the top 10 customers by total spending
SELECT
    customer_id,
    SUM(amount) AS total_spending
FROM orders
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;


-- Q13. Rank customers by total spending
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spending,
    RANK() OVER(
        ORDER BY total_spending DESC
    ) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;


-- Q14. Find the number of orders per customer
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;


-- Q15. Find repeat customers
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;


-- Q16. Find customers with only one order
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1;


-- Q17. Find customers whose spending is above
-- the average customer spending
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spending
FROM customer_sales
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM customer_sales
)
ORDER BY total_spending DESC;


-- Q18. Find average order value for each customer
SELECT
    customer_id,
    AVG(amount) AS average_order_value
FROM orders
GROUP BY customer_id
ORDER BY average_order_value DESC;


-- Q19. Find the first purchase date for each customer
SELECT
    customer_id,
    MIN(order_date) AS first_purchase_date
FROM orders
GROUP BY customer_id
ORDER BY first_purchase_date;


-- Q20. Find the latest purchase date for each customer
SELECT
    customer_id,
    MAX(order_date) AS latest_purchase_date
FROM orders
GROUP BY customer_id
ORDER BY latest_purchase_date DESC;


-- Q21. Find customers who have never placed an order
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;


-- Q22. Calculate customer lifetime spending
SELECT
    customer_id,
    SUM(amount) AS lifetime_spending
FROM orders
GROUP BY customer_id
ORDER BY lifetime_spending DESC;


-- Q23. Find customers with more than 5 orders
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;


-- Q24. Find the highest order amount for each customer
SELECT
    customer_id,
    MAX(amount) AS highest_order_amount
FROM orders
GROUP BY customer_id
ORDER BY highest_order_amount DESC;


-- Q25. Find the lowest order amount for each customer
SELECT
    customer_id,
    MIN(amount) AS lowest_order_amount
FROM orders
GROUP BY customer_id
ORDER BY lowest_order_amount;
