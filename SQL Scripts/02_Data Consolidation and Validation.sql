USE CustomerAnalytics;
GO

--Checking Column names and Values for that Column
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'online_retail_2009-2010'
ORDER BY ORDINAL_POSITION;


-- Combining Both Tables And Data Type Safely
SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    TRY_CONVERT(DECIMAL(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2009-2010' AS SourceSheet

INTO dbo.RetailCombined

FROM dbo.[online_retail_2009-2010]

UNION ALL

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    TRY_CONVERT(DECIMAL(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2010-2011' AS SourceSheet

FROM dbo.[online_retail_2010-2011];

--Checking the appended Retail Table

-- Total Rows
SELECT COUNT(*) AS Total_Rows
FROM dbo.RetailCombined;

-- Failed Date Conversions / NULL Dates
SELECT COUNT(*) AS Failed_Dates
FROM dbo.RetailCombined
WHERE InvoiceDate IS NULL;

-- Failed Price Conversions / NULL Prices
SELECT COUNT(*) AS Failed_Prices
FROM dbo.RetailCombined
WHERE Price IS NULL;