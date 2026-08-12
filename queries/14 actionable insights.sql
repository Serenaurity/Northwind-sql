use northwind;

with customer_segments as (
    select	customer_id, company, net_sales,
			ntile(5) over (order by net_sales desc) as spend_group
    from vw_customer_sales
    where total_orders > 0
),
segment_summary as (
    select	spend_group,
			count(*) as customers,
			sum(net_sales) as net_sales
    from customer_segments
    group by spend_group
),
total_sales as (
    select sum(net_sales) as total_net_sales
    from segment_summary
)
select	ss.spend_group, ss.customers,
		round(ss.net_sales, 2) as net_sales,
		round(ss.net_sales / ts.total_net_sales * 100, 2) as revenue_share_pct
from segment_summary as ss
cross join total_sales as ts
order by ss.spend_group;

select	coalesce(p.category, 'unknown') as category,
		count(distinct od.order_id) as total_orders,
		sum(od.quantity) as units_sold,
		round(sum(od.quantity * od.unit_price * (1 - coalesce(od.discount, 0))
        ), 2) as net_sales,
		round(avg(od.discount) * 100, 2) as average_discount_pct
from order_details as od
join products as p on p.id = od.product_id
group by p.category
order by net_sales desc;

with customer_orders as (
    select	customer_id,
			count(*) as total_orders
    from orders where customer_id is not null
    group by customer_id
)
select
	case
        when total_orders = 1 then 'one-time customer'
        else 'repeat customer'
    end as customer_type,
    count(*) as customers,
    round(avg(total_orders), 2) as average_orders
from customer_orders
group by customer_type;

select
    case
        when shipped_date is null then 'not shipped'
        when datediff(shipped_date, order_date) > 7 then 'over 7 days'
        else 'within 7 days'
    end as shipping_status,
    count(*) as total_orders,
    round(avg(
            case
                when shipped_date is not null
                then datediff(shipped_date, order_date)
            end), 2) as average_shipping_days
from orders
group by shipping_status
order by total_orders desc;