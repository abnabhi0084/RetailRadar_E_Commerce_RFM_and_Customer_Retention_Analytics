
USE CustomerAnalytics;
GO

/* ============================================================
   1. BUSINESS OVERVIEW — KPI CROSS-CHECK

   Compare with:
   Total Customers, Total Revenue, Avg Customer Value,
   Churned % and Inactive Customers.

   Customer metrics: CustomerRFMSegments
   Revenue: RetailCleaned
   ============================================================ */

SELECT
    (SELECT COUNT(DISTINCT Customer_ID)
     FROM dbo.CustomerRFMSegments) AS Total_Customers,

    (SELECT CAST(
         SUM(CAST(Quantity AS DECIMAL(18,2))
             * CAST(Price AS DECIMAL(18,2)))
         AS DECIMAL(18,2))
     FROM dbo.RetailCleaned) AS Total_Revenue,

    (SELECT CAST(
         AVG(CAST(Monetary AS DECIMAL(18,2)))
         AS DECIMAL(18,2))
     FROM dbo.CustomerRFMSegments) AS Avg_Customer_Value,

    (SELECT COUNT(*)
     FROM dbo.CustomerRFMSegments
     WHERE IsChurned = 1) AS Inactive_Customers,

    (SELECT CAST(
         100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*), 0)
         AS DECIMAL(6,2))
     FROM dbo.CustomerRFMSegments) AS Inactivity_Rate_Percent;


/* ============================================================
   2. BUSINESS OVERVIEW — REVENUE AND CUSTOMER RETENTION
      BY SEGMENT

   Revenue comes from transaction-level data.
   Customer counts and inactivity come from customer-level data.
   ============================================================ */

;WITH RevenueBySegment AS
(
    SELECT
        C.Segment,
        CAST(
            SUM(
                CAST(T.Quantity AS DECIMAL(18,2))
                * CAST(T.Price AS DECIMAL(18,2))
            )
            AS DECIMAL(18,2)
        ) AS Total_Revenue
    FROM dbo.RetailCleaned AS T
    INNER JOIN dbo.CustomerRFMSegments AS C
        ON T.Customer_ID = C.Customer_ID
    GROUP BY C.Segment
),
CustomersBySegment AS
(
    SELECT
        Segment,
        COUNT(*) AS Total_Customers,

        SUM(CASE WHEN IsChurned = 0 THEN 1 ELSE 0 END)
            AS Active_Customers,

        SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
            AS Inactive_Customers,

        CAST(
            100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
            / NULLIF(COUNT(*), 0)
            AS DECIMAL(6,2)
        ) AS Inactivity_Rate_Percent

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
    ON C.Segment = R.Segment
ORDER BY R.Total_Revenue DESC;


/* ============================================================
   3. BUSINESS OVERVIEW — TOP 5 COUNTRIES BY REVENUE

   Revenue is calculated from transaction-level data.
   ============================================================ */

SELECT TOP (5)
    Country,

    CAST(
        SUM(
            CAST(Quantity AS DECIMAL(18,2))
            * CAST(Price AS DECIMAL(18,2))
        )
        AS DECIMAL(18,2)
    ) AS Total_Revenue

FROM dbo.RetailCleaned
GROUP BY Country
ORDER BY Total_Revenue DESC;


/* ============================================================
   4. RFM ANALYSIS & CUSTOMER CHURN — SEGMENT SUMMARY

   Customer-level table is used.
   Each customer contributes exactly once to the averages,
   customer counts and historical monetary calculations.
   ============================================================ */

SELECT
    Segment,

    COUNT(*) AS Total_Customers,

    CAST(
        AVG(CAST(Frequency AS DECIMAL(18,2)))
        AS DECIMAL(18,2)
    ) AS Avg_Frequency,

    CAST(
        AVG(CAST(Recency AS DECIMAL(18,2)))
        AS DECIMAL(18,2)
    ) AS Avg_Recency_Days,

    CAST(
        AVG(CAST(Monetary AS DECIMAL(18,2)))
        AS DECIMAL(18,2)
    ) AS Avg_Monetary,

    CAST(
        AVG(CAST(F_Score AS DECIMAL(5,2)))
        AS DECIMAL(5,2)
    ) AS Avg_F_Score,

    CAST(
        AVG(CAST(R_Score AS DECIMAL(5,2)))
        AS DECIMAL(5,2)
    ) AS Avg_R_Score,

    CAST(
        AVG(CAST(M_Score AS DECIMAL(5,2)))
        AS DECIMAL(5,2)
    ) AS Avg_M_Score,

    SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
        AS Inactive_Customers,

    CAST(
        100.0 * SUM(CASE WHEN IsChurned = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Inactivity_Rate_Percent,

    CAST(
        SUM(
            CASE WHEN IsChurned = 1
                 THEN Monetary
                 ELSE 0
            END
        )
        AS DECIMAL(18,2)
    ) AS Inactive_Historical_Monetary

FROM dbo.CustomerRFMSegments
GROUP BY Segment
ORDER BY Segment;
