
USE CustomerAnalytics;
GO

/* 1. BUSINESS OVERVIEW — KPI CROSS-CHECK
      Compare with Total Customers, Total Revenue, Avg Customer Value,
      and Churned % / 90-Day Inactivity Rate cards. */
SELECT
    (SELECT COUNT(DISTINCT Customer_ID)
     FROM dbo.CustomerRFMSegments) AS Total_Customers,

    (SELECT CAST(SUM(CAST(Revenue AS DECIMAL(18,2))) AS DECIMAL(18,2))
     FROM dbo.RetailRFMTransactions) AS Total_Revenue,

    (SELECT CAST(AVG(CAST(Monetary AS DECIMAL(18,2))) AS DECIMAL(18,2))
     FROM dbo.CustomerRFMSegments) AS Avg_Customer_Value,

    (SELECT COUNT(*)
     FROM dbo.CustomerRFMSegments
     WHERE IsChurned = 1) AS Inactive_Customers,

    (SELECT CAST(
         100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*), 0) AS DECIMAL(6,2))
     FROM dbo.CustomerRFMSegments) AS Inactivity_Rate_Percent;


/* 2. BUSINESS OVERVIEW — REVENUE AND CUSTOMER RETENTION BY SEGMENT
      Compare with Revenue Contribution by Segment and the
      Active / Inactive Customers by Segment visual. */
;WITH RevenueBySegment AS
(
    SELECT
        Segment,
        CAST(SUM(CAST(Revenue AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Total_Revenue
    FROM dbo.RetailRFMTransactions
    GROUP BY Segment
),
CustomersBySegment AS
(
    SELECT
        Segment,
        COUNT(DISTINCT Customer_ID) AS Total_Customers,
        SUM(CASE WHEN IsChurned = 0 THEN 1 ELSE 0 END) AS Active_Customers,
        SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END) AS Inactive_Customers,
        CAST(100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
             / NULLIF(COUNT(*), 0) AS DECIMAL(6,2)) AS Inactivity_Rate_Percent
    FROM dbo.CustomerRFMSegments
    GROUP BY Segment
)
SELECT
    C.Segment,
    C.Total_Customers,
    R.Total_Revenue,
    C.Active_Customers,
    C.Inactive_Customers,
    C.Inactivity_Rate_Percent
FROM CustomersBySegment AS C
LEFT JOIN RevenueBySegment AS R
    ON R.Segment = C.Segment
ORDER BY R.Total_Revenue DESC;


/* 3. BUSINESS OVERVIEW — TOP 5 COUNTRIES BY REVENUE
      Compare with the Top 5 Countries by Revenue bar chart. */
SELECT TOP (5)
    Country,
    CAST(SUM(CAST(Revenue AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Total_Revenue
FROM dbo.RetailRFMTransactions
GROUP BY Country
ORDER BY Total_Revenue DESC;


/* 4. RFM ANALYSIS & CUSTOMER CHURN — SEGMENT SUMMARY
      Compare with the RFM profile table and the inactivity / inactive
      historical monetary value visuals. Customer-level table is used so
      each customer contributes once to the averages and totals. */
SELECT
    Segment,
    COUNT(*) AS Total_Customers,
    CAST(AVG(CAST(Frequency AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Avg_Frequency,
    CAST(AVG(CAST(Recency AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Avg_Recency_Days,
    CAST(AVG(CAST(Monetary AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Avg_Monetary,
    CAST(AVG(CAST(F_Score AS DECIMAL(5,2))) AS DECIMAL(5,2)) AS Avg_F_Score,
    CAST(AVG(CAST(R_Score AS DECIMAL(5,2))) AS DECIMAL(5,2)) AS Avg_R_Score,
    CAST(AVG(CAST(M_Score AS DECIMAL(5,2))) AS DECIMAL(5,2)) AS Avg_M_Score,
    SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END) AS Inactive_Customers,
    CAST(100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*), 0) AS DECIMAL(6,2)) AS Inactivity_Rate_Percent,
    CAST(SUM(CASE WHEN IsChurned = 1 THEN Monetary ELSE 0 END)
         AS DECIMAL(18,2)) AS Inactive_Historical_Monetary
FROM dbo.CustomerRFMSegments
GROUP BY Segment
ORDER BY Segment;
