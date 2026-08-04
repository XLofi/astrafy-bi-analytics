with source_orders as (

    select *
    from {{ source('raw', 'orders') }}

),

renamed as (

    select
        orders_id as order_id,
        customers_id as customer_id,
        date_date as order_date,
        net_sales as order_net_sales

    from source_orders

)

select *
from renamed
