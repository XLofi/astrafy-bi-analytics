# Exercise 2 — Orders per Month in 2026

| Month | Orders |
|---|---:|
| January | 232 |
| February | 176 |
| March | 203 |
| April | 188 |
| May | 172 |
| June | 169 |
| July | 193 |
| August | 167 |
| September | 212 |
| October | 223 |
| November | 389 |
| December | 249 |
| **Total** | **2,573** |

Orders are grouped using:

```sql
date_trunc(order_date, month)
```

Analysis:

```text
analyses/exercise_02_orders_per_month.sql
```

The monthly total reconciles with Exercise 1.
