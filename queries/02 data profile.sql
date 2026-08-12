USE northwind;

select 'customers' as table_name, count(*) as row_count from customers
union all
select 'orders', count(*) from orders
union all
select 'order_details', count(*) from order_details
union all
select 'products', count(*) from products;

select 	min(order_date) as first_order, max(order_date) as last_order,
		count(distinct customer_id) as customers_with_orders
from orders;

select	sum(quantity <= 0) as non_positive_quantity,
		sum(unit_price < 0) as negative_unit_price,
        sum(discount < 0 or discount > 1) as invalid_discount
from order_details;

