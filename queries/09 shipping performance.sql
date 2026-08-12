USE northwind;

select 	coalesce(s.company, 'Unknown') as shipper,
		count(*) as total_orders,
        sum(o.shipped_date is null) as not_shipped_orders,
        round(avg(	
				case
					when o.shipped_date is not null
					then datediff(o.shipped_date, o.order_date)
				end
        ), 2) as average_shipping_days,
        
        min(case
				when o.shipped_date is not null
                then datediff(o.shipped_date, o.order_date)
			end
		) as fastest_shipping_days,
        
        max(case
				when o.shipped_date is not null
                then datediff(o.shipped_date, o.order_date)
			end
		) as slowest_shipping_days
from orders as o
left join shippers as s on s.id = o.shipper_id
group by s.company
order by average_shipping_days;