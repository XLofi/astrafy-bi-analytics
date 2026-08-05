with sales as (

    select *
    from {{ ref('stg_sales') }}

),

valid_orders as (

    select
        order_id
    from {{ ref('stg_orders') }}

),

valid_sales as (

    select
        sales.*

    from sales

    inner join valid_orders
        on sales.order_id = valid_orders.order_id

),

aggregated as (

    select
        order_id,
        sum(product_quantity) as qty_product,
        count(distinct product_id) as distinct_product_count,
        count(*) as product_line_count,
        sum(line_net_sales) as calculated_order_net_sales

    from valid_sales

    group by order_id

)

select *
from aggregated
