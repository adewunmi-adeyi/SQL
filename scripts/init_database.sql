/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up 2 schemas 
    within the database: 'Postcall_survey' and 'zip_code'.

WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouseAnalytics' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;
GO

USE DataWarehouseAnalytics;
GO


-- Build Schema Customer Experience 

CREATE SCHEMA CX_Postcall_survey;
GO

CREATE TABLE zip_codes (
	postcode_key int,
	city nvarchar(50),
	county nvarchar(50),
	state_name nvarchar(50),
	state_code nvarchar(50),
	country nvarchar(50)
);
GO

CREATE TABLE Postcall_Survey
(
	call_ID int ,
	survey_ID nvarchar(50) ,
	survey_date date,
	Call_reason nvarchar(50) ,
	fcr_responses nvarchar(50) ,
	csat_responses nvarchar(50) ,
	agent_effort nvarchar(50) ,
	net_promoter_score int,
	submission_date nvarchar(50),
	post_code int
);
GO
-----------------------------------
-- INSERTING DATA FROM SOURCE

TRUNCATE TABLE zip_codes;
GO

BULK INSERT zip_codes
FROM 'C:\Users\passi\OneDrive\Desktop\SQL Files\zip_codes.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

TRUNCATE TABLE Postcall_Survey;
GO

BULK INSERT Postcall_Survey
FROM 'C:\Users\passi\OneDrive\Desktop\SQL Files\Fire_Services_Customer_Survey.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO
