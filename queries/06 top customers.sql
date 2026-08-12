USE northwind;

with customer_sales as (
	select	o.customer_id,
			count(distinct o.id) as total_orders,
            sum(od.quantity) as total_units,
            sum(od.quantity * od.unit_price * (1 - od.discount)) as net_sales
	from orders as o
    join order_details as od on od.order_id = o.id
    group by o.customer_id
),

ranked_customers as (
	select 	cs.*,
			dense_rank() over (order by net_sales desc) as sales_rank
	from customer_sales as cs
)

select	rc.sales_rank,		c.company,
		c.country_region,	rc.total_orders,
        rc.total_units,
        round(rc.net_sales, 2) as net_sales
from ranked_customers as rc
left join customers as c on c.id = rc.customer_id
order by rc.sales_rank
limit 20;