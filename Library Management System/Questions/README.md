This folder contains a structured set of SQL questions designed for practicing data analytics using a Library Management System dataset.

The questions range from basic retrieval queries to advanced analytical tasks involving aggregations, ranking, trends, and performance analysis.

These exercises help learners strengthen their SQL skills in a real-world database scenario involving books, members, employees, branches, and transactional data.

📑 Table of Contents
1.	Overview
2.	Dataset Used
3.	Question Categories
o	Basic Questions
o	Intermediate Questions
o	Advanced Questions
4.	How to Use
5.	Recommended SQL Skills Covered
6.	License

🔍 Overview
The questions in this directory are part of the MySQL Data Analytics Project – Real-World SQL Insights.

They are intended to help SQL learners apply analytical thinking to datasets commonly found in operational systems such as libraries.

These questions cover:

•	Filtering

•	Joins

•	Aggregations

•	Group & window functions

•	Ranking

•	Revenue analysis

•	Performance comparison

📂 Dataset Used

The questions are based on the following CSV tables from the Dataset folder:

•	books.csv

•	members.csv

•	employees.csv

•	branch.csv

•	issued_status.csv

•	return_status.csv

If needed, I can generate a schema.md file describing each field.

🟦 Question Categories

🔹 Basic Questions

These questions test your understanding of filtering, simple joins, and retrieving clean datasets.

1.	Which members joined the library after the year 2024?
2.	Which books are currently available for borrowing?
3.	Which employees work in the library, and what are their roles and branch assignments?
4.	Which books have been issued, and on what dates were they issued?
5.	What are the branch addresses, contact numbers, and manager details for all branches?
6.	How many books are available in each category?
7.	Which books have a rental price higher than 100?
8.	Which members have never issued any book since joining?
9.	What are the last 10 books that were returned most recently?

🔹 Intermediate Questions
These involve aggregations, multi-table joins, and group-level analysis.
1.	Find the number of books issued by each member.
2.	Show each employee and how many books they issued.
3.	List categories with more than 50 books.
4.	Top 5 most issued books.
5.	Find members who issued more than 5 books.
6.	Total rental revenue by category.
7.	Count returned books per month.
8.	Identify the top 3 authors whose books are issued the most.
9.	Find categories where average rental price is above ₹200.
10.	Bottom 5 least-issued books (slow movers).

🔹 Advanced Questions
These questions require deeper analytical skills, ranking logic, performance evaluation, and time-based insights.
1.	Identify the top 3 members who spent the highest total rental amount.
2.	Find books that are issued more times than the average issue count of all books.
3.	Monthly revenue trend for the last 6 months.
4.	Identify slow-moving books: books NEVER issued in the last 1 year.
5.	Branch performance: Rank branches based on total revenue.
6.	Find the member who returned books the fastest (minimum avg return time).
7.	Detect branches with employees who issued more than the branch average.
8.	Identify the most profitable category (highest revenue per issue).
9.	Find employees who handled 20%+ of total library issues.
10.	Find members who issued a book again within 7 days of returning a previous one.

🚀 How to Use
1.	Import the dataset into MySQL.
2.	Create tables and set relationships (PKs & FKs).
3.	Use the questions as SQL practice tasks.
4.	Optionally create dashboards or reports using the query outputs.
5.	Improve performance using indexes and query optimization techniques.
If you want, I can generate:
✔ SQL answers
✔ Query optimization suggestions
✔ A combined project README
✔ A solution notebook (Jupyter / Markdown)

🎯 Recommended SQL Skills Covered
•	SELECT, WHERE, ORDER BY
•	JOINs: INNER, LEFT, RIGHT
•	GROUP BY & HAVING
•	Aggregate functions
•	Subqueries
•	Window functions
•	Ranking (ROW_NUMBER, RANK, DENSE_RANK)
•	Date/time functions
•	Revenue analysis
•	Performance metrics
•	Trend analysis
________________________________________
📜 License
This set of questions may be used freely for learning, teaching, or SQL practice.
Add a formal license (MIT, Apache-2.0) if your repository requires one.
