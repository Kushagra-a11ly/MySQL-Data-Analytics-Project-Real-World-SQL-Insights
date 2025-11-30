CREATE DATABASE hr_analytics;

USE hr_analytics;

RENAME TABLE `hr_analytics_table` TO hr_analytics;

-- All records
SELECT 
    *
FROM
    hr_analytics;

-- Count total employees
SELECT 
    COUNT(*) AS Total_Employees
FROM
    hr_analytics;

-- Count attrition (employees who left)
SELECT 
    COUNT(*) AS Total_attrition
FROM
    hr_analytics
WHERE
    Attrition = 'Yes';

-- Employees by gender
SELECT 
    Gender, COUNT(*)
FROM
    hr_analytics
GROUP BY Gender;

-- Employees by department
SELECT 
    Department, COUNT(*)
FROM
    hr_analytics
GROUP BY Department;

-- Average age of employees
SELECT 
    AVG(Age) AS avg_age
FROM
    hr_analytics;

-- Minimum and maximum salary
SELECT 
    MIN(MonthlyIncome) AS Minimum_Income,
    MAX(MonthlyIncome) AS Maximum_Income
FROM
    hr_analytics;

-- List all employees with job role
SELECT 
    EmpID, Job_Role, Department
FROM
    hr_analytics;

-- Count employees by marital status
SELECT 
    Marital_Status, COUNT(*)
FROM
    hr_analytics
GROUP BY Marital_Status;

-- Average distance from home
SELECT 
    AVG(Distance_From_Home) AS Average_distance
FROM
    hr_analytics;

-- List employees who work overtime
SELECT 
    EmpID, Job_Role
FROM
    hr_analytics
WHERE
    OverTime = 'Yes';

-- Which department has the highest total salary expense

SELECT 
    Department, SUM(MonthlyIncome) AS total_salary_expense
FROM
    hr_analytics
GROUP BY Department
ORDER BY total_salary_expense DESC;

-- What is the attrition rate for each department.

SELECT 
    Department,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) * 100.0 / COUNT(*) AS attrition_rate
FROM
    hr_analytics
GROUP BY Department
ORDER BY attrition_rate DESC;

-- Which job roles have the highest earning employees?

SELECT 
    Job_Role, AVG(MonthlyIncome) AS avg_salary
FROM
    hr_analytics
GROUP BY Job_Role
ORDER BY avg_salary DESC;

-- Which factors are strongly associated with employees leaving?

SELECT 
    Attrition,
    AVG(Job_Satisfaction) AS avg_job_satisfaction,
    AVG(Work_Life_Balance) AS avg_worklife,
    AVG(Environment_Satisfaction) AS avg_environment,
    AVG(Years_At_Company) AS avg_tenure
FROM
    hr_analytics
GROUP BY Attrition;

-- Which employees are overworked based on Overtime + Work-Life Balance?

SELECT 
    EmpID, Job_Role, OverTime, Work_Life_Balance, MonthlyIncome
FROM
    hr_analytics
WHERE
    OverTime = 'Y' AND Work_Life_Balance <= 2;

-- What is the average time before employees get their first promotion?
SELECT 
    AVG(Years_Since_Last_Promotion) AS avg_years_before_promotion
FROM
    hr_analytics;

-- Which employees are most likely ready for promotion
SELECT 
    EmpID,
    Job_Role,
    Years_In_Current_Role,
    Performance_Rating,
    Job_Involvement
FROM
    hr_analytics
WHERE
    Performance_Rating >= 4
        AND Job_Involvement >= 3
        AND Years_In_Current_Role >= 3;

-- Which age group generates the highest revenue (salary cost)?
SELECT 
    Age_Group,SUM(MonthlyIncome) AS total_income_cost
FROM
    hr_analytics
GROUP BY Age_Group
ORDER BY total_income_cost DESC;

-- Which business travel group leaves the company more?
SELECT 
    Business_Travel,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS total_attrition
FROM
    hr_analytics
GROUP BY Business_Travel
ORDER BY total_attrition DESC;

-- Which departments have the lowest employee satisfaction?
SELECT 
    Department,
    AVG(Job_Satisfaction) AS avg_satisfaction,
    AVG(Environment_Satisfaction) AS avg_environment
FROM
    hr_analytics
GROUP BY Department
ORDER BY avg_satisfaction ASC;

-- Pair employees with same Job_Role for comparison
SELECT 
    a.EmpID AS Emp1,
    b.EmpID AS Emp2,
    a.Job_Role
FROM hr_analytics a
JOIN hr_analytics b
    ON a.Job_Role = b.Job_Role
   AND a.EmpID < b.EmpID;

-- Rank employees based on Monthly Income within each Department
SELECT 
    EmpID,
    Department,
    MonthlyIncome,
    RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS Income_Rank
FROM hr_analytics;


-- Rank employees by salary within Job_Role
SELECT 
    EmpID,
    Job_Role,
    MonthlyIncome,
    RANK() OVER (PARTITION BY Job_Role ORDER BY MonthlyIncome DESC) AS Role_Salary_Rank
FROM hr_analytics; 

-- Calculate rolling average income (moving window)
SELECT 
    EmpID,
    MonthlyIncome,
    AVG(MonthlyIncome) OVER (ORDER BY MonthlyIncome ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_Avg
FROM hr_analytics;

-- Find employees earning above department median income
WITH median_calc AS (
    SELECT 
        Department,
        MonthlyIncome,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY MonthlyIncome) AS rn,
        COUNT(*) OVER (PARTITION BY Department) AS cnt
    FROM hr_analytics
)
SELECT Department, MonthlyIncome
FROM median_calc
WHERE rn IN ((cnt + 1)/2, (cnt + 2)/2);

-- Check if employee salary increased compared to previous employee
SELECT 
    EmpID,
    MonthlyIncome,
    LAG(MonthlyIncome) OVER (ORDER BY EmpID) AS Prev_Employee_Salary,
    MonthlyIncome - LAG(MonthlyIncome) OVER (ORDER BY EmpID) AS Salary_Diff
FROM hr_analytics;

-- Detect satisfaction drop from previous employee
SELECT 
    EmpID,
    Job_Satisfaction,
    LAG(Job_Satisfaction) OVER (ORDER BY EmpID) AS Previous_Satisfaction,
    Job_Satisfaction - LAG(Job_Satisfaction) OVER (ORDER BY EmpID) AS Change_
FROM hr_analytics;

-- Split employees into salary quartiles
SELECT 
    EmpID,
    MonthlyIncome,
    NTILE(4) OVER (ORDER BY MonthlyIncome) AS Salary_Quartile
FROM hr_analytics;

-- Create performance deciles (Top 10%, top 20%, etc.)
SELECT 
    EmpID,
    Performance_Rating,
    NTILE(10) OVER (ORDER BY Performance_Rating DESC) AS Performance_Decile
FROM hr_analytics;

-- Identify "Future Managers" using a scoring model

WITH score AS (
    SELECT 
        EmpID,
        Job_Role,
        Performance_Rating + Job_Satisfaction + Job_Involvement AS Score
    FROM hr_analytics
)
SELECT *
FROM score
WHERE Score >= (SELECT AVG(Score) FROM score)
ORDER BY Score DESC;

-- Find long-tenure employees using window percentiles
WITH p AS (
    SELECT 
        EmpID,
        Years_At_Company,
        PERCENT_RANK() OVER (ORDER BY Years_At_Company DESC) AS Tenure_Percentile
    FROM hr_analytics
)
SELECT *
FROM p
WHERE Tenure_Percentile <= 0.10; 

-- Employees who earn more than all peers in their department
SELECT *
FROM hr_analytics h
WHERE MonthlyIncome = (
    SELECT MAX(MonthlyIncome)
    FROM hr_analytics
    WHERE Department = h.Department
);

-- Employees with above-average Work_Life_Balance for their role
SELECT *
FROM hr_analytics h
WHERE Work_Life_Balance >
(
    SELECT AVG(Work_Life_Balance)
    FROM hr_analytics
    WHERE Job_Role = h.Job_Role
);

-- Generate hierarchy-like years (1 to max Years_At_Company)
WITH RECURSIVE nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM nums
    WHERE n < (SELECT MAX(Years_At_Company) FROM hr_analytics)
)
SELECT * FROM nums;






























































