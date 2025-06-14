/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


USE master;
GO;


-- Check if the database exists
IF EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = 'DataWarehouse'
)
BEGIN
    -- Drop the database if it exists
    DROP DATABASE DataWarehouse;
END;


-- Create Database DataWarhouse

CREATE DATABASE DataWarhouse;

USE DataWarhouse;

-- Create schema

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;

-- GO works as the seprate batches in sql statements 

