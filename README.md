# 📊 End-to-End Sales & Profit Analysis with SQL & Power BI

## 🔹 Overview
This is an **end-to-end data analytics project** that takes raw sales data through the full analytics lifecycle — from **SQL-based data cleaning and exploration** to an **interactive Power BI dashboard**.  
The aim is to uncover trends, patterns, and insights to drive better business decisions.

---

## 🛠 Tech Stack
- **SQL (MySQL 8.0)** – Data cleaning, transformation, and exploratory analysis  
- **Power BI** – Interactive visualizations and dashboards  
- **DAX** – Calculated columns and measures for KPIs  
- **Excel** – Data export and quick checks  

---

## 📌 Project Workflow
1. **Data Preparation in SQL**
   - Imported raw sales data into MySQL  
   - Removed duplicates and standardized values  
   - Created calculated columns like Profit Margin, Sales Category, etc.  

2. **Exploratory Data Analysis (EDA)**
   - Aggregated sales and profit by category, region, and customer segment  
   - Identified seasonal trends and high/low-performing products  
   - Used SQL GROUP BY, CTEs, and window functions for deeper analysis  

3. **Data Modeling in Power BI**
   - Designed star schema with fact and dimension tables  
   - Created a Date table for time intelligence  
   - Wrote DAX measures for KPIs (YTD Sales, Profit %, Growth Rate)  

4. **Dashboard Creation**
   - **Sales Overview:** Total Sales, Profit, Orders trend  
   - **Category Performance:** Contribution to revenue and profit  
   - **Regional Insights:** Map visualization for geographic performance  
   - **Customer Segmentation:** Analysis by segments and loyalty  

---

## 💡 Key Insights
- **High Margin Category:** Technology contributed ~35% of total profit despite lower sales volume.  
- **Seasonality:** Sales spike during Q4, suggesting targeted seasonal marketing could boost profits.  
- **Customer Concentration:** Top 20% of customers account for over 60% of total revenue.  

---

## 📷 Dashboard Preview
*(Add your screenshots here)*  
Example:  
![Dashboard Overview](images/dashboard_overview.png)  
![Category Performance](images/category_performance.png)  

---

## 🚀 How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/super-samplestore-powerbi-sql.git
