-----------------------
--  SALARY ANALYSIS  --
-----------------------

-- *********************
-- DATABASE CREATION
-- *********************

-- Creating table for CSV import 
CREATE TABLE IF NOT EXISTS salary_data (
    Age INT,
    Gender VARCHAR(10),
    Education_Level VARCHAR(50),
    Job_Title VARCHAR(100),
    Years_of_Experience INT,
    Salary DECIMAL(10,2)
);

-- Load CSV data into salary_data
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Salary_Data.csv'
INTO TABLE salary_data
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS
SET Salary = NULLIF(Salary, ''),
Age = NULLIF(Age, ''),
Gender = NULLIF(Gender, ''),
Education_Level = NULLIF(Education_Level, ''),
Job_Title = NULLIF(Job_Title, ''),
Years_of_Experience = NULLIF(Years_of_Experience, '');

-- *********************
-- DATA CLEANING
-- *********************

-- Dealing with null data
SELECT *
FROM salary_data
WHERE Age IS NULL OR Gender IS NULL OR Job_Title IS NULL OR Salary IS NULL OR Education_Level IS NULL;

DELETE FROM salary_data
WHERE Age IS NULL OR Gender IS NULL OR Job_Title IS NULL OR Salary IS NULL OR Education_Level IS NULL;

SELECT *
FROM salary_data
WHERE Years_of_Experience IS NULL;

UPDATE salary_data
SET Years_of_Experience = 0
WHERE Years_of_Experience IS NULL;

-- Checking for duplicate data
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER(
           PARTITION BY Age, Gender, Education_Level, 
           Job_Title, Years_of_Experience, Salary ORDER BY Age) AS row_num
    FROM salary_data
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Standardize Data
SELECT DISTINCT Gender
FROM salary_data;

SELECT DISTINCT Education_Level
FROM salary_data;

SELECT DISTINCT Job_Title
FROM salary_data;

UPDATE salary_data
SET Education_Level = 'Bachelor\'s Degree'
WHERE Education_Level LIKE '%Bachelor%' OR Education_Level LIKE '%bachelor%';

UPDATE salary_data
SET Education_Level =  'PhD'
WHERE Education_Level LIKE '%pHD%';

UPDATE salary_data
SET Education_Level = 'Master\'s Degree'
WHERE Education_Level LIKE '%Master%' OR Education_Level LIKE '%master%';

-- Check for Null values, standardization and outliers
SELECT 
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Nulls,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Nulls,
    SUM(CASE WHEN Education_Level IS NULL THEN 1 ELSE 0 END) AS Education_Nulls,
    SUM(CASE WHEN Job_Title IS NULL THEN 1 ELSE 0 END) AS Job_Nulls,
    SUM(CASE WHEN Years_of_Experience IS NULL THEN 1 ELSE 0 END) AS Experience_Nulls,
    SUM(CASE WHEN Salary IS NULL THEN 1 ELSE 0 END) AS Salary_Nulls
FROM salary_data;

SELECT DISTINCT Education_Level
FROM salary_data;

SELECT 
    MIN(Salary) AS Min_Salary, 
    MAX(Salary) AS Max_Salary, 
    AVG(Salary) AS Avg_Salary,
    MIN(Years_of_Experience) AS Min_Experience, 
    MAX(Years_of_Experience) AS Max_Experience, 
    AVG(Years_of_Experience) AS Avg_Experience
FROM salary_data;

SELECT *
FROM salary_data
WHERE Salary <= 10000;

DELETE
FROM salary_data
WHERE Salary <= 10000;

SELECT *
FROM salary_data;