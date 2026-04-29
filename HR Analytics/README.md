# 📊 HR Analytics — SQL Business Insights Project

> Extracting actionable workforce intelligence from an HR Analytics dataset using a structured progression from Basic through Intermediate SQL — covering attrition, compensation, satisfaction, career growth, and performance patterns.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Dataset](#dataset)
- [Schema Reference](#schema-reference)
- [SQL Topics Covered](#sql-topics-covered)
- [Analysis Goals](#analysis-goals)
- [Installation & Setup](#installation--setup)
- [Project Structure](#project-structure)
- [Sample Queries](#sample-queries)
- [Key Business Questions](#key-business-questions)
- [Tech Stack](#tech-stack)

---

## Project Overview

This project applies structured SQL analysis to a real-world **HR Analytics dataset** to surface business-critical insights across six analytical domains:

| Domain | Focus |
|---|---|
| **Employee Behavior** | Overtime patterns, travel frequency, work-life balance |
| **Attrition Analysis** | Who leaves, why, and from which departments |
| **Satisfaction Levels** | Job, environment, and relationship satisfaction drivers |
| **Career Growth** | Promotions, role tenure, manager relationships |
| **Compensation Structure** | Income distribution, salary slabs, hike patterns |
| **Performance Patterns** | Ratings, training frequency, job involvement |

The SQL skill progression moves deliberately from **Basic → Intermediate**, ensuring each concept is applied in a meaningful analytical context rather than in isolation.

---

## Dataset

| Property | Value |
|---|---|
| **Table Name** | `hr_analytics` |
| **Domain** | Human Resources / People Analytics |
| **Primary Task** | Exploratory Analysis & Business Reporting |
| **Total Columns** | 38 |
| **Key Entity** | Individual employees identified by `EmpID` |

---

## Schema Reference

### 🪪 Employee Identity

| Column | Type | Description |
|---|---|---|
| `EmpID` | TEXT | Unique employee identifier |
| `Age` | INT | Employee age in years |
| `Age_Group` | TEXT | Bucketed age category |
| `Gender` | TEXT | Employee gender |
| `Marital_Status` | TEXT | Single, Married, or Divorced |
| `Over_18` | TEXT | Age eligibility flag |
| `Employee_Count` | INT | Constant (used for aggregation) |
| `Employee_Number` | INT | Internal HR system number |

### 🏢 Organizational Details

| Column | Type | Description |
|---|---|---|
| `Department` | TEXT | Department name |
| `Job_Role` | TEXT | Employee's specific role |
| `JobLevel` | INT | Seniority level (1–5) |
| `Business_Travel` | TEXT | Travel frequency category |
| `Standard_Hours` | INT | Standard working hours |
| `Distance_FromHome` | TEXT | Commute distance category |

### 💰 Compensation

| Column | Type | Description |
|---|---|---|
| `MonthlyIncome` | INT | Monthly salary in USD |
| `Salary_Slab` | TEXT | Income bracket label |
| `DailyRate` | INT | Daily pay rate |
| `Hourly_Rate` | INT | Hourly pay rate |
| `Monthly_Rate` | INT | Monthly rate figure |
| `Percent_Salary_Hike` | INT | Last salary increase percentage |
| `Stock_Option_Level` | INT | Stock option tier (0–3) |

### 📈 Performance & Engagement

| Column | Type | Description |
|---|---|---|
| `Performance_Rating` | INT | Last performance rating (1–4) |
| `Job_Involvement` | INT | Involvement score (1–4) |
| `Training_Times_Last_Year` | INT | Number of training sessions attended |
| `OverTime` | TEXT | Whether the employee works overtime |

### 😊 Satisfaction Metrics

| Column | Type | Description |
|---|---|---|
| `Job_Satisfaction` | INT | Job satisfaction score (1–4) |
| `Environment_Satisfaction` | INT | Workplace environment score (1–4) |
| `Relationship_Satisfaction` | INT | Peer relationship score (1–4) |
| `Work_Life_Balance` | INT | Work-life balance score (1–4) |

### 🎓 Education

| Column | Type | Description |
|---|---|---|
| `Education` | INT | Education level (1–5) |
| `Education_Field` | TEXT | Field of study |
| `Number_Companies_Worked` | INT | Prior employers count |

### 📅 Career Timeline

| Column | Type | Description |
|---|---|---|
| `Total_Working_Years` | INT | Total professional experience |
| `Years_At_Company` | INT | Tenure at current company |
| `Years_In_Current_Role` | INT | Time in current role |
| `Years_Since_Last_Promotion` | INT | Years since last promotion |
| `Years_With_Current_Manager` | INT | Time reporting to current manager |

### 🚪 Attrition

| Column | Type | Description |
|---|---|---|
| `Attrition` | TEXT | Whether the employee left (`Yes` / `No`) |

---

## SQL Topics Covered

### 🔹 Basic SQL

Foundational concepts applied to direct data retrieval, filtering, and aggregation.

#### 1. Data Retrieval
```sql
SELECT        -- Column selection and projection
DISTINCT      -- Removing duplicate values
ORDER BY      -- Sorting results ascending or descending
```

#### 2. Filtering
```sql
WHERE                          -- Row-level filtering
=, >, <, !=                    -- Comparison operators
BETWEEN ... AND ...            -- Range filtering
IN (...)                       -- Set membership filtering
LIKE '%pattern%'               -- Pattern matching
```

#### 3. Aggregations
```sql
COUNT()   -- Row counts and frequency analysis
SUM()     -- Totals (e.g., total income by department)
AVG()     -- Averages (e.g., mean satisfaction score)
MIN()     -- Minimum values
MAX()     -- Maximum values
```

#### 4. Grouping
```sql
GROUP BY    -- Aggregating by category
HAVING      -- Filtering on aggregated results
```

#### 5. Table Operations
```sql
CREATE TABLE    -- Defining new tables
ALTER TABLE     -- Modifying existing schema
DROP TABLE      -- Removing tables
```

---

### 🔸 Intermediate SQL

Applied to multi-table analysis, business logic, reusable objects, and data integrity.

#### 1. Joins & Set Operations
```sql
INNER JOIN    -- Matching records across tables
LEFT JOIN     -- All left-side records with optional right match
RIGHT JOIN    -- All right-side records with optional left match
FULL JOIN     -- All records from both tables
UNION         -- Combined results, deduplicated
UNION ALL     -- Combined results, including duplicates
```

#### 2. Subqueries
```sql
-- Subquery in WHERE
SELECT * FROM hr_analytics
WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) FROM hr_analytics);

-- Subquery in SELECT
SELECT EmpID,
       (SELECT AVG(MonthlyIncome) FROM hr_analytics) AS company_avg
FROM hr_analytics;

-- Correlated subquery
SELECT EmpID, Department, MonthlyIncome
FROM hr_analytics a
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM hr_analytics b
    WHERE b.Department = a.Department
);
```

#### 3. String & Date Functions
```sql
CONCAT()          -- Combining text fields
UPPER(), LOWER()  -- Case transformation
SUBSTRING()       -- Extracting partial strings
DATEDIFF()        -- Date difference calculations
DATE_FORMAT()     -- Formatting date outputs
```

#### 4. Conditional Logic
```sql
CASE WHEN ... THEN ... ELSE ... END    -- Inline branching logic
IFNULL(expr, fallback)                 -- Null-safe substitution
COALESCE(expr1, expr2, ...)            -- First non-null selection
```

#### 5. Views
```sql
CREATE VIEW attrition_summary AS ...     -- Reusable query layer
CREATE OR REPLACE VIEW ...               -- Updating existing views
DROP VIEW IF EXISTS attrition_summary;   -- Removing views
```

#### 6. Constraints & Keys
```sql
PRIMARY KEY     -- Unique row identifier
FOREIGN KEY     -- Referential integrity across tables
UNIQUE          -- Enforcing uniqueness on a column
CHECK           -- Validating column value conditions
-- Self-Joins   -- Comparing rows within the same table
```

---

## Analysis Goals

| # | Business Question | SQL Concepts Used |
|---|---|---|
| 1 | What is the overall attrition rate by department? | `GROUP BY`, `COUNT()`, `HAVING` |
| 2 | Which job roles have the highest average monthly income? | `AVG()`, `ORDER BY`, `GROUP BY` |
| 3 | Do overtime employees have lower satisfaction scores? | `CASE WHEN`, `AVG()`, `WHERE` |
| 4 | Which employees earn above the company-wide average? | Subquery in `WHERE` |
| 5 | How does satisfaction vary by department vs. company average? | Correlated subquery |
| 6 | What is the attrition rate for each salary slab? | `GROUP BY`, `CASE WHEN` |
| 7 | Which employees haven't been promoted in over 5 years? | `WHERE`, `BETWEEN` |
| 8 | How does years of experience relate to job level? | `AVG()`, `GROUP BY`, `ORDER BY` |
| 9 | What training frequency correlates with high performance? | `AVG()`, `GROUP BY`, `HAVING` |
| 10 | Which departments have the highest stock option coverage? | `SUM()`, `GROUP BY`, `JOIN` |

---

## Installation & Setup

### Prerequisites

- MySQL 8.0+ / PostgreSQL 14+ / SQLite 3+
- Any SQL client: MySQL Workbench, DBeaver, pgAdmin, or VS Code with SQL extension

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/hr-analytics-sql.git
cd hr-analytics-sql
```

### 2. Create the Database

```sql
CREATE DATABASE hr_analytics_db;
USE hr_analytics_db;
```

### 3. Create the Table

```sql
CREATE TABLE hr_analytics (
    EmpID                      TEXT,
    Age                        INT,
    Age_Group                  TEXT,
    Attrition                  TEXT,
    Business_Travel            TEXT,
    DailyRate                  INT,
    Department                 TEXT,
    Distance_FromHome          TEXT,
    Education                  INT,
    Education_Field            TEXT,
    Employee_Count             INT,
    Employee_Number            INT,
    Environment_Satisfaction   INT,
    Gender                     TEXT,
    Hourly_Rate                INT,
    Job_Involvement            INT,
    JobLevel                   INT,
    Job_Role                   TEXT,
    Job_Satisfaction           INT,
    Marital_Status             TEXT,
    MonthlyIncome              INT,
    Salary_Slab                TEXT,
    Monthly_Rate               INT,
    Number_Companies_Worked    INT,
    Over_18                    TEXT,
    OverTime                   TEXT,
    Percent_Salary_Hike        INT,
    Performance_Rating         INT,
    Relationship_Satisfaction  INT,
    Standard_Hours             INT,
    Stock_Option_Level         INT,
    Total_Working_Years        INT,
    Training_Times_Last_Year   INT,
    Work_Life_Balance          INT,
    Years_At_Company           INT,
    Years_In_Current_Role      INT,
    Years_Since_Last_Promotion INT,
    Years_With_Current_Manager INT
);
```

### 4. Load the Data

```sql
-- MySQL
LOAD DATA INFILE 'hr_analytics.csv'
INTO TABLE hr_analytics
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

Or use your SQL client's built-in CSV import wizard.

### 5. Verify

```sql
SELECT COUNT(*) FROM hr_analytics;
SELECT * FROM hr_analytics LIMIT 5;
```

---

## Sample Queries

### Attrition Rate by Department

```sql
SELECT
    Department,
    COUNT(*)                                                                AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)                    AS attrited,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    )                                                                       AS attrition_rate_pct
FROM hr_analytics
GROUP BY Department
ORDER BY attrition_rate_pct DESC;
```

### Employees Earning Above Their Department Average

```sql
SELECT EmpID, Department, Job_Role, MonthlyIncome
FROM hr_analytics a
WHERE MonthlyIncome > (
    SELECT AVG(MonthlyIncome)
    FROM hr_analytics b
    WHERE b.Department = a.Department
)
ORDER BY Department, MonthlyIncome DESC;
```

### Satisfaction Breakdown by Overtime Status

```sql
SELECT
    OverTime,
    ROUND(AVG(Job_Satisfaction), 2)         AS avg_job_satisfaction,
    ROUND(AVG(Environment_Satisfaction), 2) AS avg_env_satisfaction,
    ROUND(AVG(Work_Life_Balance), 2)        AS avg_work_life_balance,
    COUNT(*)                                AS employee_count
FROM hr_analytics
GROUP BY OverTime;
```

### Employees Overdue for Promotion

```sql
SELECT EmpID, Job_Role, Department, Years_Since_Last_Promotion, JobLevel
FROM hr_analytics
WHERE Years_Since_Last_Promotion > 5
  AND Attrition = 'No'
ORDER BY Years_Since_Last_Promotion DESC;
```

### Create Reusable Attrition Summary View

```sql
CREATE VIEW attrition_summary AS
SELECT
    Department,
    Job_Role,
    Attrition,
    COUNT(*)                        AS headcount,
    ROUND(AVG(MonthlyIncome), 0)    AS avg_income,
    ROUND(AVG(Job_Satisfaction), 2) AS avg_satisfaction
FROM hr_analytics
GROUP BY Department, Job_Role, Attrition;
```

---

## Key Business Questions

```
├── Attrition
│   ├── Which department has the highest attrition rate?
│   ├── Does overtime significantly increase attrition likelihood?
│   ├── What salary slab sees the most departures?
│   └── Does distance from home influence attrition?
│
├── Compensation
│   ├── Which job roles command the highest average income?
│   ├── How does salary hike percentage vary by performance rating?
│   ├── Are stock options distributed equitably across job levels?
│   └── What is the income gap between genders per department?
│
├── Satisfaction
│   ├── Which departments have the lowest environment satisfaction?
│   ├── Does marital status correlate with work-life balance scores?
│   ├── Do high performers report higher job satisfaction?
│   └── How does training frequency affect satisfaction?
│
└── Career Growth
    ├── Which job levels have the longest promotion gaps?
    ├── Does manager tenure correlate with employee satisfaction?
    ├── How does number of prior companies relate to current job level?
    └── Which roles have the highest average years in current role?
```

---

## Project Structure

```
hr-analytics-sql/
│
├── data/
│   └── hr_analytics.csv                   # Raw dataset
│
├── schema/
│   └── create_table.sql                   # Table definition and constraints
│
├── queries/
│   ├── 01_basic/
│   │   ├── 01_data_retrieval.sql
│   │   ├── 02_filtering.sql
│   │   ├── 03_aggregations.sql
│   │   └── 04_grouping.sql
│   │
│   └── 02_intermediate/
│       ├── 05_joins.sql
│       ├── 06_subqueries.sql
│       ├── 07_string_functions.sql
│       ├── 08_case_when.sql
│       ├── 09_views.sql
│       └── 10_constraints_self_joins.sql
│
├── views/
│   └── attrition_summary.sql              # Reusable view definitions
│
└── README.md
```

---

## Tech Stack

| Tool | Purpose |
|---|---|
| **MySQL / PostgreSQL** | Query execution and database engine |
| **SQL** | Primary analysis language |
| **MySQL Workbench / DBeaver** | Query writing and result visualisation |
| **CSV** | Raw data format for import |

---

## License

This project is released under the [MIT License](LICENSE).

---

## Author

**Your Name**
[GitHub](https://github.com/your-username) · [LinkedIn](https://linkedin.com/in/your-profile) · [Email](mailto:you@example.com)

---

> *"Good SQL isn't just about getting the right answer — it's about writing queries that explain themselves. Every query in this project is structured to be readable, reproducible, and business-ready."*
