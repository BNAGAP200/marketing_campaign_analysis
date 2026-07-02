# Marketing Campaign Analysis

## Project Overview

This project analyzes customer-level marketing campaign data for a retail company. The goal is to understand customer behavior, campaign response patterns, product spending, purchase channel usage, and customer segments.

The project uses Python for data cleaning, feature engineering, exploratory data analysis, and segmentation. SQL is used for table creation, data loading, KPI queries, and dashboard-supporting analytical views. Streamlit is used to build an interactive dashboard.

## Business Objective

The main objective is to help the business answer these questions:

1. Which customer segments have the highest campaign response rate?
2. Which customers are high-value customers?
3. How does spending differ across product categories?
4. Which purchase channels are used most by customers?
5. Which customers are underserved?
6. What type of customer should be targeted in future campaigns?

## Folder Structure

```text
Marketing_Campaign_Analysis/
│
├── data/
│   ├── marketing_campaign_data.csv
│   ├── marketing_data_dictionary.csv
│   └── cleaned_marketing_data.csv
│
├── notebooks/
│   └── marketing_campaign_analysis.ipynb
│
├── sql/
│   ├── create_tables.sql
│   ├── load_data.sql
│   └── analytical_queries.sql
│
├── dashboard/
│   ├── app.py
│   └── requirements.txt
│
├── outputs/
│   └── day2/
│
├── reports/
│   └── marketing_campaign_analysis_report.pdf
│
└── README.md
```

## Dataset Details

The dataset contains customer-level marketing information.

Main column groups:

| Category | Columns |
|---|---|
| Customer details | ID |
| Demographics | Year_Birth, Education, Marital_Status, Income, Country |
| Family details | Kidhome, Teenhome |
| Customer relationship | Dt_Customer, Recency |
| Product spending | MntWines, MntFruits, MntMeatProducts, MntFishProducts, MntSweetProducts, MntGoldProds |
| Purchase channels | NumDealsPurchases, NumWebPurchases, NumCatalogPurchases, NumStorePurchases, NumWebVisitsMonth |
| Campaign response | AcceptedCmp1, AcceptedCmp2, AcceptedCmp3, AcceptedCmp4, AcceptedCmp5, Response |
| Complaint | Complain |

## Tools and Technologies Used

- Python
- Pandas
- NumPy
- SQL
- Streamlit
- Plotly
- Jupyter Notebook



The Python notebook includes:

1. Data loading
2. Data understanding
3. Missing value check
4. Duplicate check
5. Data type correction
6. Date conversion
7. Feature engineering
8. Exploratory data analysis
9. Rule-based customer segmentation
10. Exporting cleaned data


The following new features were created:

| Feature | Description |
|---|---|
| Age | Customer age calculated from Year_Birth |
| Customer_Tenure_Days | Number of days since customer joined |
| Children | Kidhome + Teenhome |
| Total_Spend | Total product spending |
| Total_Purchases | Total purchases across channels |
| Age_Band | Customer age group |
| Income_Band | Customer income group |

## Customer Segmentation Rules

| Segment | Rule |
|---|---|
| High Income | Income greater than 75,000 |
| Young Customer | Age less than 30 |
| Campaign Responder | Response equals 1 |
| High Web Engagement | NumWebVisitsMonth greater than 5 |
| Family Customer | Children greater than 0 |
| High Spender | Total_Spend greater than 90th percentile |
| High Value Customer | High spender OR high income customer with campaign response |
| Underserved Customer | Low spend, high web visits, and no campaign response |

## SQL Work Completed

The SQL folder contains three files:

### 1. create_tables.sql

This file creates the main SQL table:

```text
marketing_customers
```

### 2. load_data.sql

This file loads the cleaned CSV data into the SQL table.

### 3. analytical_queries.sql

This file contains business analysis queries, including:

1. Overall KPIs
2. Campaign acceptance rates
3. Segment KPI summary
4. Product spend by demographic group
5. Channel usage by high spender
6. Channel usage by high-value customer
7. Underserved customer summary
8. Ideal target customer profile
9. Window function ranking query
10. Dashboard views

## Dashboard

The dashboard was created using Streamlit.

Dashboard file:

```text
dashboard/app.py
```

Required packages are listed in:

```text
dashboard/requirements.txt
```

## Dashboard Features

The dashboard includes:

1. KPI cards
2. Country filter
3. Education filter
4. Marital status filter
5. Age band filter
6. Income band filter
7. Campaign performance chart
8. Segment performance chart
9. Product spending chart
10. Channel usage chart
11. Response analysis by income band
12. Response analysis by age band
13. Response analysis by country
14. High-value customer count
15. Underserved customer count
16. Filtered data preview

## How to Run the Project

### Step 1: Open the project folder

```bash
cd Marketing_Campaign_Analysis
```

### Step 2: Run the notebook

Open the notebook:

```text
notebooks/marketing_campaign_analysis.ipynb
```

Run all cells from top to bottom.

This will create or update:

```text
data/cleaned_marketing_data.csv
outputs/day2/
sql/
```

### Step 3: Run the dashboard

Go to the dashboard folder:

```bash
cd dashboard
```

Install required packages:

```bash
python -m pip install -r requirements.txt
```

Run the Streamlit app:

```bash
python -m streamlit run app.py
```

The dashboard will open in the browser. Usually the local URL will be:

```text
http://localhost:8501
```

## Key Outputs

| Output | Location |
|---|---|
| Cleaned dataset | data/cleaned_marketing_data.csv |
| Python notebook | notebooks/marketing_campaign_analysis.ipynb |
| SQL scripts | sql/ |
| Dashboard app | dashboard/app.py |
| Dashboard requirements | dashboard/requirements.txt |
| Analysis outputs | outputs/day2/ |
| Final report | reports/marketing_campaign_analysis_report.pdf |

## Business Insights

1. High spender customers are commercially important because they contribute higher average spending.
2. High income customers are useful for premium campaign targeting.
3. Campaign responders can be used as a base group for future remarketing.
4. High web engagement customers should be targeted through digital channels.
5. Underserved customers require separate campaign treatment because they visit frequently but show low response.
6. Product spending varies by customer group, so future campaigns should be product-specific.

## Recommendations

1. Target high spender customers with premium product bundles.
2. Focus high income customers for campaigns with higher-value offers.
3. Use past campaign responders for remarketing campaigns.
4. Use web-based promotions for high web engagement customers.
5. Create trial offers or discount campaigns for underserved customers.
6. Use age band, income band, and country filters to design more specific campaign strategies.

## Final Submission Checklist

Before submitting, confirm that these files are available:

```text
[ ] data/marketing_campaign_data.csv
[ ] data/marketing_data_dictionary.csv
[ ] data/cleaned_marketing_data.csv
[ ] notebooks/marketing_campaign_analysis.ipynb
[ ] sql/create_tables.sql
[ ] sql/load_data.sql
[ ] sql/analytical_queries.sql
[ ] dashboard/app.py
[ ] dashboard/requirements.txt
[ ] reports/marketing_campaign_analysis_report.pdf
[ ] README.md
```

## Conclusion

This project provides a complete marketing analytics solution using Python, SQL, and Streamlit. It helps identify valuable customers, understand campaign performance, study product spending, analyze channel usage, and recommend better future campaign strategies.