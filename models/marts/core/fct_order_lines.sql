{{
    config(
        materialized = "table",
        partition_by = {
            "field": "order_date",
            "data_type": "date",
            "granularity": "day"
        },
        cluster_by = [
            "product_id",
            "order_segmentation",
            "customer_id"
        ]
    )
}}

with sales as (

    select *
    from {{ ref('stg_sales') }}

),

orders as (

    select
        order_id,
        customer_id,
        order_date,
        order_segmentation,
        prior_orders_12m,
        has_complete_12_month_history

    from {{ ref('fct_orders_segmented') }}

),

valid_order_lines as (

    select
        sales.order_id,
        orders.customer_id,
        orders.order_date,
        sales.product_id,
        sales.product_quantity,
        sales.line_net_sales,
        orders.order_segmentation,
        orders.prior_orders_12m,
        orders.has_complete_12_month_history

    from sales

    inner join orders
        on sales.order_id = orders.order_id

)

select *
from valid_order_lines
