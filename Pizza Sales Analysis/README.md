🍕 Pizza Sales Analysis — MySQL Data Analytics Project

📘 Project Overview

This project is a complete MySQL-based data analytics case study built using a real-world pizza sales dataset. 
The goal of the project is to explore restaurant sales performance, customer ordering patterns, product demand, and revenue metrics using clean, structured SQL queries.
The repository showcases practical SQL skills widely used in analytics roles, including data cleaning, joins, aggregations, window functions, performance analysis, and KPI derivation. 
All insights were generated using MySQL 8, ensuring modern SQL features and high-quality analytical reporting.

📁 Dataset Description (With Correct Columns)

The dataset consists of four CSV files representing a realistic pizza store database:
1. order_details.csv
Contains item-level details for each order.
Columns:
order_details_id — Unique identifier for each order item
order_id — Connects to the orders table
pizza_id — Identifies the specific pizza
quantity — Number of units ordered

2. orders.csv

Stores each order’s timestamp.
Columns:
order_id — Unique ID for each order
date — Date of the order
time — Time of the order

3. pizza_types.csv
Contains pizza category and ingredients.
Columns:
pizza_type_id — Unique identifier for each type
name — Name of the pizza
category — Category (Veggie, Classic, Supreme, etc.)
ingredients — Ingredient list

4. pizzas.csv

Links pizza type with size and price.
Columns:
pizza_id — Unique pizza ID
pizza_type_id — Connects to the pizza types table
size — S, M, L, XL, XXL
price — Price of the pizza

🧱 Database Structure Overview

The database is relational and connected as follows:
orders → one order per row

order_details → one line item per order, connected via order_id

pizzas → defines pizza size & price

pizza_types → defines pizza category & ingredients

This structure allows detailed analysis across product, order, and revenue dimensions.

🎯 Project Objectives

Analyze total revenue and order trends
Identify best-selling pizzas and categories
Understand size-based price and demand patterns
Analyze peak order hours and busiest days
Explore ingredient-driven popularity
Measure operational efficiency and product performance

🧠 Skills Demonstrated

MySQL relational joins
CTE-based analysis
Window functions
Date & time analysis
Aggregation & ranking
Data modeling and schema interpretation
Analytical problem-solving

🚀 How to Use This Repository

Load the CSV files into MySQL using the correct table schema.
Create the relational structure with foreign keys if needed.
Run the SQL scripts provided in the repository.
Explore insights or visualize in BI tools.
Modify queries for deeper analysis as needed.

🏆 Why This Project Is Valuable

Strong representation of SQL skills for recruiters
Realistic end-to-end business analytics scenario
Clean, organized, clearly documented project
Demonstrates ability to analyze relational datasets
Ideal for data analyst and BI developer portfolios

🧪 How to Use This Repository

Import the dataset into MySQL using CSV load or GUI tools.
Build the relational tables with appropriate schema definitions.
Run the analytical SQL queries provided in this repository.
Explore insights or integrate them into dashboards (Power BI/Tableau).
Modify queries as needed to suit analysis requirements
