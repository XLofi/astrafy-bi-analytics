# Exercise 6 — Final Segmented 2026 Order Table

Output model:

```text
fct_orders_segmented_2026
```

## Columns

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `customer_id` | Customer identifier |
| `order_date` | Order date |
| `order_net_sales` | Net sales amount |
| `qty_product` | Total product quantity |
| `prior_orders_12m` | Prior orders in the rolling window |
| `order_segmentation` | New, Returning, or VIP |
| `has_complete_12_month_history` | Whether the full lookback is available |

## Validation

| Check | Result |
|---|---:|
| Rows | 2,573 |
| Unique orders | 2,573 |
| Minimum date | 2026-01-01 |
| Maximum date | 2026-12-31 |
| New orders | 1,087 |
| Returning orders | 794 |
| VIP orders | 692 |
| Incomplete-history orders | 1,195 |

The table is partitioned by `order_date` and clustered by
`order_segmentation` and `customer_id`.
