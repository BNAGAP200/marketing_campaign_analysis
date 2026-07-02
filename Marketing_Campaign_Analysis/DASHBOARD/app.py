import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
from pathlib import Path


# --------------------------------------------------
# Page setup
# --------------------------------------------------
st.set_page_config(
    page_title="Marketing Campaign Analysis",
    layout="wide"
)

st.title("Marketing Campaign Analysis Dashboard")
st.write("Customer segmentation, campaign performance, product spending, and channel usage analysis.")


# --------------------------------------------------
# Load data
# --------------------------------------------------
@st.cache_data
def load_data():
    df = pd.read_csv("../data/cleaned_marketing_data.csv")
    return df


df = load_data()


# --------------------------------------------------
# Create missing features if needed
# --------------------------------------------------
spend_cols = [
    "MntWines",
    "MntFruits",
    "MntMeatProducts",
    "MntFishProducts",
    "MntSweetProducts",
    "MntGoldProds"
]

purchase_cols = [
    "NumDealsPurchases",
    "NumWebPurchases",
    "NumCatalogPurchases",
    "NumStorePurchases"
]

if "Age" not in df.columns:
    df["Age"] = 2014 - df["Year_Birth"]

if "Children" not in df.columns:
    df["Children"] = df["Kidhome"] + df["Teenhome"]

if "Total_Spend" not in df.columns:
    df["Total_Spend"] = df[spend_cols].sum(axis=1)

if "Total_Purchases" not in df.columns:
    df["Total_Purchases"] = df[purchase_cols].sum(axis=1)

if "Age_Band" not in df.columns:
    df["Age_Band"] = pd.cut(
        df["Age"],
        bins=[0, 29, 45, 60, 100],
        labels=["Under 30", "30-45", "46-60", "60+"]
    )

if "Income_Band" not in df.columns:
    df["Income_Band"] = pd.cut(
        df["Income"],
        bins=[0, 30000, 60000, 90000, 300000],
        labels=["Low", "Medium", "High", "Very High"]
    )

if "High_Income" not in df.columns:
    df["High_Income"] = (df["Income"] > 75000).astype(int)

if "Young_Customer" not in df.columns:
    df["Young_Customer"] = (df["Age"] < 30).astype(int)

if "Campaign_Responder" not in df.columns:
    df["Campaign_Responder"] = (df["Response"] == 1).astype(int)

if "High_Web_Engagement" not in df.columns:
    df["High_Web_Engagement"] = (df["NumWebVisitsMonth"] > 5).astype(int)

if "Family_Customer" not in df.columns:
    df["Family_Customer"] = (df["Children"] > 0).astype(int)

if "High_Spender" not in df.columns:
    high_spend_limit = df["Total_Spend"].quantile(0.90)
    df["High_Spender"] = (df["Total_Spend"] > high_spend_limit).astype(int)

if "High_Value_Customer" not in df.columns:
    df["High_Value_Customer"] = (
        (df["High_Spender"] == 1) |
        ((df["High_Income"] == 1) & (df["Response"] == 1))
    ).astype(int)

if "Underserved_Customer" not in df.columns:
    low_spend_limit = df["Total_Spend"].median()
    df["Underserved_Customer"] = (
        (df["Total_Spend"] <= low_spend_limit) &
        (df["NumWebVisitsMonth"] > 5) &
        (df["Response"] == 0)
    ).astype(int)


# --------------------------------------------------
# Sidebar filters
# --------------------------------------------------
st.sidebar.header("Filters")

country_filter = st.sidebar.multiselect(
    "Country",
    sorted(df["Country"].dropna().unique()),
    default=sorted(df["Country"].dropna().unique())
)

education_filter = st.sidebar.multiselect(
    "Education",
    sorted(df["Education"].dropna().unique()),
    default=sorted(df["Education"].dropna().unique())
)

marital_filter = st.sidebar.multiselect(
    "Marital Status",
    sorted(df["Marital_Status"].dropna().unique()),
    default=sorted(df["Marital_Status"].dropna().unique())
)

age_filter = st.sidebar.multiselect(
    "Age Band",
    sorted(df["Age_Band"].dropna().astype(str).unique()),
    default=sorted(df["Age_Band"].dropna().astype(str).unique())
)

income_filter = st.sidebar.multiselect(
    "Income Band",
    sorted(df["Income_Band"].dropna().astype(str).unique()),
    default=sorted(df["Income_Band"].dropna().astype(str).unique())
)


filtered_df = df[
    (df["Country"].isin(country_filter)) &
    (df["Education"].isin(education_filter)) &
    (df["Marital_Status"].isin(marital_filter)) &
    (df["Age_Band"].astype(str).isin(age_filter)) &
    (df["Income_Band"].astype(str).isin(income_filter))
]


# --------------------------------------------------
# KPI cards
# --------------------------------------------------
st.subheader("Overall KPIs")

total_customers = len(filtered_df)
total_spend = filtered_df["Total_Spend"].sum()
avg_income = filtered_df["Income"].mean()
avg_spend = filtered_df["Total_Spend"].mean()
response_rate = filtered_df["Response"].mean() * 100

col1, col2, col3, col4, col5 = st.columns(5)

col1.metric("Total Customers", f"{total_customers:,}")
col2.metric("Total Spend", f"{total_spend:,.0f}")
col3.metric("Average Income", f"{avg_income:,.0f}")
col4.metric("Average Spend", f"{avg_spend:,.0f}")
col5.metric("Response Rate", f"{response_rate:.2f}%")


# --------------------------------------------------
# Campaign performance
# --------------------------------------------------
st.subheader("Campaign Performance")

campaign_cols = [
    "AcceptedCmp1",
    "AcceptedCmp2",
    "AcceptedCmp3",
    "AcceptedCmp4",
    "AcceptedCmp5",
    "Response"
]

campaign_data = []

for col in campaign_cols:
    campaign_data.append({
        "Campaign": col,
        "Accepted Customers": filtered_df[col].sum(),
        "Acceptance Rate": filtered_df[col].mean() * 100
    })

campaign_df = pd.DataFrame(campaign_data)

fig_campaign = px.bar(
    campaign_df,
    x="Campaign",
    y="Acceptance Rate",
    text="Acceptance Rate",
    title="Campaign Acceptance Rate"
)

fig_campaign.update_traces(texttemplate="%{text:.2f}%", textposition="outside")
st.plotly_chart(fig_campaign, use_container_width=True)


# --------------------------------------------------
# Segment performance
# --------------------------------------------------
st.subheader("Customer Segment Performance")

segments = [
    "High_Income",
    "Young_Customer",
    "Campaign_Responder",
    "High_Web_Engagement",
    "Family_Customer",
    "High_Spender",
    "High_Value_Customer",
    "Underserved_Customer"
]

segment_data = []

for segment in segments:
    temp = filtered_df[filtered_df[segment] == 1]

    if len(temp) > 0:
        segment_data.append({
            "Segment": segment.replace("_", " "),
            "Customers": len(temp),
            "Response Rate": temp["Response"].mean() * 100,
            "Average Spend": temp["Total_Spend"].mean()
        })

segment_df = pd.DataFrame(segment_data)

col1, col2 = st.columns(2)

with col1:
    fig_segment_count = px.bar(
        segment_df,
        x="Segment",
        y="Customers",
        title="Customer Count by Segment"
    )
    st.plotly_chart(fig_segment_count, use_container_width=True)

with col2:
    fig_segment_response = px.bar(
        segment_df,
        x="Segment",
        y="Response Rate",
        title="Response Rate by Segment"
    )
    st.plotly_chart(fig_segment_response, use_container_width=True)


# --------------------------------------------------
# Product spending
# --------------------------------------------------
st.subheader("Product Spending Analysis")

product_data = pd.DataFrame({
    "Product": [
        "Wines",
        "Fruits",
        "Meat",
        "Fish",
        "Sweets",
        "Gold"
    ],
    "Total Spend": [
        filtered_df["MntWines"].sum(),
        filtered_df["MntFruits"].sum(),
        filtered_df["MntMeatProducts"].sum(),
        filtered_df["MntFishProducts"].sum(),
        filtered_df["MntSweetProducts"].sum(),
        filtered_df["MntGoldProds"].sum()
    ],
    "Average Spend": [
        filtered_df["MntWines"].mean(),
        filtered_df["MntFruits"].mean(),
        filtered_df["MntMeatProducts"].mean(),
        filtered_df["MntFishProducts"].mean(),
        filtered_df["MntSweetProducts"].mean(),
        filtered_df["MntGoldProds"].mean()
    ]
})

col1, col2 = st.columns(2)

with col1:
    fig_product_total = px.bar(
        product_data,
        x="Product",
        y="Total Spend",
        title="Total Spend by Product"
    )
    st.plotly_chart(fig_product_total, use_container_width=True)

with col2:
    fig_product_avg = px.bar(
        product_data,
        x="Product",
        y="Average Spend",
        title="Average Spend by Product"
    )
    st.plotly_chart(fig_product_avg, use_container_width=True)


# --------------------------------------------------
# Channel usage
# --------------------------------------------------
st.subheader("Channel Usage Analysis")

channel_data = pd.DataFrame({
    "Channel": [
        "Deals Purchases",
        "Web Purchases",
        "Catalog Purchases",
        "Store Purchases",
        "Web Visits"
    ],
    "Average": [
        filtered_df["NumDealsPurchases"].mean(),
        filtered_df["NumWebPurchases"].mean(),
        filtered_df["NumCatalogPurchases"].mean(),
        filtered_df["NumStorePurchases"].mean(),
        filtered_df["NumWebVisitsMonth"].mean()
    ]
})

fig_channel = px.bar(
    channel_data,
    x="Channel",
    y="Average",
    title="Average Channel Usage"
)

st.plotly_chart(fig_channel, use_container_width=True)


# --------------------------------------------------
# Response analysis by groups
# --------------------------------------------------
st.subheader("Response Analysis by Customer Groups")

col1, col2 = st.columns(2)

with col1:
    response_income = filtered_df.groupby("Income_Band", observed=False)["Response"].mean().reset_index()
    response_income["Response Rate"] = response_income["Response"] * 100

    fig_income = px.bar(
        response_income,
        x="Income_Band",
        y="Response Rate",
        title="Response Rate by Income Band"
    )
    st.plotly_chart(fig_income, use_container_width=True)

with col2:
    response_age = filtered_df.groupby("Age_Band", observed=False)["Response"].mean().reset_index()
    response_age["Response Rate"] = response_age["Response"] * 100

    fig_age = px.bar(
        response_age,
        x="Age_Band",
        y="Response Rate",
        title="Response Rate by Age Band"
    )
    st.plotly_chart(fig_age, use_container_width=True)


response_country = filtered_df.groupby("Country")["Response"].mean().reset_index()
response_country["Response Rate"] = response_country["Response"] * 100
response_country = response_country.sort_values("Response Rate", ascending=False)

fig_country = px.bar(
    response_country,
    x="Country",
    y="Response Rate",
    title="Response Rate by Country"
)

st.plotly_chart(fig_country, use_container_width=True)


# --------------------------------------------------
# High-value and underserved customers
# --------------------------------------------------
st.subheader("High-Value and Underserved Customer Summary")

high_value_count = filtered_df["High_Value_Customer"].sum()
underserved_count = filtered_df["Underserved_Customer"].sum()

col1, col2 = st.columns(2)

col1.metric("High-Value Customers", f"{high_value_count:,}")
col2.metric("Underserved Customers", f"{underserved_count:,}")


# --------------------------------------------------
# Data preview
# --------------------------------------------------
st.subheader("Filtered Data Preview")

st.dataframe(filtered_df.head(100))

csv_data = filtered_df.to_csv(index=False).encode("utf-8")

st.download_button(
    label="Download Filtered Data",
    data=csv_data,
    file_name="filtered_marketing_data.csv",
    mime="text/csv"
)