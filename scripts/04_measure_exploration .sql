/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Analysis the data

-- Find the Total Sales
SELECT
    SUM(sales_amount) total_sales
FROM gold.fact_sales;

-- Find how many items are sold
SELECT
    SUM(quantity) total_quantity
FROM gold.fact_sales;

-- Find the average selling price
SELECT
    AVG(price) avg_prices
FROM gold.fact_sales;

-- Find the total number of orders
SELECT
    COUNT(order_number) total_orders,
    COUNT (DISTINCT order_number) total_unique_orders
FROM gold.fact_sales;

-- Find the total number of products
SELECT
    COUNT(product_key) total_number_of_products,
    COUNT(DISTINCT product_key) unique_total_number_of_products
FROM gold.dim_products

-- Find the total number of customers
SELECT
    COUNT(customer_key) total_number_of_customer
FROM gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT
    COUNT(DISTINCT customer_key) total_customer_placed_order
FROM gold.fact_sales;

--------------------
-- Generate a Report that shows all key metrics of the business
SELECT
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
    'Total Quantity' AS measure_name,
    SUM(quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
-- Find the average selling price
SELECT
    'Avg Selling Price' AS measure_name,
    AVG(price) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
    'Total number of unique order' AS measure_name,
    COUNT (DISTINCT order_number) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT
    'Total number of product' AS measure_name,
    COUNT(DISTINCT product_key) AS measure_value
FROM gold.dim_products
UNION ALL
SELECT
    'Total number of customer' AS measure_name,
    COUNT(customer_key) AS measure_value
FROM gold.dim_customers
UNION ALL
SELECT
    'Total number of customer who placed the order' AS measure_name,
    COUNT(DISTINCT customer_key) AS measure_value
FROM gold.fact_sales;