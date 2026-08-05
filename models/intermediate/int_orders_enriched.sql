with orders as (

    select *
    from {{ ref('stg_orders') }}

),

product_metrics as (

    select *
    from {{ ref('int_order_product_metrics') }}

),

enriched_orders as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_net_sales,

        product_metrics.qty_product,
        product_metrics.distinct_product_count,
        product_metrics.product_line_count,
        product_metrics.calculated_order_net_sales,

        orders.order_net_sales
            - product_metrics.calculated_order_net_sales
            as revenue_difference

    from orders

    left join product_metrics
        on orders.order_id = product_metrics.order_id

)

select *
from enriched_orders
