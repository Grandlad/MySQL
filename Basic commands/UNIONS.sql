-- Unions

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name, 'SENIOR Male' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT first_name, last_name, 'SENIOR Female' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name, last_name, 'Higly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
;

