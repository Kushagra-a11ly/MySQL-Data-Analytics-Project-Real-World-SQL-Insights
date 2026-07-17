# 🎓 University Analytics Dataset

A relational dataset simulating a university academic environment, designed for data analysis, SQL practice, and academic performance research.

---

## 📁 Dataset Files

| File | Table | Rows |
|------|-------|------|
| `departments.csv` | departments | 4 |
| `students.csv` | students | 20 |
| `courses.csv` | courses | 10 |
| `enrollments.csv` | enrollments | 80 |
| `extracurricular_activities.csv` | extracurricular_activities | 20 |

All tables are also available as sheets in `university_analytics.xlsx`.

---

## 🗃️ Schema & Data Dictionary

### 1. `departments`
Stores the academic departments in the university.

| Column | Type | Description |
|--------|------|-------------|
| `dept_id` | INT (PK) | Unique department identifier |
| `dept_name` | VARCHAR | Name of the department (unique) |

**Departments:** Computer Science, Mathematics, Physics, Economics

---

### 2. `students`
Contains personal and academic information for each student.

| Column | Type | Description |
|--------|------|-------------|
| `student_id` | INT (PK) | Unique student identifier (101–120) |
| `first_name` | VARCHAR | Student's first name |
| `last_name` | VARCHAR | Student's last name |
| `date_of_birth` | DATE | Format: YYYY-MM-DD |
| `gender` | ENUM | `M`, `F`, or `Other` |
| `major_dept_id` | INT (FK) | References `departments.dept_id` |
| `enrollment_year` | INT | Year the student enrolled (2019–2022) |
| `email` | VARCHAR | Unique university email address |

---

### 3. `courses`
Lists all available courses and their department associations.

| Column | Type | Description |
|--------|------|-------------|
| `course_id` | INT (PK) | Unique course identifier |
| `course_code` | VARCHAR | Short code e.g. `CS101`, `MATH150` |
| `course_name` | VARCHAR | Full name of the course |
| `credits` | INT | Credit hours (valid values: 1–6) |
| `dept_id` | INT (FK) | References `departments.dept_id` |

---

### 4. `enrollments`
Core fact table recording student grades and attendance per course per semester.

| Column | Type | Description |
|--------|------|-------------|
| `enrollment_id` | INT (PK) | Unique enrollment record identifier |
| `student_id` | INT (FK) | References `students.student_id` |
| `course_id` | INT (FK) | References `courses.course_id` |
| `semester` | ENUM | `Fall`, `Spring`, or `Summer` |
| `year` | INT | Academic year of enrollment |
| `grade_numeric` | DECIMAL | Grade out of 100 (nullable — see notes) |
| `attendance_percentage` | DECIMAL | Attendance out of 100 |

---

### 5. `extracurricular_activities`
Tracks student participation in extracurricular activities for correlation analysis.

| Column | Type | Description |
|--------|------|-------------|
| `activity_id` | INT (PK) | Unique activity record identifier |
| `student_id` | INT (FK) | References `students.student_id` |
| `activity_name` | VARCHAR | Name of the activity (e.g. Chess Club, Basketball) |
| `hours_per_week` | DECIMAL | Hours spent per week on the activity |
| `academic_year` | INT | Year of participation |

**Activities include:** Chess Club, Basketball, Debate Team, Music Band, Volunteering, Coding Club, Swimming

---

## 🔗 Entity Relationships

```
departments
    ├── students        (via major_dept_id)
    └── courses         (via dept_id)
            └── enrollments   (via course_id)
students
    ├── enrollments     (via student_id)
    └── extracurricular_activities (via student_id)
```

---

## ⚠️ Data Notes

- **NULLs in `grade_numeric`:** 1 record (enrollment_id = 20, student Grace Martinez) has a NULL grade — handle with `IS NOT NULL` filters or imputation as needed.
- **Year range:** Enrollment years span 2019–2024.
- **One student per activity:** Each student has exactly one extracurricular record.
- **Multiple enrollments per student:** Students appear multiple times in `enrollments` across semesters and years.
- **Grades range:** 63.0 to 95.0 out of 100 across all records.
- **Attendance range:** 65.0 to 98.0 out of 100.

---

## 🚀 How to Use

### Load CSVs in Python (pandas)
```python
import pandas as pd

departments = pd.read_csv('departments.csv')
students    = pd.read_csv('students.csv')
courses     = pd.read_csv('courses.csv')
enrollments = pd.read_csv('enrollments.csv')
activities  = pd.read_csv('extracurricular_activities.csv')
```

### Load into MySQL
```sql
CREATE DATABASE IF NOT EXISTS university_analytics;
USE university_analytics;
-- Then run the full SQL script to create tables and insert data.
```

### Load Excel file
Open `university_analytics.xlsx` in Excel or Google Sheets — each table is a separate sheet.

---

## 💡 Analysis Ideas

- **GPA analysis** — Average grade per student, per department, per semester
- **Attendance vs. grades** — Correlation between attendance and academic performance
- **Extracurricular impact** — Does activity type or hours per week affect grades?
- **Department comparison** — Which department has the highest/lowest average grades?
- **Semester trends** — Do grades improve or decline over time for individual students?

---

## 📋 Dataset Summary

| Property | Value |
|----------|-------|
| Total students | 20 |
| Total courses | 10 |
| Total enrollment records | 80 |
| Departments | 4 |
| Semesters covered | Fall, Spring, Summer |
| Year range | 2019 – 2024 |
| Missing values | 1 (grade_numeric) |

---

*Dataset created for educational and analytical purposes.*
