USE northwind;

with order_sales as (
	select	order_id,
			sum(quantity * unit_price) as gross_sales,
            sum(quantity * unit_price * (1 - discount)) as net_sales,
            sum(quantity) as total_units
	from order_details
    group by order_id
)

select	count(*) as total_orders,
		sum(total_units) as total_units,
		round(sum(gross_sales), 2) as gross_sales,
        round(sum(gross_sales - net_sales), 2) as total_discount,
        round(sum(net_sales), 2) as net_sales,
        round(avg(net_sales), 2) as avarage_order_value
from order_sales;
