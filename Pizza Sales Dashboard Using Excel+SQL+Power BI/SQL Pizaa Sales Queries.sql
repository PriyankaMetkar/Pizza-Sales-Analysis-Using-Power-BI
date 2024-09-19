create database Pizza_db;
use Pizza_db;
select * from Pizza_sales;
# Total Revenue
Select sum(total_price) as Total_Revenue from pizza_sales;

# Average Order Value
Select sum(total_price)/count(distinct order_id) as Avg_Order_Value  from pizza_sales;

#Total Pizzas Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

#Total Orders
select count(distinct order_id) as Total_orders from pizza_sales;

#Average Pizzas per Orders
select cast(cast(sum(quantity)as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizza_per_order from pizza_sales;

#Daily Trend for Total Orders
SELECT DAYNAME(str_to_date(order_date,'%d-%m-%Y')) AS order_day, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales GROUP BY order_day;
-- DAYNAME(order_date) AS order_day: Extracts the name of the day (e.g., Monday, Tuesday) from the order_date column and aliases it as order_day.
-- STR_TO_DATE('18-09-2024', '%d-%m-%Y'): Converts the string '18-09-2024' to a DATE type. The format '%d-%m-%Y' specifies the input date format (day-month-year).

#Monthly Trend for Total Orders
SELECT MONTHNAME(str_to_date(order_date,'%d-%m-%Y')) AS Month_Name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales GROUP BY Month_Name ORDER BY Total_Orders DESC;

#Percentage of sales by pizza Category
SELECT Pizza_category,sum(total_price)as Total_Sales,sum(total_price)*100/ (select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%Y'))=1) as Percentage_of_Total from pizza_sales 
 where month(str_to_date(order_date,'%d-%m-%Y'))=1 group by pizza_category;
 -- month(str_to_date(order_date,'%d-%m-%Y'))=1 –indicates that the ouput is for the month of January.
 -- Suppose month(str_to_date(order_date,'%d-%m-%Y'))=4 indicates output for month of April.
 
 # Percentage of Sales by Pizza Size
 SELECT Pizza_size, Cast(sum(total_price) as decimal(10,2)) as Total_Sales, Cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales  where quarter(str_to_date(order_date,'%d-%m-%Y'))=1    )as decimal(10,2))  as Percentage_of_Total from pizza_sales 
  where quarter(str_to_date(order_date,'%d-%m-%Y'))=1  
  group by pizza_size order by Percentage_of_Total Desc;
  -- Quarter(str_to_date(order_date,'%d-%m-%Y'))=1 –indicates that the ouput is for the Quarter 1.
 
 
 #Top 5 Best Sellers by Revenue
 
 select pizza_name,sum(total_price)  as Total_Revenue from pizza_sales
 group by pizza_name order by  Total_Revenue desc limit 5;
 
 
 #Bottom 5 Best sellers by Revenue
 select pizza_name,sum(total_price)  as Total_Revenue from pizza_sales
 group by pizza_name order by  Total_Revenue  limit 5;
 
 
 #Top 5 Best Sellers by Total Quantity 
 select pizza_name,sum(quantity)  as Total_quantity from pizza_sales
 group by pizza_name order by  Total_quantity desc limit 5;
 
 #Bottom 5 Best sellers by Total Quantity 
 select pizza_name,sum(quantity)  as Total_quantity from pizza_sales
 group by pizza_name order by  Total_quantity  limit 5;
 
 #Top 5 Best Sellers by Total Orders
 select pizza_name,count(distinct order_id)  as Total_orders from pizza_sales
 group by pizza_name order by  Total_orders desc limit 5;
 
 
 #Bottom 5 Best sellers by Total Orders
 select pizza_name,count(distinct order_id)  as Total_orders from pizza_sales
 group by pizza_name order by  Total_orders  limit 5;
 
 
 


