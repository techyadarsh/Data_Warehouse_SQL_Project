# 🧾 Bronze Layer Table Creation Script – Data Warehouse (SQL Server)

## 📄 Script Purpose

This SQL script sets up the **Bronze Layer** tables in the `DataWarhouse` database as part of a modern data warehouse architecture built using **SQL Server**.

### ✅ Objectives:
- Drop existing tables in the `bronze` schema if they exist.
- Create raw data staging tables from both **CRM** and **ERP** source systems.
- Organize the raw datasets under a dedicated schema (`bronze`) to ensure a clear separation of layers.
- Provide a foundation for the ETL process into **Silver** and **Gold** layers.

### 📁 Tables Created:

| Table Name                      | Description                          |
|----------------------------------|--------------------------------------|
| `bronze.crm_cust_info`          | Customer personal info from CRM      |
| `bronze.crm_prd_info`           | Product master data from CRM         |
| `bronze.crm_sales_details`      | Sales transactions from CRM          |
| `bronze.erp_cust_az12`          | Customer demographics from ERP       |
| `bronze.erp_loc_a101`           | Customer location info from ERP      |
| `bronze.erp_px_cat_g1v2`        | Product category and maintenance data|

### ⚠️ Notes:
- Requires the `bronze` schema to exist in the `DataWarhouse` database.
- Assumes sufficient permissions to create and drop tables.

---

-- Creating Tables in Bronze layer
use DataWarhouse;

IF OBJECT_ID ('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info(
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	DATETIME,
	prd_end_dt		DATETIME
);


IF OBJECT_ID ('bronze.crm_sales_details','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details(
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_order_dt	INT,
	sls_ship_dt		INT,
	sls_due_dt		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);


IF OBJECT_ID ('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12(
	CID		NVARCHAR(50),
	BDATE	DATE,
	GEN		NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101(
	CID		NVARCHAR(50),
	CNTRY	NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2(
	ID			NVARCHAR(50),
	CAT			NVARCHAR(50),
	SUBCAT		NVARCHAR(50),
	MAINTENANCE NVARCHAR(50)
);

