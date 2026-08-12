USE northwind;

show tables;

select
	table_name, table_rows
from information_schema.tables where table_schema = 'northwind'
order by table_name;

describe customers;
describe orders;
describe order_details;
describe products;
describe employees;

select count(*) as total_customers from customers;
select count(*) as total_orders from orders;
select count(*) as total_order_details from order_details;

select min(order_date) as first_order, max(order_date) as last_order
from orders;