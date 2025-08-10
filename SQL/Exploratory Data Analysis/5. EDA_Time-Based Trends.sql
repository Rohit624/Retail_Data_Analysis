----------------------------- Time-Based Trends -----------------------------

-- Q1: What is the monthly sales trend?
with cte as (
select
	month(order_date) as month,
	monthname(order_date) as Month_Name , 
	round(sum(sales),2) as monthly_sales
from f_orders
group by month(order_date),monthname(order_date)
order by month
)
select *,
concat(round(monthly_sales/sum(monthly_sales) over() * 100,2),'%') as percentage_distribution
from cte;


-- Q2: Which months have the highest and lowest sales?
with cte as (
select
	monthname(order_date) as Month_Name , 
	round(sum(sales),2) as Total_sales,
    Dense_rank() over(order by sum(sales) desc) as month_rank
from f_orders
group by monthname(order_date)
)
select 'Highest Sales' as '' , month_name, Total_sales
from cte where  month_rank = 1
	union all
select 'Lowest Sales' , month_name, Total_sales 
from cte where  month_rank = (select max(month_rank) from cte);


-- Q3: What is the yearly trend in profit and sales?
select
	Year(order_date) as Year , 
	round(sum(sales),2) as Total_sales
from f_orders
group by Year(order_date)
order by year ;


-- Q4: What is the average delivery time (ship date - order date)?
select
	'Avg_Delivery_Time'as '',
	round(avg(Delivery_days),2) as day
from(
	select
		datediff(ship_date, order_date) as Delivery_days
	from f_orders) x ;


-- Q5: What is the cumulative sales over each month and moving average of 4 months?
select 
	year(order_date) as year,
    month(order_date) as month_No,
	monthname(order_date) as month_name,
    round(sum(sales),2) as total_sales,
    round(sum(sum(sales)) 
		over(order by year(order_date), month(order_date)),2) as Running_total,
    round(avg(sum(sales)) 
		over(partition by year(order_date) order by year(order_date), month(order_date) rows between 3 preceding and current row),2) as moving_average
from f_orders
group by 
	year(order_date),
    month(order_date),
	monthname(order_date)
order by year(order_date), month(order_date);


-- Q6: What is the year-to-date (YTD) cumulative profit for each product category for current year?
with cte as (
select 
	category,
    year(order_date) as year,
	month(order_date) as month_no,
    monthname(order_date) as month,
    round(sum(profit),2) as total_profit
from f_orders as o
left join d_products as p
	on o.product_key = p.product_key
where year(order_date) = 2017
group by 
	category, 
    year(order_date),
	month(order_date),
    monthname(order_date)
order by category, year(order_date), month(order_date)
)
select
    category,
    year,
    month,
    total_profit,
    round(sum(total_profit) over(partition by category order by year,month_no),2) as cummulative_profit
from cte;


-- Q7: How did total sales and profit in 2017 compare to 2016? What was the year-over-year growth?
with cte as(
	select 
		year(order_date) as year,
		round(sum(sales),2) as total_sales,
		round(sum(profit),2) as total_profit
	from f_orders
	group by year
	order by year
),
cte2 as (
select 
	year,
    total_sales,
    round(total_sales - lag(total_sales) over(),2) as sales_change,
	concat (
    round(
    ( (total_sales - lag(total_sales) over()) / (lag(total_sales) over()) ) * 100
    ,2) , '%')as Sales_percent_change,
	total_profit,
    round(total_profit - lag(total_profit) over(),2) as profit_change,
    concat(
	round(
    ( (total_profit - lag(total_profit) over()) / (lag(total_profit) over()) ) * 100
    ,2) , '%') as profit_percent_change
from cte
)
select 
	year, 
    total_sales, 
    ifnull(sales_change, 0) as sales_change, 
    ifnull(sales_percent_change,'0%') as sales_percent_change,
    total_profit,
    ifnull(profit_change,0) as profit_change,
    ifnull(profit_percent_change , '0%') as profit_percent_change
from cte2
where year = 2017;


