🌍 Global Superstore Data Analysis Project

📊 Project Overview

This project involves cleaning, exploring, and visualizing the **Global Superstore** dataset using **SQL** and **Power BI** to uncover actionable business insights. The dataset spans sales, customer segments, regional data, and logistics, providing a comprehensive view of store performance, customer behavior, and profitability trends.

📂 Project Structure

global-superstore-project/
│
├── data/
│   ├── raw_data.xlsx              # Original unprocessed dataset
│   └── cleaned_data.sql           # Cleaned version imported into MySQL
│
├── scripts/
│   └── queries.sql                # SQL scripts for data cleaning and analysis
│
├── dashboard/
│   └── global_superstore_dashboard.pbix  # Power BI dashboard file
│
└── README.md                      # Project documentation (this file)

🧽 Data Cleaning Process

Performed in **MySQL Workbench**, the data cleaning steps ensured consistency, accuracy, and usability for downstream analysis and visualization.

1. 📅 Date Formatting

   * Reformatted `Order Date` and `Ship Date` to the SQL `DATE` type for proper chronological analysis.

2. 🏷️ Standardized Column Naming

   * Renamed columns to follow consistent naming conventions (e.g., `order_id`, `customer_segment`, etc.).

3. 🚫 Missing Value Handling

   * Replaced null or blank values in `Postal Code` with `'Unknown'`.

4. 🔁 Duplicate Detection

   * Removed duplicate rows based on `Order_ID` to ensure data uniqueness.

5. 📈 Profit and Discount Categorization

   * Added derived columns like `profit_status` (e.g., `Profitable`, `Loss`) and `discount_status` to analyze pricing effectiveness.


🔍 Data Exploration Highlights

📌 Descriptive Analysis

* **Average Sales** across all orders
* **Standard Deviation** for sales, profit, quantity, and shipping cost
* **Top Products** by sales volume and profitability

🌍 Regional Insights

* **Country & Region Performance:** Sales and profit comparison across different geographies
* **Shipping Mode Analysis:** Popular shipping methods and their associated costs and timelines

📈 Time Series Analysis

* **Monthly Sales & Profit Trends:** Spanning 2011 to 2014
* **Peak Seasons:** Identification of months/years with maximum profitability

📊 Power BI Dashboard

A dynamic **Power BI dashboard** was created to bring data insights to life. Key visuals include:

* Regional Sales and Profit Map
* Top Products by Revenue
* Monthly Trends (Sales, Profit, Orders)
* Discount vs Profitability Analysis
* Customer Segment Performance

📁 **File:** `/dashboard/global_superstore_dashboard.pbix`

> ✅ The dashboard enhances decision-making by providing interactive, visual storytelling of core KPIs and trends.

⚙️ Technologies Used

* **📄 Excel** – Initial data preparation
* **🛠️ MySQL Workbench** – Data cleaning and SQL analysis
* **📊 Power BI** – Dashboard creation and visualization

📥 Repository Contents Summary

| Path                  | Description                          |
| --------------------- | ------------------------------------ |
| `data/`               | Raw and cleaned datasets             |
| `scripts/queries.sql` | SQL cleaning and exploration scripts |
| `dashboard/`          | Power BI dashboard file              |
| `README.md`           | Project overview and documentation   |


📝 Lessons Learned

This project strengthened skills in:

* SQL-based data cleaning and transformation
* Writing efficient queries for business insights
* Time-series and regional trend analysis
* Designing effective visual dashboards in Power BI

It reinforced the importance of clean, consistent data and the value of combining SQL and BI tools for comprehensive business analytics.


