-- MERGE RFM RESULTS BACK ONTO TRANSACTIONS

USE CustomerAnalytics;
GO

SELECT
    T.Invoice,
    T.StockCode,
    T.Description,
    T.Quantity,
    T.InvoiceDate,

    DATEFROMPARTS(
        YEAR(T.InvoiceDate),
        MONTH(T.InvoiceDate),
        1
    ) AS InvoiceMonth,

    T.Price,

    T.Quantity * T.Price AS Revenue,

    T.Customer_ID,
    T.Country,
    T.SourceSheet,

    R.Recency,
    R.Frequency,
    R.Monetary,

    R.R_Score,
    R.F_Score,
    R.M_Score,

    R.Segment,
    R.IsChurned

INTO dbo.RetailRFMTransactions

FROM dbo.RetailCleaned AS T

LEFT JOIN dbo.CustomerRFMSegments AS R
    ON T.Customer_ID = R.Customer_ID

WHERE T.Customer_ID IS NOT NULL
  AND T.Quantity > 0;


-- VIEW FINAL INTEGRATED DATA

SELECT TOP 100 *
FROM dbo.RetailRFMTransactions;