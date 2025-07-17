use hr_analytics;
show tables;
describe hr_emp_attrition;
show tables;
select * from hr_emp_attrition;
# data_cleaning
-- rename column name
alter table hr_emp_attrition change column age Age int;

# data_analysis
-- gender breakdown employee in company
select gender,count(gender)employeenumber from hr_emp_attrition where age>=18 group by gender;

-- What is the distance of employees from the company?
select count(DistanceFromHome)employeenumber,DistanceFromHome from hr_emp_attrition 
where DistanceFromHome>=10 or DistanceFromHome<=5 group by DistanceFromHome ;

-- What is the age distribution of employees in the company?
 SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 24 THEN '18-24'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  COUNT(*) AS employeenumber
FROM hr_emp_attrition
WHERE age >= 18 AND age IS NULL
GROUP BY age_group
ORDER BY age_group
;
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 24 THEN '18-24'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,
  gender,
  COUNT(*) AS employeenumber
FROM hr_emp_attrition
WHERE age >= 18
GROUP BY age_group, gender
ORDER BY age_group;

-- How many employees work at headquarters versus remote locations?

SELECT BusinessTravel,COUNT(*)employeenumber
FROM hr_emp_attrition
WHERE age >= 18
GROUP BY BusinessTravel
ORDER BY BusinessTravel;

-- What is the average length of employment for employees who have been terminated?
SELECT Employeenumber,Attrition 
FROM hr_emp_attrition
WHERE age >=18 and length(employeenumber)>0 and Attrition='yes'
GROUP BY Attrition,EmployeeNumber;

-- How does the gender distribution/count vary across departments and job titles?
SELECT jobrole,Department,gender,count(*)EmployeeNumber
FROM hr_emp_attrition
WHERE age>=18
GROUP BY jobrole,gender,department
ORDER BY Department;

-- What is the distribution/count of job titles across the company?
SELECT jobrole,COUNT(*) employeenumber
FROM hr_emp_attrition
WHERE age >= 18
GROUP BY jobrole
ORDER BY jobrole
;

-- Which department has the highest turnover rate?
SELECT department,count(*)employeenumber 
FROM hr_emp_attrition
WHERE age>=18 and PerformanceRating<4
GROUP BY department
ORDER BY employeenumber desc;


-- How has the company's employee count changed over time based on hire and term dates?
SELECT department,count(*)overtime,attrition,count(*)employeenumber,count(*)yearsatcompany
FROM hr_emp_attrition
WHERE yearsatcompany>5
GROUP BY department,attrition
ORDER BY overtime;
