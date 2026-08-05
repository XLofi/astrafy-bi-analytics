with order_history as (

    select *
    from {{ ref('int_order_rolling_history') }}

),

segmented as (

    select
        order_id,
        customer_id,
        order_date,
        order_net_sales,
        qty_product,
        prior_orders_12m,
        has_complete_12_month_history,

        {{ classify_order_segment('prior_orders_12m') }}
            as order_segmentation

    from order_history

)

select *
from segmented
