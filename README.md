# Northwind SQL Analysis

A MySQL analysis project using the Northwind sample database.

## Project Overview

This project explores sales performance, customer behavior, product performance, employee results, shipping operations, inventory, and data quality using SQL.

The goal is to practice relational data analysis and turn query results into actionable business insights.

## Dataset

The project uses the MyWind version of the Northwind sample database.

Main business areas:

- Customers
- Orders and order details
- Products
- Employees
- Suppliers
- Shippers
- Purchasing
- Inventory
- Invoices

## Analysis Topics

- Database and schema inspection
- Data profiling and quality checks
- Sales overview
- Sales by country
- Monthly sales trends
- Top customers
- Top products
- Employee performance
- Shipping performance
- Inventory analysis
- Query performance and indexing
- Reusable SQL views
- Actionable business insights

## Repository Structure

```text
Northwind-sql/
├── data/
│   ├── Northwind_MySql.sql
│   ├── Northwind_Data.sql
│   └── Northwind_LICENSE.txt
├── docs/
│   ├── Northwind_ERD.png
│   └── data_dictionary.md
├── queries/
│   ├── 01 setup.sql
│   ├── 02 data profile.sql
│   ├── 03 sales overview.sql
│   ├── 04 sales by country.sql
│   ├── 05 monthly sales trend.sql
│   ├── 06 top customers.sql
│   ├── 07 top products.sql
│   ├── 08 employee performance.sql
│   ├── 09 shipping performance.sql
│   ├── 10 inventory data quality.sql
│   ├── 11 create views.sql
│   ├── 12 performance.sql
│   ├── 13 data dictionary.sql
│   └── 14 actionable insights.sql
└── README.md
```

## SQL Concepts Used

- Joins
- Aggregations
- Common Table Expressions
- Window functions
- Conditional aggregation
- Views
- Date calculations
- Data quality checks
- Indexes
- `EXPLAIN ANALYZE`

## How to Run

1. Open MySQL Workbench.
2. Run `data/Northwind_MySql.sql`.
3. Run `data/Northwind_Data.sql`.
4. Select the `northwind` database.
5. Run the files in the `queries` folder in numerical order.

Example:

```sql
USE northwind;

SHOW TABLES;
```

## Reusable Views

The project includes the following views:

- `vw_order_sales` — order-level sales summary
- `vw_customer_sales` — customer-level sales summary
- `vw_monthly_sales` — monthly sales summary

## Query Performance

The project compares query execution before and after adding indexes.

Performance checks include:

- Execution plans
- Table scans and index scans
- Estimated and actual rows
- Query execution time
- `EXPLAIN ANALYZE`

## Actionable Insights

### Customer Concentration

- **Finding:** Revenue is highly concentrated among the highest-spending customers.
- **Evidence:** The top spending group generated **37,240**, representing **54.65%** of total net sales. In comparison, the lowest spending group generated only **4.50%**.
- **Business Action:** Prioritize retention programs and personalized offers for high-value customers because they contribute most of the revenue.

### Product Category Performance

- **Finding:** Beverages is the strongest product category by a significant margin.
- **Evidence:** Beverages generated **38,260.25** in net sales from **1,452 units**, which is more than half of the total category revenue. Jams, Preserves ranked second with **5,740** in net sales.
- **Business Action:** Maintain strong availability for Beverages and investigate opportunities to grow the next-best categories, especially Jams, Preserves and Dried Fruit & Nuts.

- **Additional Finding:** The average discount was **0% across all categories**.
- **Business Action:** Review whether discounts are not being used or are missing from the dataset before making pricing decisions.

### Customer Retention

- **Finding:** The customers included in the analysis were repeat customers.
- **Evidence:** The query identified **15 repeat customers** with an average of **3.20 orders per customer**. No one-time customers appeared in the result.
- **Business Action:** Continue strengthening repeat purchasing through loyalty programs and targeted follow-up campaigns. Further analysis should verify whether one-time customers are missing from the order data.

### Shipping Performance

- **Finding:** Most shipped orders were completed within seven days, but some orders remain unresolved.
- **Evidence:** **38 orders** were shipped within seven days, with an average shipping time of **0.55 days**. However, **9 orders were not shipped**, and **1 order took more than seven days**, with a shipping time of **14 days**.
- **Business Action:** Investigate the nine unshipped orders and review the cause of the 14-day delay to reduce fulfillment risk.

### Overall Recommendation

The business should focus on retaining high-value customers, maintaining inventory for Beverages, testing whether promotional pricing can increase demand in lower-performing categories, and resolving unshipped or delayed orders.

## Data Quality Notes

The analysis checks for:

- Missing values
- Invalid prices or discounts
- Orphan records
- Invalid shipping dates
- Discontinued products
- Missing product categories

## Tools

- MySQL
- MySQL Workbench

## License

The Northwind dataset and source files retain their original license and attribution.

See `data/Northwind_LICENSE.txt` for the dataset license.

Dataset source: [dalers/mywind](https://github.com/dalers/mywind)
