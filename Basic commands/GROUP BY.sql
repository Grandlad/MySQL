-- Group By

-- 
SELECT gender
FROM employee_demographics
GROUP BY gender
;

-- Selecting column "gender" from table "employee demographics" and Grouping by values insige columns. Meanwhile adding AVG age basing on "age" column from the same table.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;


-- Adding calculated columns basing on the columns from db
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

