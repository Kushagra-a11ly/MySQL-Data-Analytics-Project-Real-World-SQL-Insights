
# 🍕 Pizza Sales Analysis — MySQL Data Analytics Project

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

## 🧾 Dataset Description

This project is built on a **structured, relational dataset** that represents real-world
pizza store operations. The data is organized into **four interconnected tables**, enabling
detailed analysis across orders, items, pricing, categories, and ingredients. Together,
these tables form a complete transactional database that mirrors how a real restaurant
management system stores and tracks business data.

---

### 📄 1. `order_details.csv` — Line-Item Order Records

This table captures **item-level details** for every order placed. Each row represents
a single pizza item within an order, making it the most granular table in the dataset.
It serves as the central fact table for sales volume and quantity analysis.

| Column | Data Type | Description |
|---|---|---|
| `order_details_id` | INT | Unique identifier for each line-item entry |
| `order_id` | INT | Foreign key linking to the `orders` table |
| `pizza_id` | VARCHAR | Specifies the exact pizza variant ordered |
| `quantity` | INT | Number of units purchased for that line item |

**Analytical Use:**
- Calculate total units sold per pizza
- Identify high-demand items at the order level
- Join with `pizzas` to compute item-level revenue

---

### 📄 2. `orders.csv` — Order-Level Transactions

This table stores **one record per order**, capturing the date and time each transaction
was placed. It acts as the primary time-dimension table, enabling trend and
temporal analysis across the dataset.

| Column | Data Type | Description |
|---|---|---|
| `order_id` | INT | Unique identifier for each customer order |
| `date` | DATE | Calendar date of the transaction |
| `time` | TIME | Timestamp of when the order was placed |

**Analytical Use:**
- Identify peak ordering hours and busiest days of the week
- Analyze monthly and seasonal sales trends
- Calculate daily and weekly order volumes

---

### 📄 3. `pizzas.csv` — Pizza Variants, Sizes, and Pricing

This table defines every **pizza variant** available on the menu by combining pizza type
with size and price. Each unique combination of `pizza_type_id` and `size` produces
a distinct `pizza_id`, acting as the product SKU table.

| Column | Data Type | Description |
|---|---|---|
| `pizza_id` | VARCHAR | Unique SKU for each pizza variant |
| `pizza_type_id` | VARCHAR | Foreign key linking to the `pizza_types` table |
| `size` | VARCHAR | Size of the pizza — `S`, `M`, `L`, `XL`, `XXL` |
| `price` | DECIMAL | Price of the specific pizza size variant |

**Analytical Use:**
- Analyze pricing across sizes and categories
- Identify highest-revenue pizza variants
- Understand customer size preferences and their revenue contribution

---

### 📄 4. `pizza_types.csv` — Pizza Categories and Ingredients

This table describes the **high-level characteristics** of each pizza, including its
name, category classification, and complete ingredient list. It serves as the
product dimension table for category-level and ingredient-level analysis.

| Column | Data Type | Description |
|---|---|---|
| `pizza_type_id` | VARCHAR | Unique identifier for each pizza type |
| `name` | VARCHAR | Full name of the pizza |
| `category` | VARCHAR | Category classification — Classic, Supreme, Veggie, Chicken, etc. |
| `ingredients` | TEXT | Comma-separated list of all ingredients used |

**Analytical Use:**
- Analyze sales and revenue performance by category
- Identify the most popular ingredient combinations
- Support menu optimization and promotional decisions

---

### 🔗 Relational Structure

The four tables are connected through a clear relational hierarchy:

```
orders
  └──► order_details      (joined on order_id)
             └──► pizzas             (joined on pizza_id)
                       └──► pizza_types    (joined on pizza_type_id)
```

This structure supports **multi-table joins** across the entire data pipeline —
from raw order timestamps down to individual pizza ingredients — enabling both
high-level KPI reporting and granular, item-level analytical insights.

---

## 🎯 Project Objectives

This project delivers a **complete SQL-based analytical workflow** by exploring key
business and operational questions across the pizza store's data.

| # | Objective |
|---|---|
| 1 | Analyze total sales, revenue, and order volume across the dataset |
| 2 | Identify best-selling pizzas, sizes, and categories by demand and revenue |
| 3 | Understand peak ordering hours, busiest days, and seasonal trends |
| 4 | Explore ingredient-level patterns to uncover customer preferences |
| 5 | Provide data-driven menu optimization and promotional recommendations |
| 6 | Strengthen MySQL analytical, data modeling, and problem-solving skills |

---

## 🧠 SQL Skills Demonstrated

This project showcases **strong SQL competency** through a diverse range of queries
and analytical techniques:

### 🔹 Data Retrieval and Filtering
- `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT` for targeted data extraction
- Filtering by date ranges, categories, and size variants

### 🔹 Joins and Relational Analysis
- Complex **multi-table `JOIN` operations** across all four tables
- Inner joins, left joins, and chained joins for complete data assembly

### 🔹 Aggregations and Grouping
- `GROUP BY` aggregations for sales summaries and performance metrics
- `SUM()`, `COUNT()`, `AVG()`, `MIN()`, `MAX()` for KPI generation

### 🔹 Window Functions
- `RANK()` and `DENSE_RANK()` for pizza and category performance ranking
- `SUM() OVER()` for running totals and cumulative revenue analysis
- `ROW_NUMBER()` for ordered result segmentation

### 🔹 CTEs and Subqueries
- **CTEs (Common Table Expressions)** for clean, readable, modular query design
- Nested subqueries for intermediate aggregation and filtering

### 🔹 Date and Time Analysis
- Extracting `HOUR()`, `DAY()`, `MONTH()`, and `DAYNAME()` from timestamps
- Identifying peak hours, high-traffic days, and seasonal ordering patterns

### 🔹 KPI Generation and Business Insights
- Total revenue, average order value (AOV), and order count
- Revenue contribution percentage by category and pizza type
- Best and worst performers by sales volume and revenue
- Answering real-world business questions through SQL-driven insights

---

## 📝 Query Description

The SQL queries in this repository cover all levels of complexity in a single,
unified analytical workflow:

| Level | Techniques Used |
|---|---|
| **Basic** | `SELECT`, `WHERE`, `ORDER BY`, and foundational aggregations |
| **Intermediate** | Multi-table `JOIN`s, `GROUP BY`, and summary aggregation functions |
| **Advanced** | Subqueries, CTEs, window functions, and complex business KPIs |

---

## 🚀 How to Use This Repository

1. Load the four CSV files into MySQL using the correct table schema
2. Create the relational structure with foreign keys as needed
3. Run the SQL scripts provided in the repository
4. Explore insights or visualize results in a BI tool (Power BI / Tableau)
5. Modify queries for deeper or custom analysis as required

---

## 🏆 Why This Project Is Valuable

- Strong representation of SQL skills for recruiters and hiring managers
- Realistic, end-to-end business analytics scenario using relational data
- Clean, organized, and clearly documented project structure
- Demonstrates the ability to analyze complex, multi-table transactional datasets
- Ideal for **data analyst** and **BI developer** portfolios
- Widely applicable to SQL interviews, hackathons, and industry roles
```
