This directory contains all SQL scripts used for creating the Library Management System database, generating tables, establishing relationships, and running analytical SQL queries ranging from basic to advanced levels.
These queries help perform real-world data analysis on books, members, employees, branches, issues, returns, and library revenue.

📂 Contents
•	Database Creation Script
•	Table Creation Queries
•	Sample Data Checks
•	Basic SQL Queries
•	Intermediate SQL Queries
•	Advanced SQL Queries

🛠️ 1. Database Creation
CREATE DATABASE library_db;
USE library_db;

🧱 2. Table Schema
This script creates six core tables used throughout the system:

1. Branch Table
Stores library branch information.
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(30),
    contact_no VARCHAR(15)
);
2. Employees Table
Stores employee details and their branch assignments.

CREATE TABLE employees (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(30),
    position VARCHAR(30),
    salary DECIMAL(10,2),
    branch_id VARCHAR(10),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);
3. Members Table
Stores registered library members.
CREATE TABLE members (
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(30),
    reg_date DATE
);
4. Books Table
Stores all book metadata.
CREATE TABLE books (
    isbn VARCHAR(50) PRIMARY KEY,
    book_title VARCHAR(80),
    category VARCHAR(30),
    rental_price DECIMAL(10,2),
    status VARCHAR(10),
    author VARCHAR(30),
    publisher VARCHAR(30)
);
5. Issued Status Table
Tracks books issued to members.
CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(30),
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(50),
    issued_emp_id VARCHAR(10),
    FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn)
);
6. Return Status Table
Tracks book returns.
CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(30),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50),
    FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

🔍 3. Data Validation Queries
These queries ensure all tables are loaded and functioning correctly:
SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

A. Basic SQL Queries

✔ List all books with category and rental price
SELECT isbn, book_title, category, rental_price 
FROM books;

✔ List members by latest registration
SELECT member_name, reg_date
FROM members
ORDER BY reg_date DESC;

✔ Books in a specific category
SELECT book_title, isbn 
FROM books WHERE category = 'Fiction';

✔ All employees with positions and branch info
SELECT emp_id, emp_name, position, branch_id 
FROM employees;

✔ All issued books and issue dates
SELECT issued_id, issued_book_name, issued_book_isbn, issued_date 
FROM issued_status;

✔ Branch contact & address details
SELECT branch_id, branch_address, contact_no, manager_id 
FROM branch;

✔ Count of books per category
SELECT category, COUNT(*) AS books_count
FROM books
GROUP BY category
ORDER BY books_count DESC;

✔ Last 10 returned books
SELECT *
FROM return_status
ORDER BY return_date DESC
LIMIT 10;

B. Intermediate SQL Queries

✔ Books issued per member
SELECT m.member_id, m.member_name, COUNT(i.issued_id) AS total_issues
FROM members m
LEFT JOIN issued_status i ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name;

✔ Books issued by each employee
SELECT e.emp_id, e.emp_name, COUNT(i.issued_id) AS books_processed
FROM employees e
LEFT JOIN issued_status i ON e.emp_id = i.issued_emp_id
GROUP BY e.emp_id, e.emp_name;

✔ Top 5 most issued books
SELECT b.book_title, COUNT(i.issued_id) AS issue_count
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY b.book_title
ORDER BY issue_count DESC
LIMIT 5;

✔ Total rental revenue by category
SELECT b.category, SUM(b.rental_price) AS total_revenue
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY b.category;

✔ Count returned books per month
SELECT DATE_FORMAT(return_date, '%Y-%m') AS month, COUNT(*) AS returns_count
FROM return_status
GROUP BY month
ORDER BY month DESC;

✔ Top 3 authors based on issues
SELECT b.author, COUNT(i.issued_id) AS total_issues
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.author
ORDER BY total_issues DESC
LIMIT 3;

C. Advanced SQL Queries

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

✔ Books issued more times than average
SELECT b.book_title, COUNT(i.issued_id) AS issue_count
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.book_title
HAVING COUNT(i.issued_id) > (
    SELECT AVG(issue_count)
    FROM (
        SELECT COUNT(*) AS issue_count
        FROM issued_status
        GROUP BY issued_book_isbn
    ) sub
);

✔ Monthly revenue trend for last 6 months
WITH last6 AS (
    SELECT DATE_FORMAT(issued_date, '%Y-%m') AS month,
           SUM(b.rental_price) AS revenue
    FROM issued_status i
    JOIN books b ON i.issued_book_isbn = b.isbn
    WHERE issued_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY month
)
SELECT * FROM last6 ORDER BY month;

✔ Slow-moving books (not issued in last 1 year)
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

✔ Fastest returning members
SELECT m.member_id, m.member_name,
       AVG(DATEDIFF(r.return_date, i.issued_date)) AS avg_return_days
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
JOIN return_status r ON i.issued_id = r.issued_id
GROUP BY m.member_id, m.member_name
ORDER BY avg_return_days;

✔ Employees handling 20%+ of total issues
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

✔ Members who issued another book within 7 days after returning one
SELECT DISTINCT m.member_id, m.member_name
FROM members m
JOIN issued_status i1 ON m.member_id = i1.issued_member_id
JOIN return_status r ON i1.issued_id = r.issued_id
JOIN issued_status i2 ON m.member_id = i2.issued_member_id
WHERE i2.issued_date > r.return_date
  AND DATEDIFF(i2.issued_date, r.return_date) <= 7;

📜 License

Use these SQL scripts for learning, teaching, or data analysis projects.
