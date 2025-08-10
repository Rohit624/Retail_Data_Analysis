
----------------------------- Customer Analysis -----------------------------

-- Q1: Who are the top 10 customers by sales?
select 
	customer_id , 
	customer_name, 
	round(sum(sales),2) as total_sales
from f_orders as o
left join d_customers as c
	on o.customer_key = c.customer_key
group by customer_id, customer_name
order by total_sales desc
limit 10;

-- Q2: How many repeat customers are there?
with cou as (
	select  
		customer_key, count(customer_key) as ord
	from f_orders 
	group by customer_key
    having count(customer_key) > 1
)
select 
	'No. of Repeat customers' as '',
	count(customer_key)  as value
from cou;

-- Q3: What is the average number of orders per customer? 
select  
	'avg order per customer' as '',
	avg(total_quantity) as "value"
from(
	select 
		customer_id, sum(quantity) as total_quantity
	from f_orders as o
	left join d_customers as c
		on o.customer_key = c.customer_key
	group by customer_id
)x;


-- Q4: What is the average and total sales per customer segment?
select 
	segment,
	round(sum(sales),2) as total_sales,
    round(avg(sales),2) as average_sales
from f_orders as o
left join d_customers as c
	on o.customer_key = c.customer_key
group by segment
order by total_sales desc;