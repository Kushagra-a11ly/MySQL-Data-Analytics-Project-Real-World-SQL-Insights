📌 Introduction

This dataset is part of the MySQL Data Analytics Project – Real World SQL Insights and represents a simplified Library Management System.

It contains CSV files that model books, members, employees, branches, and transaction statuses such as issuing and returning books.

The dataset can be used for SQL practice, data analytics, data modeling, or ETL learning.

📂 Dataset Contents

The folder includes the following CSV files:

File Name	Description

1.books.csv	Contains information about all books available in the library (title, author, genre, etc.).

2.branch.csv	Contains details of different library branches.

3.employees.csv	Stores employee records assigned to specific branches.

4.issued_status.csv	Records of books issued to members, including issue dates.

5.members.csv	Contains member details such as name, contact info, and membership type.

6.return_status.csv	Tracks book returns, including return dates and penalties (if any).

🧱 Database Structure (High-Level)

This dataset supports a relational structure commonly used in library systems:

•	books ↔ issued_status (one-to-many)

•	members ↔ issued_status (one-to-many)

•	issued_status ↔ return_status (one-to-one)

•	branch ↔ employees (one-to-many)

•	books may also be associated with a branch (if applicable in your schema)

If you want, I can generate a full ER diagram (ERD) from these CSVs.

🔧 Installation & Setup
1. Clone the Repository

git clone <your-repo-url>

cd Library Management System/Dataset

2. Import CSV Files Into MySQL

You can load the data using:

Option A — MySQL Workbench

•	Create a new schema (e.g., library_db)

•	Right-click each table → Table Data Import Wizard

Option B — Command Line

LOAD DATA INFILE 'path/books.csv'

INTO TABLE books

FIELDS TERMINATED BY ','

IGNORE 1 LINES;

(Repeat for the other tables.)

📊 Example Use Cases

You can use this dataset to practice:

✔ Writing SQL queries

•	Top borrowed books

•	Overdue books

•	Branch with highest activity

•	Employee distribution

✔ Analytical insights

•	Popular genres

•	Member borrowing behavior

•	Peak issue/return periods

✔ Creating dashboards (Power BI, Tableau)

•	Book circulation metrics

•	Branch performance overview


🧪 Sample Queries
-- 1. Find the top 10 most issued books

SELECT book_id, COUNT(*) AS issue_count

FROM issued_status

GROUP BY book_id

ORDER BY issue_count DESC

LIMIT 10;

-- 2. Books not returned yet

SELECT i.issue_id, i.book_id, i.member_id

FROM issued_status i

LEFT JOIN return_status r

ON i.issue_id = r.issue_id

WHERE r.issue_id IS NULL;

📝 Notes & Assumptions

•	CSV headers may need minor formatting depending on your SQL schema.

•	Date columns should be stored as DATE or DATETIME.

•	Primary and foreign keys should be added during table creation.

📜 License

If you want a specific license (MIT, Apache-2.0, etc.), let me know and I’ll add it.

👥 Contributors

•	Kushagra Mukund Dhamani




