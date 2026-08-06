# Data-Quality Controls

## Generic tests

- `not_null`
- `unique`
- `accepted_values`
- `relationships`

## Singular tests

| Test | Purpose |
|---|---|
| `assert_stg_sales_unique_order_product` | Confirms one raw sales row per order and product |
| `assert_fct_order_lines_unique_order_product` | Confirms one valid mart row per order and product |
| `assert_order_revenue_reconciliation` | Reconciles order revenue with sales-line revenue |
| `assert_order_segment_matches_history` | Verifies the segmentation thresholds |
| `assert_segmented_2026_matches_orders` | Confirms every 2026 order appears in the final mart |
| `assert_segmented_orders_in_exercise_year` | Confirms only 2026 orders are included |

## Revenue reconciliation

```text
Orders checked: 3,661
Revenue mismatches: 0
Maximum absolute difference: 0
```

## Product-level mart validation

The `fct_order_lines` mart contains only product lines associated with valid
orders.

| Check | Result |
|---|---:|
| Rows | 28,360 |
| Unique order-product combinations | 28,360 |
| Unique orders | 3,661 |
| Unique products | 9,196 |
| Total product units | 47,728 |
| Total net revenue | 269,044.0526 |
| Revenue mismatches against order facts | 0 |
| Maximum revenue difference | 0 |

The composite `order_id + product_id` grain is tested explicitly, and every
order line has a valid relationship to `fct_orders_segmented`.

## Known warning

The complete build returns one warning for the orphan order `5361303`.
It is intentional and documented.
