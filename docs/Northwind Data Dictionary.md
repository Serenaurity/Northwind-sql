# Northwind Data Dictionary

## Overview

Northwind is a sample database for a product sales business. It contains customer, order, product, employee, shipping, purchasing, inventory, and invoice data.

## Data Grain

| Table | Grain |
|---|---|
| `customers` | One row per customer |
| `orders` | One row per order |
| `order_details` | One product line within an order |
| `products` | One row per product |
| `employees` | One row per employee |
| `shippers` | One row per shipping provider |
| `suppliers` | One row per supplier |
| `invoices` | One row per invoice |

## Core Tables

### customers

Customer information.

| Column | Type | Key | Description |
|---|---|---|---|
| `id` | int | PK | Customer identifier |
| `company` | varchar |  | Company name |
| `first_name` | varchar |  | Customer first name |
| `last_name` | varchar |  | Customer last name |
| `email_address` | varchar |  | Customer email |
| `job_title` | varchar |  | Customer job title |
| `business_phone` | varchar |  | Business phone number |
| `home_phone` | varchar |  | Home phone number |
| `mobile_phone` | varchar |  | Mobile phone number |
| `address` | longtext |  | Customer address |
| `city` | varchar |  | City |
| `state_province` | varchar |  | State or province |
| `zip_postal_code` | varchar |  | Postal code |
| `country_region` | varchar |  | Country or region |
| `notes` | longtext |  | Additional notes |
| `attachments` | longblob |  | Attached files |

### orders

Customer order information.

| Column | Type | Key | Description |
|---|---|---|---|
| `id` | int | PK | Order identifier |
| `employee_id` | int | FK | Employee responsible for the order |
| `customer_id` | int | FK | Customer who placed the order |
| `order_date` | datetime |  | Order date |
| `shipped_date` | datetime |  | Shipment date |
| `shipper_id` | int | FK | Shipping provider |
| `ship_name` | varchar |  | Recipient name |
| `ship_address` | longtext |  | Shipping address |
| `ship_city` | varchar |  | Destination city |
| `ship_country_region` | varchar |  | Destination country or region |
| `shipping_fee` | decimal |  | Shipping fee |
| `taxes` | decimal |  | Tax amount |
| `payment_type` | varchar |  | Payment method |
| `paid_date` | datetime |  | Payment date |
| `tax_rate` | double |  | Tax rate |
| `status_id` | tinyint | FK | Order status |
| `tax_status_id` | tinyint | FK | Tax status |

### order_details

Product-level details for each order.

| Column | Type | Key | Description |
|---|---|---|---|
| `id` | int | PK | Order detail identifier |
| `order_id` | int | FK | Related order |
| `product_id` | int | FK | Related product |
| `quantity` | decimal |  | Quantity ordered |
| `unit_price` | decimal |  | Transaction price per unit |
| `discount` | double |  | Discount as a decimal value |
| `status_id` | int | FK | Order detail status |
| `date_allocated` | datetime |  | Product allocation date |
| `purchase_order_id` | int | FK | Related purchase order |
| `inventory_id` | int |  | Related inventory transaction |

### products

Product information.

| Column | Type | Key | Description |
|---|---|---|---|
| `id` | int | PK | Product identifier |
| `product_code` | varchar |  | Product code |
| `product_name` | varchar |  | Product name |
| `description` | longtext |  | Product description |
| `standard_cost` | decimal |  | Standard product cost |
| `list_price` | decimal |  | Standard selling price |
| `reorder_level` | int |  | Reorder threshold |
| `target_level` | int |  | Target inventory level |
| `quantity_per_unit` | varchar |  | Quantity included per unit |
| `discontinued` | tinyint |  | Whether the product is discontinued |
| `minimum_reorder_quantity` | int |  | Minimum reorder quantity |
| `category` | varchar |  | Product category |
| `supplier_ids` | longtext |  | Supplier IDs stored as text |

## Shared Entity Tables

The `employees`, `shippers`, and `suppliers` tables share similar contact and address columns:

- `id` — Entity identifier
- `company` — Company name
- `first_name`, `last_name` — First and last name
- `email_address` — Email address
- `job_title` — Job title
- `business_phone`, `home_phone`, `mobile_phone` — Phone numbers
- `address`, `city`, `state_province`, `zip_postal_code`, `country_region` — Address information
- `notes` — Additional notes
- `attachments` — Attached files

| Table | Description |
|---|---|
| `employees` | Company employees |
| `shippers` | Shipping companies or providers |
| `suppliers` | Product suppliers |

## Purchasing and Inventory

| Table | Description |
|---|---|
| `purchase_orders` | Purchase orders placed with suppliers |
| `purchase_order_details` | Products included in purchase orders |
| `purchase_order_status` | Purchase order status values |
| `inventory_transactions` | Product inventory movements |
| `inventory_transaction_types` | Types of inventory movements |

### inventory_transactions

| Column | Description |
|---|---|
| `id` | Inventory transaction identifier |
| `transaction_type` | Inventory movement type |
| `transaction_created_date` | Transaction creation date |
| `transaction_modified_date` | Transaction modification date |
| `product_id` | Related product |
| `quantity` | Quantity moved |
| `purchase_order_id` | Related purchase order |
| `customer_order_id` | Related customer order |
| `comments` | Additional comments |

## Reference Tables

| Table | Description |
|---|---|
| `orders_status` | Order status values |
| `orders_tax_status` | Tax status values |
| `order_details_status` | Order detail status values |
| `privileges` | Employee privileges |
| `employee_privileges` | Bridge table between employees and privileges |
| `sales_reports` | Sales report configuration |
| `strings` | System text values |

## invoices

Invoice information.

| Column | Description |
|---|---|
| `id` | Invoice identifier |
| `order_id` | Related order |
| `invoice_date` | Invoice issue date |
| `due_date` | Payment due date |
| `tax` | Tax amount |
| `shipping` | Shipping amount |
| `amount_due` | Amount due |

## Views

### `vw_order_sales`

Order-level sales summary.

- `order_id`
- `order_date`
- `customer_id`
- `employee_id`
- `shipper_id`
- `total_units`
- `gross_sales`
- `net_sales`

Sales calculations:

```text
gross_sales = quantity × unit_price

net_sales = quantity × unit_price × (1 - discount)
```

### `vw_customer_sales`

Customer-level sales summary containing:

- Total orders
- Total units purchased
- Net sales
- Average order value

### `vw_monthly_sales`

Monthly sales summary containing:

- Month
- Total orders
- Total units sold
- Net sales

## Key Relationships

- `orders.customer_id` → `customers.id`
- `orders.employee_id` → `employees.id`
- `orders.shipper_id` → `shippers.id`
- `orders.status_id` → `orders_status.id`
- `orders.tax_status_id` → `orders_tax_status.id`
- `order_details.order_id` → `orders.id`
- `order_details.product_id` → `products.id`
- `inventory_transactions.product_id` → `products.id`
- `purchase_orders.supplier_id` → `suppliers.id`
- `purchase_order_details.purchase_order_id` → `purchase_orders.id`
- `employee_privileges.employee_id` → `employees.id`
- `employee_privileges.privilege_id` → `privileges.id`

## Data Modeling Notes

- `products.supplier_ids` is stored as `LONGTEXT` and is not connected through a foreign key.
- Several foreign key columns allow `NULL` values.
- `order_details.unit_price` represents the actual transaction price.
- `products.list_price` represents the standard selling price.
- Data quality checks should include `NULL` values, orphan records, and shipments dated before the order date.