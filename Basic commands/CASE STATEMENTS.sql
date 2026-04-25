-- Case Statements

SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Middle Aged'
    WHEN age >= 50 THEN 'Senior'
END AS Age_Category
FROM employee_demographics
;

-- Pay Increase and Bonus
-- < 50 000 = 5%
-- > 50 000 = 7%
-- Finance = 10% OF ADDITIONAL BONUS

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
    WHEN occupation = 'Finance' THEN salary * 1.1
END AS 'New Salary',
CASE
	WHEN dept_id = 6 THEN salary * .1
END AS 'Bonus'
FROM employee_salary;

