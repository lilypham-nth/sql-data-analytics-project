/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/


-- Analyse the sales performance over time
SELECT
    DATETRUNC(year,order_date) order_date,
    SUM(sales_amount) total_sales,
    COUNT(DISTINCT customer_key) total_customer,
    SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
ORDER BY DATETRUNC(YEAR,order_date)

-- change the format
SELECT
    FORMAT(order_date,'yyyy-MMM') order_date,
    SUM(sales_amount) total_sales,
    COUNT(DISTINCT customer_key) total_customer,
    SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY FORMAT(order_date,'yyyy-MMM')