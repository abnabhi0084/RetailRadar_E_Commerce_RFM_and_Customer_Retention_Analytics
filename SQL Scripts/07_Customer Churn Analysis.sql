-- OVERALL CUSTOMER CHURN ANALYSIS

USE CustomerAnalytics;
GO

SELECT
    CASE
        WHEN IsChurned = 1 THEN 'Churned'
        ELSE 'Not Churned'
    END AS Churn_Status,

    COUNT(*) AS Total_Customers,

    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER()
        AS DECIMAL(5,2)
    ) AS Customer_Percentage

FROM dbo.CustomerRFMSegments

GROUP BY IsChurned;

-- CHURN ANALYSIS BY CUSTOMER SEGMENT

SELECT
    Segment,

    COUNT(*) AS Total_Customers,

    SUM(IsChurned) AS Churned_Customers,

    COUNT(*) - SUM(IsChurned) AS Active_Customers,

    CAST(
        SUM(IsChurned) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS Churn_Rate

FROM dbo.CustomerRFMSegments

GROUP BY Segment

ORDER BY Churn_Rate DESC;