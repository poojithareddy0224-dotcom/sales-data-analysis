-- Sales Data Analysis SQL Project
-- Dataset: sales_data.csv
-- Table name assumed: sales_data

-- 1. Total Sales
SELECT ROUND(SUM(Sales), 2) AS total_sales
FROM sales_data;

-- 2. Total Profit
SELECT ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data;

-- 3. Total Orders and Quantity
SELECT
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Quantity) AS total_quantity
FROM sales_data;

-- 4. Profit Margin
SELECT
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percentage
FROM sales_data;

-- 5. Sales by Region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY Region
ORDER BY total_sales DESC;

-- 6. Sales by Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;

-- 7. Top 5 Products by Sales
SELECT
    Product,
    ROUND(SUM(Sales), 2) AS total_sales,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 5;

-- 8. Monthly Sales
SELECT
    EXTRACT(MONTH FROM Order_Date) AS month_number,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY EXTRACT(MONTH FROM Order_Date)
ORDER BY month_number;

-- 9. Customer-wise Sales
SELECT
    Customer,
    COUNT(DISTINCT Order_ID) AS orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY Customer
ORDER BY total_sales DESC;

-- 10. Highest-Value Orders
SELECT
    Order_ID,
    Order_Date,
    Customer,
    Product,
    Region,
    ROUND(Sales, 2) AS sales,
    ROUND(Profit, 2) AS profit
FROM sales_data
ORDER BY Sales DESC
LIMIT 10;

-- 11. Average Order Value
SELECT
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS average_order_value
FROM sales_data;

-- 12. Best Region by Profit
SELECT
    Region,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data
GROUP BY Region
ORDER BY total_profit DESC
LIMIT 1;

-- 13. Best-Selling Category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC
LIMIT 1;

-- 14. Products with Sales Above Average Product Sales
SELECT
    Product,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales_data
GROUP BY Product
HAVING SUM(Sales) > (
    SELECT AVG(product_sales)
    FROM (
        SELECT SUM(Sales) AS product_sales
        FROM sales_data
        GROUP BY Product
    ) AS product_totals
)
ORDER BY total_sales DESC;
