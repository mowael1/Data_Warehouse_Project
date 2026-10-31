/*
===============================================================================
Measures Exploration
===============================================================================
Purpose:
    - To calculate aggregated metrics.
    - To identify overall trends or spot anomalies.
===============================================================================
*/

-- Total number of sales
SELECT SUM(price) AS total_sales
FROM gold.fact_sales

-- Number of sold item
SELECT SUM(quanity) AS total_quantity
FROM gold.fact_sales

-- Average selling price
SELECT AVG(price) AS avg_price
FROM gold.fact_sales

-- Total Number of unique orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- Total number of products
SELECT COUNT(product_number) AS total_products
FROM gold.dim_product


-- Total number of customers
SELECT COUNT(customer_key) AS total_customers
FROM gold.dim_customers

-- Total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales


-- Report show all key metrics of the business
SELECT 'Total Sales' AS measure_name, 
		SUM(sales_amount) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', 
		SUM(quanity) 
FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', 
		AVG(price) 
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', 
		COUNT(DISTINCT order_number)
FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products', 
		COUNT(product_name) 
FROM gold.dim_product
UNION ALL
SELECT 'Total Nr. Customers', 
		COUNT(customer_key) 
FROM gold.dim_customers