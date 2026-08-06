# Exercise 1 — Number of Orders in 2026

## Result

There are **2,573 orders** in 2026.

## Definition

An order is identified by one unique `order_id` in `stg_orders`.

## Implementation

```sql
order_date >= date '2026-01-01'
and order_date < date '2027-01-01'
```

The year is controlled by the `exercise_year` variable.

Analysis:

```text
analyses/exercise_01_orders_by_year.sql
```

## Why `count(*)`

`order_id` is tested for uniqueness and non-null values. Because the grain is
validated, `count(*)` represents the order count without hiding duplicates.
