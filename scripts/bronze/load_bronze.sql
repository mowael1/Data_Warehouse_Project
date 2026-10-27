/*

Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Uses the BULK INSERT command to load data from csv Files to bronze tables.

# Run this script will load data from source to bronze tables
by using: EXEC bronze.load_bronze

*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '==========================';
		PRINT 'Loading Bronze Layer';
		PRINT '==========================';

		PRINT '--------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------';

		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '--------------------------';
		PRINT 'Loading ERB Tables'
		PRINT '--------------------------';

		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12 
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2 
		FROM 'C:\Users\mw865\OneDrive\Desktop\Data_Warehouse_project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	END TRY
	BEGIN CATCH
		PRINT '==========================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT '==========================';
	END CATCH

END

GO

-- Load Data
EXEC bronze.load_bronze