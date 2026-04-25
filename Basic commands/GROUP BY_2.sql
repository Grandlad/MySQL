-- Group By

-- 
SELECT gender
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;


SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;