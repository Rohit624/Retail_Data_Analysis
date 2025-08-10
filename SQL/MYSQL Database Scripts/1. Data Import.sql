-------------------- Creating database and Table --------------------

drop database if exists bronze;
Create database bronze;
use bronze;

drop table if exists b_store_sales;

Create table b_store (
row_id			varchar(50),
order_id		varchar(50),
order_date		varchar(50),
ship_date		varchar(50),
ship_mode		varchar(50),
customer_id		varchar(50),
customer_name	varchar(50),
segment			varchar(50),
country			varchar(50),
city			varchar(50),
state			varchar(50),
postal_code		varchar(50),
region			varchar(50),
product_id		varchar(50),
category		varchar(50),
sub_category	varchar(50),
product_name	varchar(200),
sales			varchar(50),
quantity		varchar(50),
discount		varchar(50),
profit			varchar(50)
);

truncate table b_store_sales;

-------------------- Importing Data --------------------
 
load data local infile 'E:/Data Projects/Sales Project/Data/SuperStore/Sample _Superstore_new.csv'
into table b_store
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from b_store_sales;