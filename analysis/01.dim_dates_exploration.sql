/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
    - Identifiy the unique values in each dimension.
===============================================================================
*/

-- List of unique countries for customers
SELECT DISTINCT country
FROM gold.dim_customers


-- Explore categories
SELECT DISTINCT category
FROM gold.dim_product


--- Explore subcategories
SELECT DISTINCT category, subcategory
FROM gold.dim_product

-- Explore products (full picture)
SELECT DISTINCT category, subcategory, product_name
FROM gold.dim_product


-- Date Exploration
-- First and Last order dates and the years of sales are available
SELECT 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(year,MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- Customers age range
SELECT 
	MIN(birthdate) oldest_birthdate,
	DATEDIFF(year,MIN(birthdate),GETDATE()) AS oldest_age,
	MAX(birthdate) youngest_birthdate,
	DATEDIFF(year,MAX(birthdate),GETDATE()) AS youngest_age
FROM gold.dim_customers
