-- Stored Procedures

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();


DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;


CALL large_salaries3


DELIMITER $$
CREATE PROCEDURE large_salaries5(ID INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = ID
    ;
END $$
DELIMITER ;

CALL large_salaries5(1);

