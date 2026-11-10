# RetailRadar — E-Commerce RFM & Customer Retention Analytics

**Customer Segmentation · RFM Analysis · 90-Day Churn Analysis · SQL Server · Power BI**

RetailRadar is an end-to-end customer analytics project I built to understand customer purchasing behavior, identify the segments that contribute the most historical revenue, and examine customers who meet a defined 90-day inactivity threshold.

I used **Microsoft SQL Server** to consolidate and prepare transaction data, calculate customer-level Recency, Frequency and Monetary (RFM) metrics, assign six customer segments, and create a rule-based 90-day churn flag. I then integrated the customer-level RFM attributes into the transaction-level data and built an interactive **Power BI report with two main analytical pages**.

My aim was to move beyond overall sales figures and answer practical questions about customer value, purchasing behavior and retention.

---

## Power BI Dashboard Preview

### 1. Business Overview

![RetailRadar Business Overview dashboard](Screenshots/Business_Overview.png)

The first page gives a high-level view of the business through four KPI cards and five visuals. It compares revenue contribution with customer volume, shows active and inactive customers by segment, identifies the leading countries by revenue, and tracks revenue and invoice activity across the available quarters.

**Dashboard KPIs**

| KPI | Result |
|---|---:|
| Total Customers | **5,881** |
| Total Revenue | **£17.37M** |
| Average Customer Value | **£2.95K** |
| Churned / Inactive Customers | **50.86%** |

### 2. RFM Analysis & Customer Churn

![RetailRadar RFM Analysis and Customer Churn dashboard](Screenshots/RFM_Analysis_Customer_Churn.png)

The second page moves from business-level performance to customer-level analysis. It combines an RFM segment profile, a Frequency-versus-Monetary customer value matrix, a segment-level inactivity comparison, an inactive-customer composition chart, and the historical monetary value associated with inactive customers.

---

## Project at a Glance

| Measure | Result |
|---|---:|
| Original Online Retail II records | **1,067,371** |
| Final integrated transaction rows | **779,495** |
| Unique identified customers | **5,881** |
| Distinct invoices in the integrated data | **36,975** |
| Countries represented after analysis filters | **41** |
| Transaction observation period | **1 Dec 2009 – 9 Dec 2011** |
| RFM snapshot date | **10 Dec 2011** |
| Total revenue in the integrated analysis data | **£17,374,804.25** |
| Average historical Monetary value per customer | **£2,954.40** |
| Customers inactive for more than 90 days | **2,991 (50.86%)** |

**How to read these figures:** The 779,495 rows and £17.37M revenue refer to the final customer-linked transaction table used by Power BI. It is built after exact-duplicate removal and includes rows with a known `Customer_ID` and `Quantity > 0`. It is not the unfiltered total of every row in the original source files. Average customer value is the average customer-level Monetary total across the analysis period; it is not predicted customer lifetime value.

---

## 1. Business Questions

I structured the analysis around questions a business team could use to understand customer value and prioritize retention attention.

### Customer Value & Revenue Contribution

1. Which customer segments contribute the highest share of total revenue?
2. Do high-value customer segments also demonstrate stronger purchasing frequency?
3. How does average customer Monetary value differ across the RFM segments?
4. Which countries contribute the largest share of revenue?

### Customer Retention & Churn

5. How many customers meet the defined 90-day inactivity rule?
6. Which RFM segments contain the largest number of inactive customers?
7. Are previously high-value customers also present in the inactive population?
8. How much historical Monetary value is associated with inactive customers across different segments?

### Business Monitoring

9. How do revenue and invoice volumes change across the available years and quarters?
10. How do customer value and inactivity differ across the six RFM segments?

The analysis is descriptive and diagnostic. It identifies customers who meet a fixed inactivity rule and highlights segments that may deserve retention attention. It does not predict future churn or establish why a customer stopped purchasing.

---

## 2. Dashboard Walkthrough

### Page 1 — Business Overview

**Main business question:** What is the overall customer and revenue position, and which customer segments contribute the most value?

The page uses Year, Quarter, Month, Segment and Country slicers.

| Visual | What it shows | Business question |
|---|---|---|
| Revenue Contribution by Customer Segment | A combo chart comparing total revenue and customer count across the six segments. | Which segments contribute the most revenue, and how does that compare with their customer population? |
| Customer Retention by Customer Segment | A stacked bar chart showing active and inactive customer counts by segment. | How are active and inactive customers distributed across segments? |
| Top 5 Countries by Revenue | A ranked horizontal bar chart. | Which countries contribute the largest amount of revenue? |
| Total Revenue by Year and Quarter | A time-series area chart. | How does revenue move across the available quarters? |
| Orders by Year and Quarter | A time-series area chart of distinct invoice counts. | Do changes in invoice volume move alongside changes in revenue? |

**Why this page matters:** It establishes the overall business position before moving into customer-level analysis. It keeps customer volume, revenue contribution, retention status, geography and time trends in one place rather than relying on a single total-revenue figure.

### Page 2 — RFM Analysis & Customer Churn

**Main business question:** How do customers differ in purchasing behavior and monetary value, and which inactive segments represent the greatest historical customer value?

The page retains the same Year, Quarter, Month, Segment and Country slicers as the Business Overview page.

| Visual | What it shows | Business question |
|---|---|---|
| RFM Profile by Customer Segment | Customer count, average Frequency, average Recency, average Monetary value, and average R, F and M scores. | How do the six customer segments differ in actual purchasing behavior and RFM scores? |
| Customer Value Matrix (Frequency vs. Monetary) | A bubble/scatter chart comparing average Frequency with average Monetary value by segment; bubble size represents customer count. | Which segments combine stronger purchasing frequency with higher historical Monetary value? |
| Inactive Customers and Churned % by Segment | A combo chart comparing inactive customer count with the 90-day inactivity rate. | Which segments have the largest inactive population and the highest inactivity rate? |
| Inactive Customers by Segment | A doughnut chart showing the composition of the inactive customer population. | Which segments make up the largest share of inactive customers? |
| Historical Monetary Value of Inactive Customers | A horizontal bar chart of the historical Monetary value associated with inactive customers in each segment. | Where is the greatest historical customer value represented within the inactive population? |

**Why this page matters:** It connects customer segmentation with retention analysis. Instead of looking only at how many customers are inactive, it also considers their historical purchase frequency and monetary contribution.

---

## 3. Key Findings & Business Insights

The figures below come from the final customer-level RFM output and integrated transaction data.

### Customer Segment Performance

| Customer Segment | Customers | Historical Revenue | Inactive Customers | Inactivity Rate |
|---|---:|---:|---:|---:|
| Champions | 1,289 | £11,830,781.14 | 0 | 0.00% |
| Loyal | 1,416 | £2,705,479.18 | 444 | 31.36% |
| At Risk | 823 | £1,588,013.79 | 823 | 100.00% |
| New | 442 | £392,021.57 | 0 | 0.00% |
| Needs Attention | 382 | £202,557.09 | 195 | 51.05% |
| Lost | 1,529 | £655,951.48 | 1,529 | 100.00% |
| **Total** | **5,881** | **£17,374,804.25** | **2,991** | **50.86%** |

### What Stood Out to Me

**1. Champions dominate historical revenue contribution.**

The 1,289 Champions generated approximately **£11.83M**, or **68.09%** of total revenue. Champions and Loyal customers together contributed approximately **£14.54M (83.66%)**.

This shows that revenue contribution is concentrated in a relatively small group of customer segments. It also makes protecting high-value customer relationships an important business consideration.

**2. The inactive customer population is substantial.**

I identified **2,991 customers (50.86%)** with more than 90 days since their latest recorded purchase at the RFM snapshot date.

This is a rule-based inactivity result using the project's agreed 90-day threshold.

**3. At Risk and Lost customers have different retention implications.**

Both segments are 100% inactive under the implemented definition, but their customer counts and historical Monetary values are different.

- **At Risk:** 823 inactive customers with approximately **£1.59M** in historical Monetary value.
- **Lost:** 1,529 inactive customers with approximately **£0.66M** in historical Monetary value.

This is why inactivity percentage alone is not enough to understand the business importance of an inactive segment.

**4. Loyal customers also contain an important inactive population.**

There are **444 inactive customers** in the Loyal segment, representing **31.36%** of that segment. Their historical Monetary value is approximately **£1.05M**.

This is worth monitoring because a segment with a strong historical purchase pattern can still contain customers who have gone quiet.

**5. Inactive customers represent meaningful historical value.**

The inactive customer population represents approximately **£3.39M in historical Monetary value**:

| Inactive Segment | Historical Monetary Value |
|---|---:|
| At Risk | £1.59M |
| Loyal | £1.05M |
| Lost | £0.66M |
| Needs Attention | £0.10M |
| **Total** | **£3.39M** |

This amount represents what those customers spent during the observation period. It is **not** a forecast of future revenue loss, guaranteed recoverable revenue, or predicted customer lifetime value.

**6. The United Kingdom is the leading revenue market.**

The United Kingdom contributed approximately **£14.39M** in the integrated analysis data, followed by EIRE, the Netherlands, Germany and France.

### Potential Business Actions by Segment

| Segment | Suggested business direction |
|---|---|
| Champions | Protect customer relationships and recognize customers who contribute the strongest historical value. |
| Loyal | Encourage repeat purchasing and review the inactive subset before it grows. |
| At Risk | Prioritize win-back investigation, especially for customers with stronger historical Frequency and Monetary value. |
| New | Encourage a second purchase and help recent, low-frequency customers become established buyers. |
| Needs Attention | Focus on repeat-purchase engagement and monitor customers whose recency is weakening. |
| Lost | Use a cost-conscious reactivation approach and compare effort with each customer's historical value. |

These are potential actions suggested by the descriptive analysis. I did not execute marketing campaigns or measure campaign performance.

---

## 4. RFM Methodology & Customer Segmentation

I calculated RFM at the **customer level**, using **10 December 2011** as the fixed snapshot date.

| Metric | Calculation | Business interpretation |
|---|---|---|
| **Recency (R)** | Days between the customer's latest `InvoiceDate` and `2011-12-10`. | Fewer days since the last purchase is better. |
| **Frequency (F)** | Count of distinct invoices for the customer during the analysis period. | More distinct purchase invoices indicate more frequent purchasing. |
| **Monetary (M)** | Sum of `Quantity * Price` for the customer's eligible transaction rows. | Higher cumulative spend indicates greater historical monetary value. |

### RFM Scoring

I used the SQL Server `NTILE(5)` window function to distribute customers into five score groups for each RFM metric.

- **R Score:** Recency is reversed so that a lower number of days since the latest purchase produces a higher score.
- **F Score:** Higher invoice frequency produces a higher score.
- **M Score:** Higher historical Monetary value produces a higher score.

Each score ranges from **1 to 5**, with 5 representing the stronger result for that dimension.

### Customer Segment Rules

The SQL `CASE` expression assigns customers in this order:

| Segment | Rule / interpretation |
|---|---|
| **Champions** | `R_Score >= 4`, `F_Score >= 4` and `M_Score >= 4` — recent, frequent and high-value customers. |
| **Loyal** | `R_Score >= 3` and `F_Score >= 3` — customers with an established and reasonably recent purchase pattern. |
| **At Risk** | `R_Score <= 2` and `F_Score >= 3` — customers with stronger historical purchase frequency but weak recency. |
| **New** | `R_Score >= 4` and `F_Score <= 2` — recent customers with relatively low purchase frequency. |
| **Needs Attention** | `R_Score = 3` and `F_Score <= 2` — customers with moderate recency but low purchase frequency. |
| **Lost** | Remaining score combinations not assigned by the preceding rules. |

### 90-Day Churn / Inactivity Definition

I implemented the project's fixed 90-day rule at the RFM snapshot date:

```sql
CASE
    WHEN Recency > 90 THEN 1
    ELSE 0
END AS IsChurned
```

In this project, **`IsChurned = 1` means the customer had more than 90 days since their latest recorded purchase as of 10 December 2011**. It is a transparent, rule-based definition used for customer inactivity analysis. It is not a machine-learning prediction, a confirmed cancellation event, or a recorded churn date.

---

## 5. SQL Server Workflow

I kept the data preparation, RFM calculations, customer scoring, segmentation and integration in **T-SQL**. The scripts are numbered so the workflow can be followed in sequence.

### SQL Script Documentation

| Script | What I did |
|---|---|
| `01_DataBase Creation and Table import.sql` | Created the `CustomerAnalytics` database and checked the row counts of the two imported yearly source tables. The source files are loaded through the SSMS Import Flat File workflow. |
| `02_Data Consolidation and Validation.sql` | Combined both periods with `UNION ALL`, converted `Price` using `TRY_CONVERT(DECIMAL(10,2), ...)`, and checked for failed date and price conversions. The result is `RetailCombined`. |
| `03_Data Quality Assesment.sql` | Assessed missing Customer IDs, non-positive quantities, missing descriptions and exact duplicate transaction groups. |
| `04_Data Deduplication.sql` | Used `ROW_NUMBER()` with the transaction fields as the duplicate key to retain one copy of exact duplicate rows and create `RetailCleaned`. |
| `05_RFM Calculation.sql` | Calculated customer-level Recency, Frequency and Monetary values using the fixed snapshot date of `2011-12-10`. The result is `CustomerRFM`. |
| `06_RFM Calculation and Custmer Segementation.sql` | Applied 1–5 RFM scores with `NTILE(5)`, assigned the six customer segments, and created the `IsChurned` flag. The result is `CustomerRFMSegments`. |
| `07_Customer Churn Analysis.sql` | Summarized the inactive population overall and by customer segment. |
| `08_RFM Integration.sql` | Joined customer-level RFM attributes back to eligible transaction rows, created `InvoiceMonth` and line-level `Revenue`, and produced `RetailRFMTransactions`. |
| `09_PowerBI_Dashboard_Validation.sql` | Returned SQL comparison outputs for the Power BI KPIs, segment summaries, top countries, year/quarter trends and customer-value matrix. This is a read-only reconciliation script. |

### Main SQL Tables

| Table | Grain | Purpose |
|---|---|---|
| `RetailCombined` | Transaction line | Consolidated source periods before deduplication. |
| `RetailCleaned` | Transaction line | Exact duplicate transaction rows removed. |
| `CustomerRFM` | One row per customer | Recency, Frequency and Monetary metrics. |
| `CustomerRFMSegments` | One row per customer | RFM scores, segment assignment and 90-day inactivity flag. |
| `RetailRFMTransactions` | Transaction line | Final Power BI table with transaction fields and attached customer-level RFM attributes. |

### Data Preparation Decisions

- I consolidated the two yearly source tables into one staging table.
- I used `TRY_CONVERT` for price conversion so conversion issues could be checked.
- I assessed missing customer identifiers, non-positive quantities, missing descriptions and exact duplicates before building the customer model.
- I removed exact duplicate transaction rows with `ROW_NUMBER()` over Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID and Country.
- I calculated RFM only for rows with a known `Customer_ID` and a positive `Quantity`.
- I calculated line revenue as `Quantity * Price` and joined the resulting customer-level attributes back to the transaction table for Power BI analysis.

---

## 6. Power BI Data Model & Validation

I used `RetailRFMTransactions` as the primary transaction-level table in Power BI.

The report also contains:

- **`Dim_Date`** — Calendar table used for Year, Quarter and Month filtering.
- **`Project_measures`** — Dedicated table used to organize DAX measures.

### Dashboard Filtering

Both main dashboard pages provide the following slicers:

- Year
- Quarter
- Month
- Segment
- Country

The date slicers provide period context for transaction and revenue analysis. The RFM scores and 90-day inactivity flag remain based on the fixed **10 December 2011** snapshot; they are not recalculated as separate historical RFM or churn snapshots for each month or quarter.

Because customer-level RFM attributes are attached to transaction rows, customer counts and RFM averages must be calculated at the distinct-customer level rather than treating every repeated transaction row as a separate customer.

### SQL-to-Power BI Validation

I added `09_PowerBI_Dashboard_Validation.sql` as a lightweight reconciliation step. It is **read-only** and returns SQL result sets to compare with the corresponding Power BI visuals.

The script checks:

1. Total customers, total revenue, average customer value and the 90-day inactivity rate.
2. Revenue, active customers, inactive customers and inactivity rate by segment.
3. The top five countries by revenue.
4. Revenue and distinct invoice counts by year and quarter.
5. Customer-level RFM averages, segment counts and inactive historical Monetary value.
6. Average Frequency, average Monetary and customer count by segment for the Customer Value Matrix.

I use these outputs as evidence that the Power BI figures reconcile with the SQL Server data. The script does not modify the database or automatically certify a Power BI refresh; the returned values must be compared with the report after the model is refreshed.

---

## 7. Assumptions & Limitations

- **Fixed snapshot:** RFM metrics and `IsChurned` are calculated as of **10 December 2011**. The report does not reconstruct a separate RFM or churn status for every historical month.
- **Rule-based churn:** The 90-day threshold is a defined business rule. It is not a statistically estimated cutoff or a predictive churn model.
- **No churn event date or reason:** The source records purchasing activity, not confirmed cancellation events, reasons for leaving, customer feedback or reactivation history. I can identify inactivity under the defined rule, but I cannot establish why a customer stopped buying.
- **Customer identification:** Rows without a `Customer_ID` cannot be assigned to an individual customer segment and are not included in the final customer-linked Power BI fact table.
- **Non-positive quantities:** Rows with `Quantity <= 0` are excluded from the RFM and integrated sales calculations. This means returns and non-positive quantity records are outside the final revenue analysis.
- **Wholesale and individual buyers:** The source includes a mix of purchasing patterns, including bulk buying. The available fields do not reliably distinguish wholesale buyers from individual shoppers.
- **Historical Monetary value:** Monetary is the sum of eligible historical transaction revenue during the observation period. It is not a forecast, customer lifetime value model or estimate of recoverable churn revenue.
- **Campaign execution:** The project provides segment-level evidence and possible retention priorities. It does not run marketing campaigns or measure campaign lift.

---

## 8. How to Reproduce the Project

### Requirements

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Power BI Desktop
- The two yearly source CSV files included in `Raw Datasets/`

### Run the SQL Pipeline

1. Create the `CustomerAnalytics` database using Script 01.
2. Use **Import Flat File** in SSMS to load the two yearly CSV files into `dbo.[online_retail_2009-2010]` and `dbo.[online_retail_2010-2011]`.
3. Run the row-count checks in Script 01 to confirm that both source tables were imported.
4. Execute Scripts **02 through 08 in numeric order** to consolidate, assess, deduplicate, calculate RFM, assign segments, flag 90-day inactivity and create the integrated transaction table.
5. Run Script 09 and compare its result sets with the matching Power BI cards, charts and tables.

The table-creation scripts use `SELECT ... INTO` for intermediate outputs, so run the pipeline in order on a clean database or remove existing output tables before rebuilding it.

### Open the Power BI Report

1. Open `PowerBI/E-Commerce RFM & Customer Retention Analytics.pbix` in Power BI Desktop.
2. If your SQL Server instance differs from the one used when the report was built, update the source connection to your local SQL Server and the `CustomerAnalytics` database.
3. Refresh the model after the SQL pipeline has completed.
4. Compare the refreshed report with the result sets from Script 09.

---

## 9. Dataset & Source Attribution

I used the **Online Retail II** dataset, which contains transaction-level records for a UK-based online retailer from **1 December 2009 to 9 December 2011**. The original dataset contains **1,067,371 records** and includes invoice identifiers, product codes and descriptions, quantities, invoice dates, unit prices, customer identifiers and country.

The repository includes the two yearly source files:

- `online_retail_2009-2010.csv`
- `online_retail_2010-2011.csv`

**Dataset sources:**

- [UCI Machine Learning Repository — Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii)
- [Dataset DOI — 10.24432/C5CG6D](https://doi.org/10.24432/C5CG6D)
- [Kaggle — Online Retail II UCI](https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci)
- [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

**Dataset citation:** Chen, D. (2012). *Online Retail II* [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5CG6D

---

## Repository Structure

```text
RetailRadar/
│
├── PowerBI/
│   └── E-Commerce RFM & Customer Retention Analytics.pbix
│
├── Raw Datasets/
│   ├── online_retail_2009-2010.csv
│   └── online_retail_2010-2011.csv
│
├── Screenshots/
│   ├── Business_Overview.png
│   └── RFM_Analysis_Customer_Churn.png
│
├── SQL Scripts/
│   ├── 01_DataBase Creation and Table import.sql
│   ├── 02_Data Consolidation and Validation.sql
│   ├── 03_Data Quality Assesment.sql
│   ├── 04_Data Deduplication.sql
│   ├── 05_RFM Calculation.sql
│   ├── 06_RFM Calculation and Custmer Segementation.sql
│   ├── 07_Customer Churn Analysis.sql
│   ├── 08_RFM Integration.sql
│   └── 09_PowerBI_Dashboard_Validation.sql
│
└── README.md
```

---

## Author

**Abhishek Mishra**  
GitHub: [@abnabhi0084](https://github.com/abnabhi0084)

**Project:** RetailRadar — E-Commerce RFM & Customer Retention Analytics  
**Technology Stack:** Microsoft SQL Server · T-SQL · Power BI · DAX

---

*RetailRadar demonstrates how transaction-level data can be transformed into customer segmentation, revenue contribution and retention analysis using SQL Server and Power BI.*
