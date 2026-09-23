/*
========================================================
Experiment No : 3 (Part 3)
Title         : SELECT, WHERE, ORDER BY
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO3
========================================================
Concepts covered:
- Basic SELECT, DISTINCT, column alias
- Comparison & logical operators, BETWEEN, IN, LIKE
- IS NULL, ORDER BY
Interview angle:
- Logical query execution order
========================================================
*/

-- 1. Basic SELECT with column alias
SELECT Student_ID, Name AS Student_Name, Email
FROM STUDENT;

-- 2. SELECT all columns
SELECT * FROM STUDENT;

-- 3. DISTINCT - unique Dept_IDs used by students
SELECT DISTINCT Dept_ID FROM STUDENT;

-- 4. WHERE with comparison operator
SELECT Name, DOB FROM STUDENT
WHERE Dept_ID = 101;

-- 5. WHERE with logical operators (AND / OR)
SELECT Name, Dept_ID FROM STUDENT
WHERE Dept_ID = 101 AND DOB > DATE '2004-01-01';

-- 6. BETWEEN - courses with credits in a range
SELECT Course_Name, Credits FROM COURSE
WHERE Credits BETWEEN 3 AND 4;

-- 7. IN - students belonging to specific departments
SELECT Name, Dept_ID FROM STUDENT
WHERE Dept_ID IN (101, 103);

-- 8. LIKE - pattern matching (names starting with 'S')
SELECT Name FROM STUDENT
WHERE Name LIKE 'S%';

-- 9. IS NULL - departments with no HOD assigned (example check)
SELECT Dept_Name FROM DEPARTMENT
WHERE HOD_Name IS NULL;

-- 10. ORDER BY - sort students by name (ascending, default)
SELECT Name, DOB FROM STUDENT
ORDER BY Name ASC;

-- 11. ORDER BY descending, multiple columns
SELECT Dept_ID, Name FROM STUDENT
ORDER BY Dept_ID ASC, Name DESC;