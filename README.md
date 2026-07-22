# HR Employee Attrition Analysis SQL
HR Employee Attrition Analysis using SQL to uncover workforce trends and employee retention insights.

## Project Overview
This project analyses the IBM HR Employee Attrition dataset using SQL and Microsoft Excel to identify trends, patterns, and key factors influencing employee turnover. The analysis focuses on understanding how employee demographics, job roles, departments, income, overtime, and other workplace attributes relate to attrition.

## Dataset
- IBM HR Employee Attrition Dataset
- Fields include: Age, Attrition, Business Travel, Education, Overtime, Job involvement, Job satisfaction, etc.

## Tools Used
- SQL (PgAdmin)
- Excel
- GitHub

## Project Title
- Project Title: HR Employee Attrition Analysis
- Level: Beginner
- Database: `HR-Employee-Attrition-Analysis`

## Few Key Insights
- Overall attrition was highest among employees in the Sales department, indicating a greater need for retention strategies within customer-facing roles.
- Employees working overtime showed significantly higher attrition than those who did not, highlighting workload as a potential factor in turnover.
- Employees with fewer years at the company were more likely to leave, emphasising the importance of onboarding and early career engagement.

## Objectives
- Analyse employee attrition trends using SQL and Excel.
- Identify the key factors contributing to employee turnover.
- Compare attrition across departments, job roles, and employee demographics.
- Generate insights to support data-driven HR decision-making.

## Project Structure

### 1. Database and Table Setup
- **Database Creation**: The project starts by creating a database named `HR-Employee-Attrition-Analysis`.
- **Table Creation**: A table named `hr_employee_attrition` is created to store the employees data.

The table structure includes columns for Age, Attrition,	BusinessTravel,	DailyRate,	Department,	DistanceFromHome,	Education,	EducationField,	EmployeeCount,	EmployeeNumber,	EnvironmentSatisfaction,	Gender,	HourlyRate,	JobInvolvement,	JobLevel,	JobRole,	JobSatisfaction,	MaritalStatus,	MonthlyIncome,	MonthlyRate,	NumCompaniesWorked,	Over18,	OverTime,	PercentSalaryHike,	PerformanceRating, RelationshipSatisfaction,	StandardHours,	StockOptionLevel,	TotalWorkingYears,	TrainingTimesLastYear,	WorkLifeBalance,	YearsAtCompany,	YearsInCurrentRole,	YearsSinceLastPromotion,	YearsWithCurrManager.

```sql
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
```

### 2. Database Exploration
- Employee count: Checking for the number of employees
- Department count: Determining the number of departments
- Job role count: Determining various job roles
- Attrition and overtime: Checking availability of attrition and overtime

```sql
SELECT * From hr_employee_attrition

SELECT COUNT (*) FROM hr_employee_attrition

SELECT DISTINCT department FROM hr_employee_attrition

SELECT DISTINCT jobrole FROM hr_employee_attrition

SELECT DISTINCT attrition FROM hr_employee_attrition

SELECT DISTINCT overtime FROM hr_employee_attrition
```

### Data Analysis and Findings
The following SQL queries were developed to answer specific business questions:

1. **Which department has the highest attrition rate?** :
   
   **Answer**: The *Sales* department recorded the highest employee attrition rate.
   
```sql
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
```

2. **Is overtime associated with higher attrition?** :
   
   **Answer**: Employees who *worked overtime were more likely to leave* the company than those who did not.

```sql
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
```

3. **Which job role has the highest average monthly income?** :
   
    **Answer**: *Managers* had the highest average monthly income among all job roles.

```sql
SELECT
    jobrole,
    ROUND(AVG(monthlyincome),2) AS average_salary
FROM hr_employee_attrition
GROUP BY jobrole
ORDER BY average_salary DESC;
```

4. **What is the average age of employees by department?** :
   
   **Answer**: The average employee age *varies across departments*, providing insights into workforce demographics.

```sql
SELECT
    department,
    ROUND(AVG(age),2) AS average_age
FROM hr_employee_attrition
GROUP BY department
ORDER BY average_age DESC;
```

5. **Which education field has the highest number of employees?**
   
    **Answer**: The *Life Sciences* education field had the highest number of employees.

```sql
SELECT
    educationfield,
    COUNT(*) AS total_employees
FROM hr_employee_attrition
GROUP BY educationfield
ORDER BY total_employees DESC;
```

6. **Which age group has the highest attrition?** :
   
   **Answer**: Employees aged *26–35* years experienced the highest employee attrition.

```sql
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
```

7. What is the average years at the company by job role?** :
   
   **Answer**: The average years at the company *differs across job roles*, reflecting varying levels of employee experience and retention.

```sql
SELECT
    jobrole,
    ROUND(AVG(yearsatcompany),2) AS average_years
FROM hr_employee_attrition
GROUP BY jobrole
ORDER BY average_years DESC;
```

8. **Which departments have the highest job satisfaction?** :
   
   **Answer**: Job satisfaction levels *vary by department*, with some departments reporting higher average satisfaction than others.

```sql
SELECT
    department,
    ROUND(AVG(jobsatisfaction),2) AS average_job_satisfaction
FROM hr_employee_attrition
GROUP BY department
ORDER BY average_job_satisfaction DESC;
```

9. **Who are the top 10 highest-paid employees?** :
    
   **Answer**: The analysis identified the top 10 employees with the highest monthly income within the organisation.

```sql
SELECT
    employeenumber,
    jobrole,
    department,
    monthlyincome
FROM hr_employee_attrition
ORDER BY monthlyincome DESC
LIMIT 10;
```

10. ***What is the gender distribution across departments?** :
    
    **Answer**: The gender distribution varies across departments, providing insights into workforce diversity.

```sql
SELECT
    department,
    gender,
    COUNT(*) AS total_employees
FROM hr_employee_attrition
GROUP BY department, gender
ORDER BY department, total_employees DESC;
```

## Report Summary
- Analysed the HR Employee Attrition dataset using SQL and Excel.
- Explored employee turnover trends across departments, job roles, and demographics.
- Used SQL queries to extract, filter, and summarise HR data.
- Presented findings using Excel tables and charts for better interpretation.

## Conclusion
- Identified key factors associated with employee attrition.
- Demonstrated practical SQL and Excel skills through real-world data analysis.
- Converted raw HR data into meaningful business insights.
- Showed how data analysis can support HR decision-making and employee retention strategies.

## Author - Chinmayi K

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Connect with me through:
- **LinkedIn**: [Connect with me professionaly](www.linkedin.com/in/chinmayi-k2408)
- **Email**: [Connect with me professionally](chinmayik2408@gmail.com)
