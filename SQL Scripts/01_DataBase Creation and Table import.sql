IF DB_ID('CustomerAnalytics') IS NULL
BEGIN
    CREATE DATABASE CustomerAnalytics;
END

--Import DataSets Using Import Flat Files to DataBase

--Row Counts Checks After Dataset Import(Excel Count for Validation)
USE CustomerAnalytics;
GO

SELECT COUNT(*) AS Rows_2009_2010
FROM dbo.[online_retail_2009-2010];

SELECT COUNT(*) AS Rows_2010_2011
FROM dbo.[online_retail_2010-2011];