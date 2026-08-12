USE northwind;

with employee_sales as (
	select	o.employee_id,
			count(distinct o.id) as total_orders,
            sum(od.quantity * od.unit_price * (1 - od.discount)) as net_sales
	from orders as o
    join order_details as od on od.order_id = o.id
    group by o.employee_id
)

select	e.id as employee_id,
		concat(e.first_name, ' ',e.last_name) as employee_name,
        es.total_orders,
        round(es.net_sales, 2) as net_sales,
        round(es.net_sales / nullif(es.total_orders, 0), 2) as average_order_value,
        rank() over (order by es.net_sales desc) as sales_rank
from employee_sales as es
join employees as e on e.id = es.employee_id
order by sales_rank;