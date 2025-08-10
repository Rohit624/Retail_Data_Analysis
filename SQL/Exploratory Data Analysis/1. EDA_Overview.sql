
----------------------------- General Overview -----------------------------

-- Q1: What is the total sales, total profit, and total quantity sold?
select 
	round(sum(sales),2) as total_sales, 
    sum(profit) as total_profit, 
    sum(quantity) as total_quantity
from f_orders;

-- Q2: What is the overall profit margin?
select 
	round( sum(profit)/ sum(sales)* 100, 2) as profit_margin 
from f_orders;

-- Q3: How many unique orders, products, and customers are there?
select 
	count(distinct order_id) as unique_orders, 
    count(distinct p.product_id) as unique_products,
	count(distinct c.customer_id) as unique_customers
from f_orders as o
left join d_products as p
	on o.product_key = p.product_key
left join d_customers as c
	on o.customer_key = c.customer_key;

-- Q4: What is the overall time range of the dataset (min and max Order_Date)?
select 
		min(order_date) as minimum_date , 
		max(order_date) as maximum_date, 
		round((timestampdiff(month, min(order_date), max(order_date)) ) /12, 1) as 'Year.month'
from f_orders;


