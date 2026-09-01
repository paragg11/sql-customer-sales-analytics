-- SQL Customer & Sales Analytics
-- Date Analysis & Window Functions

-- Q31. Monthly Revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Q32. Monthly Order Count
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Q33. Running Revenue
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    SUM(revenue) OVER(ORDER BY month) AS running_revenue
FROM monthly_sales;

-- Q34. Previous Month Revenue (LAG)
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue
FROM monthly_sales;

-- Q35. Month-over-Month Growth %
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),
comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER(ORDER BY month) AS previous_revenue
    FROM monthly_sales
)
SELECT
    month,
    revenue,
    previous_revenue,
    ROUND(
        (revenue - previous_revenue) /
        NULLIF(previous_revenue,0) * 100,
        2
    ) AS growth_percentage
FROM comparison;

-- Q36. Next Month Revenue (LEAD)
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    LEAD(revenue) OVER(ORDER BY month) AS next_month_revenue
FROM monthly_sales;

-- Q37. First Purchase Date of Every Customer
SELECT
    customer_id,
    MIN(order_date) AS first_purchase
FROM orders
GROUP BY customer_id;

-- Q38. Latest Purchase Date of Every Customer
SELECT
    customer_id,
    MAX(order_date) AS latest_purchase
FROM orders
GROUP BY customer_id;

-- Q39. Running Customer Spending
SELECT
    customer_id,
    order_date,
    amount,
    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_customer_spending
FROM orders;

-- Q40. Customer Order Ranking (Newest to Oldest)
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date DESC
    ) AS order_rank
FROM orders;
