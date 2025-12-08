CREATE DATABASE spotify;

USE spotify;

RENAME TABLE spotify_dataset TO spotify;

-- BASIC QUESTIONS

-- 1.Tracks with more than 1B streams
SELECT Track, Stream
FROM spotify
WHERE Stream > 1000000000;

-- 2. List albums with their artists
SELECT Album, Artist
FROM spotify;

-- 3. Total comments where licensed = 'TRUE'
SELECT SUM(Comments) AS total_comments
FROM spotify
WHERE Licensed = 'TRUE';

-- 4. Tracks belonging to album type 'single'
SELECT Track
FROM spotify
WHERE Album_type = 'single';

-- 5. Count total tracks by each artist
SELECT Artist, COUNT(*) AS total_tracks
FROM spotify
GROUP BY Artist;

-- 6. Tracks with more than 5 minutes duration
SELECT Track, Duration_min
FROM spotify
WHERE Duration_min > 5;

-- 7. Tracks with more than 1M views
SELECT Track, Views
FROM spotify
WHERE Views > 1000000;

-- 8. List all unique album types
SELECT DISTINCT Album_type
FROM spotify;

-- 9. Artists with tracks having likes > 1M
SELECT DISTINCT Artist
FROM spotify
WHERE Likes > 1000000;

-- 10. Tracks with zero views OR zero streams
SELECT Track
FROM spotify
WHERE Views = 0 OR Stream = 0;

-- INTERMEDIATE  LEVEL  QUESTIONS

-- 1. Average danceability per album
SELECT Album, AVG(Danceability) AS avg_danceability
FROM spotify
GROUP BY Album;

-- 2. Top 5 tracks with highest energy
SELECT Track, Energy
FROM spotify
ORDER BY Energy DESC
LIMIT 5;

-- 3. Tracks where official_video = 'TRUE'
SELECT Track, Views, Likes
FROM spotify
WHERE official_video = 'TRUE';

-- 4. Total views per album
SELECT Album, SUM(Views) AS total_views
FROM spotify
GROUP BY Album;

-- 5. Tracks where Stream > Views
SELECT Track, Stream, Views
FROM spotify
WHERE Stream > Views;

-- 6. High valence (>0.75) ordered by likes
SELECT Track, Valence, Likes
FROM spotify
WHERE Valence > 0.75
ORDER BY Likes DESC;

-- 7. Average loudness per artist
SELECT Artist, AVG(Loudness) AS avg_loudness
FROM spotify
GROUP BY Artist;

-- 8. Tracks longer than average duration
SELECT Track, Duration_min
FROM spotify
WHERE Duration_min > (SELECT AVG(Duration_min) FROM spotify_dataset);

-- 9. Most viewed track per album
SELECT Album, Track, Views
FROM (
    SELECT Album, Track, Views,
           ROW_NUMBER() OVER(PARTITION BY Album ORDER BY Views DESC) AS rnk
    FROM spotify
) t
WHERE rnk = 1;

-- 10. Albums with more than 10 tracks
SELECT Album, COUNT(*) AS track_count
FROM spotify
GROUP BY Album
HAVING COUNT(*) > 10;

-- ADVANCED LEVEL QUESTIONS
-- 1. Top 3 most-viewed tracks per artist
SELECT Artist, Track, Views
FROM (
      SELECT Artist, Track, Views,
             ROW_NUMBER() OVER(PARTITION BY Artist ORDER BY Views DESC) AS rnk
      FROM spotify
) t
WHERE rnk <= 3;

-- 2. Tracks with liveness above average
SELECT Track, Liveness
FROM spotify
WHERE Liveness > (SELECT AVG(Liveness) FROM spotify_dataset);

-- 3. Energy difference per album (max - min)
WITH energy_stats AS (
    SELECT Album,
           MAX(Energy) AS max_energy,
           MIN(Energy) AS min_energy
    FROM spotify
    GROUP BY Album
)
SELECT Album, (max_energy - min_energy) AS energy_difference
FROM energy_stats;

-- 4. Running total of streams per artist
SELECT Artist, Track, Stream,
       SUM(Stream) OVER(
            PARTITION BY Artist
            ORDER BY Stream DESC
       ) AS running_total
FROM spotify;

-- 5. Tracks in the top 10% based on Views
SELECT Track, Views
FROM (
      SELECT Track, Views,
             NTILE(10) OVER (ORDER BY Views DESC) AS bucket
      FROM spotify
) t
WHERE bucket = 1;

-- 6. Artists with above-average energy
SELECT Artist
FROM spotify
GROUP BY Artist
HAVING AVG(Energy) > (SELECT AVG(Energy) FROM spotify_dataset);

-- 7. Tracks with high danceability & valence
SELECT Track, Danceability, Valence
FROM spotify
WHERE Danceability > 0.7 AND Valence > 0.7;

-- 8. Latest track per channel (using most_playedon text field)

SELECT Channel, Track, most_playedon
FROM (
    SELECT Channel, Track, most_playedon,
           ROW_NUMBER() OVER(PARTITION BY Channel ORDER BY most_playedon DESC) AS rnk
    FROM spotify
) t
WHERE rnk = 1;

-- 9. Top 5% albums by views
WITH album_views AS (
    SELECT Album, SUM(Views) AS total_views
    FROM spotify
    GROUP BY Album
)
SELECT Album, total_views
FROM (
      SELECT Album, total_views,
             NTILE(20) OVER(ORDER BY total_views DESC) AS bucket
      FROM album_views
) t
WHERE bucket = 1;

-- 10. Tracks within ±5 BPM of artist’s average tempo
SELECT Artist, Track, Tempo
FROM (
      SELECT Artist, Track, Tempo,
             AVG(Tempo) OVER(PARTITION BY Artist) AS avg_tempo
      FROM spotify
) t
WHERE ABS(Tempo - avg_tempo) <= 5;