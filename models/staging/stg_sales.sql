with source_sales as (

    select *
    from {{ source('raw', 'sales') }}

),

renamed as (

    select
        order_id,
        customer_id,
        date_date as order_date,
        products_id as product_id,
        net_sales as line_net_sales,
        qty as product_quantity

    from source_sales

)

select *
from renamed
