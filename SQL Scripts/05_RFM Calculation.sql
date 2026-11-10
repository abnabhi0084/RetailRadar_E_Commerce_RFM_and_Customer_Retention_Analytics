-- CUSTOMER RFM CALCULATION

USE CustomerAnalytics;
GO

-- SNAPSHOT DATE
DECLARE @SnapshotDate DATE = '2011-12-10';

-- CALCULATE RECENCY, FREQUENCY AND MONETARY

SELECT
    Customer_ID,

    DATEDIFF(
        DAY,
        MAX(InvoiceDate),
        @SnapshotDate
    ) AS Recency,

    COUNT(DISTINCT Invoice) AS Frequency,

    SUM(
        CAST(Quantity AS DECIMAL(18,2)) * Price
    ) AS Monetary

INTO dbo.CustomerRFM

FROM dbo.RetailCleaned

WHERE Customer_ID IS NOT NULL
  AND Quantity > 0

GROUP BY Customer_ID;


-- VIEW RFM RESULTS

SELECT *
FROM dbo.CustomerRFM;