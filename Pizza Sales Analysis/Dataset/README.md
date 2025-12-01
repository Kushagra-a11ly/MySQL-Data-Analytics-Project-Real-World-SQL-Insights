🧾 Dataset Description

This project is built on a structured, relational dataset that represents real-world pizza store operations. The data is organized into four interconnected tables, enabling detailed analysis across orders, items, pricing, categories, and ingredients.

1. order_details.csv

Contains line-item information for each order.
Columns:

order_details_id – Unique identifier for each item entry

order_id – Links to the orders table

pizza_id – Specifies the pizza ordered

quantity – Number of units purchased

2. orders.csv

Stores the core order information, including timestamps.
Columns:

order_id

date – Date of the transaction

time – Time of the transaction

3. pizzas.csv

Defines pizza variations based on size and price.
Columns:

pizza_id – Unique pizza SKU

pizza_type_id – Links to pizza types

size – S, M, L, XL, XXL

price – Price of the specific pizza variant

4. pizza_types.csv

Describes high-level pizza characteristics.
Columns:

pizza_type_id

name – Pizza name

category – Category (Classic, Supreme, Veggie, etc.)

ingredients – Complete ingredient list

🎯 Objectives of This Project

This project aims to deliver a complete SQL-based analytical workflow by exploring key business and operational questions. The objectives include:

Analyzing total sales, revenue, and order volume

Identifying best-selling pizzas, sizes, and categories

Understanding peak ordering hours, days, and seasonal trends

Analyzing ingredient-level patterns to understand customer preferences

Providing menu optimization and promotional recommendations

Strengthening MySQL analytical, modeling, and problem-solving skills

🧠 SQL Skills Demonstrated

This project showcases strong SQL competency through a diverse set of queries and analytical techniques, including:

Complex JOIN operations across multiple tables

GROUP BY aggregations for sales and performance metrics

Window functions for ranking, running totals, and comparisons

CTEs (Common Table Expressions) for clean, modular query design

Date and time analysis for trend identification

Ranking and performance evaluation of items and categories

KPI generation, including revenue, order count, AOV, and item performance

Answering real-world business questions through SQL-driven insights

