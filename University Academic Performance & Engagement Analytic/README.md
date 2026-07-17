# University Academic Performance & Engagement Analytics

A hands-on SQL workshop that takes you from beginner queries to data-science-grade
analytics — all inside a relational database. No Python, no pandas, no BI tool.
Just SQL, a realistic university dataset, and a progression of exercises that
build real analytical thinking.

---

## Table of Contents

- [Project Objective](#project-objective)
- [Domain](#domain)
- [Schema Overview](#schema-overview)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Data Characteristics](#data-characteristics)
- [Learning Path](#learning-path)
  - [1. Basic SQL](#1-basic-sql)
  - [2. Joins](#2-joins)
  - [3. Subqueries & CTEs](#3-subqueries--ctes)
  - [4. Window Functions](#4-window-functions)
  - [5. Statistical Analytics](#5-statistical-analytics)
  - [6. Data Cleaning](#6-data-cleaning)
  - [7. Optimization](#7-optimization)
  - [8. Advanced Data Science Tasks](#8-advanced-data-science-tasks)
- [Getting Started](#getting-started)
- [Suggested Repository Structure](#suggested-repository-structure)
- [Prerequisites](#prerequisites)
- [How to Use This Workshop](#how-to-use-this-workshop)

---

## Project Objective

This project is a complete, hands-on workshop that transforms a **SQL beginner**
into someone who can **query, analyze, and derive business insights** from a
relational database — entirely using SQL. Each module builds on the last, moving
from basic `SELECT` statements to statistical modeling and cohort analysis,
using nothing but the query language itself.

By the end of the workshop, you will be able to:

- Write clean, efficient, multi-table SQL queries
- Reason about data using window functions and CTEs
- Compute statistical measures (correlation, z-scores, regression) in raw SQL
- Clean and repair messy real-world data
- Reason about performance (indexing, `EXPLAIN`, partitioning)
- Perform data-science-style analysis (cohorts, retention, outliers, Bayesian
  probability, confusion matrices) without leaving the database

## Domain

The dataset focuses on **university academic life** — deliberately excluding
employee and product data (common in other SQL courses) so the workshop feels
fresh and directly relevant to education analytics:

- Student demographics
- Course grades
- Attendance patterns
- Extracurricular involvement
- Department performance

## Schema Overview

Five relational tables make up the schema:

| Table | Description |
|---|---|
| `departments` | Academic departments (CS, Math, Physics, Economics) |
| `students` | Student details (ID, name, DOB, gender, major, enrollment year, email) |
| `courses` | Course info (code, name, credits, offering department) |
| `enrollments` | **Fact table** — student-course registrations with grade, attendance, semester, year |
| `extracurricular_activities` | Student activities (name, hours/week, academic year) |

### Suggested Table Definitions

```sql
CREATE TABLE departments (
    department_id   INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    building        VARCHAR(100)
);

CREATE TABLE students (
    student_id      INTEGER PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    date_of_birth   DATE,
    gender          VARCHAR(10),
    major           VARCHAR(100),
    enrollment_year INTEGER,
    email           VARCHAR(150)
);

CREATE TABLE courses (
    course_code     VARCHAR(10) PRIMARY KEY,
    course_name     VARCHAR(150) NOT NULL,
    credits         INTEGER,
    department_id   INTEGER REFERENCES departments(department_id)
);

CREATE TABLE enrollments (
    enrollment_id   INTEGER PRIMARY KEY,
    student_id      INTEGER REFERENCES students(student_id),
    course_code     VARCHAR(10) REFERENCES courses(course_code),
    grade           INTEGER,          -- 63-95, NULLs allowed
    attendance_pct  DECIMAL(5,2),     -- 65-98%
    semester        VARCHAR(10),      -- Fall, Spring, Summer
    academic_year   INTEGER           -- 2019-2024
);

CREATE TABLE extracurricular_activities (
    activity_id     INTEGER PRIMARY KEY,
    student_id      INTEGER REFERENCES students(student_id),
    activity_name   VARCHAR(150),
    hours_per_week  DECIMAL(4,2),
    academic_year   INTEGER
);
```

## Entity Relationship Diagram

```
departments ──1:N──▶ courses ──1:N──▶ enrollments ◀──N:1── students ──1:N──▶ extracurricular_activities
```

- One department offers many courses
- One course has many enrollments
- One student has many enrollments and many activities
- `enrollments` is the central fact table joining students and courses

## Data Characteristics

| Metric | Value |
|---|---|
| Students | 20 |
| Courses | 10 |
| Enrollments | 80 |
| Activity records | 20 |
| Grade range | 63–95 (no failing grades, all ≥ 60) |
| Attendance range | 65–98% |
| Missing data | 1 `NULL` grade (intentional, for data-cleaning exercises) |
| Semesters | Fall, Spring, Summer |
| Years covered | 2019–2024 |

This scale is intentionally small — big enough to produce meaningful patterns,
small enough to eyeball and verify every query result by hand.

---

## Learning Path

### 1. Basic SQL
- `SELECT`, column aliasing, `DISTINCT`
- Filtering with `WHERE`, `BETWEEN`, `IN`, `LIKE`
- Sorting with `ORDER BY`
- Aggregation: `COUNT`, `AVG`, `SUM`, `MIN`, `MAX`, `GROUP BY`, `HAVING`

**Example:** Average grade per department.

### 2. Joins
- `INNER JOIN` — students matched to their enrollments
- `LEFT JOIN` / `RIGHT JOIN` — finding students with no activities
- Multi-table joins — students + enrollments + courses + departments in one query
- Self-join — comparing students within the same major or cohort year

### 3. Subqueries & CTEs
- Scalar and correlated subqueries (e.g., students above their department's average)
- Common Table Expressions (`WITH`) for readable, layered logic
- Recursive CTEs (optional extension, e.g., academic-year sequences)

### 4. Window Functions
- `RANK()`, `DENSE_RANK()` — ranking students within a course or department
- `LAG()` / `LEAD()` — semester-over-semester grade change
- Rolling averages — moving average of attendance over semesters
- `NTILE()` — splitting students into performance quartiles

### 5. Statistical Analytics
- Correlation between attendance and grade
- Z-score standardization of grades
- Histogram/bucket distribution of grades
- Entropy of grade distribution per department
- Linear regression slope (grade trend over academic years), computed with
  raw SQL aggregate math

### 6. Data Cleaning
- Detecting and handling `NULL` grades
- `CASE` statements for grade-to-letter conversion
- `COALESCE` for default/fallback values
- `UPDATE` statements to backfill or correct missing data

### 7. Optimization
- Creating indexes on foreign keys and frequently filtered columns
- Reading and interpreting `EXPLAIN` / `EXPLAIN ANALYZE` output
- Table partitioning strategies (e.g., by `academic_year`)
- Materialized views for precomputed department summaries

### 8. Advanced Data Science Tasks
- **Cohort analysis** — grouping students by enrollment year and tracking outcomes
- **Retention analysis** — which cohorts continue enrolling across semesters
- **Outlier detection** — students with abnormal grade/attendance combinations
- **Bayesian probability** — e.g., P(high grade | high attendance) using SQL aggregates
- **Confusion matrix** — comparing predicted vs. actual pass/fail-style labels
  built from grade thresholds

---

## Getting Started

1. Choose a database engine — PostgreSQL, MySQL, or SQLite all work; PostgreSQL
   is recommended for full window-function and materialized-view support.
2. Run the schema DDL (above or in `schema.sql`) to create the five tables.
3. Load the seed dataset (20 students, 10 courses, 80 enrollments, 20 activities).
4. Work through the modules in order — each one builds on concepts from the last.
5. Verify results by hand where possible; the dataset is small enough to sanity-check.

## Suggested Repository Structure

```
university-sql-analytics/
├── README.md
├── schema.sql                  # table definitions
├── seed_data.sql                # sample data (20 students, 10 courses, 80 enrollments, 20 activities)
├── 01_basic_sql.sql
├── 02_joins.sql
├── 03_subqueries_ctes.sql
├── 04_window_functions.sql
├── 05_statistical_analytics.sql
├── 06_data_cleaning.sql
├── 07_optimization.sql
└── 08_advanced_ds_tasks.sql
```

## Prerequisites

- Basic comfort with a command line or a SQL client (psql, MySQL Workbench,
  DBeaver, or similar)
- No prior SQL experience required to start Module 1
- No Python, R, or external tooling needed anywhere in this workshop

## How to Use This Workshop

Each module file is self-contained: it includes a short concept explanation,
one or more worked examples against this schema, and practice exercises with
expected results you can check against the seed dataset. Work sequentially —
later modules (statistics, optimization, advanced DS tasks) assume comfort
with joins, CTEs, and window functions from earlier modules.

---

*This workshop deliberately avoids employee and product datasets — common in
most SQL courses — in favor of a domain (higher education) that offers rich,
relatable examples of demographics, performance, and engagement analysis.*
