# 🎮 Video Game Sales SQL Analysis

This project is an exploratory analysis of video game sales data using SQL. The dataset contains historical sales data from various platforms and regions, sourced from [Kaggle](https://www.kaggle.com/datasets/zahidmughal2343/video-games-sale).

## 📌 Objective

Analyze global video game sales to identify:
- Best-selling games by year
- Genre and platform preferences by region
- Top publishers and their reach
- Regional consumption trends over time

## 🧹 Data Cleaning

Steps included:
- Creating a staging table to preserve the original data
- Removing duplicates
- Standardizing publisher names (e.g. "Sony" variations)
- Checking for missing or null values

All queries are documented in `cleaning.sql`.

## 📊 Exploratory Data Analysis (EDA)

Topics covered:
- Global sales by platform and genre
- Favorite genres by region
- Regional sales trends over the years
- Top publishers globally


## 📈 Example Insights

- **Action** is the most popular genre in NA and EU.
- **Japan** has a strong preference for **Role-Playing** games.
- The **DS** and **PS2** platforms lead in global sales.
- **Nintendo** and **Electronic Arts** are top publishers globally.

## 🔧 Tools Used

- MySQL
- VS Code / DBeaver (SQL Editor)
- Optional: Excel or Power BI for charts

## 📁 Files

- `Data Cleaning.sql` – Data cleaning and preparation queries
- `Exploratory Data Analysis.sql` – Analysis queries
- `vg_sales_clean.csv` – Cleaned version of the dataset
---

