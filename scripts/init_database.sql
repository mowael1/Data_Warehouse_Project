/*
================================================
Create Database and Schemas
================================================

Script Purpose:
		This script creates a new database named 'DataWarehouse'.
		The script sets up three schemas within the database: 'bronze', 'silver', and 'gold'.
*/


USE master;

# Create our database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

# Create Shemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO