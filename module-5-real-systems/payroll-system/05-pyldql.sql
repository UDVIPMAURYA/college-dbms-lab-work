/*
========================================================
Module        : Module 5 - Real World Systems
Project       : Payroll Processing System
Title         : DQL - SELECT, WHERE, JOIN, GROUP BY, HAVING, ORDER BY
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
Schema        : PAYROLL
========================================================
Concepts covered:
- WHERE clause filtering
- INNER JOIN across two and three related tables
- Aggregate function (SUM) with GROUP BY
- HAVING clause to filter grouped results
- ORDER BY for sorting
========================================================
*/

-- 1. List all employees belonging to the IT department (Dept_ID 102)
SELECT EMP_NAME, Designation
FROM EMPLOYEE
WHERE Dept_ID = 102;


-- 2. List every employee along with their department name (JOIN across 2 tables)
SELECT e.EMP_NAME, d.DEPT_NAME
FROM EMPLOYEE e
INNER JOIN DEPARTMENT d ON e.Dept_ID = d.Dept_ID;


-- 3. List every employee's Net_Salary for the January 2026 pay cycle (JOIN with PAYROLL)
SELECT e.EMP_NAME, p.Net_Salary
FROM PAYROLL p
INNER JOIN EMPLOYEE e ON p.Employee_ID = e.Employee_ID
WHERE p.Pay_Month = DATE '2026-01-01';


-- 4. Total salary expenditure per department for January 2026 (Aggregate + GROUP BY)
SELECT Dept_ID, SUM(Net_Salary) AS Total_Salary_Expense
FROM PAYROLL
GROUP BY Dept_ID;


-- 5. Departments whose total salary expenditure exceeds Rs. 375,000 (GROUP BY + HAVING)
SELECT Dept_ID, SUM(Net_Salary) AS Total_Salary_Expense
FROM PAYROLL
GROUP BY Dept_ID
HAVING SUM(Net_Salary) > 375000;


-- 6. Employees sorted by Basic_Salary, highest to lowest (ORDER BY)
SELECT EMP_NAME, Basic_Salary
FROM EMPLOYEE
ORDER BY Basic_Salary DESC;