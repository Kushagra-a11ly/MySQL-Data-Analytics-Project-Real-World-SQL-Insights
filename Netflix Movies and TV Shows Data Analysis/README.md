![image alt](https://github.com/Kushagra-a11ly/MySQL-Data-Analytics-Project-Real-World-SQL-Insights/blob/77195de5019ba41f39d56d5db28dcdbe3a6c64d0/Netflix%20Movies%20and%20TV%20Shows%20Data%20Analysis/logo.png)


# 🎬 Netflix Movies & TV Shows — Data Analysis using MySQL

A comprehensive SQL-based analytical project exploring the Netflix Movies and TV Shows dataset to uncover trends in content strategy, genre distribution, geographic reach, and audience segmentation.

---

## 📘 Project Overview

This project delivers deep analytical insights from the popular **Netflix Movies and TV Shows dataset** using **MySQL**. It focuses on exploring global streaming content trends, uncovering patterns in genres, release years, cast collaborations, ratings, and country-wise distribution.

The goal is to demonstrate real-world SQL data analysis skills — showcasing the ability to convert a raw, semi-structured dataset into clear, business-ready insights using clean and efficient query design.

---

## 🎯 Objectives

- Analyze the content library structure and trends
- Explore genre and category distributions
- Study country-wise content production
- Examine director and cast collaboration patterns
- Investigate ratings, durations, and release-year evolution
- Create SQL-based insights comparable to industry analytics tasks

---

## 🗂 Dataset Description

The dataset contains metadata for all movies and TV shows available on Netflix.

| Column | Description |
|---|---|
| `show_id` | Unique identifier for each title |
| `type` | Content type — Movie or TV Show |
| `title` | Name of the content |
| `director` | Director(s) of the content |
| `cast` | Main actors featured |
| `country` | Country of origin |
| `date_added` | Date the content was added to Netflix |
| `release_year` | Original year of release |
| `rating` | Content rating (TV-MA, PG, TV-14, etc.) |
| `duration` | Movie runtime (minutes) or number of seasons |
| `listed_in` | Genre(s) / category tags |
| `description` | Short summary of the content |

---

## 🛠 Tech Stack

- **Database:** MySQL 8.0+
- **Tools:** MySQL Workbench / CLI
- **Techniques:** Joins, CTEs, Window Functions, String Functions, Aggregations

---

## 🧱 Table Schema

```sql
CREATE TABLE netflix (
    show_id      VARCHAR(10) PRIMARY KEY,
    type         VARCHAR(10),
    title        VARCHAR(255),
    director     VARCHAR(255),
    cast_members TEXT,
    country      VARCHAR(255),
    date_added   DATE,
    release_year INT,
    rating       VARCHAR(10),
    duration     VARCHAR(20),
    listed_in    VARCHAR(255),
    description  TEXT
);
```

---

## 🔍 What This Project Demonstrates

- Clean, professional MySQL query-writing
- Complex filtering and aggregation logic
- Pattern analysis and text parsing on multi-valued fields
- Date-based trend discovery
- Real-world analytics thinking
- Industry-standard SQL exploration techniques

---

## 🚀 Key Business Questions & Insights Answered

1. Most dominant genres on Netflix
2. Countries producing the maximum content
3. Most frequent actor collaborations
4. Rating distribution and audience segmentation
5. Year-wise evolution of Movies vs. TV Shows
6. Longest-running TV shows and longest movies
7. Directors with the highest number of titles
8. Keyword frequency patterns in content descriptions

---

## 💡 Sample Queries

**1. Count of Movies vs. TV Shows**
```sql
SELECT type, COUNT(*) AS total_titles
FROM netflix
GROUP BY type;
```

**2. Top 10 Countries by Content Volume**
```sql
SELECT TRIM(SUBSTRING_INDEX(country, ',', 1)) AS primary_country,
       COUNT(*) AS total_titles
FROM netflix
WHERE country IS NOT NULL
GROUP BY primary_country
ORDER BY total_titles DESC
LIMIT 10;
```

**3. Most Common Genres**
```sql
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n.n), ',', -1)) AS genre,
       COUNT(*) AS genre_count
FROM netflix
JOIN (SELECT 1 n UNION SELECT 2 UNION SELECT 3) n
  ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n.n - 1
GROUP BY genre
ORDER BY genre_count DESC
LIMIT 10;
```

**4. Directors with Most Titles**
```sql
SELECT director, COUNT(*) AS total_titles
FROM netflix
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;
```

**5. Year-wise Trend of Movies vs. TV Shows Added**
```sql
SELECT YEAR(date_added) AS year_added, type, COUNT(*) AS total
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added;
```

**6. Longest Movies**
```sql
SELECT title, CAST(REPLACE(duration, ' min', '') AS UNSIGNED) AS duration_minutes
FROM netflix
WHERE type = 'Movie' AND duration LIKE '%min%'
ORDER BY duration_minutes DESC
LIMIT 10;
```

**7. Rating-wise Content Distribution**
```sql
SELECT rating, COUNT(*) AS total_titles
FROM netflix
GROUP BY rating
ORDER BY total_titles DESC;
```

**8. Most Frequent Actor Pairings**
```sql
-- Uses a self-join on a normalized cast table to find actors
-- who most frequently appear together in the same title
SELECT c1.actor AS actor_1, c2.actor AS actor_2, COUNT(*) AS collaborations
FROM netflix_cast c1
JOIN netflix_cast c2
  ON c1.show_id = c2.show_id AND c1.actor < c2.actor
GROUP BY actor_1, actor_2
ORDER BY collaborations DESC
LIMIT 10;
```

---

## 🧩 Skills Demonstrated

- MySQL Querying
- Data Cleaning with SQL
- Exploratory Data Analysis (EDA)
- Joins, Aggregations, and Window Functions
- Text Analysis using String Functions
- Trend and Pattern Discovery

---

## 📁 Project Structure

```
netflix-sql-analysis/
│
├── data/
│   └── netflix_titles.csv
│
├── sql/
│   ├── 01_schema_creation.sql
│   ├── 02_data_cleaning.sql
│   └── 03_analysis_queries.sql
│
└── README.md
```

---

## ✅ Conclusion

This project illustrates how raw streaming metadata can be transformed into actionable insights using pure SQL — without external BI tools. It reflects practical, interview-ready analytical thinking applicable to real-world data analyst and business intelligence roles.

---

## 👤 Author

**[Your Name]**
Data Analyst | SQL Enthusiast
