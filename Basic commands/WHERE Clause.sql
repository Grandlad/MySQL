-- WHERE clause

SELECT * -- Searching for everyone named Leslie from  employee salary table
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT * -- Searching for everyone earning more or equal to 50 000
FROM employee_salary
WHERE salary >= 50000
;

SELECT * -- Searching for everyone who is NOT female
FROM employee_demographics
WHERE gender != 'Female'
;


-- AND, OR, NOT -- Logical operators

SELECT * -- Searching for everyone who younger than 1985-01-01 and is male
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;

SELECT * -- Searching for everyone who's first name is Leslie and age is 44 OR everyone who's age is over 55
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;


-- LIKE statement
-- % and _ - to mark if something is before or after the phrase. "%" is anything before or after, while "_" stands for 1 character

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;
