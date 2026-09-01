-- SQL Customer & Sales Analytics
-- Advanced Window Functions


-- Q41. Assign a unique row number to every order
SELECT
    order_id,
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER(
        ORDER BY amount DESC
    ) AS row_number
FROM orders;


-- Q42. Rank customers by total spending
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
FROM customer_sales;


-- Q43. Dense rank customers by total spending
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
    DENSE_RANK() OVER(
        ORDER BY total_spending DESC
    ) AS customer_rank
FROM customer_sales;


-- Q44. Rank products within each category
WITH product_sales AS (
    SELECT
        category,
        product_id,
        product_name,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY
        category,
        product_id,
        product_name
)
SELECT
    category,
    product_id,
    product_name,
    revenue,
    RANK() OVER(
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS product_rank
FROM product_sales;


-- Q45. Find top 3 products in each category
WITH product_sales AS (
    SELECT
        category,
        product_id,
        product_name,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY
        category,
        product_id,
        product_name
),
ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER(
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE product_rank <= 3;


-- Q46. Find each customer's previous order amount
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    LAG(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders;


-- Q47. Find each customer's next order amount
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    LEAD(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount
FROM orders;


-- Q48. Calculate running revenue
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
    SUM(revenue) OVER(
        ORDER BY month
    ) AS running_revenue
FROM monthly_sales;


-- Q49. Calculate running spending for each customer
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    SUM(amount) OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS running_customer_spending
FROM orders;


-- Q50. Calculate average order amount for each customer
SELECT
    customer_id,
    order_id,
    amount,
    AVG(amount) OVER(
        PARTITION BY customer_id
    ) AS customer_average_order
FROM orders;


-- Q51. Compare each order with the customer's previous order
WITH customer_orders AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        amount,
        LAG(amount) OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_amount
    FROM orders
)
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    previous_amount,
    amount - previous_amount AS amount_difference
FROM customer_orders;


-- Q52. Find customers whose latest order
-- is greater than their previous order
WITH customer_orders AS (
    SELECT
        customer_id,
        order_id,
        order_date,
        amount,
        LAG(amount) OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_amount
    FROM orders
)
SELECT *
FROM customer_orders
WHERE amount > previous_amount;


-- Q53. Number each customer's orders chronologically
SELECT
    customer_id,
    order_id,
    order_date,
    amount,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_order_number
FROM orders;


-- Q54. Find the first order for every customer
WITH ranked_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked_orders
WHERE rn = 1;


-- Q55. Find the most recent order for every customer
WITH ranked_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked_orders
WHERE rn = 1;
