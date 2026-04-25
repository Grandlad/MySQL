-- String Functions

SELECT LENGTH('skyfall')
;

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;

SELECT UPPER ('sky');
SELECT LOWER ('SKY')
;

SELECT first_name, UPPER(first_name)
FROM employee_demographics
;

-- Trimms

SELECT TRIM('                    sky        ')
;

SELECT LTRIM('                    sky        ')
;

S2ELECT RTRIM('                    sky        ')
;

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4)
FROM employee_demographics
; 

-- Substrings

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS Birth_Month
FROM employee_demographics
; 


-- Replace
SELECT first_name, REPLACE(first_name, 'A', 'Z')
FROM employee_demographics
;

-- CONCAT - merging columns

SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) AS 'Full Name'
FROM employee_demographics
;


