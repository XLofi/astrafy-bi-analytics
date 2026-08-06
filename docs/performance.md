# BigQuery Performance and Cost Considerations

## Partitioning

The fact tables are partitioned by `order_date`. Analyses use explicit date
ranges to support partition pruning.

```sql
order_date >= date '2026-01-01'
and order_date < date '2027-01-01'
```

## Clustering

`fct_orders` is clustered by `customer_id`.

`fct_orders_segmented_2026` is clustered by:

```text
order_segmentation
customer_id
```

## Reusable transformations

Product aggregation, revenue reconciliation, rolling history, and segmentation
are centralized in intermediate models.

## Production-scale evolution

For billions of rows:

- Incremental models
- Reprocessing recent partitions for late-arriving data
- Incremental rolling-history logic
- Source freshness checks
- CI in isolated schemas
- BigQuery labels and cost monitoring
- Required date filters in BI Explores
- Scheduled orchestration
