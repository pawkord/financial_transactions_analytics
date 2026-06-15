# Financial Transactions Analytics: Customer Behavior & Profitability

**Domain:** Banking, Financial Services, Business Intelligence  
**Tech Stack:** SQL (MySQL), Python (Pandas)  

## 📌 Project Overview
This project explores customer spending habits and evaluates individual profitability using a comprehensive financial dataset. By processing raw transaction logs, card details, and demographic information into a relational database, the project uncovers behavioral spending patterns, geographical revenue distribution, and customer segments. 

The ultimate goal is to provide data-driven insights that support Customer Analytics, Business Intelligence, and financial planning.

## 📂 Data Source
* **Dataset:** [Financial Transactions Dataset: Analytics](https://www.kaggle.com/datasets/computingvictor/transactions-fraud-datasets)
* **Context:** This dataset combines transaction records, customer information, and card data from a banking institution spanning the 2010s decade. While designed for multiple analytical purposes (including AI fraud detection), this specific project leverages the data for **Customer Analytics** (segmentation, lifetime value) and **Business Intelligence** (market trends, revenue distribution).

## 🛠️ 1. Data Preparation & ETL (Python)
Before SQL analysis, an ETL process was performed using **Python (`pandas`)** to transform the raw data into an analysis-ready format.

* **Data Sampling:** Extracted a 10,000-row subset of transactions for rapid query testing while maintaining relational integrity with the `users` and `cards` tables.
* **Data Cleaning:** Removed financial symbols (`$`, `,`) and converted strings to proper numeric data types.
* **Output:** Cleaned data was exported as CSV files and loaded into a MySQL database schema. *(See `etl_pipeline/credit_cards.ipynb`)*.

---

## 📊 2. SQL Analysis & Business Insights

### 🕒 Time-of-Day Analysis
* **Observation:** Core transaction volume peaks between **08:00 AM and 12:00 PM**. However, the highest Average Order Value (AOV) is recorded at **04:00 AM ($169.57)**.
* **Takeaway:** Routine daily transactions drive morning volume, requiring standard IT infrastructure capacity. The unusually high AOV during off-peak hours (4 AM) indicates either automated B2B scheduled processing or a window of elevated anomaly risk, requiring specific transaction monitoring rules.

### 👥 Customer Income Segmentation
* **Observation:** The customer base consists primarily of the Low-Income tier (<$50k), accounting for **70.25%** of users. The Mid-Income tier accounts for 27.15%, and the High-Income tier ($100k+) represents a niche of **2.60%**.
* **Takeaway:** Product offerings should reflect this distribution: focus on accessible, low-fee daily banking products for the mass market (70%), and develop highly targeted premium rewards programs for the high-income segment (2.6%).

### 📈 Cumulative Revenue Analysis
* **Observation:** Using SQL Window Functions (`SUM() OVER`), the running total of transaction volume shows a steady, consistent daily increase over the sample period without severe drop-offs.
* **Takeaway:** In a production environment, tracking this running total serves as a real-time financial health indicator to quickly identify technical checkout failures or payment gateway issues.

### 🗺️ Geographical Revenue Distribution
* **Observation:** Four states drive **33.28%** of the total transaction volume: California (11.23%), Texas (10.16%), New York (6.33%), and Florida (5.56%).
* **Takeaway:** Regional marketing budgets, merchant partnerships, and sales forecasting should be heavily concentrated in these top-performing markets to maximize ROI.

---

## 👑 3. Customer 360 Profitability View
*(See `sql_scripts/5_customer_profitability_view.sql`)*

A master flat table was created using **CTEs** and **LEFT JOINs** to combine demographic data (`users`), credit risk factors (`cards`), and behavioral metrics (`transactions`). `COALESCE()` was utilized to cleanly handle inactive users with zero transactions.

**Key Findings from Top Spenders:**
* **Strong Purchasing Power in the 50+ Demographic:** The top 5 highest-spending customers in the sample are all over the age of 50. The #1 overall spender (User 96, Age 69) generated **$2,690.02** over just 4 days. This indicates that customer acquisition and premium card marketing efforts should heavily target the senior demographic.
* **High Spend vs. Credit Risk:** The #2 overall spender (User 1168) generated **$2,471.05** in transaction volume and belongs to the 'High Income' tier. However, this user has a high-risk credit score of only **505**. This validates the necessity of a consolidated "Customer 360" view—looking at transaction volume or income alone would obscure the significant default risk this individual poses to the institution.
