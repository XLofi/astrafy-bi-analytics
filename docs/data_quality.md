# Data-Quality Controls

## Generic tests

- `not_null`
- `unique`
- `accepted_values`
- `relationships`

## Singular tests

| Test | Purpose |
|---|---|
| `assert_stg_sales_unique_order_product` | Confirms one row per order and product |
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

## Known warning

The complete build returns one warning for the orphan order `5361303`.
It is intentional and documented.
