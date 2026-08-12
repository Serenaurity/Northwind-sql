USE northwind;

select version();

set @analysis_start = (
	select date_sub(max(order_date), interval 90 day) from orders
    );

set @analysis_end = (
	select date_add(max(order_date), interval 1 day) from orders
    );
    
select
	@analysis_start as analysis_start,
    @analysis_end as analysis_end;
    
show index from orders;
show index from order_details;

explain analyze
select	o.customer_id,
		count(distinct o.id) as total_orders,
        round(sum(od.quantity * od.unit_price * (1 - coalesce(od.discount, 0))
        ), 2) as net_sales
from orders as o
join order_details as od on od.order_id = o.id
where o.order_date >= @analysis_start and o.order_date < @analysis_end
group by o.customer_id
order by net_sales desc;

create index idx_orders_date_customer
on orders (order_date, customer_id);

create index idx_order_details_order_product
on order_details (order_id, product_id);

analyze table orders, order_details;