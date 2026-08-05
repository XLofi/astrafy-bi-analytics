select
    order_id,
    prior_orders_12m,
    order_segmentation

from {{ ref('int_orders_segmented') }}

where not (
       (prior_orders_12m = 0 and order_segmentation = 'New')
    or (prior_orders_12m between 1 and 3 and order_segmentation = 'Returning')
    or (prior_orders_12m >= 4 and order_segmentation = 'VIP')
)
