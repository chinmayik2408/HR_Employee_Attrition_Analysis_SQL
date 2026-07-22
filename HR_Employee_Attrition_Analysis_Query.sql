-- HR Employee Attrition Analysis

-- Creating a Table

CREATE TABLE hr_employee_attrition (
    age INT,
    attrition VARCHAR(10),
    businesstravel VARCHAR(50),
    dailyrate INT,
    department VARCHAR(50),
    distancefromhome INT,
    education INT,
    educationfield VARCHAR(50),
    employeecount INT,
    employeenumber INT,
    environmentsatisfaction INT,
    gender VARCHAR(10),
    hourlyrate INT,
    jobinvolvement INT,
    joblevel INT,
    jobrole VARCHAR(50),
    jobsatisfaction INT,
    maritalstatus VARCHAR(20),
    monthlyincome INT,
    monthlyrate INT,
    numcompaniesworked INT,
    over18 VARCHAR(5),
    overtime VARCHAR(10),
    percentsalaryhike INT,
    performancerating INT,
    relationshipsatisfaction INT,
    standardhours INT,
    stockoptionlevel INT,
    totalworkingyears INT,
    trainingtimeslastyear INT,
    worklifebalance INT,
    yearsatcompany INT,
    yearsincurrentrole INT,
    yearssincelastpromotion INT,
    yearswithcurrmanager INT
);


-- Understanding the data 

SELECT * From hr_employee_attrition

SELECT COUNT (*) FROM hr_employee_attrition

SELECT DISTINCT department FROM hr_employee_attrition

SELECT DISTINCT jobrole FROM hr_employee_attrition

SELECT DISTINCT attrition FROM hr_employee_attrition

SELECT DISTINCT overtime FROM hr_employee_attrition


-- Business-related Questions and Answers

-- Q1)Which department has the highest attrition rate? 
-- Q2)Is overtime associated with higher attrition? 
-- Q3) Which job role has the highest average monthly income? 
-- Q4)What is the average age of employees by department? 
-- Q5)Which education field has the highest number of employees? 
-- Q6)Which age group has the highest attrition? 
-- Q7)What is the average years at the company by job role? 
-- Q8)Which departments have the highest job satisfaction? 
-- Q9)Who are the top 10 highest-paid employees? 
-- Q10)What is the gender distribution across departments?

SELECT * FROM hr_employee_attrition

-- Q1)Which department has the highest attrition rate? 

SELECT
    department,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND(
        (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*))::NUMERIC,
        2
    ) AS attrition_rate
FROM hr_employee_attrition
GROUP BY department
ORDER BY attrition_rate DESC;

-- Q2)Is overtime associated with higher attrition? 

SELECT
    overtime,
    COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND(
        (COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*))::NUMERIC,
        2
    ) AS attrition_rate
FROM hr_employee_attrition
GROUP BY overtime
ORDER BY attrition_rate DESC;

-- Q3) Which job role has the highest average monthly income? 

SELECT
    jobrole,
    ROUND(AVG(monthlyincome),2) AS average_salary
FROM hr_employee_attrition
GROUP BY jobrole
ORDER BY average_salary DESC;

-- Q4)What is the average age of employees by department?

SELECT
    department,
    ROUND(AVG(age),2) AS average_age
FROM hr_employee_attrition
GROUP BY department
ORDER BY average_age DESC;

-- Q5)Which education field has the highest number of employees? 

SELECT
    educationfield,
    COUNT(*) AS total_employees
FROM hr_employee_attrition
GROUP BY educationfield
ORDER BY total_employees DESC;

-- Q6)Which age group has the highest attrition? 

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(CASE WHEN attrition='Yes' THEN 1 END) AS employees_left
FROM hr_employee_attrition
GROUP BY age_group
ORDER BY employees_left DESC;

-- Q7)What is the average years at the company by job role? 

SELECT
    jobrole,
    ROUND(AVG(yearsatcompany),2) AS average_years
FROM hr_employee_attrition
GROUP BY jobrole
ORDER BY average_years DESC;

-- Q8)Which departments have the highest job satisfaction? 

SELECT
    department,
    ROUND(AVG(jobsatisfaction),2) AS average_job_satisfaction
FROM hr_employee_attrition
GROUP BY department
ORDER BY average_job_satisfaction DESC;

-- Q9)Who are the top 10 highest-paid employees? 

SELECT
    employeenumber,
    jobrole,
    department,
    monthlyincome
FROM hr_employee_attrition
ORDER BY monthlyincome DESC
LIMIT 10;

-- Q10)What is the gender distribution across departments?

SELECT
    department,
    gender,
    COUNT(*) AS total_employees
FROM hr_employee_attrition
GROUP BY department, gender
ORDER BY department, total_employees DESC;

--End of project

