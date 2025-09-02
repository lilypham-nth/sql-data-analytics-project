/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/


CREATE VIEW gold.report_customers AS
WITH base_query AS
(
--  1) Base Query: retrieves core colums from tables
SELECT
	s.order_number,
	s.product_key,
	s.order_date,
	s.sales_amount,
	s.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
	DATEDIFF(year, c.birthdate, GETDATE()) AS customer_age
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
)

-- 3)Aggregates customer-level metrics
, customer_aggregation AS (
SELECT
	customer_key,
	customer_number,
	customer_name,
	customer_age,
	COUNT(DISTINCT order_number) AS total_order,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_product,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM base_query
GROUP BY 
	customer_key,
	customer_number,
	customer_name,
	customer_age
)

-- 2) Segments customers into categories (VIP, Regular, New) and age groups.
-- 4) Calculates valuable KPIs.
SELECT
	customer_key,
	customer_number,
	customer_name,
	customer_age,
	CASE
        WHEN customer_age <20 THEN 'Under 20'
        WHEN customer_age BETWEEN 20 AND 29 THEN '20-29'
		WHEN customer_age BETWEEN 30 AND 39 THEN '30-39'
		WHEN customer_age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS age_group,
	CASE
        WHEN lifespan >=12 AND total_sales > £5000 THEN 'VIP'
        WHEN lifespan >=12 AND total_sales <= £5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
	last_order_date,
	--  (4)recency (months since last order)
	DATEDIFF(month,last_order_date,GETDATE()) AS recency,
	total_order,
	total_sales,
	total_quantity,
	total_product,
	lifespan,
-- (4) Compuate average order value (AVO)
	CASE
		WHEN total_order = 0 THEN 0
		ELSE total_sales/total_order
	END AS avg_order_value,
-- (4) Compuate average monthly spend
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales/lifespan
	END AS avg_monthly_spend
FROM customer_aggregation

