# Final Validation Summary

```text
Models: 10
Analyses: 7
Data tests: 82
Passes: 91
Warnings: 1
Errors: 0
Skipped: 0
Total executed nodes: 92
```

The warning corresponds to orphan sales order `5361303`.

## Final mart

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

## Product mart validation

| Check | Result |
|---|---:|
| Rows | 28,360 |
| Unique order-product combinations | 28,360 |
| Unique orders | 3,661 |
| Unique products | 9,196 |
| Total product units | 47,728 |
| Total product net revenue | 269,044.0526 |
| Revenue mismatches | 0 |
| Maximum revenue difference | 0 |

The single orphan source sales line is preserved in staging but excluded from
the valid product mart because it has no corresponding authoritative order.
