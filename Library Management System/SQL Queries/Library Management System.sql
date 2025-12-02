CREATE DATABASE library_db;

USE library_db;

DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);


-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employebranchemployeesmembersreturn_statuses
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);



-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);



-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
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



-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);


SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

-- List all books with category and rental price.

SELECT isbn, book_title, category, rental_price
FROM books;

-- List members sorted by latest registration
SELECT member_name, reg_date
FROM members
ORDER BY reg_date DESC;

-- Get books belonging to a specific category (e.g., Fiction)
SELECT book_title, isbn
FROM books
WHERE category = 'Fiction';

-- All employees with position and branch.

SELECT emp_id, emp_name, position, branch_id
FROM employees;

-- List all issued books and their issued_date.

SELECT issued_id, issued_book_name, issued_book_isbn, issued_date, issued_member_id, issued_emp_id
FROM issued_status;

-- Branch contact numbers and addresses.

SELECT branch_id, branch_address, contact_no, manager_id
FROM branch;

-- Count of books per category.

SELECT category, COUNT(*) AS books_count
FROM books
GROUP BY category
ORDER BY books_count DESC;


-- Show all books issued in the system

SELECT issued_id, issued_book_name, issued_date
FROM issued_status;

-- Last 10 returned books by return_date (most recent first).

SELECT return_id, return_book_name, return_book_isbn, return_date, issued_id
FROM return_status
ORDER BY return_date DESC
LIMIT 10;

-- Find the number of books issued by each member.

SELECT 
    m.member_id,
    m.member_name,
    COUNT(i.issued_id) AS total_issues
FROM members m
LEFT JOIN issued_status i 
    ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name
ORDER BY total_issues DESC;

-- Show each employee and how many books they issued.

SELECT 
    e.emp_id,
    e.emp_name,
    COUNT(i.issued_id) AS books_processed
FROM employees e
LEFT JOIN issued_status i 
    ON e.emp_id = i.issued_emp_id
GROUP BY e.emp_id, e.emp_name
ORDER BY books_processed DESC;

-- List categories with more than 50 books.

SELECT 
    category,
    COUNT(*) AS total_books
FROM books
GROUP BY category
HAVING COUNT(*) > 50
ORDER BY total_books DESC;

-- Top 5 most issued books.

SELECT 
    i.issued_book_isbn,
    b.book_title,
    COUNT(i.issued_id) AS issue_count
FROM issued_status i
JOIN books b 
    ON i.issued_book_isbn = b.isbn
GROUP BY i.issued_book_isbn, b.book_title
ORDER BY issue_count DESC
LIMIT 5;

-- Find members who issued more than 5 books.

SELECT 
    m.member_id,
    m.member_name,
    COUNT(i.issued_id) AS total_issues
FROM members m
JOIN issued_status i 
    ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(i.issued_id) > 5
ORDER BY total_issues DESC;

-- Total rental revenue by category.

SELECT 
    b.category,
    SUM(b.rental_price) AS total_revenue
FROM issued_status i
JOIN books b 
    ON i.issued_book_isbn = b.isbn
GROUP BY b.category
ORDER BY total_revenue DESC;

-- Count returned books per month.

SELECT 
    DATE_FORMAT(r.return_date, '%Y-%m') AS month,
    COUNT(r.return_id) AS returns_count
FROM return_status r
GROUP BY DATE_FORMAT(r.return_date, '%Y-%m')
ORDER BY month DESC;

-- Identify the top 3 authors whose books are issued the most.

SELECT 
    b.author,
    COUNT(i.issued_id) AS total_issues
FROM books b
JOIN issued_status i
    ON b.isbn = i.issued_book_isbn
GROUP BY b.author
ORDER BY total_issues DESC
LIMIT 3;

-- Find categories where average rental price is above ₹200.

SELECT 
    category,
    AVG(rental_price) AS avg_price
FROM books
GROUP BY category
HAVING AVG(rental_price) > 200
ORDER BY avg_price DESC;

-- Bottom 5 least-issued books (slow movers).
 
SELECT 
    b.isbn,
    b.book_title,
    COUNT(i.issued_id) AS issue_count
FROM books b
LEFT JOIN issued_status i 
    ON b.isbn = i.issued_book_isbn
GROUP BY b.isbn, b.book_title
ORDER BY issue_count ASC
LIMIT 5;

-- Identify the top 3 members who spent the highest total rental amount.

SELECT *
FROM (
    SELECT 
        m.member_id,
        m.member_name,
        SUM(b.rental_price) AS total_spent,
        RANK() OVER (ORDER BY SUM(b.rental_price) DESC) AS rnk
    FROM members m
    JOIN issued_status i ON m.member_id = i.issued_member_id
    JOIN books b ON i.issued_book_isbn = b.isbn
    GROUP BY m.member_id, m.member_name
) x
WHERE rnk <= 3;

-- Find books that are issued more times than the average issue count of all books.

SELECT 
    b.book_title,
    COUNT(i.issued_id) AS issue_count
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.book_title
HAVING COUNT(i.issued_id) >
       (SELECT AVG(issue_count)
        FROM (
            SELECT COUNT(*) AS issue_count
            FROM issued_status
            GROUP BY issued_book_isbn
        ) AS sub);

-- Monthly revenue trend for the last 6 months.

WITH last6 AS (
    SELECT DATE_FORMAT(issued_date, '%Y-%m') AS month,
           SUM(b.rental_price) AS revenue
    FROM issued_status i
    JOIN books b ON i.issued_book_isbn = b.isbn
    WHERE issued_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY month
)
SELECT * 
FROM last6
ORDER BY month;

-- Identify slow-moving books: books NEVER issued in the last 1 year.

SELECT 
    b.isbn,
    b.book_title
FROM books b
LEFT JOIN issued_status i 
    ON b.isbn = i.issued_book_isbn
    AND i.issued_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
WHERE i.issued_id IS NULL;

-- Branch performance: Rank branches based on total revenue.

SELECT 
    br.branch_id,
    br.branch_address,
    SUM(b.rental_price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.rental_price) DESC) AS branch_rank
FROM branch br
JOIN employees e ON br.branch_id = e.branch_id
JOIN issued_status i ON e.emp_id = i.issued_emp_id
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY br.branch_id, br.branch_address;

-- Find the member who returned books the fastest (minimum avg return time).

SELECT 
    m.member_id,
    m.member_name,
    AVG(DATEDIFF(r.return_date, i.issued_date)) AS avg_return_days,
    RANK() OVER (ORDER BY AVG(DATEDIFF(r.return_date, i.issued_date))) AS speed_rank
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
JOIN return_status r ON i.issued_id = r.issued_id
GROUP BY m.member_id, m.member_name;

-- Detect branches with employees who issued more than the branch average.

SELECT 
    e.emp_id,
    e.emp_name,
    e.branch_id,
    COUNT(i.issued_id) AS books_issued
FROM employees e
JOIN issued_status i ON e.emp_id = i.issued_emp_id
GROUP BY e.emp_id, e.emp_name, e.branch_id
HAVING books_issued >
       (SELECT AVG(branch_count)
        FROM (
            SELECT COUNT(i2.issued_id) AS branch_count
            FROM employees e2
            JOIN issued_status i2 ON e2.emp_id = i2.issued_emp_id
            WHERE e2.branch_id = e.branch_id
            GROUP BY e2.emp_id
        ) AS sub);

-- Identify the most profitable category (highest revenue per issue).

SELECT 
    b.category,
    SUM(b.rental_price) AS total_revenue,
    COUNT(i.issued_id) AS total_issues,
    (SUM(b.rental_price) / COUNT(i.issued_id)) AS revenue_per_issue
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.category
ORDER BY revenue_per_issue DESC
LIMIT 1;

-- Find employees who handled 20%+ of total library issues.

WITH emp_issues AS (
    SELECT 
        e.emp_id,
        e.emp_name,
        COUNT(i.issued_id) AS total_issues
    FROM employees e
    JOIN issued_status i ON e.emp_id = i.issued_emp_id
    GROUP BY e.emp_id, e.emp_name
), total AS (
    SELECT SUM(total_issues) AS library_total FROM emp_issues
)
SELECT 
    ei.emp_id,
    ei.emp_name,
    ei.total_issues,
    ROUND(ei.total_issues / t.library_total * 100, 2) AS pct_share
FROM emp_issues ei, total t
WHERE ei.total_issues >= 0.20 * t.library_total
ORDER BY pct_share DESC;

-- Find members who issued a book again within 7 days of returning a previous one.

SELECT DISTINCT 
    m.member_id,
    m.member_name
FROM members m
JOIN issued_status i1 ON m.member_id = i1.issued_member_id
JOIN return_status r ON i1.issued_id = r.issued_id
JOIN issued_status i2 ON m.member_id = i2.issued_member_id
WHERE i2.issued_date > r.return_date
  AND DATEDIFF(i2.issued_date, r.return_date) <= 7;






















