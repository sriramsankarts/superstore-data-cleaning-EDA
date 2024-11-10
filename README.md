🌍 Global Superstore Data Cleaning and Exploration

📊 Project Overview
This project involves cleaning and exploring the Global Superstore dataset using SQL to extract key insights. The dataset covers sales, customer segments, regional data, and more, allowing for in-depth analysis of store performance and customer trends.

---

📂 Project Structure
- Data 
  - **Raw Data:** Unprocessed dataset in Excel format.
  - **Cleaned Data:** Dataset after applying transformations, stored in SQL.
  - **Scripts:** SQL queries used for data cleaning and exploration.

---

🧽 Data Cleaning Steps
To ensure accuracy and consistency, various cleaning steps were applied to remove errors, normalize data, and handle missing values.

1. **📅 Date Formatting**  
   - Reformatted `Order Date` and `Ship Date` to SQL `DATE` type for better handling in analyses.
2. **🏷️ Column Renaming**  
   - Standardized column names for clarity and consistency.
3. **🚫 Missing Data Handling**  
   - Replaced `NULL` and blank `Postal Code` entries with "Unknown."
4. **✂️ Duplicate Removal**  
   - Identified and removed duplicate `Order_ID` entries.
5. **📈 Profit and Discount Analysis**  
   - Created `profit_status` and `discount_status` columns to track profit trends and discount application.

---

🔍 Data Exploration
After cleaning, the data was explored to uncover key insights about the business and customers.

🏆 Descriptive Statistics
   - **Average Sales:** Calculate average sales across all orders.
   - **Standard Deviation:** Determine variability for sales, quantity, profit, and shipping costs.
   - **Top Products:** Identify the best-selling products based on total sales.

🌎 Regional Insights
   - **Country and Region Trends:** Track sales and profit by country and region.
   - **Shipping Mode Analysis:** Examine preferred shipping methods and associated costs.

📈 Time Series Analysis
   - **Monthly Sales and Profit:** Analyze monthly performance from 2011 to 2014.
   - **High-Profit Periods:** Identify peak months and years for profit.

---

📌 Key Queries

Below are some core SQL queries used in the project:

Top 10 Products by Sales:**
   ```sql
   SELECT product_name, ROUND(SUM(Sales), 2) AS Total_Sales
   FROM global_superstore2
   GROUP BY product_name
   ORDER BY Total_Sales DESC
   LIMIT 10;
   ```

Monthly Sales and Profit Trends:**
   ```sql
   SELECT DATE_FORMAT(order_date , "%Y-%m") AS Monthly_Year, 
          ROUND(SUM(Sales), 2) AS Monthly_sales, 
          ROUND(SUM(Profit), 2) AS Monthly_Profit
   FROM global_superstore2
   GROUP BY Monthly_Year
   ORDER BY Monthly_Year;
   ```

---

⚙️ Technologies Used
- **📄 Excel** for initial data input and formatting
- **🛠️ MySQL Workbench** for data cleaning, transformations, and exploration

---

📥 Repository Contents
- `data/`: Contains both the raw and cleaned datasets.
- `queries.sql`: All SQL scripts used for data cleaning and exploration.
- `README.md`: Project documentation and details (this file).

---

📝 Lessons Learned
This project provided hands-on experience with SQL for data cleaning and analysis, improving skills in data manipulation, trend identification, and understanding large datasets. It highlighted the importance of data quality and consistency for meaningful insights.
