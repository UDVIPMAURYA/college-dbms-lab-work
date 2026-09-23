/*
========================================================
Experiment No : 3 (Part 4)
Title         : JOINs - Displaying Data from Multiple Tables
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO3
========================================================
Concepts covered:
- INNER JOIN, LEFT JOIN, RIGHT JOIN
- Table aliases
- Join across 3 tables
Interview angle:
- LEFT JOIN vs INNER JOIN behavior with unmatched rows
========================================================
*/

-- 1. INNER JOIN: Student name with their department name
SELECT s.Name AS Student_Name, d.Dept_Name
FROM STUDENT s
INNER JOIN DEPARTMENT d
    ON s.Dept_ID = d.Dept_ID;

-- 2. INNER JOIN across THREE tables:
--    Which student is enrolled in which course
SELECT s.Name AS Student_Name, c.Course_Name, e.Enroll_Date
FROM ENROLLMENT e
INNER JOIN STUDENT s ON e.Student_ID = s.Student_ID
INNER JOIN COURSE c  ON e.Course_ID  = c.Course_ID
ORDER BY s.Name;

-- 3. LEFT JOIN: ALL students, even if they haven't enrolled in any course
SELECT s.Name AS Student_Name, c.Course_Name
FROM STUDENT s
LEFT JOIN ENROLLMENT e ON s.Student_ID = e.Student_ID
LEFT JOIN COURSE c     ON e.Course_ID  = c.Course_ID;

-- 4. RIGHT JOIN: ALL departments, even if they have no faculty (example)
SELECT d.Dept_Name, f.Name AS Faculty_Name
FROM FACULTY f
RIGHT JOIN DEPARTMENT d ON f.Dept_ID = d.Dept_ID;

-- 5. Join with a filter (WHERE + JOIN together)
SELECT s.Name, c.Course_Name
FROM STUDENT s
JOIN ENROLLMENT e ON s.Student_ID = e.Student_ID
JOIN COURSE c ON e.Course_ID = c.Course_ID
WHERE c.Credits = 4;