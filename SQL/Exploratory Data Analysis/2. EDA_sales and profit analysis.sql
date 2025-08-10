
----------------------------- Sales and Profit Analysis -----------------------------
-- Q1: Which product categories generate the most and least sales?
with cat as (
	select 
		category,
		round(sum(sales),2)  as sales,
		rank() over(order by sum(sales) desc) as ranking
	from f_orders as o
	left join d_products as p
		on o.product_key = p.product_key
	group by category
	order by sales desc
)
select 'Most sold category' as '', category, sales
from cat where ranking = 1  
union all
select 'Least sold category' as '', category, sales
from cat where ranking = (select max(ranking) from cat); 


-- Q2: Which sub-categories are most and least profitable?
with sub_cat as (
	select 
		sub_category,
		round(sum(profit),2)  as profit,
		case 
		when round(sum(profit),2) > 0 then rank() over(order by sum(profit) desc)
		else 0 end as profit_flag
	from f_orders as o
	left join d_products as p
		on o.product_key = p.product_key
	group by sub_category
)
select 'Most profitable' as '',sub_category, profit 
from sub_cat where profit_flag = 1
union all
select 'Least profitable',sub_category, profit from sub_cat 
where profit_flag = (select max(profit_flag) from sub_cat);



-- Q3: What are the top 10 products by sales?
select 
	rank() over(order by sum(sales) desc) as ranking,
	product_id,
	product_name,
    round(sum(sales),2)  as sales
from f_orders as o
left join d_products as p
	on o.product_key = p.product_key
group by product_id, product_name
order by sales desc
limit 10;


-- Q4: Which products or sub-categories generate the most losses?
select 
	sub_category,
    round(sum(profit),2)  as profit
from f_orders as o
left join d_products as p
	on o.product_key = p.product_key
group by sub_category 
order by profit asc
limit 3;


-- Q5: What is the average profit per order?
select round(avg(total_profit),2 ) as Average_profit 
from (
	select order_id, sum(profit) as total_profit
	from f_orders
	group by order_id
) x ;
