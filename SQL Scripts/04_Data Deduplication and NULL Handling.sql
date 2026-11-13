-- REMOVE DUPLICATES,NULL and NEGATIVE or ZERO PRICE HANDLING AND CREATE FINAL CLEANED TABLE

USE CustomerAnalytics;
GO

WITH Deduped AS
(
    SELECT
        Invoice,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        Price,
        Customer_ID,
        Country,
        SourceSheet,

        ROW_NUMBER() OVER
        (
            PARTITION BY
                Invoice,
                StockCode,
                Description,
                Quantity,
                InvoiceDate,
                Price,
                Customer_ID,
                Country

            ORDER BY SourceSheet
        ) AS RowNum

    FROM dbo.RetailCombined
    WHERE Customer_ID IS NOT NULL AND Price > 0 AND Quantity > 0
)

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country,
    SourceSheet

INTO dbo.RetailCleaned

FROM Deduped
WHERE RowNum = 1;


--Validation Duplicate Check 
-- CHECK 2: REMAINING DUPLICATES

SELECT COUNT(*) AS Remaining_Duplicate_Groups
FROM
(
    SELECT
        Invoice,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        Price,
        Customer_ID,
        Country
    FROM dbo.RetailCleaned
    GROUP BY
        Invoice,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        Price,
        Customer_ID,
        Country
    HAVING COUNT(*) > 1
) AS DuplicateCheck;

--NULL VALUE Check

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Invoice IS NULL THEN 1 ELSE 0 END) AS Null_Invoice,
    SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS Null_StockCode,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS Null_Description,
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS Null_InvoiceDate,
    SUM(CASE WHEN Price IS NULL THEN 1 ELSE 0 END) AS Null_Price,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_CustomerID,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Null_Country
FROM dbo.RetailCleaned;

--Quantity and Price Validaton
SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS Invalid_Quantity,
    SUM(CASE WHEN Price <= 0 THEN 1 ELSE 0 END) AS Invalid_Price
FROM dbo.RetailCleaned;
