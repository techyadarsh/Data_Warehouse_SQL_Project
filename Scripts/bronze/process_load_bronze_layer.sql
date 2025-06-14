/*================================================================= 
  Title:
  Bronze Layer Data Load Procedure – Data Warehouse (SQL Server)

  Script Purpose:
  - Loads raw data into Bronze Layer tables using BULK INSERT.
  - Performs a truncate-and-load operation to refresh data from CSV files.
  - Handles both CRM and ERP source datasets.
  - Tracks execution time for each table and the overall batch.
  - Includes error handling and logging via PRINT statements.

  Note:
  - Assumes all source CSV files exist at the specified file paths.
  - Requires proper permissions to use BULK INSERT and TRUNCATE.
==================================================================*/


/*================================================================= 
	BULK Insert method use to load the data 
	Truncate and load so that if prevous data will delete and updated data will inserted
====================================================================*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'loading Bronze Layer';
		PRINT '==============================================';

		PRINT '----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';



		PRINT '----------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';



		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.erp_loc_a10';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a10';
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';



		SET @start_time = GETDATE();
		PRINT '>> TRUNCATE TABLE bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2'; 
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\DA\MSSQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD Duration:' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR ) + 'seconds';
		PRINT '=============================================='
		SET @batch_end_time = GETDATE();
		PRINT '>> LOAD Duration of Bronze Layer:' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR ) + 'seconds';
		PRINT '=============================================='
	END TRY
	BEGIN CATCH
	PRINT '=============================================='
	PRINT 'ERROR OCCURD DURING LODING BRONZE LAYER'
	PRINT '=============================================='
	END CATCH

END

EXEC bronze.load_bronze

