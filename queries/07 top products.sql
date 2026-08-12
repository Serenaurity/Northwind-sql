USE northwind;

with product_sales as (
	select 	od.product_id,
			sum(od.quantity) as units_sold,
            sum(od.quantity * od.unit_price * (1 - od.discount)) as net_sales
	from order_details as od
    group by od.product_id
)

select	p.id,		p.product_name,
		p.category,	ps.units_sold,
        round(ps.net_sales, 2) as net_sales,
        rank() over (order by ps.net_sales desc) as sales_rank
from product_sales as ps
join products as p on p.id = ps.product_id
order by sales_rank
limit 20;