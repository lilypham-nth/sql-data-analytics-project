/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/


-- to see all the data table
SELECT *
FROM gold.dim_customers;

-- Explore all distinct countries that customers come from.
SELECT DISTINCT
    Country
FROM gold.dim_customers;

---------------------

-- to see all the data table
SELECT *
FROM gold.dim_products;

-- Explore all Categories "The Major Divisions"
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY 1,2,3;