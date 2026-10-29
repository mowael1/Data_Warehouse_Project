/*
	This script to insert data into silver.crm_sales_details
	And all data quality checks before inserting
*/


/*
TRUNCATE TABLE silver.crm_sales_details;
INSERT INTO silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,

	CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS sls_order_dt ,

	CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
		 ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS sls_ship_dt ,

	CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
		 ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END AS sls_due_dt,

	CASE WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price)
		 THEN sls_quantity * ABS(sls_price)
		 ELSE sls_sales
	END AS sls_sales,

	sls_quantity,

	CASE WHEN sls_price <= 0 OR sls_price IS NULL
		 THEN sls_sales * ABS(sls_quantity)

		 ELSE sls_price

	END AS sls_price
FROM bronze.crm_sales_details

*/



---------------------------------------------------------
-- Data Check
---------------------------------------------------------

/*
-- Check for nulls in the primary key
SELECT *
FROM bronze.crm_sales_details
WHERE sls_ord_num IS NULL


-- Check for unwanted spaces
SELECT *
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)

SELECT *
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (
	SELECT prd_key
	FROM silver.crm_prd_info
)

SELECT *
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (
	SELECT cst_id
	FROM silver.crm_cust_info
)

select sls_order_dt
from bronze.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8

select sls_ship_dt
from bronze.crm_sales_details
WHERE sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8


select sls_due_dt
from bronze.crm_sales_details
WHERE sls_due_dt <= 0 OR LEN(sls_due_dt) != 8


SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


SELECT
	sls_quantity,

	CASE WHEN sls_sales <= 0 OR sls_sales IS NULL OR sls_sales != sls_quantity * ABS(sls_price)
		 THEN sls_quantity * ABS(sls_price)

		 ELSE sls_sales

	END AS new_sls_sales,

	CASE WHEN sls_price <= 0 OR sls_price IS NULL
		 THEN sls_sales * ABS(sls_quantity)

		 ELSE sls_price

	END AS new_sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0

*/