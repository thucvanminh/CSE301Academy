use problem2;


-- 1. Check constraint to value of gender in “Nam” or “Nu”. 

alter table employees 
add constraint check_gender Check (gender in ('Nam','Nu'));

-- 2. Check constraint to value of salary > 0. 
alter table employees
add constraint check_salary check (salary>0);
select * from employees;

-- 3. Check constraint to value of relationship in Relative table in “Vo chong”, “Con trai”, “Con 
-- gai”, “Me ruot”, “Cha ruot”.  
alter table relative
add constraint check_relative check (relationship in ('Vo chong','Con trai','Con gai','Me ruot','Cha ruot' )  );

-- 1 Look for employees with salaries above 25,000 in room 4 or employees with salaries above 
-- 30,000 in room 5.

select * from employees
where ( salary >25000 and departmentID = 4 ) or (salary > 30000 and departmentID = 5);


-- 2 Provide full names of employees in HCM city. 
select concat(lastname,' ',middleName,' ',firstName) as fullname from employees
where address like '%TPHCM%';

-- 3. Indicate the date of birth of Dinh Ba Tien staff. 
select dateOfBirth from employees 
where concat(lastname,' ',middleName,' ',firstName) = 'Dinh Ba Tien';

-- 4. The names of the employees of Room 5 are involved in the "San pham X" project and this 
-- employee is directly managed by "Nguyen Thanh Tung". 

select * from employees e inner join assignment a
on e.employeeID = a.employeeID 
where e.managerID = ( select employeeID from employees  where concat(lastname,' ',middleName,' ',firstName) = 'Nguyen Thanh Tung')
and e.departmentID = 5 
and projectID = ( select projectID from project where projectName = 'San pham X');

-- 5. Find the names of department heads of each department
	select e.firstName from department d inner join employees e 
    on d.managerID = e.employeeID
    where d.managerID in (select employeeID from employees) ;


-- 6 Find projectID, projectName, projectAddress, departmentID, departmentName, 
-- departmentID, date0fEmployment. 
select * from project p inner join department d 
on d.departmentID = p.departmentID;

-- 7. Find the names of female employees and their relatives.
select * from relative r inner join employees e
on r.employeeID = e.employeeID
where e.gender like '%Nu%';

-- 8For all projects in "Hanoi", list the project code (projectID), the code of the project lead 
-- department (departmentID), the full name of the manager (lastName, middleName, 
-- firstName) as well as the address (Address) and date of birth (date0fBirth) of the 
-- Employees.


select p.projectID, p.departmentID, concat(e.lastname,' ',e.middleName,' ',e.firstName) as `Full Name`, e.address, e.dateOfBirth 
from project p inner join department d 
on d.departmentID = p.departmentID 
inner join employees e 
on e.employeeID = d.managerID
where projectAddres = 'Ha Noi';

-- 10 For each employee, indicate the employee's full name and the full name of the head of the 
-- department in which the employee works. 

select concat(e.lastname,' ',e.middleName,' ',e.firstName) as `Full Name`
from department d inner join employees e
on d.managerID = e.employeeID;

select concat(e.lastname,' ',e.middleName,' ',e.firstName) as `Employees Name`
from employees e  inner join department d 
on d.departmentID = e.departmentID;

-- 11 Provide the employee's full name (lastName, middleName, firstName) and the names of 
-- the projects in which the employee participated, if any. 
select * from employees;
select * from assignment;
select * from project;

select concat(e.lastname,' ',e.middleName,' ',e.firstName) as `Full Name`, p.projectName
from employees e inner join assignment a 
on e.employeeID = a.employeeID
inner join project p 
on p.projectID = a.projectID;

-- 12For each scheme, list the scheme name (projectName) and the total number of hours 
-- worked per week of all employees attending that scheme. 

select * from assignment;
select * from project;

select p.projectName, sum(WorkingHour) from project p 
inner join assignment a on a.projectID = p.projectID
group by p.projectName;
-- 13.....
SELECT d.departmentName, AVG(e.salary) AS averageSalary
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName;
-- 14.....
SELECT d.departmentName, COUNT(e.employeeID) AS numberOfEmployees
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName
HAVING AVG(e.salary) > 30000;
-- 15.....
SELECT DISTINCT p.projectID
FROM PROJECTS p
LEFT JOIN ASSIGNMENT a ON p.projectID = a.projectID
LEFT JOIN EMPLOYEES e ON a.employeeID = e.employeeID
LEFT JOIN DEPARTMENT d ON p.departmentID = d.departmentID
LEFT JOIN EMPLOYEES m ON d.managerID = m.employeeID
WHERE e.lastName = 'Dinh'
   OR m.lastName = 'Dinh';
-- 16.....
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
JOIN RELATIVE r ON e.employeeID = r.employeeID
GROUP BY e.employeeID, e.lastName, e.middleName, e.firstName
HAVING COUNT(r.relativeName) > 2;
-- 17.....
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
LEFT JOIN RELATIVE r ON e.employeeID = r.employeeID
WHERE r.employeeID IS NULL;
-- 18.....
SELECT DISTINCT m.lastName, m.middleName, m.firstName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID;
-- 19.....
SELECT DISTINCT m.lastName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID
WHERE r.relationship not like 'Vo chong';
-- 20.....
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS fullName
FROM EMPLOYEES e
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM EMPLOYEES e2
    JOIN DEPARTMENT d2 ON e2.departmentID = d2.departmentID
    WHERE d2.departmentName = 'Nghien cuu'
);
-- 21.....
SELECT d.departmentName, CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName
FROM DEPARTMENT d
JOIN EMPLOYEES m ON d.managerID = m.employeeID
JOIN (
    SELECT departmentID, COUNT(employeeID) AS numEmployees
    FROM EMPLOYEES
    GROUP BY departmentID
    ORDER BY numEmployees DESC
    LIMIT 1
) dept_max ON d.departmentID = dept_max.departmentID;
-- 22.....
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%TPHCM%'
  AND da.address NOT LIKE '%TPHCM%';
-- 23.....
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%'
  AND da.address NOT LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%';
-- 24.....
DELIMITER //
CREATE PROCEDURE ListEmployeeInfoByDepartment(IN deptName VARCHAR(255))
BEGIN
    SELECT e.lastName, e.middleName, e.firstName, e.address
    FROM EMPLOYEES e
    JOIN DEPARTMENT d ON e.departmentID = d.departmentID
    WHERE d.departmentName = deptName;
END //
DELIMITER ;
-- 25.....
DELIMITER //
CREATE PROCEDURE SearchProjectsByEmployeeLastName(IN empLastName VARCHAR(255))
BEGIN
    SELECT p.projectID, p.projectName, p.projectAddress
    FROM PROJECTS p
    JOIN ASSIGNMENT a ON p.projectID = a.projectID
    JOIN EMPLOYEES e ON a.employeeID = e.employeeID
    WHERE e.lastName = empLastName;
END //
DELIMITER ;
-- 26.....
DELIMITER //
CREATE FUNCTION GetAverageSalary(deptID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avgSalary DECIMAL(10, 2);
    
    SELECT AVG(salary) INTO avgSalary
    FROM EMPLOYEES
    WHERE departmentID = deptID;
    
    RETURN avgSalary;
END //
DELIMITER ;
-- 27.....
DELIMITER //
CREATE FUNCTION IsEmployeeInProject(empID INT, projID INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE isInvolved BOOLEAN;
    
    SELECT CASE
               WHEN COUNT(*) > 0 THEN TRUE
               ELSE FALSE
           END INTO isInvolved
    FROM ASSIGNMENT
    WHERE employeeID = empID AND projectID = projID;
    
    RETURN isInvolved;
END //
DELIMITER ;