/*
========================================================
Experiment No : 3 (Part 5)
Title         : Aggregate Functions, GROUP BY, HAVING
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO3
========================================================
Concepts covered:
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY, HAVING
Interview angle:
- WHERE vs HAVING difference
========================================================
*/

-- 1. Total number of students
SELECT COUNT(*) AS Total_Students FROM STUDENT;

-- 2. Total, Average, Min, Max credits across all courses
SELECT SUM(Credits) AS Total_Credits,
       AVG(Credits) AS Avg_Credits,
       MIN(Credits) AS Min_Credits,
       MAX(Credits) AS Max_Credits
FROM COURSE;

-- 3. GROUP BY: number of students per department
SELECT Dept_ID, COUNT(*) AS Total_Students
FROM STUDENT
GROUP BY Dept_ID;

-- 4. GROUP BY with JOIN: department name + student count (more readable)
SELECT d.Dept_Name, COUNT(s.Student_ID) AS Total_Students
FROM DEPARTMENT d
LEFT JOIN STUDENT s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_Name;

-- 5. HAVING: only departments with MORE THAN 2 students
SELECT Dept_ID, COUNT(*) AS Total_Students
FROM STUDENT
GROUP BY Dept_ID
HAVING COUNT(*) > 2;

-- 6. WHERE + GROUP BY + HAVING together:
--    Among courses with 4 credits, show courses that have more than 1 enrolled student
SELECT c.Course_Name, COUNT(e.Student_ID) AS Enrolled_Students
FROM COURSE c
JOIN ENROLLMENT e ON c.Course_ID = e.Course_ID
WHERE c.Credits = 4
GROUP BY c.Course_Name
HAVING COUNT(e.Student_ID) > 1;