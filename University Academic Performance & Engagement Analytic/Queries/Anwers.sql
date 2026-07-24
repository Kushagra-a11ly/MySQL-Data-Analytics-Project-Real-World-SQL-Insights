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
