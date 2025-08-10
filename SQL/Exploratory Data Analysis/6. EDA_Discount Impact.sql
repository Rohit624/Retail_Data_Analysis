
----------------------------- Discount Impact -----------------------------

-- Q1: What is the average discount given across orders?
select concat(round(avg(discount) *100 ,2), '%') as average_discount
from f_orders;


-- Q2: Are higher discounts correlated with losses?
with dis as (
select
	*,
    case 
    when discount < 0.20 then 'under 20%'
    when discount between 0.20 and 0.40 then '20-40%'
    when discount between 0.40 and 0.60 then '40-60%'
    when discount between 0.60 and 0.80 then '60-80%'
    when discount > 0.80 then 'above 80%'
    end as discount_range
from f_orders
)
select 
	discount_range, 
	round(sum(profit),2) as total_profit
from dis
group by discount_range;


-- Q3: Which discount range generates the highest profit?
with cte as (
select
	*,
    case 
    when discount < 0.20 then 'under 20%'
    when discount between 0.20 and 0.40 then '20-40%'
    when discount between 0.40 and 0.60 then '40-60%'
    when discount between 0.60 and 0.80 then '60-80%'
    when discount > 0.80 then 'above 80%'
    end as discount_range
from f_orders
)
select
	'Highest Profit Range' as '',
	discount_range, 
    round(sum(profit),2) as total_profit
from cte
group by discount_range
order by total_profit desc
limit 1;