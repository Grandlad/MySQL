-- WINDOW FUNCTIONS

SELECT gender, AVG (salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

SELECT dem.first_name, dem.last_name, gender, AVG (salary) OVER(partition by gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.first_name, dem.last_name, gender, 
SUM(salary) OVER(partition by gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- Rolling total

-- Summaring salaries based on gender (numbering restart at gender switch)

SELECT dem.first_name, dem.last_name, salary, 
SUM(salary) OVER(partition by gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- Order by gender, calculating rows with (numbering restart at gender switch)

SELECT dem.employee_id, dem.first_name, dem.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- Order highest to lowest salary and by gender (numbering restart at gender switch)

SELECT dem.employee_id, dem.first_name, dem.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- numbering on "RANK" is based on the value so if there are 2 values = x in the dataset it will "duplicate" the number - it will give next number positionally not numerically

SELECT dem.employee_id, dem.first_name, dem.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- DENSE_RANK after "duplicate" it will give next number numerically not positionally

SELECT dem.employee_id, dem.first_name, dem.last_name, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


