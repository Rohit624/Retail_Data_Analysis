----------------------------- Geographic Analysis -----------------------------

-- Q1: From each region's states(Top 3) generate the most profit?
with cte as (
select 
	region,
	state, 
	round(sum(profit),2) as profit,
    dense_rank() over(partition by region order by round(sum(profit),2) desc) as ranking
from f_orders as o 
left join d_location as l
	on o.location_key = l.location_key
group by region, state
order by region asc, profit desc
)
select *
from cte
where ranking <= 3
order by region, ranking ;


-- Q2: Which states have negative overall profit?
select state, round(sum(profit),2) as total_profit
from f_orders as o 
left join d_location as l
	on o.location_key = l.location_key
group by state
having total_profit < 0
order by total_profit ;


-- Q3: What is the total sales and profit by region?
select 
	region, 
	round(sum(sales),2) as total_sales, 
	round(sum(profit),2) as total_profit 
from f_orders as o 
left join d_location as l
	on o.location_key = l.location_key
group by region;


-- Q4: How is the customer distribution by state and region?
with cte as (
select region, state, count( customer_key) as customer_count
from f_orders as o
left join d_location as l
	on o.location_key = l.location_key
group by region, state
)
select *, 
	concat(round(customer_count/ sum(customer_count) over() * 100,2), '%') as Percent_distribution
from cte
order by region,percent_distribution desc;

-- Q5: Who are the top 10 states by sales?
select state , round(sum(sales),2) as Total_sales
from gold.f_orders as o
left join gold.d_location as l
	on o.location_key = l.location_key
group by state
order by Total_sales desc
limit 10 ; 

