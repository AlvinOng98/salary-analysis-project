-----------------------
--  SALARY ANALYSIS  --
-----------------------

-- *********************
-- DATA OVERVIEW
-- *********************

-- 1. Overview of salary
-- Helps understand salary range & standard deviation.
SELECT 
    MIN(salary) AS min_salary, 
    MAX(salary) AS max_salary, 
    ROUND(AVG(salary), 2) AS avg_salary, 
    STDDEV(salary) AS std_dev_salary, 
    COUNT(*) AS total_records
FROM salary_data;

-- *********************
-- SIMPLE DATA ANALYSIS
-- *********************

-- 2. Salary breakdown by Job Title
-- See the highest-paying and most common jobs.
SELECT Job_Title, COUNT(*) AS Num_Employees, 
       AVG(Salary) AS Avg_Salary, 
       MAX(Salary) AS Max_Salary, 
       MIN(Salary) AS Min_Salary
FROM salary_data
GROUP BY Job_Title
ORDER BY Avg_Salary DESC
LIMIT 10;

SELECT Job_Title, COUNT(*) AS Num_Employees, 
       AVG(Salary) AS Avg_Salary, 
       MAX(Salary) AS Max_Salary, 
       MIN(Salary) AS Min_Salary
FROM salary_data
GROUP BY Job_Title
ORDER BY Num_Employees DESC
LIMIT 10;

-- 3. Salary vs. Education Level
SELECT Education_Level, COUNT(*) AS Num_Employees, 
       AVG(Salary) AS Avg_Salary
FROM salary_data
GROUP BY Education_Level
ORDER BY Avg_Salary DESC
LIMIT 10;

-- 4. Experience vs. Salary Relationship
-- See if salary increases with experience.
SELECT Years_of_Experience, 
       COUNT(*) AS Num_Employees,
       AVG(Salary) AS Avg_Salary
FROM salary_data
GROUP BY Years_of_Experience
ORDER BY Years_of_Experience 
LIMIT 10;

-- 5. Gender Pay Gap
-- Check for potential gender-based salary differences.
SELECT Gender, AVG(Salary) AS Avg_Salary, COUNT(*) AS Num_Employees
FROM salary_data
GROUP BY Gender;
