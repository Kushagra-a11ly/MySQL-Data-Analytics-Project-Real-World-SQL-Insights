This folder contains a complete collection of SQL scripts used to build, manage, and analyze a Library Management System using MySQL.

The queries cover everything from database creation, table design, and data validation to analytical SQL questions categorized by difficulty levels.

These scripts form the backbone of the project and are intended for practicing SQL, performing data analysis, and understanding relational database concepts.

📂 What This Folder Contains

Section	Description

Database Setup	SQL commands to create the database and switch context.

Table Creation	Schema for branches, employees, members, books, issue status, and return status tables.

Data Verification Queries	Simple SELECT statements to confirm successful data loading.

Basic SQL Queries	Foundational SELECT, filtering, and sorting operations.

Intermediate SQL Queries	Joins, aggregations, category breakdowns, top/bottom performers.

Advanced SQL Queries	Window functions, ranking, revenue analysis, trend insights, and behavior analysis.

🔧 1. Database Initialization

The project starts by creating and selecting the database:

CREATE DATABASE library_db;

USE library_db;

This ensures all tables and queries run inside a dedicated environment.

🧱 2. Table Structure & Schema Explanation

The Library Management System includes six relational tables.

Below is a high-level overview of each table:

📍 Branch Table

Stores information about different library locations.

Column	Description

branch_id -->	Unique ID of the branch (Primary Key)

manager_id -->	ID of the branch manager

branch_address -->	Physical address of the branch

contact_no	--> Contact number for the branch

👔 Employees Table

Stores employee information and maps each employee to a branch.

Column	Description

emp_id -->	Unique employee ID

emp_name -->	Employee name

position -->	Job role (e.g., Librarian, Clerk)

salary -->	Monthly salary

branch_id	--> Branch they work at (Foreign Key)

🧑 Members Table

Represents all registered library members.

Column	Description

member_id -->	Unique ID for each member

member_name -->	Full name

member_address -->	Address of the member

reg_date -->	Registration date

📚 Books Table

Contains all book metadata.

Column	Description

isbn	Unique --> book identifier

book_title -->	Title of the book

category -->	Genre/category

rental_price -->	Cost to rent the book

status -->	Availability status

author -->	Author name

publisher -->	Publisher name

📖 Issued Status Table

Tracks all issued transactions.

Column	Description

issued_id -->	Unique issue transaction ID

issued_member_id -->	ID of the member who borrowed the book

issued_book_name -->	Title of the issued book

issued_date -->	Borrowing date

issued_book_isbn -->	Book ISBN (Foreign Key)

issued_emp_id -->	Employee who issued the book (Foreign Key)

🔁 Return Status Table

Logs book return transactions.

Column	Description

return_id -->	Unique return record ID

issued_id -->	Issued record ID (FK relationship expected)

return_book_name -->	Book title

return_date -->	Date returned

return_book_isbn -->	ISBN (Foreign Key)

🔍 3. Data Validation Queries

These simple SELECT queries confirm table creation and data loading:

SELECT * FROM books;

SELECT * FROM branch;

SELECT * FROM employees;

SELECT * FROM issued_status;

SELECT * FROM return_status;

SELECT * FROM members;

🟩 4. Basic SQL Queries

These queries help extract essential information from the system.

✔ List all books with category and rental price
SELECT isbn, book_title, category, rental_price FROM books;

✔ Members sorted by latest registration
SELECT member_name, reg_date
FROM members
ORDER BY reg_date DESC;

✔ Books from a specific category
SELECT book_title, isbn FROM books WHERE category = 'Fiction';

✔ All employees and their branch assignments
SELECT emp_id, emp_name, position, branch_id FROM employees;

✔ Recently returned books
SELECT return_id, return_book_name, return_date
FROM return_status
ORDER BY return_date DESC
LIMIT 10;

🟨 5. Intermediate SQL Queries

These queries involve joins and aggregated insights.

✔ Total books issued by each member
SELECT m.member_id, m.member_name, COUNT(i.issued_id) AS total_issues
FROM members m
LEFT JOIN issued_status i ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name;

✔ Top 5 most issued books
SELECT b.book_title, COUNT(i.issued_id) AS issue_count
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY b.book_title
ORDER BY issue_count DESC
LIMIT 5;

✔ Categories with average rental price above ₹200
SELECT category, AVG(rental_price) AS avg_price
FROM books
GROUP BY category
HAVING AVG(rental_price) > 200;

✔ Total rental revenue by category
SELECT b.category, SUM(b.rental_price) AS total_revenue
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY b.category;

🟥 6. Advanced SQL Queries

These are deep analytical queries using window functions, ranking, and trend analysis.

✔ Top 3 members by total rental spending
SELECT *
FROM (
    SELECT m.member_id, m.member_name, SUM(b.rental_price) AS total_spent,
           RANK() OVER (ORDER BY SUM(b.rental_price) DESC) AS rnk
    FROM members m
    JOIN issued_status i ON m.member_id = i.issued_member_id
    JOIN books b ON i.issued_book_isbn = b.isbn
    GROUP BY m.member_id, m.member_name
) x
WHERE rnk <= 3;

✔ Monthly revenue trend (last 6 months)
WITH last6 AS (
    SELECT DATE_FORMAT(issued_date, '%Y-%m') AS month,
           SUM(b.rental_price) AS revenue
    FROM issued_status i
    JOIN books b ON i.issued_book_isbn = b.isbn
    WHERE issued_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY month
)
SELECT * FROM last6 ORDER BY month;

✔ Detect slow-moving books
SELECT b.isbn, b.book_title
FROM books b
LEFT JOIN issued_status i 
    ON b.isbn = i.issued_book_isbn
    AND i.issued_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
WHERE i.issued_id IS NULL;

✔ Branch performance ranking
SELECT br.branch_id, br.branch_address, SUM(b.rental_price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(b.rental_price) DESC) AS branch_rank
FROM branch br
JOIN employees e ON br.branch_id = e.branch_id
JOIN issued_status i ON e.emp_id = i.issued_emp_id
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY br.branch_id, br.branch_address;

✔ Employees handling 20%+ of all issues
WITH emp_issues AS (
    SELECT e.emp_id, e.emp_name, COUNT(i.issued_id) AS total_issues
    FROM employees e
    JOIN issued_status i ON e.emp_id = i.issued_emp_id
    GROUP BY e.emp_id, e.emp_name
), total AS (
    SELECT SUM(total_issues) AS library_total FROM emp_issues
)
SELECT ei.emp_id, ei.emp_name, ei.total_issues,
       ROUND(ei.total_issues / t.library_total * 100, 2) AS pct_share
FROM emp_issues ei, total t
WHERE ei.total_issues >= 0.20 * t.library_total;

🎯 Purpose of These Queries

These SQL scripts help achieve:

Understanding real-world relational schemas

Practicing joins, aggregations, and window functions

Analyzing library operations and performance

Generating insights such as:

Most issued books

Fastest returners

Branch revenue rankings

Employee performance

Category-level rentability

📜 License

These SQL scripts may be used for learning, teaching, academic projects, or data analysis practice.
