Library Management System using SQL Project 
Project Overview
Project Title: Library Management System
Level: Intermediate
Database: library_db
This project focuses on implementing a Library Management System using SQL. It involves creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The aim is to demonstrate proficiency in database design, data manipulation, and query execution.
Library_project

![image alt](https://github.com/Kushagra-a11ly/MySQL-Data-Analytics-Project-Real-World-SQL-Insights/blob/8df6de8cc60ee2cbed78f67d968400141f73baae/Library%20Management%20System/library.jpg)


Objectives
•	Set up the Library Management System Database: Create and populate tables for branches, employees, members, books, issued status, and return status.
•	CRUD Operations: Execute Create, Read, Update, and Delete operations on the database.
•	CTAS (Create Table As Select): Use CTAS to generate new tables based on query results.
•	Advanced SQL Queries: Write complex queries to analyze and extract specific information.
Project Structure
1.	Database Setup
o	ERD
o	Database Creation: A database named library_db has been created.
o	Table Creation: Tables were created for branches, employees, members, books, issued status, and return status, with all necessary columns and relationships defined.

CREATE DATABASE library_db;

DROP TABLE IF EXISTS branch;

CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);


-- Create table "Employee"

DROP TABLE IF EXISTS employees;

CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);


-- Create table "Members"

DROP TABLE IF EXISTS members;

CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);



-- Create table "Books"

DROP TABLE IF EXISTS books;

CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);



-- Create table "IssueStatus"

DROP TABLE IF EXISTS issued_status;

CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);



-- Create table "ReturnStatus"

DROP TABLE IF EXISTS return_status;

CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

