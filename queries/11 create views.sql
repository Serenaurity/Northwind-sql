USE northwind;

create or replace view vw_order_sales as
select	o.id as order_id,
		o.order_date, o.customer_id,
        o.employee_id, o.shipper_id,
        sum(od.quantity) as total_units,
        round(sum(od.quantity * od.unit_price), 2) as gross_sales,
        round(sum(od.quantity * od.unit_price * (1 - coalesce(od.discount, 0))
        ), 2) as net_sales
from orders as o
join order_details as od on od.order_id = o.id
group by o.id, o.order_date, o.customer_id,
		o.employee_id, o.shipper_id;

create or replace view vw_customer_sales as
select 	c.id as customer_id,
		c.company, c.country_region,
        count(v.order_id) as total_orders,
        coalesce(sum(v.total_units), 0) as total_units,
        round(coalesce(sum(v.net_sales), 0), 2) as net_sales,
        round(coalesce(avg(v.net_sales), 0), 2) as average_order_value
from customers as c
left join vw_order_sales as v on v.customer_id = c.id
group by c.id, c.company, c.country_region;

create or replace view vw_monthly_sales as
select	cast(date_format(order_date, '%Y-%m-01') as date) as month_start,
		count(*) as total_orders,
        sum(total_units) as total_units,
        round(sum(net_sales), 2) as net_sales
from vw_order_sales
group by cast(date_format(order_date, '%Y-%m-01')as date);

show full tables where table_type = 'view';

select * from vw_order_sales limit 10;

select * from vw_customer_sales
order by net_sales desc limit 10;

select * from vw_monthly_sales
order by month_start