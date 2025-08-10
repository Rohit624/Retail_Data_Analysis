drop database if exists gold;
create database gold;
use gold;

-------------------- Dropping Views --------------------

drop view if exists gold.d_customers;
drop view if exists gold.d_products;
drop view if exists gold.d_Location;
drop view if exists gold.f_orders;


-------------------- dimension_customer_table --------------------

create view gold.d_customers as (
select 
	dense_rank() over(order by customer_id) as customer_key,
	customer_id,
	customer_name,
	segment
from silver.s_store
group by  customer_id, customer_name, segment
);

-------------------- dimension_product_table --------------------

create view d_products as (
select 
		dense_rank() over(order by product_id,product_name) as product_key,
		product_id,
        product_name,
		category,
		sub_category,
        product_price
from silver.s_store
group by product_id, product_name, category,sub_category,product_price
);

-------------------- dimension_Location_table --------------------

create view d_Location as (
select 
		dense_rank() over(order by postal_code,city) as Location_key,
		postal_code,
		city,
		state,
		region,
		country
from silver.s_store
group by postal_code, city, state,
			region, country
);


-------------------- Fact_order_table --------------------

create view f_orders as (
select 
		order_id,
        dense_rank() over(order by customer_id) as customer_key,
        dense_rank() over(order by product_id,product_name) as product_key,
        dense_rank() over(order by postal_code,city) as Location_key,
		order_date, 
		ship_date,
		ship_mode,
		quantity,
		discount,
		sales,
		profit
from silver.s_store
);

-------------------- Views --------------------

select * from gold.d_customers;
select * from gold.d_location;
select * from gold.d_products;
select * from gold.f_orders;
