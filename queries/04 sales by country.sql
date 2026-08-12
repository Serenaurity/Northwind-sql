USE northwind;

with order_sales as (
	select	order_id,
			sum(quantity * unit_price) as gross_sales,
            sum(quantity * unit_price * (1 - discount)) as net_sales,
            sum(quantity) as total_units
	from order_details
    group by order_id
)

select	coalesce(c.country_region, 'Unknown') as country,
		count(distinct o.id) as total_orders,
        count(distinct c.id) as total_customers,
        round(sum(os.net_sales), 2) as net_sales
from orders as o
join order_sales as os on os.order_id = o.id
left join customers as c on c.id = o.customer_id
group by c.country_region
order by net_sales desc;
