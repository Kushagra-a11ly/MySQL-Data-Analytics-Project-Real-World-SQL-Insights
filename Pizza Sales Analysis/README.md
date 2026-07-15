# 🍕 Pizza Sales Analysis 
---

## 📘 Project Overview

This project is a complete **MySQL-based data analytics case study** built using a
real-world pizza sales dataset. The goal is to explore restaurant sales performance,
customer ordering patterns, product demand, and revenue metrics using clean,
structured SQL queries.

The repository showcases practical SQL skills widely used in analytics roles —
including data cleaning, joins, aggregations, window functions, performance analysis,
and KPI derivation. All insights were generated using **MySQL 8**, ensuring modern
SQL features and high-quality analytical reporting.

---

## 📁 Dataset Description

The dataset consists of **four CSV files** representing a realistic pizza store database:

### 1. `order_details.csv`
Contains item-level details for each order.

| Column | Description |
|---|---|
| `order_details_id` | Unique identifier for each order item |
| `order_id` | Foreign key connecting to the orders table |
| `pizza_id` | Identifies the specific pizza ordered |
| `quantity` | Number of units ordered |

---

### 2. `orders.csv`
Stores each order's timestamp information.

| Column | Description |
|---|---|
| `order_id` | Unique ID for each order |
| `date` | Date the order was placed |
| `time` | Time the order was placed |

---

### 3. `pizza_types.csv`
Contains pizza category and ingredient details.

| Column | Description |
|---|---|
| `pizza_type_id` | Unique identifier for each pizza type |
| `name` | Name of the pizza |
| `category` | Category (e.g., Veggie, Classic, Supreme) |
| `ingredients` | Full ingredient list |

---

### 4. `pizzas.csv`
Links pizza type with size and pricing.

| Column | Description |
|---|---|
| `pizza_id` | Unique pizza identifier |
| `pizza_type_id` | Foreign key connecting to the pizza types table |
| `size` | Size of the pizza — S, M, L, XL, XXL |
| `price` | Price of the pizza |

---

## 🧱 Database Structure Overview

The database follows a **relational model** connected across four tables:
