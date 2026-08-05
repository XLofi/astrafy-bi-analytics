select
    sales.order_id,
    min(sales.order_date) as order_date,
    min(sales.customer_id) as customer_id,
    count(*) as sales_line_count,
    sum(sales.product_quantity) as total_quantity,
    sum(sales.line_net_sales) as total_net_sales

from {{ ref('stg_sales') }} as sales

left join {{ ref('stg_orders') }} as orders
    on sales.order_id = orders.order_id

where orders.order_id is null

group by sales.order_id
order by sales.order_id
