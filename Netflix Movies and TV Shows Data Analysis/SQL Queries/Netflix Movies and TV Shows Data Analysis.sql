CREATE DATABASE netflix;

USE netflix;

-- Count total Movies & TV Shows
SELECT 
    type,
    COUNT(*) AS total_count
FROM netflix_titles
GROUP BY type;

--  List all unique ratings

SELECT DISTINCT rating 
FROM netflix_titles
ORDER BY rating;

-- List all movies released in a specific year 

SELECT * 
FROM netflix_titles
WHERE release_year = 2020;

-- Titles released after 2015
SELECT *
FROM netflix_titles
WHERE release_year > 2015;

-- Titles where description contains “crime”
SELECT *
FROM netflix_titles
WHERE description LIKE '%crime%';

-- Titles with rating = TV-MA
SELECT *
FROM netflix_titles
WHERE rating = 'TV-MA';

-- Count by rating
SELECT 
    rating, 
    COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;

-- Top 5 countries producing the most Netflix content
SELECT 
    country,
    COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;

-- Which movie in the Netflix dataset has the longest duration.

SELECT *
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC;

-- All Horror Movies.

SELECT *
FROM netflix_titles
WHERE listed_in LIKE '%Horror%';

-- Count of movies per genre.

SELECT 
    'Action' AS genre,
    COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = 'Movie'
  AND listed_in LIKE '%Action%';

-- Director with the most Netflix titles.

SELECT 
    director,
    COUNT(*) AS total_titles
FROM netflix_titles
WHERE director IS NOT NULL AND director <> ''
GROUP BY director
ORDER BY total_titles DESC
LIMIT 1;

-- Titles featuring a specific actor (Joseph Sargent).

SELECT *
FROM netflix_titles
WHERE director LIKE '%Joseph Sargent%';

-- Titles with no director.

SELECT *
FROM netflix_titles
WHERE director IS NULL OR director = '';

-- Oldest title on Netflix.

SELECT *
FROM netflix_titles
ORDER BY release_year
LIMIT 1;

-- Count titles per decade.

SELECT 
    (release_year / 10) * 10 AS decade,
    COUNT(*)
FROM netflix_titles
GROUP BY decade
ORDER BY decade;

-- Most common release year.

SELECT 
    release_year,
    COUNT(*) AS total
FROM netflix_titles
GROUP BY release_year
ORDER BY total DESC
LIMIT 1;

-- Titles mentioning “based on true events”.

SELECT *
FROM netflix_titles
WHERE description LIKE '%based on true events%';

-- Categorize titles as Good/Bad based on violence keywords
SELECT *,
    CASE 
        WHEN description LIKE '%kill%' 
          OR description LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS category
    FROM netflix_titles;
    
SELECT *
FROM netflix_titles
WHERE director LIKE '%K.S. Ravikumar%';

-- Count content by month of addition
SELECT 
    MONTHNAME(date_added) AS month_name,
    COUNT(*) AS total_content
FROM netflix_titles
GROUP BY MONTHNAME(date_added)
ORDER BY total_content DESC;

-- Year with the highest number of Netflix additions
SELECT 
    EXTRACT(YEAR FROM date_added) AS year_added,
    COUNT(*) AS total
FROM netflix_titles
GROUP BY year_added
ORDER BY total DESC
LIMIT 1;

-- Longest Movie
SELECT *
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;

-- TV Shows with more than 5 seasons
SELECT *
FROM netflix_titles
WHERE type = 'TV Show'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;

-- Country with the highest number of TV Shows
SELECT 
    country,
    COUNT(*) AS total_shows
FROM netflix_titles
WHERE type = 'TV Show'
GROUP BY country
ORDER BY total_shows DESC
LIMIT 1;

-- Top 10 most common words in description
SELECT 'love' AS word, COUNT(*) AS total FROM netflix_titles WHERE description LIKE '%love%'
UNION ALL
SELECT 'family', COUNT(*) FROM netflix_titles WHERE description LIKE '%family%'
UNION ALL
SELECT 'murder', COUNT(*) FROM netflix_titles WHERE description LIKE '%murder%'
UNION ALL
SELECT 'crime', COUNT(*) FROM netflix_titles WHERE description LIKE '%crime%'
UNION ALL
SELECT 'friendship', COUNT(*) FROM netflix_titles WHERE description LIKE '%friendship%';


-- Actors who appear together most often
WITH actors AS (
    SELECT 
        show_id,
        TRIM(JSON_UNQUOTE(JSON_EXTRACT(j.value, '$'))) AS actor
    FROM netflix_titles
    JOIN JSON_TABLE(
        CONCAT('["', REPLACE(cast, ',', '","'), '"]'),
        "$[*]" COLUMNS (value JSON PATH "$")
    ) AS j
)
SELECT 
    LEAST(a.actor, b.actor) AS actor1,
    GREATEST(a.actor, b.actor) AS actor2,
    COUNT(*) AS together_count
FROM actors a
JOIN actors b
    ON a.show_id = b.show_id
   AND a.actor < b.actor
GROUP BY actor1, actor2
ORDER BY together_count DESC
LIMIT 10;

-- Content that is both “Drama” AND “Romantic”
SELECT *
FROM netflix_titles
WHERE listed_in LIKE '%Drama%'
  AND listed_in LIKE '%Romantic%';

-- Multi-country productions (country contains commas)
SELECT *
FROM netflix_titles
WHERE country LIKE '%,%';    


WITH actors AS (
    SELECT 
        show_id,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n.n), ',', -1)) AS actor
    FROM netflix_titles
    JOIN (
        SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    ) n
    ON n.n <= 1 + LENGTH(cast) - LENGTH(REPLACE(cast, ',', ''))
)
SELECT actor, COUNT(*) AS total_titles
FROM actors
GROUP BY actor
ORDER BY total_titles DESC
LIMIT 20;


-- Actors with most unique co-actors (simple)
WITH actors AS (
    SELECT 
        show_id,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n.n), ',', -1)) AS actor
    FROM netflix_titles
    JOIN (
        SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    ) n
    ON n.n <= 1 + LENGTH(cast) - LENGTH(REPLACE(cast, ',', ''))
)
SELECT 
    a.actor,
    COUNT(DISTINCT b.actor) AS unique_coactors
FROM actors a
JOIN actors b 
    ON a.show_id = b.show_id 
    AND a.actor <> b.actor
GROUP BY a.actor
ORDER BY unique_coactors DESC
LIMIT 20;