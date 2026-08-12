USE northwind;

with monthly_sales as (
    select	date_format(o.order_date, '%Y-%m-01') as month_start,
			sum(od.quantity * od.unit_price * (1 - od.discount)) as net_sales
    from orders as o
    join order_details as od on od.order_id = o.id
    group by date_format(o.order_date, '%Y-%m-01')
),
trend as (
    select	month_start, net_sales,
			lag(net_sales) over (order by month_start) as previous_month_sales
    from monthly_sales
)
select	month_start,
		round(net_sales, 2) as net_sales,
		round(previous_month_sales, 2) as previous_month_sales,
		round((net_sales - previous_month_sales)
			/ nullif(previous_month_sales, 0) * 100, 2
		) as growth_percent
from trend
order by month_start;