
/*
TRUNCATE TABLE silver.erp_px_cat_g1v2;
INSERT INTO silver.erp_px_cat_g1v2 (id,cat,subcat,maintenance)
SELECT *
FROM bronze.erp_px_cat_g1v2
*/



/*
-----------------------------------------
-- Checks
-----------------------------------------
SELECT id
FROM bronze.erp_px_cat_g1v2
WHERE id NOT IN (
	SELECT cat_id
	FROM silver.crm_prd_info
)

-- Check for unwanted Spaces
SELECT * 
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)


-- Data Standardization & Consistency
SELECT DISTINCT
cat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT
subcat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT
maintenance
FROM bronze.erp_px_cat_g1v2

*/