# Exercise 3 — Average Products per Order by Month

## Definition

```sql
qty_product = sum(product_quantity)
```

| Month | Orders | Average products per order |
|---|---:|---:|
| January | 232 | 12.57 |
| February | 176 | 12.62 |
| March | 203 | 13.07 |
| April | 188 | 15.10 |
| May | 172 | 14.63 |
| June | 169 | 14.18 |
| July | 193 | 13.75 |
| August | 167 | 14.46 |
| September | 212 | 13.67 |
| October | 223 | 13.03 |
| November | 389 | 10.48 |
| December | 249 | 11.37 |

The calculation is based on the one-row-per-order
`int_orders_enriched` model:

```sql
avg(qty_product)
```

January validation:

```text
2,916 units / 232 orders = 12.568965...
Rounded result: 12.57
```
