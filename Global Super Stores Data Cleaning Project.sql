--  Name of the Database : global_super_store
USE global_super_store; -- Use the Database with the name of the DB.

-- Create table :
-- Table name : global_superstore
-- By the use of Excel Sheet , Create the respective columns with the suitable datatypes to insert into our table.
CREATE TABLE Global_Superstore (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(255),
    Order_Date VARCHAR(255),
    Ship_Date VARCHAR(255),
    Ship_Mode VARCHAR(255),
    Customer_ID VARCHAR(255),
    Customer_Name VARCHAR(255),
    Segment VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    Country VARCHAR(255),
    Postal_Code VARCHAR(10),
    Market VARCHAR(255),
    Region VARCHAR(255),
    Product_ID VARCHAR(255),
    Category VARCHAR(255),
    Sub_Category VARCHAR(255),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(5, 2),
    Profit DECIMAL(10, 2),
    Shipping_Cost DECIMAL(10, 2),
    Order_Priority VARCHAR(255)
);

-- Query to Load the Data Present in the Excel into the MYSQL Workbench : 
LOAD DATA INFILE 'C:\Users\tssri\Downloads\Global_Superstore2.csv' -- Inside the single quotes , fill your path of the CSV file.
INTO TABLE your_table
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verify wether the Data is imported into our Workbench : 
SELECT * FROM global_superstore;

-- For safety purpose , go with creating a new table LIKE our existing table and clean , manipulate the data from the newly created table.
-- The below query , helps to create a table same like the existing table : 
CREATE TABLE global_superstore2
LIKE global_superstore;

-- Insert the values into the global_superstore2 from the global_superstore table :
-- The below query , helps to insert the values from the existing table : 
INSERT global_superstore2
SELECT *
FROM global_superstore;

-- Verify the newly created table : global_superstore2
SELECT * FROM global_superstore2;

-- Identified Row ID as a unwanted column existing in our dataset . So DROP the column from our Dataset :
ALTER TABLE global_superstore2
DROP COLUMN `Row ID`;

-- Rename the Column Order ID , Order Date , Ship Date , Ship Mode , Customer ID and Customer Name as per our wish :
ALTER TABLE global_superstore2
CHANGE `Order Date` order_date VARCHAR(255),
CHANGE `Ship Date` ship_date VARCHAR(255),
CHANGE `Ship Mode` ship_mode VARCHAR(255),
CHANGE `Customer ID` customer_id VARCHAR(255),
CHANGE `Customer Name` customer_name VARCHAR(255),
CHANGE `Product Name` product_name VARCHAR(255),
CHANGE `Shipping Cost` shipping_cost DECIMAL(10 , 2),
CHANGE `Order Priority` order_priority VARCHAR(255);

-- Update the column order_date to date format :
UPDATE global_superstore2
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

-- Modify the Data Type of the column order_date : 
ALTER TABLE global_superstore2
MODIFY order_date DATE;

-- Same like the order_date , Update the column ship_date to date format :
UPDATE global_superstore2
SET ship_date = STR_TO_DATE(ship_date , "%d-%m-%Y");

-- Modify the Data Type of the column ship_date :
ALTER TABLE global_superstore2
MODIFY ship_date DATE;

-- Updating the column Postal Code as Unknown , wherever there is NULL or Empty Space in Postal Code Column:
UPDATE global_superstore2
SET `Postal Code` = "Unknown"
WHERE `Postal Code` IS NULL OR `Postal Code` = '';

ALTER TABLE global_superstore2
CHANGE `Sub-Category` sub_category TEXT;

-- Standardize Text Data in Categorical Columns
-- Ensure consistency in columns like Segment, Category, Sub_Category, and Order_Priority :
UPDATE global_superstore2
SET Segment = UPPER(Segment),
    Category = UPPER(Category),
    sub_category = UPPER(sub_category),
    order_priority = UPPER(order_priority);

-- Creating a new Column Profit_Status to easily visualise Gain or Loss for a Customer :
ALTER TABLE global_superstore2
ADD COLUMN profit_status VARCHAR(10) AFTER Profit;

-- Update the profit_status column with respective to their profits . Which will be useful in EDA:
UPDATE global_superstore2
SET profit_status = 
CASE
	WHEN profit < 0 THEN "LOSS"
    ELSE "GAIN"
END;

-- Create a new column dis_status to keep tract of Discount Customer :
ALTER TABLE global_superstore2
ADD COLUMN discount_status VARCHAR(100) AFTER Discount;

ALTER TABLE global_superstore2
MODIFY discount_status VARCHAR(100);

UPDATE global_superstore2
SET discount_status = 
CASE 
	WHEN discount = 0  OR discount > 1
    THEN "Not Applicable"
    ELSE "Applied"
END;

-- Remove Duplicate Rows :
DELETE FROM global_superstore2
WHERE Order_ID IN (
    SELECT Order_ID
    FROM (
        SELECT Order_ID, COUNT(*) AS count
        FROM global_superstore2
        GROUP BY order_id
        HAVING count > 1
    ) AS duplicates
);

-- Checking for unreasonable discount percentage . As discount percentage could be negative and could not be more than 100 % :
SELECT *
FROM global_superstore2
WHERE discount < 0  OR discount > 1;

-- Data Exploration
-- To Find the Median of the Sales Table  
WITH OrderedSales AS (
    SELECT 
        Sales,
        ROW_NUMBER() OVER (ORDER BY Sales) AS row_num,
        COUNT(*) OVER () AS total_count
    FROM global_superstore2
)
SELECT AVG(Sales) AS median_sales
FROM OrderedSales
WHERE row_num = (total_count + 1) / 2   -- For odd numbers
   OR row_num = (total_count / 2) + 1;  -- For even numbers

-- Descriptive Statistics :
SELECT 
    AVG(Sales) AS avg_sales,
    MIN(Sales) AS min_sales,
    MAX(Sales) AS max_sales,
    STDDEV(Sales) AS stddev_sales,
    
    AVG(Quantity) AS avg_quantity,
    MIN(Quantity) AS min_quantity,
    MAX(Quantity) AS max_quantity,
    STDDEV(Quantity) AS stddev_quantity,
    
    AVG(Profit) AS avg_profit,
    MIN(Profit) AS min_profit,
    MAX(Profit) AS max_profit,
    STDDEV(Profit) AS stddev_profit,
    
    AVG(shipping_cost) AS avg_shipping_cost,
    MIN(shipping_cost) AS min_shipping_cost,
    MAX(shipping_cost) AS max_shipping_cost,
    STDDEV(shipping_cost) AS stddev_shipping_cost
FROM global_superstore2;

-- Explore orders , ordered by Customers where City and State are same :
WITH CTE AS(
	SELECT *
    FROM global_superstore2
    WHERE City = State
)
SELECT order_id,customer_name,customer_id
FROM CTE;

-- Analyse the dataset based on the ship mode preferred by the customers :
SELECT ship_mode,COUNT(ship_mode)
FROM global_superstore2
GROUP BY ship_mode;

-- Customer Analysis by Segment :
SELECT Segment,
	   Total_Count,
       SUM(Total_Count) OVER(ORDER BY Segment) AS Rolling_Total_Count
FROM(
	SELECT Segment , 
	   COUNT(Segment) AS Total_Count, 
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
	FROM global_superstore2
	GROUP BY Segment
) AS subquery;

-- Region and Country Trends which is verified by the Rolling_Total and for the reference it is Rounded to two decimal :
SELECT Country ,
		Region , 
        ROUND(Total_Sales,2) AS Total_Sales,
        ROUND(Total_Profit,2) AS Total_Profit, 
	    ROUND(SUM(Total_Sales) OVER(PARTITION BY Country  ORDER BY Region),2) AS Country_Sales
FROM (
	SELECT Country ,
		   Region , 
           SUM(Sales) AS Total_Sales , 
		   SUM(Profit) AS Total_Profit
	FROM global_superstore2
	GROUP BY Country , Region
	ORDER BY Country , Region , Total_Sales DESC
) AS subquery;

-- Top Selling Product . Identify the most popular products by total sales :
SELECT product_name , 
       ROUND(SUM(Sales) , 2) AS Total_Sales
FROM global_superstore2
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Time Series Analysis . Calculate the Monthly Sales and Monthy Profit for each month from the year 2011 to 2014 :
SELECT DATE_FORMAT(order_date , "%Y-%m") AS Monthly_Year , 
	   ROUND(SUM(Sales) , 2) AS Monthly_sales , 
       ROUND(SUM(Profit) , 2) AS Monthly_Profit
FROM global_superstore2
GROUP BY Monthly_Year
ORDER BY Monthly_Year;

-- Query to retrieve the highest profit in a Year :
WITH CTE AS(
	SELECT DATE_FORMAT(order_date,"%Y-%m") AS Monthly_Year,
		   ROUND(SUM(Sales),2) AS Monthly_Sales,
           ROUND(SUM(Profit),2) AS Monthly_Profit,
           YEAR(order_date) AS YEAR
    FROM global_superstore2
    GROUP BY YEAR(order_date),Monthly_Year
    ORDER BY Monthly_Year
)
SELECT Monthly_Year,
		Monthly_Sales,
        Monthly_Profit
FROM(
	SELECT Monthly_Year,
    Monthly_Sales,
    Monthly_Profit,
    ROW_NUMBER() OVER(PARTITION BY YEAR ORDER BY Monthly_Profit DESC) AS rn
    FROM CTE
) AS Ranking
WHERE rn = 1;

-- Calculate the Number of Orders in a month in their respective year : 
SELECT DATE_FORMAT(order_date,"%Y-%m") AS Monthly_Year,
	   COUNT(order_id) AS total_orders
FROM global_superstore2
GROUP BY Monthly_Year
ORDER BY Monthly_Year;

-- Calculate the Number of Orders in a year :
SELECT YEAR(order_date) AS YEAR,
	   count(order_id) AS total_orders
FROM global_superstore2
GROUP BY YEAR(order_date)
ORDER BY YEAR;
        
SELECT * FROM global_superstore2;
SELECT DISTINCT ship_mode
FROM global_superstore2;

-- Shipping Mode Analysis : 
SELECT ship_mode,
	   COUNT(ship_mode) AS Total_Count,
	   ROUND(AVG(shipping_cost),2) AS Average_Shipping_cost
FROM global_superstore2
GROUP BY ship_mode
ORDER BY ship_mode;

-- Delivery Time Patterns :
SELECT order_id , 
	   order_date,
       ship_date,
       ship_mode,
       DATEDIFF(ship_date , order_date) AS Days_Taken
FROM global_superstore2;



