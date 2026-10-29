/*
	This script to insert data into silver.crm_prd_info
	And all data quality checks before inserting
*/

/*
TRUNCATE TABLE silver.crm_prd_info;
INSERT INTO silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
SELECT
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	SUBSTRING(prd_key,7, LEN(prd_key)) AS prd_key,
	prd_nm,
	ISNULL(prd_cost, 0) prd_cost,
	CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'n/a'
	END AS prd_line,
	CAST(prd_start_dt AS DATE) AS prd_start_dt,
	CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info
*/

/*
-- Check For Nulls or Duplicates in Primary Key
SELECT 
	prd_id,
	COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLs or Negative Numbers
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost IS NULL or prd_cost < 0

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt
*/