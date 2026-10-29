
/*
TRUNCATE TABLE silver.erp_cust_az12;
INSERT INTO silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)
SELECT 
	CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		 ELSE cid
	END AS cid,
	CASE WHEN bdate > GETDATE() THEN NULL
		 ELSE bdate
	END AS bdate, 
	CASE WHEN TRIM(gen) = 'F' THEN 'Female'
		 WHEN TRIM(gen) = 'M' THEN 'Male'
		 WHEN TRIM(gen) = '' OR TRIM(gen) IS NULL THEN 'n/a'
		 ELSE gen
	END AS gen
FROM bronze.erp_cust_az12
*/

/*
-- check
SELECT cid
from bronze.erp_cust_az12
WHERE cid NOT IN (
	SELECT cst_key
	FROM silver.crm_cust_info
)

-- Wrong Dates
SELECT 
	bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE()

-- Data Standardization & Consistency
SELECT DISTINCT 
	gen
FROM bronze.erp_cust_az12
*/