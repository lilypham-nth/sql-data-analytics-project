/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: ROW_NUMBER(), DENSE_RANK(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products generate the highest revenue
SELECT TOP 5
    p.product_name,
    SUM(s.sales_amount) total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

-- used WINDOW FUNCTIONS
SELECT *
FROM (
SELECT
    p.product_name,
    SUM(s.sales_amount) total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) rank_product
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
)t
WHERE rank_product<=5

-- What are the 5 worst-performing products in terms of sales 
SELECT TOP 5
    p.product_name,
    SUM(s.sales_amount) total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
    s.customer_key,
    c.first_name,
    c.last_name,
    SUM(s.sales_amount) total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY
    s.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC


-- and 3 customers with the fewest orders placed
SELECT TOP 3
    s.customer_key,
    c.first_name,
    c.last_name,
    COUNT( DISTINCT s.order_number) total_order
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY
    s.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_order ASC
