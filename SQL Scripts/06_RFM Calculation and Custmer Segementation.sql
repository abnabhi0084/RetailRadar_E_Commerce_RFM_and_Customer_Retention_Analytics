-- RFM SCORING AND CUSTOMER SEGMENTATION

USE CustomerAnalytics;
GO

;WITH RFMScoring AS
(
    SELECT
        Customer_ID,
        Recency,
        Frequency,
        Monetary,

        -- RECENCY SCORE (LOWER RECENCY = HIGHER SCORE)

        6 - NTILE(5) OVER(
            ORDER BY Recency ASC, Customer_ID
        ) AS R_Score,

        -- FREQUENCY SCORE

        NTILE(5) OVER(
            ORDER BY Frequency ASC, Customer_ID
        ) AS F_Score,

        -- MONETARY SCORE

        NTILE(5) OVER(
            ORDER BY Monetary ASC, Customer_ID
        ) AS M_Score

    FROM dbo.CustomerRFM
)

SELECT
    Customer_ID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,

    -- CUSTOMER SEGMENTATION

    CASE

        WHEN R_Score >= 4
         AND F_Score >= 4
         AND M_Score >= 4
        THEN 'Champions'

        WHEN R_Score >= 3
         AND F_Score >= 3
        THEN 'Loyal'

        WHEN R_Score <= 2
         AND F_Score >= 3
        THEN 'At Risk'

        WHEN R_Score >= 4
         AND F_Score <= 2
        THEN 'New'

        WHEN R_Score = 3
         AND F_Score <= 2
        THEN 'Needs Attention'

        ELSE 'Lost'

    END AS Segment,

    -- CHURN IDENTIFICATION

    CASE
        WHEN Recency > 90 THEN 1
        ELSE 0
    END AS IsChurned

INTO dbo.CustomerRFMSegments

FROM RFMScoring;


-- VIEW FINAL CUSTOMER SEGMENTS

SELECT *
FROM dbo.CustomerRFMSegments;