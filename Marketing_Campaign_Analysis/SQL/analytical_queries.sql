
-- ============================================================
-- Marketing Campaign Analysis - Analytical SQL Queries
-- ============================================================


-- 1. Overall KPIs
SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(SUM(Total_Spend), 2) AS total_spend,
    ROUND(AVG(Total_Spend), 2) AS avg_spend_per_customer,
    ROUND(AVG(Total_Purchases), 2) AS avg_purchases,
    ROUND(AVG(Response) * 100, 2) AS response_rate
FROM marketing_customers;


-- 2. Campaign acceptance rates
SELECT 'AcceptedCmp1' AS campaign, SUM(AcceptedCmp1) AS accepted_customers, ROUND(AVG(AcceptedCmp1) * 100, 2) AS acceptance_rate
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp2', SUM(AcceptedCmp2), ROUND(AVG(AcceptedCmp2) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp3', SUM(AcceptedCmp3), ROUND(AVG(AcceptedCmp3) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp4', SUM(AcceptedCmp4), ROUND(AVG(AcceptedCmp4) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp5', SUM(AcceptedCmp5), ROUND(AVG(AcceptedCmp5) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'Response', SUM(Response), ROUND(AVG(Response) * 100, 2)
FROM marketing_customers;


-- 3. Response by income band
SELECT
    Income_Band,
    COUNT(*) AS customers,
    SUM(Response) AS responders,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY Income_Band
ORDER BY response_rate DESC;


-- 4. Response by age band
SELECT
    Age_Band,
    COUNT(*) AS customers,
    SUM(Response) AS responders,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY Age_Band
ORDER BY response_rate DESC;


-- 5. Response by country
SELECT
    Country,
    COUNT(*) AS customers,
    SUM(Response) AS responders,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY Country
ORDER BY response_rate DESC;


-- 6. Response by education
SELECT
    Education,
    COUNT(*) AS customers,
    SUM(Response) AS responders,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY Education
ORDER BY response_rate DESC;


-- 7. Response by marital status
SELECT
    Marital_Status,
    COUNT(*) AS customers,
    SUM(Response) AS responders,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY Marital_Status
ORDER BY response_rate DESC;


-- 8. Segment KPI summary
SELECT
    'High Income' AS segment_name,
    COUNT(*) AS customers,
    ROUND(AVG(Response) * 100, 2) AS response_rate,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(Total_Purchases), 2) AS avg_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits
FROM marketing_customers
WHERE High_Income = 1

UNION ALL

SELECT
    'Young Customer',
    COUNT(*),
    ROUND(AVG(Response) * 100, 2),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Total_Spend), 2),
    ROUND(AVG(Total_Purchases), 2),
    ROUND(AVG(NumWebVisitsMonth), 2)
FROM marketing_customers
WHERE Young_Customer = 1

UNION ALL

SELECT
    'Campaign Responder',
    COUNT(*),
    ROUND(AVG(Response) * 100, 2),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Total_Spend), 2),
    ROUND(AVG(Total_Purchases), 2),
    ROUND(AVG(NumWebVisitsMonth), 2)
FROM marketing_customers
WHERE Campaign_Responder = 1

UNION ALL

SELECT
    'High Web Engagement',
    COUNT(*),
    ROUND(AVG(Response) * 100, 2),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Total_Spend), 2),
    ROUND(AVG(Total_Purchases), 2),
    ROUND(AVG(NumWebVisitsMonth), 2)
FROM marketing_customers
WHERE High_Web_Engagement = 1

UNION ALL

SELECT
    'Family Customer',
    COUNT(*),
    ROUND(AVG(Response) * 100, 2),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Total_Spend), 2),
    ROUND(AVG(Total_Purchases), 2),
    ROUND(AVG(NumWebVisitsMonth), 2)
FROM marketing_customers
WHERE Family_Customer = 1

UNION ALL

SELECT
    'High Spender',
    COUNT(*),
    ROUND(AVG(Response) * 100, 2),
    ROUND(AVG(Income), 2),
    ROUND(AVG(Total_Spend), 2),
    ROUND(AVG(Total_Purchases), 2),
    ROUND(AVG(NumWebVisitsMonth), 2)
FROM marketing_customers
WHERE High_Spender = 1;


-- 9. Product spend by demographic group
SELECT
    Age_Band,
    Income_Band,
    ROUND(AVG(MntWines), 2) AS avg_wines,
    ROUND(AVG(MntFruits), 2) AS avg_fruits,
    ROUND(AVG(MntMeatProducts), 2) AS avg_meat,
    ROUND(AVG(MntFishProducts), 2) AS avg_fish,
    ROUND(AVG(MntSweetProducts), 2) AS avg_sweets,
    ROUND(AVG(MntGoldProds), 2) AS avg_gold,
    ROUND(AVG(Total_Spend), 2) AS avg_total_spend
FROM marketing_customers
GROUP BY Age_Band, Income_Band
ORDER BY avg_total_spend DESC;


-- 10. Channel usage by high spender
SELECT
    High_Spender,
    COUNT(*) AS customers,
    ROUND(AVG(NumDealsPurchases), 2) AS avg_deals_purchases,
    ROUND(AVG(NumWebPurchases), 2) AS avg_web_purchases,
    ROUND(AVG(NumCatalogPurchases), 2) AS avg_catalog_purchases,
    ROUND(AVG(NumStorePurchases), 2) AS avg_store_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY High_Spender
ORDER BY High_Spender DESC;


-- 11. Channel usage by high-value customer
SELECT
    High_Value_Customer,
    COUNT(*) AS customers,
    ROUND(AVG(NumDealsPurchases), 2) AS avg_deals_purchases,
    ROUND(AVG(NumWebPurchases), 2) AS avg_web_purchases,
    ROUND(AVG(NumCatalogPurchases), 2) AS avg_catalog_purchases,
    ROUND(AVG(NumStorePurchases), 2) AS avg_store_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY High_Value_Customer
ORDER BY High_Value_Customer DESC;


-- 12. Underserved customer summary
SELECT
    COUNT(*) AS underserved_customers,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits,
    ROUND(AVG(Response) * 100, 2) AS response_rate
FROM marketing_customers
WHERE Underserved_Customer = 1;


-- 13. Ideal target customer profile
SELECT
    Age_Band,
    Income_Band,
    Education,
    Marital_Status,
    Country,
    COUNT(*) AS customers,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(Total_Purchases), 2) AS avg_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits
FROM marketing_customers
WHERE High_Spender = 1
  AND Response = 1
GROUP BY Age_Band, Income_Band, Education, Marital_Status, Country
ORDER BY customers DESC, avg_spend DESC;


-- 14. Window function ranking query
SELECT
    Country,
    customers,
    response_rate,
    RANK() OVER (ORDER BY response_rate DESC) AS response_rank
FROM (
    SELECT
        Country,
        COUNT(*) AS customers,
        ROUND(AVG(Response) * 100, 2) AS response_rate
    FROM marketing_customers
    GROUP BY Country
) country_response;


-- ============================================================
-- Dashboard Views
-- ============================================================


-- View 1: Overall dashboard KPIs
CREATE OR REPLACE VIEW vw_customer_kpis AS
SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(SUM(Total_Spend), 2) AS total_spend,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(Response) * 100, 2) AS response_rate
FROM marketing_customers;


-- View 2: Campaign performance
CREATE OR REPLACE VIEW vw_campaign_performance AS
SELECT 'AcceptedCmp1' AS campaign, SUM(AcceptedCmp1) AS accepted_customers, ROUND(AVG(AcceptedCmp1) * 100, 2) AS acceptance_rate
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp2', SUM(AcceptedCmp2), ROUND(AVG(AcceptedCmp2) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp3', SUM(AcceptedCmp3), ROUND(AVG(AcceptedCmp3) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp4', SUM(AcceptedCmp4), ROUND(AVG(AcceptedCmp4) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'AcceptedCmp5', SUM(AcceptedCmp5), ROUND(AVG(AcceptedCmp5) * 100, 2)
FROM marketing_customers
UNION ALL
SELECT 'Response', SUM(Response), ROUND(AVG(Response) * 100, 2)
FROM marketing_customers;


-- View 3: Product spend by demographics
CREATE OR REPLACE VIEW vw_product_spend_demographics AS
SELECT
    Age_Band,
    Income_Band,
    Education,
    Marital_Status,
    Country,
    ROUND(AVG(MntWines), 2) AS avg_wines,
    ROUND(AVG(MntFruits), 2) AS avg_fruits,
    ROUND(AVG(MntMeatProducts), 2) AS avg_meat,
    ROUND(AVG(MntFishProducts), 2) AS avg_fish,
    ROUND(AVG(MntSweetProducts), 2) AS avg_sweets,
    ROUND(AVG(MntGoldProds), 2) AS avg_gold,
    ROUND(AVG(Total_Spend), 2) AS avg_total_spend
FROM marketing_customers
GROUP BY Age_Band, Income_Band, Education, Marital_Status, Country;


-- View 4: Channel usage by high spender
CREATE OR REPLACE VIEW vw_channel_usage_high_spender AS
SELECT
    High_Spender,
    COUNT(*) AS customers,
    ROUND(AVG(NumDealsPurchases), 2) AS avg_deals_purchases,
    ROUND(AVG(NumWebPurchases), 2) AS avg_web_purchases,
    ROUND(AVG(NumCatalogPurchases), 2) AS avg_catalog_purchases,
    ROUND(AVG(NumStorePurchases), 2) AS avg_store_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits,
    ROUND(AVG(Total_Spend), 2) AS avg_spend
FROM marketing_customers
GROUP BY High_Spender;


-- View 5: Underserved customers
CREATE OR REPLACE VIEW vw_underserved_customers AS
SELECT
    ID,
    Age,
    Education,
    Marital_Status,
    Income,
    Country,
    Total_Spend,
    NumWebVisitsMonth,
    Response
FROM marketing_customers
WHERE Underserved_Customer = 1;


-- View 6: Ideal target profile
CREATE OR REPLACE VIEW vw_ideal_target_profile AS
SELECT
    Age_Band,
    Income_Band,
    Education,
    Marital_Status,
    Country,
    COUNT(*) AS customers,
    ROUND(AVG(Income), 2) AS avg_income,
    ROUND(AVG(Total_Spend), 2) AS avg_spend,
    ROUND(AVG(Total_Purchases), 2) AS avg_purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS avg_web_visits
FROM marketing_customers
WHERE High_Spender = 1
  AND Response = 1
GROUP BY Age_Band, Income_Band, Education, Marital_Status, Country;
