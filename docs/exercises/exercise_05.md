# Exercise 5 — Customer Order Segmentation

## Rules

| Prior orders in the preceding 12 months | Segment |
|---:|---|
| 0 | New |
| 1–3 | Returning |
| 4 or more | VIP |

The rules are centralized in `classify_order_segment`.

## Results

| Segment | Orders | Complete history | Incomplete history |
|---|---:|---:|---:|
| New | 1,087 | 631 | 456 |
| Returning | 794 | 372 | 422 |
| VIP | 692 | 375 | 317 |
| **Total** | **2,573** | **1,378** | **1,195** |

Audit fields:

```text
prior_orders_12m
has_complete_12_month_history
```

Same-day orders do not count as prior orders because the source has no
timestamps.
