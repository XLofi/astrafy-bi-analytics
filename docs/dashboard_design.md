# Marketing Daily Performance Dashboard

## 1. Objective

The dashboard helps the marketing and sales teams monitor daily business
performance, identify meaningful changes in revenue, understand customer
behavior, and analyze product performance.

The dashboard is designed around two analytical grains:

- Order-level metrics from the `Order Performance` Explore.
- Product-level metrics from the `Product Performance` Explore.

Keeping these grains separate prevents product lines from duplicating
order-level revenue, order counts, and average-order metrics.

---

## 2. Target audience

Primary users:

- Marketing managers
- Sales managers
- E-commerce managers
- Customer-retention teams
- Business analysts

Primary business questions:

1. How much revenue did the business generate?
2. Is revenue increasing or decreasing?
3. How many orders and customers generated that revenue?
4. How does average order value change over time?
5. What proportion of activity comes from New, Returning, and VIP customers?
6. Which products generate the most revenue and sales volume?
7. Are changes driven by customer volume, order frequency, or basket value?

---

## 3. Global filters

The dashboard should provide the following filters:

| Filter | Purpose |
|---|---|
| Order date | Select the analysis period |
| Customer order segment | Filter New, Returning, or VIP orders |
| Complete 12-month history | Separate fully observed segmentation from incomplete history |
| Product ID | Analyze one or more products |
| Comparison period | Compare performance with the previous equivalent period |

Recommended default:

```text
Order date: Last 30 days
Customer order segment: All
Complete 12-month history: All
```

The complete-history filter is important because the source begins on
2025-07-09. Orders before 2026-07-09 do not have a fully observable preceding
12-month period.

---

## 4. Dashboard layout

```text
┌──────────────────────────────────────────────────────────────────────┐
│ Marketing Daily Performance                                         │
│ Filters: Date | Segment | Complete History | Product                │
├──────────────┬──────────────┬──────────────┬──────────────┬─────────┤
│ Net Revenue  │ Order Count  │ AOV          │ Customers    │ Units   │
├────────────────────────────────────┬─────────────────────────────────┤
│ Daily Revenue and Orders           │ Revenue by Customer Segment     │
│ Time-series chart                  │ Stacked bar or donut            │
├────────────────────────────────────┼─────────────────────────────────┤
│ AOV by Customer Segment            │ Orders by Customer Segment      │
│ Bar chart                          │ Time-series chart               │
├────────────────────────────────────┴─────────────────────────────────┤
│ Product Performance                                                 │
├────────────────────────────────────┬─────────────────────────────────┤
│ Top Products by Revenue            │ Top Products by Units Sold      │
│ Ranked table                       │ Ranked table                    │
├────────────────────────────────────┴─────────────────────────────────┤
│ Optional Revenue Forecast and Confidence Interval                  │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 5. Executive KPI cards

### 5.1 Net Revenue

**Explore:** Order Performance  
**Measure:** `Net Revenue`

Purpose:

- Shows the total net sales generated during the selected period.
- Acts as the primary business-performance indicator.

Recommended comparison:

- Percentage change against the previous equivalent period.

### 5.2 Order Count

**Explore:** Order Performance  
**Measure:** `Order Count`

Purpose:

- Shows the number of orders placed during the selected period.
- Helps distinguish changes in transaction volume from changes in order value.

### 5.3 Average Order Value

**Explore:** Order Performance  
**Measure:** `Average Order Value`

Purpose:

- Shows average net revenue per order.
- Helps determine whether revenue changes are caused by larger baskets or changes in order volume.

### 5.4 Unique Customers

**Explore:** Order Performance  
**Measure:** `Unique Customers`

Purpose:

- Shows how many distinct customers generated the selected activity.
- Helps assess customer reach and engagement.

### 5.5 Product Units

**Explore:** Order Performance  
**Measure:** `Average Product Units per Order`

The KPI may be complemented by:

**Explore:** Product Performance  
**Measure:** `Product Units Sold`

Purpose:

- Shows purchase volume.
- Helps distinguish revenue changes caused by pricing or product quantity.

---

## 6. Revenue and order trends

### Visualization

Dual-axis time-series chart.

### Dimensions and measures

**Explore:** Order Performance

```text
Dimension: Order Date
Measure: Net Revenue
Measure: Order Count
```

Recommended date granularity:

- Day for short periods.
- Week for medium periods.
- Month for long periods.

### Business interpretation

This visualization helps determine whether revenue changes are caused by:

- More or fewer orders.
- A change in average order value.
- Seasonal or recurring patterns.
- A short-lived spike or a sustained trend.

---

## 7. Customer segmentation

The customer segment is calculated dynamically in LookML from the number of
prior orders in the preceding 12 months:

| Prior orders in preceding 12 months | Segment |
|---:|---|
| 0 | New |
| 1–3 | Returning |
| 4 or more | VIP |

### 7.1 Revenue by customer segment

Recommended visualization:

- Stacked column chart over time, or
- Donut chart for a selected period.

Fields:

```text
Dimension: Customer Order Segment
Measure: Net Revenue
```

Additional KPI measures:

```text
New Customer Net Revenue
Returning Customer Net Revenue
VIP Customer Net Revenue

New Customer Revenue Share
Returning Customer Revenue Share
VIP Customer Revenue Share
```

### 7.2 Orders by customer segment

Recommended visualization:

- Stacked time-series chart.

Fields:

```text
Dimension: Order Date
Pivot: Customer Order Segment
Measure: Order Count
```

This helps identify whether growth comes from customer acquisition,
repeat purchasing, or highly engaged VIP customers.

### 7.3 Average order value by segment

Recommended visualization:

- Horizontal bar chart.

Measures:

```text
New Customer Average Order Value
Returning Customer Average Order Value
VIP Customer Average Order Value
```

Validated results across the available dataset:

| Segment | Orders | Net revenue | Average order value | Revenue share |
|---|---:|---:|---:|---:|
| New | 1,747 | €105,604.99 | €60.45 | 39.25% |
| Returning | 1,121 | €85,410.67 | €76.19 | 31.75% |
| VIP | 793 | €78,028.40 | €98.40 | 29.00% |

The results show that VIP orders have the highest average order value, while
New customers generate the largest total share of revenue.

---

## 8. Product performance

Product analysis uses the `Product Performance` Explore because its grain is
one row per order and product.

### 8.1 Top products by net revenue

Recommended visualization:

- Ranked table or horizontal bar chart.

Fields:

```text
Dimension: Product ID
Measure: Product Net Revenue
Measure: Product Units Sold
Measure: Order Count
Measure: Unique Customers
```

Recommended sort:

```text
Product Net Revenue descending
```

Recommended limit:

```text
Top 10 or Top 20 products
```

### 8.2 Top products by units sold

Recommended visualization:

- Ranked table.

Fields:

```text
Dimension: Product ID
Measure: Product Units Sold
Measure: Product Net Revenue
Measure: Order Count
```

This distinguishes products that generate high volume from products that
generate high revenue.

### 8.3 Product performance by customer segment

Recommended visualization:

- Pivoted table or stacked bar chart.

Fields:

```text
Dimension: Product ID
Pivot: Customer Order Segment
Measure: Product Net Revenue
```

This helps marketing teams identify:

- Products that attract New customers.
- Products favored by Returning customers.
- Products with strong VIP engagement.

---

## 9. Drill-down behavior

KPI cards and visualizations should provide drill-down access to:

```text
Order ID
Order Date
Customer ID
Customer Order Segment
Prior Orders — 12 Months
Product ID
Product Units
Net Revenue
Complete 12-Month History
```

Technical composite keys and warehouse reconciliation fields remain hidden
from business users.

---

## 10. Data-quality communication

The dashboard should contain an information tile explaining:

> Customer segmentation is based on prior orders during the preceding
> 12 months. Because the source data begins on 2025-07-09, orders before
> 2026-07-09 do not have a complete observable 12-month history.

Users can apply the `Complete 12-Month History` filter when they require
strictly comparable segmentation.

One source sales record has no matching authoritative order. It remains
visible in staging for auditability but is excluded from the business marts
and dashboard metrics.

---

## 11. Conversational Analytics examples

The semantic layer should allow users to ask questions such as:

- What was net revenue last month?
- How did daily revenue change compared with the previous month?
- Which customer segment generated the most revenue?
- What percentage of revenue came from VIP customers?
- What is the average order value for Returning customers?
- Which ten products generated the most revenue?
- Which products are most frequently purchased by New customers?
- How many orders have complete 12-month customer history?

The LookML labels, descriptions, synonyms, group labels, hidden technical
fields, and explicit measure definitions are intended to reduce ambiguity
when these questions are interpreted by a conversational analytics system.

---

## 12. Forecasting bonus

An optional forecasting section can display:

```text
Daily actual net revenue
7-day forecast
30-day forecast
Prediction interval
```

Recommended visualization:

- Actual revenue as a solid line.
- Forecast revenue as a dashed line.
- Prediction interval as a shaded band.

The forecast should be presented as decision support rather than a guaranteed
outcome.

Important limitations:

- The available historical period begins in July 2025.
- The dataset may not capture multiple years of seasonality.
- Product promotions, pricing changes, holidays, and marketing campaigns are not available as explanatory variables.
- Forecast accuracy should therefore be measured and clearly communicated.

Suggested evaluation metrics:

```text
MAE
RMSE
MAPE
```

The first implementation should use a simple and explainable baseline before
introducing more complex forecasting methods.

---

## 13. Dashboard success criteria

The dashboard is successful when a business user can:

1. Understand current revenue and order activity in a few seconds.
2. Identify whether a change is driven by orders, customers, or order value.
3. Compare New, Returning, and VIP customer behavior.
4. Identify the products driving revenue and volume.
5. Drill from an aggregate KPI into the underlying business records.
6. Understand the limitations of incomplete customer history.
7. Ask natural-language business questions without relying on technical warehouse terminology.
