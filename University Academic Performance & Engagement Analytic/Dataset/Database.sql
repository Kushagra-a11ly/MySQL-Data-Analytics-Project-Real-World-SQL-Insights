-- Create and use database
CREATE DATABASE IF NOT EXISTS university_analytics;
USE university_analytics;

-- 1. Departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Students table (no employee fields)
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('M', 'F', 'Other'),
    major_dept_id INT,
    enrollment_year INT,
    email VARCHAR(100) UNIQUE,
    FOREIGN KEY (major_dept_id) REFERENCES departments(dept_id)
);

-- 3. Courses table (no product fields)
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits IN (1,2,3,4,5,6)),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- 4. Enrollments table (core fact table for grades)
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester ENUM('Fall', 'Spring', 'Summer') NOT NULL,
    year INT NOT NULL,
    grade_numeric DECIMAL(5,2) CHECK (grade_numeric >= 0 AND grade_numeric <= 100),
    attendance_percentage DECIMAL(5,2) CHECK (attendance_percentage >= 0 AND attendance_percentage <= 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 5. Extracurricular activities (adds extra dimension for correlation analysis)
CREATE TABLE extracurricular_activities (
    activity_id INT PRIMARY KEY,
    student_id INT,
    activity_name VARCHAR(100) NOT NULL,
    hours_per_week DECIMAL(4,2),
    academic_year INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Insert departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Economics');

-- Insert students (20 students, various majors, enrollment years 2019-2023)
INSERT INTO students VALUES
(101, 'Alice', 'Johnson', '2001-03-12', 'F', 1, 2020, 'alice.j@univ.edu'),
(102, 'Bob', 'Smith', '2000-07-19', 'M', 2, 2019, 'bob.smith@univ.edu'),
(103, 'Carol', 'Davis', '2002-11-05', 'F', 1, 2021, 'carol.davis@univ.edu'),
(104, 'David', 'Brown', '2001-08-21', 'M', 3, 2020, 'david.brown@univ.edu'),
(105, 'Emma', 'Wilson', '2000-01-30', 'F', 4, 2019, 'emma.wilson@univ.edu'),
(106, 'Frank', 'Garcia', '2003-04-17', 'M', 2, 2022, 'frank.garcia@univ.edu'),
(107, 'Grace', 'Martinez', '2002-09-09', 'F', 1, 2021, 'grace.m@univ.edu'),
(108, 'Henry', 'Lee', '2000-12-01', 'M', 3, 2019, 'henry.lee@univ.edu'),
(109, 'Ivy', 'White', '2001-06-25', 'F', 4, 2020, 'ivy.white@univ.edu'),
(110, 'Jack', 'Harris', '2003-02-14', 'M', 2, 2022, 'jack.harris@univ.edu'),
(111, 'Kara', 'Clark', '2002-10-30', 'F', 1, 2021, 'kara.clark@univ.edu'),
(112, 'Leo', 'Lewis', '2000-05-08', 'M', 3, 2019, 'leo.lewis@univ.edu'),
(113, 'Mia', 'Robinson', '2001-12-03', 'F', 4, 2020, 'mia.robinson@univ.edu'),
(114, 'Nick', 'Walker', '2003-08-19', 'M', 1, 2022, 'nick.walker@univ.edu'),
(115, 'Olivia', 'Young', '2002-04-27', 'F', 2, 2021, 'olivia.young@univ.edu'),
(116, 'Paul', 'Allen', '2000-09-12', 'M', 3, 2019, 'paul.allen@univ.edu'),
(117, 'Quinn', 'Scott', '2001-07-08', 'F', 4, 2020, 'quinn.scott@univ.edu'),
(118, 'Rose', 'Adams', '2003-01-22', 'F', 1, 2022, 'rose.adams@univ.edu'),
(119, 'Sam', 'Baker', '2002-06-14', 'M', 2, 2021, 'sam.baker@univ.edu'),
(120, 'Tina', 'Nelson', '2000-11-11', 'F', 3, 2019, 'tina.nelson@univ.edu');

-- Insert courses (10 courses across departments)
INSERT INTO courses VALUES
(1, 'CS101', 'Programming Fundamentals', 4, 1),
(2, 'CS201', 'Data Structures', 4, 1),
(3, 'MATH150', 'Calculus I', 3, 2),
(4, 'MATH210', 'Linear Algebra', 3, 2),
(5, 'PHYS101', 'Mechanics', 4, 3),
(6, 'PHYS202', 'Electromagnetism', 4, 3),
(7, 'ECON101', 'Microeconomics', 3, 4),
(8, 'ECON205', 'Econometrics', 4, 4),
(9, 'CS301', 'Database Systems', 4, 1),
(10, 'MATH310', 'Probability & Statistics', 3, 2);

-- Insert enrollments (80 records, grades 0-100, some NULLs for missing data)
INSERT INTO enrollments VALUES
(1,101,1,'Fall',2020,85.5,90.0),(2,101,2,'Spring',2021,78.0,85.0),(3,101,3,'Fall',2020,92.0,95.0),
(4,102,3,'Fall',2019,88.5,88.0),(5,102,4,'Spring',2020,74.0,80.0),(6,102,5,'Fall',2019,91.0,92.0),
(7,103,1,'Fall',2021,79.0,82.0),(8,103,2,'Spring',2022,84.5,88.0),(9,103,9,'Fall',2022,88.0,90.0),
(10,104,5,'Fall',2020,67.5,70.0),(11,104,6,'Spring',2021,72.0,75.0),(12,104,5,'Fall',2021,81.0,85.0),
(13,105,7,'Fall',2019,94.0,96.0),(14,105,8,'Spring',2020,82.0,84.0),(15,105,7,'Fall',2020,88.0,90.0),
(16,106,3,'Fall',2022,90.0,92.0),(17,106,4,'Spring',2023,86.5,89.0),(18,106,10,'Fall',2022,93.0,94.0),
(19,107,1,'Fall',2021,76.0,78.0),(20,107,2,'Spring',2022,NULL,85.0),(21,107,9,'Fall',2022,84.0,87.0),
(22,108,5,'Fall',2019,82.0,80.0),(23,108,6,'Spring',2020,77.0,79.0),(24,108,5,'Fall',2020,85.0,88.0),
(25,109,7,'Fall',2020,91.5,93.0),(26,109,8,'Spring',2021,79.0,81.0),(27,109,7,'Fall',2021,86.0,88.0),
(28,110,3,'Fall',2022,68.0,70.0),(29,110,4,'Spring',2023,74.5,78.0),(30,110,10,'Fall',2022,81.0,83.0),
(31,111,1,'Fall',2021,95.0,98.0),(32,111,2,'Spring',2022,88.0,91.0),(33,111,9,'Fall',2022,92.5,94.0),
(34,112,5,'Fall',2019,63.0,65.0),(35,112,6,'Spring',2020,68.0,70.0),(36,112,5,'Fall',2020,71.0,74.0),
(37,113,7,'Fall',2020,87.0,89.0),(38,113,8,'Spring',2021,93.0,95.0),(39,113,7,'Fall',2021,89.0,91.0),
(40,114,1,'Fall',2022,82.0,85.0),(41,114,2,'Spring',2023,78.5,81.0),(42,114,9,'Fall',2023,86.0,88.0),
(43,115,3,'Fall',2021,91.0,93.0),(44,115,4,'Spring',2022,84.0,86.0),(45,115,10,'Fall',2022,89.0,90.0),
(46,116,5,'Fall',2019,79.0,77.0),(47,116,6,'Spring',2020,83.0,85.0),(48,116,5,'Fall',2020,88.0,90.0),
(49,117,7,'Fall',2020,76.0,80.0),(50,117,8,'Spring',2021,81.5,84.0),(51,117,7,'Fall',2021,90.0,92.0),
(52,118,1,'Fall',2022,93.0,95.0),(53,118,2,'Spring',2023,87.0,89.0),(54,118,9,'Fall',2023,91.0,93.0),
(55,119,3,'Fall',2021,71.0,73.0),(56,119,4,'Spring',2022,64.5,67.0),(57,119,10,'Fall',2022,77.0,80.0),
(58,120,5,'Fall',2019,69.0,72.0),(59,120,6,'Spring',2020,74.0,76.0),(60,120,5,'Fall',2020,78.0,80.0),
(61,101,9,'Spring',2022,88.0,92.0),(62,102,10,'Spring',2021,79.0,82.0),(63,104,6,'Fall',2022,84.5,87.0),
(64,106,10,'Spring',2023,91.0,93.0),(65,108,6,'Fall',2021,80.0,83.0),(66,110,4,'Fall',2023,76.0,79.0),
(67,112,6,'Fall',2021,73.5,76.0),(68,114,9,'Spring',2024,88.5,90.0),(69,116,6,'Fall',2021,85.0,87.0),
(70,118,2,'Fall',2024,89.0,91.0),(71,103,3,'Spring',2022,83.0,85.0),(72,107,4,'Fall',2022,70.0,73.0),
(73,111,10,'Spring',2023,94.0,96.0),(74,115,5,'Spring',2022,76.5,79.0),(75,119,7,'Spring',2022,68.0,70.0),
(76,101,5,'Summer',2021,87.0,89.0),(77,104,3,'Summer',2021,79.5,81.0),(78,107,8,'Summer',2022,85.0,87.0),
(79,110,1,'Summer',2023,82.0,84.0),(80,113,4,'Summer',2021,90.0,92.0);

-- Insert extracurricular activities (20 records)
INSERT INTO extracurricular_activities VALUES
(1,101,'Chess Club',4.5,2020),(2,102,'Basketball',6.0,2019),(3,103,'Debate Team',3.0,2021),
(4,104,'Music Band',5.0,2020),(5,105,'Volunteering',2.5,2019),(6,106,'Chess Club',4.0,2022),
(7,107,'Coding Club',8.0,2021),(8,108,'Swimming',5.0,2019),(9,109,'Debate Team',3.5,2020),
(10,110,'Basketball',7.0,2022),(11,111,'Coding Club',6.5,2021),(12,112,'Music Band',4.0,2019),
(13,113,'Volunteering',3.0,2020),(14,114,'Chess Club',2.0,2022),(15,115,'Debate Team',4.0,2021),
(16,116,'Swimming',5.5,2019),(17,117,'Coding Club',5.0,2020),(18,118,'Basketball',6.0,2022),
(19,119,'Music Band',3.0,2021),(20,120,'Volunteering',2.0,2019);




