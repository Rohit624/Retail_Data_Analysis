-------------- creating silver layer -----------

drop database if exists silver;
create database silver;
use silver;


----------- Data Cleaning ---------------------------
drop table if exists silver.s_store;
create table silver.s_store as (
select 
	row_id,
	order_id,
	str_to_date(order_date, '%m/%d/%Y') as order_date,
	str_to_date(ship_date , '%m/%d/%Y') as ship_date,
	ship_mode,
    customer_id,
    trim(customer_name) as customer_name,
    trim(segment) as segment,
    trim(region) as region,
    trim(country) as country,
    trim(city) as city,
    state,
    cast(postal_code as signed) as postal_code,
    trim(product_id) as product_id,
    trim(product_name) as product_name,
    category,
    sub_category,
	cast(quantity as signed) as quantity,
    round((sales/quantity) / (1-discount), 2) as product_price,
	cast(discount as float) as discount,
	cast(sales as float) as sales,
	cast(profit as float) as profit
from bronze.b_store
);


# ----------------------------------------------- #

select *
from silver.s_store;





