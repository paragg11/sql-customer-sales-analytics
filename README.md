# SQL Customer & Sales Analytics

## 📊 Project Overview

This project analyzes e-commerce customer and sales data using MySQL to identify sales trends, customer behavior, product performance, and revenue patterns.

The objective is to use SQL to answer real-world business questions and generate actionable insights that can support data-driven decision-making.

---

## 🎯 Business Objectives

The analysis focuses on:

* Understanding overall sales performance
* Identifying high-value customers
* Analyzing customer purchasing behavior
* Identifying top-performing products
* Comparing product and category performance
* Analyzing monthly revenue trends
* Measuring month-over-month revenue growth
* Identifying repeat customers
* Ranking customers and products
* Analyzing first and latest customer purchases

---

## 🛠️ Tools & Technologies

* MySQL
* SQL
* Common Table Expressions (CTEs)
* Subqueries
* Joins
* Aggregate Functions
* Window Functions
* Date Functions
* String Functions
* CASE WHEN
* NULL Handling
* COALESCE

---

## 📁 Project Structure

```text
sql-customer-sales-analytics/
│
├── README.md
│
└── sql/
    ├── 01_basic_analysis.sql
    ├── 02_customer_analysis.sql
    ├── 03_product_analysis.sql
    ├── 04_date_analysis.sql
    └── 05_window_functions.sql
```

---

## 🔍 Analysis Performed

### 1. Basic Sales Analysis

* Total revenue
* Total orders
* Average order value
* Highest and lowest order
* Revenue by region
* Revenue by category
* Top orders

### 2. Customer Analysis

* Customer spending
* Top 10 customers
* Customer ranking
* Number of orders per customer
* Repeat customers
* One-time customers
* Customers above average spending
* First purchase date
* Latest purchase date
* Customers with no orders

### 3. Product Analysis

* Top products by revenue
* Top products within each category
* Top 3 products per category
* Product quantity sold
* Average order value by product
* Product ranking
* Category performance

### 4. Date & Revenue Analysis

* Monthly revenue
* Monthly order count
* Running revenue
* Previous month revenue
* Month-over-month revenue growth
* Next month revenue
* First customer purchase
* Latest customer purchase

### 5. Advanced Window Function Analysis

* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* LAG()
* LEAD()
* SUM() OVER()
* AVG() OVER()
* PARTITION BY
* Running totals
* Customer order ranking

---

## 💡 Key SQL Concepts Demonstrated

### Conditional Logic

```sql
CASE
    WHEN condition THEN result
    ELSE result
END
```

### Common Table Expressions

```sql
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales;
```

### Window Functions

```sql
RANK() OVER(
    PARTITION BY category
    ORDER BY revenue DESC
)
```

### Month-over-Month Analysis

```sql
LAG(revenue) OVER(
    ORDER BY month
)
```

---

## 📈 Business Questions Answered

Some of the key business questions addressed in this project include:

1. What is the total revenue?
2. Which regions generate the most revenue?
3. Who are the top 10 customers?
4. Which customers are repeat customers?
5. Which products generate the highest revenue?
6. What are the top 3 products in each category?
7. What is the monthly revenue trend?
8. How has revenue changed month-over-month?
9. What is the running revenue over time?
10. What was each customer's first purchase?
11. What was each customer's latest purchase?
12. Which customers spend more than the average customer?
13. Which products perform best within each category?
14. Which customers have never placed an order?

---

## 📌 Key Insights

Key insights will be added after running the SQL queries against the dataset and validating the results.

Examples of insights to investigate include:

* Highest-performing region
* Highest-revenue category
* Top customers by spending
* Best-performing products
* Monthly revenue trends
* Customer repeat-purchase behavior
* Revenue growth patterns

---

## 💼 Business Recommendations

Recommendations will be developed based on the actual analysis results.

Potential areas include:

* Focusing marketing efforts on high-value customers
* Improving repeat-purchase strategies
* Promoting high-performing products
* Investigating underperforming categories
* Identifying periods of strong or weak revenue
* Using customer purchasing behavior for targeted campaigns

---

## 🚀 Project Purpose

This project was created as part of my Data Analytics portfolio to demonstrate practical SQL skills and the ability to translate business questions into analytical queries.

The project emphasizes business-oriented SQL analysis rather than only theoretical SQL exercises.
