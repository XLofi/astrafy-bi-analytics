# Exercise 4 — Order Table for 2025 and 2026

Output model:

```text
fct_orders
```

## Columns

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `customer_id` | Customer identifier |
| `order_date` | Order date |
| `order_net_sales` | Net order revenue |
| `qty_product` | Total product quantity |

## Validation

| Check | Result |
|---|---:|
| Rows | 3,661 |
| Unique orders | 3,661 |
| Minimum date | 2025-07-09 |
| Maximum date | 2026-12-31 |
| Invalid quantities | 0 |

The table is partitioned by `order_date` and clustered by `customer_id`.
