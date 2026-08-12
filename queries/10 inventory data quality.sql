USE northwind;

select	id,	product_name,
		reorder_level, target_level,
        discontinued
from products
where discontinued = 0	
		and reorder_level is not null
		and target_level is not null
		and reorder_level >= target_level;

select	sum(product_name is null or trim(product_name) = ' ') as missing_product_name,
		sum(list_price < 0) as negative_list_price,
        sum(discontinued not in (0, 1)) as invaild_discontinued,
        sum(category is null or trim(category) = ' ') as missing_category
from products;

select count(*) as orphan_order_details
from order_details as od
left join orders as o on o.id = od.order_id
where o.id is null;

select count(*) as orphan_order
from orders as o
left join customers as c on c.id = o.customer_id
where o.customer_id is not null and c.id is null;

select count(*) as invalid_shipping_date
from orders
where shipped_date < order_date;
