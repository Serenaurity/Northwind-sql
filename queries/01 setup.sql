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