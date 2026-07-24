-- 1. List all students with their full name and email.
SELECT CONCAT(first_name,' ',last_name) AS full_name, email
FROM students;

-- 2. Show all courses that have 4 credits.
SELECT *
FROM courses
WHERE credits = 4;

-- 3. Retrieve distinct semesters present in the enrollments table.
SELECT DISTINCT semester
FROM enrollments;

-- 4. Count the total number of students.
SELECT COUNT(*) AS total_students
FROM students;

-- 5. Display the names of all departments.
SELECT dept_name
FROM departments;

-- 6. Find the oldest student’s date of birth.
SELECT MIN(date_of_birth) AS oldest_dob
FROM students;

-- 7. Show all enrollments where grade is NULL.
SELECT *
FROM enrollments
WHERE grade_numeric IS NULL;

-- 8. Get the average attendance percentage across all enrollments.
SELECT AVG(attendance_percentage) AS avg_attendance
FROM enrollments;

-- 9. List students enrolled in 2020 or later.
SELECT *
FROM students
WHERE enrollment_year >= 2020;

-- 10. Display courses sorted by course_code.
SELECT *
FROM courses
ORDER BY course_code;

-- 11. Count the number of female students.
SELECT COUNT(*) AS female_students
FROM students
WHERE gender = 'F';

-- 12. Find distinct academic years from extracurricular activities.
SELECT DISTINCT academic_year
FROM extracurricular_activities;

-- 13. Show students whose first name starts with 'A'.
SELECT *
FROM students
WHERE first_name LIKE 'A%';

-- 14. Retrieve the minimum and maximum grade_numeric.
SELECT MIN(grade_numeric) AS min_grade,
       MAX(grade_numeric) AS max_grade
FROM enrollments;

-- 15. List all enrollments from the Fall semester.
SELECT *
FROM enrollments
WHERE semester = 'Fall';

-- 16. Count how many courses each department offers.
SELECT dept_id,
       COUNT(*) AS total_courses
FROM courses
GROUP BY dept_id;

-- 17. Show student names and their majors.
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
       d.dept_name
FROM students s
JOIN departments d
ON s.major_dept_id = d.dept_id;

-- 18. Find students born after 2001-01-01.
SELECT *
FROM students
WHERE date_of_birth > '2001-01-01';

-- 19. Display all unique activity names.
SELECT DISTINCT activity_name
FROM extracurricular_activities;

-- 20. Count total enrollments per year.
SELECT year,
       COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY year;

-- 21. Find students with attendance below 75%.
SELECT DISTINCT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.attendance_percentage < 75;

-- 22. Show enrollments where grade is between 80 and 90.
SELECT *
FROM enrollments
WHERE grade_numeric BETWEEN 80 AND 90;

-- 23. List courses with 'Data' in their name.
SELECT *
FROM courses
WHERE course_name LIKE '%Data%';

-- 24. Find students whose last name ends with 'son'.
SELECT *
FROM students
WHERE last_name LIKE '%son';

-- 25. Show enrollments from Spring 2020 with grade > 85.
SELECT *
FROM enrollments
WHERE semester='Spring'
AND year=2020
AND grade_numeric>85;

-- 26. Retrieve students with no extracurricular activity.
SELECT s.*
FROM students s
LEFT JOIN extracurricular_activities ea
ON s.student_id = ea.student_id
WHERE ea.student_id IS NULL;

-- 27. Find courses that have never been enrolled.
SELECT c.*
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

-- 28. Show students whose major is Computer Science and enrolled after 2020.
SELECT *
FROM students
WHERE major_dept_id = 1
AND enrollment_year > 2020;

-- 29. List enrollments with grade < 60 ordered by grade ascending.
SELECT *
FROM enrollments
WHERE grade_numeric < 60
ORDER BY grade_numeric ASC;

-- 30. Find students with a 'gmail.com' email domain.
SELECT *
FROM students
WHERE email LIKE '%@gmail.com';

-- 31. Show activities where hours_per_week > 5.
SELECT *
FROM extracurricular_activities
WHERE hours_per_week > 5;

-- 32. Retrieve courses with credits > 3 from Mathematics department.
SELECT c.*
FROM courses c
JOIN departments d
ON c.dept_id = d.dept_id
WHERE c.credits > 3
AND d.dept_name = 'Mathematics';

-- 33. Find students born in 2000.
SELECT *
FROM students
WHERE YEAR(date_of_birth) = 2000;

-- 34. Show enrollments from Summer semester with grade above 80.
SELECT *
FROM enrollments
WHERE semester='Summer'
AND grade_numeric>80;

-- 35. List students who have taken both CS101 and CS201.
SELECT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_code IN ('CS101','CS201')
GROUP BY s.student_id, student_name
HAVING COUNT(DISTINCT c.course_code)=2;

-- 36. Find courses that have at least 5 enrollments.
SELECT course_id,
       COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY course_id
HAVING COUNT(*)>=5;

-- 37. Show students whose major department ID is 1 or 2.
SELECT *
FROM students
WHERE major_dept_id IN (1,2);

-- 38. Retrieve enrollments where attendance is NULL.
SELECT *
FROM enrollments
WHERE attendance_percentage IS NULL;

-- 39. Find the two highest grades in each course.
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY course_id ORDER BY grade_numeric DESC) AS rnk
    FROM enrollments
) t
WHERE rnk<=2;

-- 40. List students who have enrolled in at least 3 different semesters.
SELECT student_id
FROM enrollments
GROUP BY student_id
HAVING COUNT(DISTINCT semester)>=3;

-- 41. Average grade per course.
SELECT course_id,
       AVG(grade_numeric) AS avg_grade
FROM enrollments
GROUP BY course_id;

-- 42. Count of students per major department.
SELECT major_dept_id,
       COUNT(*) AS total_students
FROM students
GROUP BY major_dept_id;

-- 43. Maximum grade per semester per year.
SELECT semester,
       year,
       MAX(grade_numeric) AS max_grade
FROM enrollments
GROUP BY semester, year;

-- 44. Total credits attempted by each student.
SELECT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name,
       SUM(c.credits) AS total_credits
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN courses c
ON e.course_id=c.course_id
GROUP BY s.student_id, student_name;

-- 45. Average attendance per course.
SELECT course_id,
       AVG(attendance_percentage) AS avg_attendance
FROM enrollments
GROUP BY course_id;

-- 46. Standard deviation of grades for each department.
SELECT c.dept_id,
       STDDEV(grade_numeric) AS std_deviation
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id
GROUP BY c.dept_id;

-- 47. Count of distinct students per activity.
SELECT activity_name,
       COUNT(DISTINCT student_id) AS total_students
FROM extracurricular_activities
GROUP BY activity_name;

-- 48. Minimum, maximum, average grade per year.
SELECT year,
       MIN(grade_numeric) AS min_grade,
       MAX(grade_numeric) AS max_grade,
       AVG(grade_numeric) AS avg_grade
FROM enrollments
GROUP BY year;

-- 49. Total hours per week spent on extracurriculars per student.
SELECT student_id,
       SUM(hours_per_week) AS total_hours
FROM extracurricular_activities
GROUP BY student_id;

-- 50. Median grade (using window function).
SELECT semester,
       AVG(grade_numeric) AS median_grade
FROM (
    SELECT semester,
           grade_numeric,
           ROW_NUMBER() OVER(PARTITION BY semester ORDER BY grade_numeric) AS rn,
           COUNT(*) OVER(PARTITION BY semester) AS cnt
    FROM enrollments
    WHERE grade_numeric IS NOT NULL
) x
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2))
GROUP BY semester;

-- 51. Median grade (using percentile approximation) per semester
SELECT semester,
       AVG(grade_numeric) AS median_grade
FROM (
    SELECT semester,
           grade_numeric,
           ROW_NUMBER() OVER(PARTITION BY semester ORDER BY grade_numeric) AS rn,
           COUNT(*) OVER(PARTITION BY semester) AS cnt
    FROM enrollments
    WHERE grade_numeric IS NOT NULL
) t
WHERE rn IN (FLOOR((cnt+1)/2), FLOOR((cnt+2)/2))
GROUP BY semester;

-- 52. Grade variance per course
SELECT course_id,
       VARIANCE(grade_numeric) AS grade_variance
FROM enrollments
GROUP BY course_id;

-- 53. Number of students who passed (>60) vs failed (<60) per course
SELECT course_id,
       SUM(CASE WHEN grade_numeric >= 60 THEN 1 ELSE 0 END) AS passed,
       SUM(CASE WHEN grade_numeric < 60 THEN 1 ELSE 0 END) AS failed
FROM enrollments
GROUP BY course_id;

-- 54. Average grade for male vs female students
SELECT s.gender,
       AVG(e.grade_numeric) AS avg_grade
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.gender;

-- 55. Count of courses taken per student
SELECT student_id,
       COUNT(course_id) AS courses_taken
FROM enrollments
GROUP BY student_id;

-- 56. Semester with the highest average grade
SELECT semester,
       AVG(grade_numeric) AS avg_grade
FROM enrollments
GROUP BY semester
ORDER BY avg_grade DESC
LIMIT 1;

-- 57. Percentage of students with attendance > 80% per course
SELECT course_id,
ROUND(100 * SUM(CASE WHEN attendance_percentage > 80 THEN 1 ELSE 0 END) / COUNT(*),2)
AS percentage_above_80
FROM enrollments
GROUP BY course_id;

-- 58. Average grade grouped by credit hours of courses
SELECT c.credits,
       AVG(e.grade_numeric) AS avg_grade
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.credits;

-- 59. Number of enrollments with missing grades per year
SELECT year,
       COUNT(*) AS missing_grades
FROM enrollments
WHERE grade_numeric IS NULL
GROUP BY year;

-- 60. Mean grade difference between Fall and Spring semesters
SELECT
(
 (SELECT AVG(grade_numeric)
  FROM enrollments
  WHERE semester='Fall')
-
 (SELECT AVG(grade_numeric)
  FROM enrollments
  WHERE semester='Spring')
) AS mean_difference;

-- 61. Top 3 courses by average grade
SELECT c.course_name,
       AVG(e.grade_numeric) AS avg_grade
FROM courses c
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name
ORDER BY avg_grade DESC
LIMIT 3;

-- 62. Distribution of grades (10-point buckets)
SELECT
CONCAT(FLOOR(grade_numeric/10)*10,'-',
       FLOOR(grade_numeric/10)*10+9) AS grade_bucket,
COUNT(*) AS frequency
FROM enrollments
WHERE grade_numeric IS NOT NULL
GROUP BY FLOOR(grade_numeric/10)
ORDER BY FLOOR(grade_numeric/10);

-- 63. Correlation (Pearson) between attendance and grade
SELECT
(
COUNT(*)*SUM(attendance_percentage*grade_numeric)
-
SUM(attendance_percentage)*SUM(grade_numeric)
)
/
SQRT(
(COUNT(*)*SUM(POW(attendance_percentage,2))-POW(SUM(attendance_percentage),2))
*
(COUNT(*)*SUM(POW(grade_numeric,2))-POW(SUM(grade_numeric),2))
) AS pearson_r
FROM enrollments
WHERE grade_numeric IS NOT NULL;

-- 64. Number of students who improved grade from previous semester
WITH grade_history AS
(
SELECT student_id,
       year,
       semester,
       grade_numeric,
       LAG(grade_numeric)
       OVER(PARTITION BY student_id ORDER BY year,semester) AS previous_grade
FROM enrollments
)
SELECT COUNT(DISTINCT student_id) AS improved_students
FROM grade_history
WHERE grade_numeric > previous_grade;

-- 65. Most popular extracurricular activity
SELECT activity_name,
       COUNT(*) AS participants
FROM extracurricular_activities
GROUP BY activity_name
ORDER BY participants DESC
LIMIT 1;

-- 66. Average grade of students who do vs don't do extracurriculars
SELECT
CASE
WHEN ea.student_id IS NULL THEN 'No Activity'
ELSE 'Activity'
END AS category,
AVG(e.grade_numeric) AS avg_grade
FROM students s
LEFT JOIN extracurricular_activities ea
ON s.student_id=ea.student_id
JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY category;

-- 67. Year-over-year change in average grade
WITH yearly_avg AS
(
SELECT year,
AVG(grade_numeric) avg_grade
FROM enrollments
GROUP BY year
)
SELECT year,
avg_grade,
avg_grade-LAG(avg_grade)
OVER(ORDER BY year) AS yearly_change
FROM yearly_avg;

-- 68. Count of students who took more than 5 courses
SELECT COUNT(*) AS students_over_5_courses
FROM
(
SELECT student_id
FROM enrollments
GROUP BY student_id
HAVING COUNT(*)>5
)t;

-- 69. Grade summary per student
SELECT student_id,
MIN(grade_numeric) AS min_grade,
MAX(grade_numeric) AS max_grade,
AVG(grade_numeric) AS avg_grade,
COUNT(*) AS total_courses
FROM enrollments
GROUP BY student_id;

-- 70. Percentage of students with grade above department average
SELECT
ROUND(
100*
COUNT(DISTINCT CASE
WHEN e.grade_numeric>d.avg_grade
THEN e.student_id END)
/
COUNT(DISTINCT e.student_id)
,2) AS percentage
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id
JOIN
(
SELECT c.dept_id,
AVG(e.grade_numeric) avg_grade
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id
GROUP BY c.dept_id
)d
ON c.dept_id=d.dept_id;

-- 71. Departments with average grade below 70
SELECT d.dept_name,
AVG(e.grade_numeric) avg_grade
FROM departments d
JOIN courses c
ON d.dept_id=c.dept_id
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY d.dept_name
HAVING AVG(e.grade_numeric)<70;

-- 72. Student names with their major department
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
d.dept_name
FROM students s
JOIN departments d
ON s.major_dept_id=d.dept_id;

-- 73. Enrollment details with student and course names
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
c.course_name,
e.semester,
e.year,
e.grade_numeric
FROM enrollments e
JOIN students s
ON e.student_id=s.student_id
JOIN courses c
ON e.course_id=c.course_id;

-- 74. Students and extracurricular activities (include students with none)
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
ea.activity_name
FROM students s
LEFT JOIN extracurricular_activities ea
ON s.student_id=ea.student_id;

-- 75. List all courses and number of enrollments (include zero)
SELECT c.course_name,
COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;

-- 76. Display student name, course name, grade, and attendance.
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
       c.course_name,
       e.grade_numeric,
       e.attendance_percentage
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 77. Find students who have not taken any course.
SELECT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 78. Show department-wise average grade using join.
SELECT d.dept_name,
       AVG(e.grade_numeric) AS avg_grade
FROM departments d
JOIN courses c
ON d.dept_id = c.dept_id
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY d.dept_name;

-- 79. List students who have the same major as the course they enrolled in.
SELECT DISTINCT
       CONCAT(s.first_name,' ',s.last_name) AS student_name,
       c.course_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE s.major_dept_id = c.dept_id;

-- 80. For each activity, show the average grade of participating students.
SELECT ea.activity_name,
       AVG(e.grade_numeric) AS avg_grade
FROM extracurricular_activities ea
JOIN enrollments e
ON ea.student_id = e.student_id
GROUP BY ea.activity_name;

-- 81. Find students who took a course outside their major department.
SELECT DISTINCT
       CONCAT(s.first_name,' ',s.last_name) AS student_name,
       c.course_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE s.major_dept_id <> c.dept_id;

-- 82. Show courses offered by departments that have at least 5 students.
SELECT c.course_name,
       d.dept_name
FROM courses c
JOIN departments d
ON c.dept_id = d.dept_id
WHERE d.dept_id IN
(
    SELECT major_dept_id
    FROM students
    GROUP BY major_dept_id
    HAVING COUNT(*) >= 5
);

-- 83. List student names and total credits earned (passed courses only).
SELECT CONCAT(s.first_name,' ',s.last_name) AS student_name,
       SUM(c.credits) AS credits_earned
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.grade_numeric >= 60
GROUP BY s.student_id, student_name;

-- 84. Pair students who share the same extracurricular activity.
SELECT
CONCAT(s1.first_name,' ',s1.last_name) AS student1,
CONCAT(s2.first_name,' ',s2.last_name) AS student2,
ea1.activity_name
FROM extracurricular_activities ea1
JOIN extracurricular_activities ea2
ON ea1.activity_name = ea2.activity_name
AND ea1.student_id < ea2.student_id
JOIN students s1
ON ea1.student_id = s1.student_id
JOIN students s2
ON ea2.student_id = s2.student_id;

-- 85. Find courses where average grade of students from same major is higher than others.
SELECT
c.course_name,
AVG(CASE
WHEN s.major_dept_id = c.dept_id
THEN e.grade_numeric
END) AS same_major_avg,
AVG(CASE
WHEN s.major_dept_id <> c.dept_id
THEN e.grade_numeric
END) AS other_major_avg
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name
HAVING same_major_avg > other_major_avg;

-- 86. Show semester-wise grade trend with department names.
SELECT
d.dept_name,
e.year,
e.semester,
AVG(e.grade_numeric) AS avg_grade
FROM enrollments e
JOIN courses c
ON e.course_id = c.course_id
JOIN departments d
ON c.dept_id = d.dept_id
GROUP BY d.dept_name,e.year,e.semester
ORDER BY d.dept_name,e.year,e.semester;

-- 87. Retrieve students who have taken both a CS course and a MATH course.
SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
GROUP BY s.student_id, student_name
HAVING
SUM(c.dept_id = 1) > 0
AND
SUM(c.dept_id = 2) > 0;

-- 88. List departments with number of courses and average credits.
SELECT
d.dept_name,
COUNT(c.course_id) AS total_courses,
AVG(c.credits) AS avg_credits
FROM departments d
LEFT JOIN courses c
ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

-- 89. Students with grade >85 and attendance >90.
SELECT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
c.course_name,
e.grade_numeric,
e.attendance_percentage
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.grade_numeric > 85
AND e.attendance_percentage > 90;

-- 90. Students with higher grade than average of their own major department.
SELECT DISTINCT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
e.grade_numeric
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE e.grade_numeric >
(
SELECT AVG(e2.grade_numeric)
FROM enrollments e2
JOIN students s2
ON e2.student_id = s2.student_id
WHERE s2.major_dept_id = s.major_dept_id
);

-- 91. Show each student's best grade and corresponding course.
SELECT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
c.course_name,
e.grade_numeric
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE (e.student_id,e.grade_numeric) IN
(
SELECT student_id,
MAX(grade_numeric)
FROM enrollments
GROUP BY student_id
);

-- 92. Pivot table: student vs average grade per semester.
SELECT
student_id,
AVG(CASE WHEN semester='Fall' THEN grade_numeric END) AS Fall,
AVG(CASE WHEN semester='Spring' THEN grade_numeric END) AS Spring,
AVG(CASE WHEN semester='Summer' THEN grade_numeric END) AS Summer
FROM enrollments
GROUP BY student_id;

-- 93. Self join to find students with same birth year.
SELECT
CONCAT(s1.first_name,' ',s1.last_name) AS student1,
CONCAT(s2.first_name,' ',s2.last_name) AS student2,
YEAR(s1.date_of_birth) AS birth_year
FROM students s1
JOIN students s2
ON YEAR(s1.date_of_birth)=YEAR(s2.date_of_birth)
AND s1.student_id<s2.student_id;

-- 94. Cross join departments and semesters.
SELECT
d.dept_name,
sem.semester
FROM departments d
CROSS JOIN
(
SELECT 'Fall' AS semester
UNION
SELECT 'Spring'
UNION
SELECT 'Summer'
) sem;

-- 95. Join four tables for detailed grade analysis.
SELECT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
c.course_name,
d.dept_name,
e.grade_numeric,
e.attendance_percentage
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN courses c
ON e.course_id=c.course_id
JOIN departments d
ON c.dept_id=d.dept_id;

-- 96. Students whose grade is above overall average.
SELECT DISTINCT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
e.grade_numeric
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
WHERE e.grade_numeric >
(
SELECT AVG(grade_numeric)
FROM enrollments
);

-- 97. Courses with average grade greater than CS101.
SELECT
c.course_name,
AVG(e.grade_numeric) AS avg_grade
FROM courses c
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name
HAVING AVG(e.grade_numeric) >
(
SELECT AVG(e2.grade_numeric)
FROM enrollments e2
JOIN courses c2
ON e2.course_id=c2.course_id
WHERE c2.course_code='CS101'
);

-- 98. CTE to compute GPA and rank students.
WITH student_gpa AS
(
SELECT
student_id,
AVG(grade_numeric) AS GPA
FROM enrollments
GROUP BY student_id
)
SELECT
student_id,
GPA,
RANK() OVER(ORDER BY GPA DESC) AS ranking
FROM student_gpa;

-- 99. Students with grades in the top 10% of all grades.
SELECT DISTINCT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
e.grade_numeric
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
WHERE e.grade_numeric >=
(
SELECT grade_numeric
FROM enrollments
WHERE grade_numeric IS NOT NULL
ORDER BY grade_numeric DESC
LIMIT 1 OFFSET
(
SELECT FLOOR(COUNT(*)*0.1)
FROM enrollments
WHERE grade_numeric IS NOT NULL
)
);

-- 100. Show courses that have at least one enrollment with grade < 50.
SELECT DISTINCT
c.course_name
FROM courses c
JOIN enrollments e
ON c.course_id=e.course_id
WHERE e.grade_numeric < 50;

-- 101. Retrieve students who took exactly the same set of courses as student 101.
SELECT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
WHERE s.student_id <> 101
AND NOT EXISTS (
    SELECT course_id
    FROM enrollments
    WHERE student_id = 101
    AND course_id NOT IN (
        SELECT course_id
        FROM enrollments
        WHERE student_id = s.student_id
    )
)
AND NOT EXISTS (
    SELECT course_id
    FROM enrollments
    WHERE student_id = s.student_id
    AND course_id NOT IN (
        SELECT course_id
        FROM enrollments
        WHERE student_id = 101
    )
);

-- 102. Using CTE, find courses with below average attendance.
WITH course_attendance AS (
    SELECT course_id,
           AVG(attendance_percentage) AS avg_attendance
    FROM enrollments
    GROUP BY course_id
)
SELECT c.course_name,
       ca.avg_attendance
FROM course_attendance ca
JOIN courses c
ON ca.course_id = c.course_id
WHERE ca.avg_attendance <
(
    SELECT AVG(attendance_percentage)
    FROM enrollments
);

-- 103. Find departments where the lowest grade is above 70.
SELECT d.dept_name,
       MIN(e.grade_numeric) AS lowest_grade
FROM departments d
JOIN courses c
ON d.dept_id = c.dept_id
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY d.dept_name
HAVING MIN(e.grade_numeric) > 70;

-- 104. Show each student's grade and the difference from department average.
SELECT
CONCAT(s.first_name,' ',s.last_name) AS student_name,
e.grade_numeric,
(
SELECT AVG(e2.grade_numeric)
FROM enrollments e2
JOIN courses c2
ON e2.course_id = c2.course_id
WHERE c2.dept_id = c.dept_id
) AS department_average,
e.grade_numeric -
(
SELECT AVG(e2.grade_numeric)
FROM enrollments e2
JOIN courses c2
ON e2.course_id = c2.course_id
WHERE c2.dept_id = c.dept_id
) AS difference_from_average
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id;

-- 105. List students who have taken all courses of their major department.
SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
WHERE NOT EXISTS (
    SELECT course_id
    FROM courses c
    WHERE c.dept_id = s.major_dept_id
    AND c.course_id NOT IN (
        SELECT course_id
        FROM enrollments
        WHERE student_id = s.student_id
    )
);

-- 106. Second highest grade per course.
SELECT
course_id,
grade_numeric
FROM (
    SELECT course_id,
           grade_numeric,
           DENSE_RANK() OVER(PARTITION BY course_id ORDER BY grade_numeric DESC) rnk
    FROM enrollments
) t
WHERE rnk = 2;

-- 107. CTE to calculate cumulative grade per student.
WITH cumulative AS (
SELECT student_id,
       year,
       semester,
       grade_numeric,
       SUM(grade_numeric)
       OVER(PARTITION BY student_id ORDER BY year,semester)
       AS cumulative_grade
FROM enrollments
)
SELECT *
FROM cumulative;

-- 108. Students whose Database Systems grade is higher than their average grade.
SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) AS student_name,
e.grade_numeric
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
JOIN courses c
ON e.course_id = c.course_id
WHERE c.course_name='Database Systems'
AND e.grade_numeric >
(
SELECT AVG(grade_numeric)
FROM enrollments e2
WHERE e2.student_id=s.student_id
);

-- 109. Find pairs of students with identical grade patterns.
SELECT
e1.student_id,
e2.student_id
FROM enrollments e1
JOIN enrollments e2
ON e1.course_id=e2.course_id
AND e1.grade_numeric=e2.grade_numeric
AND e1.student_id<e2.student_id
GROUP BY e1.student_id,e2.student_id
HAVING COUNT(*)=
(
SELECT COUNT(*)
FROM enrollments x
WHERE x.student_id=e1.student_id
);

-- 110. Department with maximum variation in grades.
SELECT
d.dept_name,
VARIANCE(e.grade_numeric) AS variance_grade
FROM departments d
JOIN courses c
ON d.dept_id=c.dept_id
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY d.dept_name
ORDER BY variance_grade DESC
LIMIT 1;

-- 111. Use EXISTS to find students who have taken at least one Summer course.
SELECT
student_id,
CONCAT(first_name,' ',last_name) AS student_name
FROM students s
WHERE EXISTS
(
SELECT 1
FROM enrollments e
WHERE e.student_id=s.student_id
AND semester='Summer'
);

-- 112. CTE to compute rolling average grade for each student.
WITH rolling_avg AS
(
SELECT
student_id,
year,
semester,
grade_numeric,
AVG(grade_numeric)
OVER(
PARTITION BY student_id
ORDER BY year,semester
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS rolling_average
FROM enrollments
)
SELECT *
FROM rolling_avg;

-- 113. Find courses with no enrollment in 2022.
SELECT c.course_id,
       c.course_name
FROM courses c
WHERE c.course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollments
    WHERE year = 2022
);

-- 114. Students who have never failed any course (grade >= 60).
SELECT s.student_id,
       CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
      AND e.grade_numeric < 60
);

-- 115. Average grade per semester for each student, then find best semester.
SELECT *
FROM (
    SELECT student_id,
           semester,
           AVG(grade_numeric) AS avg_grade,
           RANK() OVER(PARTITION BY student_id ORDER BY AVG(grade_numeric) DESC) AS rnk
    FROM enrollments
    GROUP BY student_id, semester
) t
WHERE rnk = 1;

-- 116. Rank students by overall average grade.
SELECT student_id,
       AVG(grade_numeric) AS avg_grade,
       RANK() OVER(ORDER BY AVG(grade_numeric) DESC) AS student_rank
FROM enrollments
GROUP BY student_id;

-- 117. For each course, give ROW_NUMBER per student ordered by grade descending.
SELECT course_id,
       student_id,
       grade_numeric,
       ROW_NUMBER() OVER(
           PARTITION BY course_id
           ORDER BY grade_numeric DESC
       ) AS row_num
FROM enrollments;

-- 118. Running total of credits attempted by each student.
SELECT
e.student_id,
e.year,
e.semester,
c.credits,
SUM(c.credits) OVER(
PARTITION BY e.student_id
ORDER BY e.year,e.semester
) AS running_credits
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id;

-- 119. Dense rank courses by average grade.
SELECT
course_id,
AVG(grade_numeric) AS avg_grade,
DENSE_RANK() OVER(
ORDER BY AVG(grade_numeric) DESC
) AS course_rank
FROM enrollments
GROUP BY course_id;

-- 120. Percentage of total credits each course contributes within its department.
SELECT
c.course_id,
c.course_name,
d.dept_name,
ROUND(
100*c.credits/
SUM(c.credits) OVER(PARTITION BY d.dept_id),2
) AS percentage_of_department
FROM courses c
JOIN departments d
ON c.dept_id=d.dept_id;

-- 121. Difference between current and previous semester grade using LAG.
SELECT
student_id,
year,
semester,
grade_numeric,
grade_numeric -
LAG(grade_numeric)
OVER(
PARTITION BY student_id
ORDER BY year,semester
) AS grade_difference
FROM enrollments;

-- 122. LEAD to see next semester's grade.
SELECT
student_id,
year,
semester,
grade_numeric,
LEAD(grade_numeric)
OVER(
PARTITION BY student_id
ORDER BY year,semester
) AS next_grade
FROM enrollments;

-- 123. Categorize students into quartiles based on GPA.
WITH student_gpa AS
(
SELECT
student_id,
AVG(grade_numeric) AS GPA
FROM enrollments
GROUP BY student_id
)
SELECT
student_id,
GPA,
NTILE(4)
OVER(ORDER BY GPA DESC) AS quartile
FROM student_gpa;

-- 124. Moving average of grades over last 3 enrollments.
SELECT
student_id,
year,
semester,
grade_numeric,
AVG(grade_numeric)
OVER(
PARTITION BY student_id
ORDER BY year,semester
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_average
FROM enrollments;

-- 125. First grade obtained by each student for each course.
SELECT DISTINCT
student_id,
course_id,
FIRST_VALUE(grade_numeric)
OVER(
PARTITION BY student_id,course_id
ORDER BY year,semester
) AS first_grade
FROM enrollments;

-- 126. Last value – most recent grade per student.
SELECT DISTINCT
    student_id,
    LAST_VALUE(grade_numeric) OVER (
        PARTITION BY student_id
        ORDER BY year, semester
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS latest_grade
FROM enrollments;

-- 127. Count of students per percentile bucket (using CUME_DIST).
WITH student_gpa AS (
    SELECT student_id,
           AVG(grade_numeric) AS GPA
    FROM enrollments
    GROUP BY student_id
)
SELECT
    student_id,
    GPA,
    CUME_DIST() OVER (ORDER BY GPA DESC) AS percentile_bucket
FROM student_gpa;

-- 128. Percent_rank of each student's GPA.
WITH student_gpa AS (
    SELECT student_id,
           AVG(grade_numeric) AS GPA
    FROM enrollments
    GROUP BY student_id
)
SELECT
    student_id,
    GPA,
    PERCENT_RANK() OVER (ORDER BY GPA DESC) AS percent_rank
FROM student_gpa;

-- 129. Rank courses by average grade within each department.
SELECT
    c.dept_id,
    c.course_name,
    AVG(e.grade_numeric) AS avg_grade,
    RANK() OVER (
        PARTITION BY c.dept_id
        ORDER BY AVG(e.grade_numeric) DESC
    ) AS dept_rank
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.dept_id, c.course_id, c.course_name;

-- 130. Compare each student's grade with department highest grade.
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    e.grade_numeric,
    MAX(e.grade_numeric) OVER(PARTITION BY d.dept_id) AS dept_highest,
    MAX(e.grade_numeric) OVER(PARTITION BY d.dept_id)-e.grade_numeric AS difference
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN courses c
ON e.course_id=c.course_id
JOIN departments d
ON c.dept_id=d.dept_id;

-- 131. Sliding standard deviation of grades.
SELECT
    student_id,
    year,
    semester,
    grade_numeric,
    STDDEV(grade_numeric) OVER(
        PARTITION BY student_id
        ORDER BY year,semester
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_stddev
FROM enrollments;

-- 132. Cumulative average grade by year and semester.
SELECT
    student_id,
    year,
    semester,
    grade_numeric,
    AVG(grade_numeric) OVER(
        PARTITION BY student_id
        ORDER BY year,semester
    ) AS cumulative_avg
FROM enrollments;

-- 133. Ratio of each student's grade to maximum grade in the course.
SELECT
    student_id,
    course_id,
    grade_numeric,
    ROUND(
        grade_numeric /
        MAX(grade_numeric) OVER(PARTITION BY course_id),
        3
    ) AS grade_ratio
FROM enrollments;

-- 134. Students whose grade improved by more than 10 points.
WITH grade_change AS (
SELECT
    student_id,
    year,
    semester,
    grade_numeric,
    LAG(grade_numeric)
    OVER(PARTITION BY student_id ORDER BY year,semester) AS previous_grade
FROM enrollments
)
SELECT *
FROM grade_change
WHERE grade_numeric-previous_grade>10;

-- 135. Group students into 5 bands based on extracurricular hours.
WITH activity_hours AS (
SELECT
    student_id,
    SUM(hours_per_week) AS total_hours
FROM extracurricular_activities
GROUP BY student_id
)
SELECT
    student_id,
    total_hours,
    NTILE(5) OVER(ORDER BY total_hours DESC) AS hour_band
FROM activity_hours;

-- 136. Most common birth month.
SELECT
    MONTH(date_of_birth) AS birth_month,
    COUNT(*) AS students
FROM students
GROUP BY MONTH(date_of_birth)
ORDER BY students DESC
LIMIT 1;

-- 137. Calculate age at enrollment.
SELECT
    student_id,
    CONCAT(first_name,' ',last_name) AS student_name,
    TIMESTAMPDIFF(
        YEAR,
        date_of_birth,
        STR_TO_DATE(CONCAT(enrollment_year,'-01-01'),'%Y-%m-%d')
    ) AS age_at_enrollment
FROM students;

-- 138. Number of students enrolled per academic year.
SELECT
    enrollment_year,
    COUNT(*) AS total_students
FROM students
GROUP BY enrollment_year
ORDER BY enrollment_year;

-- 139. Students who enrolled before turning 18.
SELECT
    student_id,
    CONCAT(first_name,' ',last_name) AS student_name
FROM students
WHERE TIMESTAMPDIFF(
YEAR,
date_of_birth,
STR_TO_DATE(CONCAT(enrollment_year,'-01-01'),'%Y-%m-%d')
)<18;

-- 140. Average grade trend by year.
SELECT
    year,
    AVG(grade_numeric) AS average_grade
FROM enrollments
GROUP BY year
ORDER BY year;

-- 141. Time gap between first and last course.
SELECT
    student_id,
    MIN(year) AS first_year,
    MAX(year) AS last_year,
    MAX(year)-MIN(year) AS year_gap
FROM enrollments
GROUP BY student_id;

-- 142. Semester with highest standard deviation.
SELECT
    semester,
    STDDEV(grade_numeric) AS grade_stddev
FROM enrollments
GROUP BY semester
ORDER BY grade_stddev DESC
LIMIT 1;

-- 143. Difference between consecutive course years.
SELECT
    student_id,
    year,
    semester,
    year-LAG(year)
    OVER(PARTITION BY student_id ORDER BY year,semester)
    AS year_gap
FROM enrollments;

-- 144. Compare Fall vs Spring performance in same year.
SELECT
    year,
    AVG(CASE WHEN semester='Fall' THEN grade_numeric END) AS Fall_Avg,
    AVG(CASE WHEN semester='Spring' THEN grade_numeric END) AS Spring_Avg
FROM enrollments
GROUP BY year;

-- 145. Retrieve enrollments from last two years.
SELECT *
FROM enrollments
WHERE year>=(
SELECT MAX(year)-1
FROM enrollments
);

-- 146. Predict graduation year (+1 year).
SELECT
    student_id,
    enrollment_year,
    enrollment_year+1 AS predicted_graduation
FROM students;

-- 147. Students who took a course in the same year as extracurricular started.
SELECT DISTINCT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN extracurricular_activities ea
ON s.student_id=ea.student_id
WHERE e.year=ea.academic_year;

-- 148. Aggregate grades by month of birth.
SELECT
    MONTH(s.date_of_birth) AS birth_month,
    AVG(e.grade_numeric) AS average_grade
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY MONTH(s.date_of_birth)
ORDER BY birth_month;

-- 149. Semester mapped to quarter.
SELECT
    enrollment_id,
    semester,
    CASE
        WHEN semester='Spring' THEN 'Q1'
        WHEN semester='Summer' THEN 'Q2'
        WHEN semester='Fall' THEN 'Q3'
    END AS quarter
FROM enrollments;

-- 150. Students who took a gap year.
WITH yearly_enrollment AS (
SELECT DISTINCT
    student_id,
    year
FROM enrollments
)
SELECT
    y1.student_id
FROM yearly_enrollment y1
LEFT JOIN yearly_enrollment y2
ON y1.student_id=y2.student_id
AND y2.year=y1.year+1
WHERE y2.student_id IS NULL
ORDER BY y1.student_id;

-- 150. Identify students who took a gap year (no enrollment in a consecutive year).
WITH yearly_enrollment AS (
    SELECT DISTINCT student_id, year
    FROM enrollments
)
SELECT y1.student_id,
       y1.year AS enrolled_year,
       y1.year + 1 AS missing_year
FROM yearly_enrollment y1
LEFT JOIN yearly_enrollment y2
ON y1.student_id = y2.student_id
AND y2.year = y1.year + 1
WHERE y2.student_id IS NULL
ORDER BY y1.student_id, y1.year;

-- 151. Compute z-score for each student's grade.
WITH grade_stats AS (
    SELECT AVG(grade_numeric) AS mean_grade,
           STDDEV(grade_numeric) AS std_grade
    FROM enrollments
    WHERE grade_numeric IS NOT NULL
)
SELECT
    e.student_id,
    e.course_id,
    e.grade_numeric,
    ROUND(
        (e.grade_numeric - gs.mean_grade) / gs.std_grade,
        3
    ) AS z_score
FROM enrollments e
CROSS JOIN grade_stats gs
WHERE e.grade_numeric IS NOT NULL;

-- 152. Histogram of grades (interval of 5).
SELECT
    CONCAT(
        FLOOR(grade_numeric/5)*5,
        '-',
        FLOOR(grade_numeric/5)*5+4
    ) AS grade_range,
    COUNT(*) AS frequency
FROM enrollments
WHERE grade_numeric IS NOT NULL
GROUP BY FLOOR(grade_numeric/5)
ORDER BY FLOOR(grade_numeric/5);

-- 153. Pearson correlation between attendance and grades.
SELECT
(
COUNT(*)*SUM(attendance_percentage*grade_numeric)
-
SUM(attendance_percentage)*SUM(grade_numeric)
)
/
SQRT(
(COUNT(*)*SUM(POW(attendance_percentage,2))
-
POW(SUM(attendance_percentage),2))
*
(COUNT(*)*SUM(POW(grade_numeric,2))
-
POW(SUM(grade_numeric),2))
) AS pearson_r
FROM enrollments
WHERE grade_numeric IS NOT NULL;

-- 154. Pass/fail flag and pass rate per course.
SELECT
    c.course_name,
    SUM(CASE WHEN e.grade_numeric >= 60 THEN 1 ELSE 0 END) AS passed,
    COUNT(*) AS total_students,
    ROUND(
        SUM(CASE WHEN e.grade_numeric >= 60 THEN 1 ELSE 0 END)
        *100.0/COUNT(*),2
    ) AS pass_rate
FROM enrollments e
JOIN courses c
ON e.course_id = c.course_id
GROUP BY c.course_name;

-- 155. Detect outlier grades (>2 standard deviations).
WITH course_stats AS (
SELECT
    course_id,
    AVG(grade_numeric) AS mean_grade,
    STDDEV(grade_numeric) AS std_grade
FROM enrollments
GROUP BY course_id
)
SELECT
    e.student_id,
    e.course_id,
    e.grade_numeric
FROM enrollments e
JOIN course_stats cs
ON e.course_id = cs.course_id
WHERE ABS(e.grade_numeric-cs.mean_grade) >
      2*cs.std_grade;

-- 156. Compare average grades across departments.
SELECT
    d.dept_name,
    AVG(e.grade_numeric) AS avg_grade,
    STDDEV(e.grade_numeric) AS std_dev,
    COUNT(*) AS observations
FROM departments d
JOIN courses c
ON d.dept_id = c.dept_id
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY d.dept_name;

-- 157. Cohort analysis by enrollment year.
SELECT
    s.enrollment_year,
    e.year,
    ROUND(AVG(e.grade_numeric),2) AS avg_grade
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.enrollment_year,e.year
ORDER BY s.enrollment_year,e.year;

-- 158. Retention: students taking another semester after first.
WITH first_semester AS (
SELECT
    student_id,
    MIN(CONCAT(year,'-',semester)) AS first_term
FROM enrollments
GROUP BY student_id
)
SELECT
ROUND(
COUNT(DISTINCT e.student_id)*100.0/
(SELECT COUNT(*) FROM first_semester),2
) AS retention_rate
FROM enrollments e
JOIN first_semester f
ON e.student_id=f.student_id
WHERE CONCAT(e.year,'-',e.semester)>f.first_term;

-- 159. Predict next grade using average of previous two grades.
SELECT
    student_id,
    year,
    semester,
    grade_numeric,
    AVG(grade_numeric) OVER(
        PARTITION BY student_id
        ORDER BY year,semester
        ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING
    ) AS predicted_grade
FROM enrollments;

-- 160. Probability that grade >80 has attendance >80%.
SELECT
ROUND(
SUM(
CASE
WHEN grade_numeric>80
AND attendance_percentage>80
THEN 1 ELSE 0
END
)
/
SUM(
CASE
WHEN grade_numeric>80
THEN 1 ELSE 0
END
)
,4) AS probability
FROM enrollments;

-- 161. Confusion matrix (Pass vs Attendance).
SELECT
CASE
WHEN grade_numeric>=60 THEN 'Predicted Pass'
ELSE 'Predicted Fail'
END AS predicted,

CASE
WHEN attendance_percentage>=75 THEN 'Actual Pass'
ELSE 'Actual Fail'
END AS actual,

COUNT(*) AS total
FROM enrollments
GROUP BY predicted,actual;

-- 162. Normalize grades using Min-Max scaling.
WITH grade_range AS (
SELECT
MIN(grade_numeric) AS min_grade,
MAX(grade_numeric) AS max_grade
FROM enrollments
WHERE grade_numeric IS NOT NULL
)
SELECT
student_id,
course_id,
grade_numeric,
ROUND(
(grade_numeric-min_grade)/
(max_grade-min_grade),
4
) AS normalized_grade
FROM enrollments
CROSS JOIN grade_range
WHERE grade_numeric IS NOT NULL;

-- 163. Compute entropy of grade distribution per department.
WITH grade_dist AS (
    SELECT c.dept_id,
           FLOOR(e.grade_numeric/10) AS grade_bucket,
           COUNT(*) AS freq
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.grade_numeric IS NOT NULL
    GROUP BY c.dept_id, FLOOR(e.grade_numeric/10)
),
dept_total AS (
    SELECT dept_id,
           SUM(freq) AS total_freq
    FROM grade_dist
    GROUP BY dept_id
)
SELECT d.dept_name,
       ROUND(
           -SUM((gd.freq/dt.total_freq) * LOG2(gd.freq/dt.total_freq)),
           4
       ) AS entropy
FROM grade_dist gd
JOIN dept_total dt ON gd.dept_id = dt.dept_id
JOIN departments d ON gd.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 164. Find courses with bimodal grade distribution.
SELECT
    c.course_name,
    COUNT(DISTINCT FLOOR(e.grade_numeric/10)) AS grade_groups,
    STDDEV(e.grade_numeric) AS std_dev
FROM courses c
JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
HAVING grade_groups >= 2
ORDER BY std_dev DESC;

-- 165. Seasonality: Average grade by semester and year.
SELECT
    year,
    semester,
    AVG(grade_numeric) AS average_grade
FROM enrollments
GROUP BY year, semester
ORDER BY year, semester;

-- 166. Students with consistently improving grades.
WITH grade_history AS (
SELECT
    student_id,
    year,
    semester,
    grade_numeric,
    LAG(grade_numeric)
    OVER(PARTITION BY student_id ORDER BY year, semester) AS prev_grade
FROM enrollments
)
SELECT student_id
FROM grade_history
GROUP BY student_id
HAVING MIN(
CASE
WHEN prev_grade IS NULL THEN 1
WHEN grade_numeric >= prev_grade THEN 1
ELSE 0
END
)=1;

-- 167. Performance lift: Activity vs No Activity.
SELECT
CASE
WHEN ea.student_id IS NULL
THEN 'No Activity'
ELSE 'Activity'
END AS category,
COUNT(*) AS students,
AVG(e.grade_numeric) AS avg_grade
FROM students s
LEFT JOIN extracurricular_activities ea
ON s.student_id = ea.student_id
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY category;

-- 168. Rolling standard deviation for university grades.
SELECT
year,
semester,
grade_numeric,
STDDEV(grade_numeric)
OVER(
ORDER BY year, semester
ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
) AS rolling_stddev
FROM enrollments;

-- 169. Cumulative distribution of GPA.
WITH gpa AS (
SELECT
student_id,
AVG(grade_numeric) AS GPA
FROM enrollments
GROUP BY student_id
)
SELECT
student_id,
GPA,
CUME_DIST()
OVER(ORDER BY GPA DESC) AS cumulative_distribution
FROM gpa;

-- 170. Linear regression slope (Grade vs Attendance).
SELECT
(
COUNT(*)*SUM(attendance_percentage*grade_numeric)
-
SUM(attendance_percentage)*SUM(grade_numeric)
)
/
(
COUNT(*)*SUM(POW(attendance_percentage,2))
-
POW(SUM(attendance_percentage),2)
) AS regression_slope
FROM enrollments
WHERE grade_numeric IS NOT NULL;

-- 171. Create GPA View.
CREATE OR REPLACE VIEW student_gpa AS
SELECT
student_id,
AVG(
CASE
WHEN grade_numeric>=90 THEN 4.0
WHEN grade_numeric>=80 THEN 3.0
WHEN grade_numeric>=70 THEN 2.0
WHEN grade_numeric>=60 THEN 1.0
ELSE 0.0
END
) AS GPA
FROM enrollments
GROUP BY student_id;

-- 172. Add letter_grade column.
ALTER TABLE enrollments
ADD COLUMN letter_grade CHAR(2);

UPDATE enrollments
SET letter_grade =
CASE
WHEN grade_numeric>=90 THEN 'A'
WHEN grade_numeric>=80 THEN 'B'
WHEN grade_numeric>=70 THEN 'C'
WHEN grade_numeric>=60 THEN 'D'
WHEN grade_numeric IS NULL THEN NULL
ELSE 'F'
END;

-- 173. Update attendance to NULL for grades below 40.
UPDATE enrollments
SET attendance_percentage=NULL
WHERE grade_numeric<40;

-- 174. Delete duplicate enrollments (keep smallest enrollment_id).
DELETE e1
FROM enrollments e1
JOIN enrollments e2
ON e1.student_id=e2.student_id
AND e1.course_id=e2.course_id
AND e1.semester=e2.semester
AND e1.year=e2.year
AND e1.enrollment_id>e2.enrollment_id;

-- 175. Add pass_status column and populate.
ALTER TABLE enrollments
ADD COLUMN pass_status VARCHAR(10);

UPDATE enrollments
SET pass_status=
CASE
WHEN grade_numeric>=60 THEN 'Pass'
WHEN grade_numeric IS NULL THEN NULL
ELSE 'Fail'
END;

-- 176. Replace NULL grades with the course average.
UPDATE enrollments e
JOIN (
    SELECT course_id,
           AVG(grade_numeric) AS avg_grade
    FROM enrollments
    WHERE grade_numeric IS NOT NULL
    GROUP BY course_id
) c
ON e.course_id = c.course_id
SET e.grade_numeric = c.avg_grade
WHERE e.grade_numeric IS NULL;

-- 177. Classify students into High, Medium, Low performance.
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    AVG(e.grade_numeric) AS avg_grade,
    IF(AVG(e.grade_numeric)>=85,'High',
       IF(AVG(e.grade_numeric)>=70,'Medium','Low')) AS performance_level
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY s.student_id,student_name;

-- 178. Pivot table: number of students per grade range per course.
SELECT
    c.course_name,
    SUM(CASE WHEN e.grade_numeric<60 THEN 1 ELSE 0 END) AS Fail,
    SUM(CASE WHEN e.grade_numeric BETWEEN 60 AND 69.99 THEN 1 ELSE 0 END) AS D_Grade,
    SUM(CASE WHEN e.grade_numeric BETWEEN 70 AND 79.99 THEN 1 ELSE 0 END) AS C_Grade,
    SUM(CASE WHEN e.grade_numeric BETWEEN 80 AND 89.99 THEN 1 ELSE 0 END) AS B_Grade,
    SUM(CASE WHEN e.grade_numeric>=90 THEN 1 ELSE 0 END) AS A_Grade
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;

-- 179. Split combined student name into first and last name.
SELECT
    CONCAT(first_name,' ',last_name) AS full_name,
    SUBSTRING_INDEX(CONCAT(first_name,' ',last_name),' ',1) AS extracted_first_name,
    SUBSTRING_INDEX(CONCAT(first_name,' ',last_name),' ',-1) AS extracted_last_name
FROM students;

-- 180. Create temporary table with Top 10 students by GPA.
CREATE TEMPORARY TABLE top10_students AS
SELECT
    student_id,
    AVG(grade_numeric) AS GPA
FROM enrollments
GROUP BY student_id
ORDER BY GPA DESC
LIMIT 10;

-- View temporary table.
SELECT * FROM top10_students;

-- 181. Generate JSON report of student grades.
SELECT
JSON_OBJECT(
    'Student_ID', s.student_id,
    'Student_Name', CONCAT(s.first_name,' ',s.last_name),
    'Average_Grade', ROUND(AVG(e.grade_numeric),2)
) AS student_report
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY s.student_id,s.first_name,s.last_name;

-- 182. Convert semester and year into a single date column.
SELECT
    enrollment_id,
    semester,
    year,
    CASE
        WHEN semester='Spring'
            THEN STR_TO_DATE(CONCAT(year,'-01-01'),'%Y-%m-%d')
        WHEN semester='Summer'
            THEN STR_TO_DATE(CONCAT(year,'-06-01'),'%Y-%m-%d')
        WHEN semester='Fall'
            THEN STR_TO_DATE(CONCAT(year,'-09-01'),'%Y-%m-%d')
    END AS semester_date
FROM enrollments;

-- 183. Add CHECK constraint for grade <=100.
ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade_numeric <= 100);

-- 184. Replace NULL attendance with 50 using COALESCE.
SELECT
    enrollment_id,
    student_id,
    COALESCE(attendance_percentage,50) AS attendance
FROM enrollments;

-- 185. Stored Procedure for department performance summary.
DELIMITER $$

CREATE PROCEDURE department_performance()
BEGIN
    SELECT
        d.dept_name,
        COUNT(DISTINCT e.student_id) AS total_students,
        ROUND(AVG(e.grade_numeric),2) AS average_grade,
        MAX(e.grade_numeric) AS highest_grade,
        MIN(e.grade_numeric) AS lowest_grade
    FROM departments d
    JOIN courses c
    ON d.dept_id=c.dept_id
    JOIN enrollments e
    ON c.course_id=e.course_id
    GROUP BY d.dept_name;
END$$

DELIMITER ;

CALL department_performance();

-- 186. Create index on enrollments(student_id, course_id).
CREATE INDEX idx_student_course
ON enrollments(student_id, course_id);

-- 187. Explain query to find highest grade per course.
EXPLAIN
SELECT
    c.course_name,
    MAX(e.grade_numeric) AS highest_grade
FROM courses c
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;

-- 188. Rewrite a slow subquery using JOIN.

-- Original (slow)
SELECT *
FROM students
WHERE student_id IN
(
    SELECT student_id
    FROM enrollments
    WHERE grade_numeric>90
);

-- Optimized using JOIN
SELECT DISTINCT s.*
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
WHERE e.grade_numeric>90;

-- 189. Create a view showing complete student academic performance.
CREATE OR REPLACE VIEW vw_student_performance AS
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    COUNT(e.course_id) AS courses_taken,
    ROUND(AVG(e.grade_numeric),2) AS average_grade,
    ROUND(AVG(e.attendance_percentage),2) AS average_attendance
FROM students s
LEFT JOIN departments d
ON s.major_dept_id = d.dept_id
LEFT JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id,s.first_name,s.last_name,d.dept_name;

-- View the data
SELECT * FROM vw_student_performance;

-- 190. Create a view showing course statistics.
CREATE OR REPLACE VIEW vw_course_statistics AS
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments,
    ROUND(AVG(e.grade_numeric),2) AS average_grade,
    MAX(e.grade_numeric) AS highest_grade,
    MIN(e.grade_numeric) AS lowest_grade
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;

SELECT * FROM vw_course_statistics;

-- 191. Stored procedure to display transcript for a student.
DELIMITER $$

CREATE PROCEDURE student_transcript(IN p_student_id INT)
BEGIN
    SELECT
        c.course_code,
        c.course_name,
        e.semester,
        e.year,
        e.grade_numeric,
        e.letter_grade,
        e.pass_status
    FROM enrollments e
    JOIN courses c
    ON e.course_id=c.course_id
    WHERE e.student_id=p_student_id
    ORDER BY e.year,e.semester;
END$$

DELIMITER ;

CALL student_transcript(101);

-- 192. Stored procedure to calculate GPA.
DELIMITER $$

CREATE PROCEDURE calculate_gpa(IN p_student_id INT)
BEGIN
    SELECT
        p_student_id AS student_id,
        ROUND(
            AVG(
                CASE
                    WHEN grade_numeric>=90 THEN 4.0
                    WHEN grade_numeric>=80 THEN 3.0
                    WHEN grade_numeric>=70 THEN 2.0
                    WHEN grade_numeric>=60 THEN 1.0
                    ELSE 0.0
                END
            ),2
        ) AS GPA
    FROM enrollments
    WHERE student_id=p_student_id;
END$$

DELIMITER ;

CALL calculate_gpa(101);

-- 193. Function to convert numeric grade to letter grade.
DELIMITER $$

CREATE FUNCTION fn_letter_grade(score DECIMAL(5,2))
RETURNS CHAR(2)
DETERMINISTIC
BEGIN
    RETURN (
        CASE
            WHEN score>=90 THEN 'A'
            WHEN score>=80 THEN 'B'
            WHEN score>=70 THEN 'C'
            WHEN score>=60 THEN 'D'
            ELSE 'F'
        END
    );
END$$

DELIMITER ;

SELECT fn_letter_grade(87);

-- 194. Trigger to automatically assign letter grade before insert.
DELIMITER $$

CREATE TRIGGER trg_before_insert_grade
BEFORE INSERT
ON enrollments
FOR EACH ROW
BEGIN
    SET NEW.letter_grade =
    CASE
        WHEN NEW.grade_numeric>=90 THEN 'A'
        WHEN NEW.grade_numeric>=80 THEN 'B'
        WHEN NEW.grade_numeric>=70 THEN 'C'
        WHEN NEW.grade_numeric>=60 THEN 'D'
        ELSE 'F'
    END;
END$$

DELIMITER ;

-- 195. Trigger to automatically assign pass status before insert.
DELIMITER $$

CREATE TRIGGER trg_before_insert_pass
BEFORE INSERT
ON enrollments
FOR EACH ROW
BEGIN
    SET NEW.pass_status =
    CASE
        WHEN NEW.grade_numeric>=60 THEN 'Pass'
        ELSE 'Fail'
    END;
END$$

DELIMITER ;

-- 196. Event to archive enrollments older than 5 years.
CREATE TABLE IF NOT EXISTS enrollment_archive
LIKE enrollments;

DELIMITER $$

CREATE EVENT archive_old_enrollments
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    INSERT INTO enrollment_archive
    SELECT *
    FROM enrollments
    WHERE year < YEAR(CURDATE())-5;

    DELETE
    FROM enrollments
    WHERE year < YEAR(CURDATE())-5;
END$$

DELIMITER ;

-- 197. Create a report of department performance.
SELECT
    d.dept_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    COUNT(DISTINCT c.course_id) AS total_courses,
    ROUND(AVG(e.grade_numeric),2) AS average_grade,
    ROUND(AVG(e.attendance_percentage),2) AS average_attendance
FROM departments d
LEFT JOIN students s
ON d.dept_id=s.major_dept_id
LEFT JOIN courses c
ON d.dept_id=c.dept_id
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY d.dept_name;

-- 198. Generate leaderboard based on GPA.
WITH student_gpa AS
(
SELECT
    student_id,
    ROUND(AVG(grade_numeric),2) AS GPA
FROM enrollments
GROUP BY student_id
)
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    g.GPA,
    DENSE_RANK() OVER(ORDER BY g.GPA DESC) AS leaderboard_rank
FROM student_gpa g
JOIN students s
ON g.student_id=s.student_id
ORDER BY leaderboard_rank;

-- 199. Display academic dashboard summary.
SELECT
    (SELECT COUNT(*) FROM students) AS total_students,
    (SELECT COUNT(*) FROM departments) AS total_departments,
    (SELECT COUNT(*) FROM courses) AS total_courses,
    (SELECT COUNT(*) FROM enrollments) AS total_enrollments,
    (SELECT ROUND(AVG(grade_numeric),2) FROM enrollments) AS university_average_grade,
    (SELECT ROUND(AVG(attendance_percentage),2) FROM enrollments) AS university_average_attendance;

-- 200. Final comprehensive report combining student, department,
-- course, activity, GPA, attendance, and ranking.
WITH student_summary AS
(
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    COALESCE(ea.activity_name,'None') AS activity,
    ROUND(AVG(e.grade_numeric),2) AS GPA,
    ROUND(AVG(e.attendance_percentage),2) AS attendance
FROM students s
LEFT JOIN departments d
ON s.major_dept_id=d.dept_id
LEFT JOIN enrollments e
ON s.student_id=e.student_id
LEFT JOIN extracurricular_activities ea
ON s.student_id=ea.student_id
GROUP BY
s.student_id,
student_name,
d.dept_name,
activity
)
SELECT
    *,
    DENSE_RANK() OVER(ORDER BY GPA DESC) AS university_rank
FROM student_summary
ORDER BY university_rank;


