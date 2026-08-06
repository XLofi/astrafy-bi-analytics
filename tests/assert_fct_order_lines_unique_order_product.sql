select
    order_id,
    product_id,
    count(*) as row_count

from {{ ref('fct_order_lines') }}

group by
    order_id,
    product_id

having count(*) > 1
