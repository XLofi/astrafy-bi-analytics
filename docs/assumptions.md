# Assumptions and Data Limitations

## Source date discrepancy

The challenge description states that the data covers 2022–2023. The supplied
files actually contain records from **2025-07-09 to 2026-12-31**. The
implementation uses the dates present in the supplied files.

## Authoritative order source

The `orders` source is treated as the authoritative list of valid orders.
The `sales` source is treated as product-line detail.

## Orphan sales order

```text
Order ID: 5361303
Date: 2026-12-31
Customer ID: 1382673
Product ID: 47321
Quantity: 1
Net sales: 47.0833
```

The row is preserved in staging, reported by a relationship test, exposed
through an analysis, and excluded from valid order-level metrics.

## Product quantity definition

```sql
qty_product = sum(product_quantity)
```

The model also calculates `product_line_count` and
`distinct_product_count`.

## Incomplete segmentation history

| Coverage | Orders |
|---|---:|
| Incomplete history | 1,195 |
| Complete history | 1,378 |
| **Total** | **2,573** |

A `New` classification before 9 July 2026 means that no prior order was found
in the available data; it does not prove the customer never ordered earlier.

## Multiple orders on the same date

| Metric | Result |
|---|---:|
| Customer/date groups with multiple orders | 63 |
| Total affected orders | 129 |
| Customer/date groups in 2026 | 43 |
| Affected orders in 2026 | 88 |

Same-day orders do not count as prior orders for one another:

```sql
prior_order.order_date >= date_sub(
    current_order.order_date,
    interval 12 month
)
and prior_order.order_date < current_order.order_date
```
