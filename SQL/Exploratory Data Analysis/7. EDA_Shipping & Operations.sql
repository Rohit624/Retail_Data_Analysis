----------------------------- Shipping & Operations ----------------------------- 

-- Q1: What is the most used shipping mode?
with cte as(
	select 
		ship_mode, 
		count(ship_mode) as times_used
	from f_orders
	group by ship_mode
	order by times_used desc
)
select 
	ship_mode, 
    times_used,
	concat(round(times_used/sum(times_used) over() *100,2) , '%') as percentage_used
from cte;

-- Q2: How does shipping mode affect delivery time?
select 
	ship_mode,
	round(avg(datediff(ship_date, order_date)),2) as avg_delivery_time
from f_orders
group by ship_mode
order by avg_delivery_time desc;


-- Q3: Which shipping modes are the most profitable?
select 
	ship_mode,
	round(sum(profit),2) as total_profit
from f_orders
group by ship_mode
order by total_profit desc;