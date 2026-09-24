/*
========================================================
Experiment No : 3 (Part 6)
Title         : Views, Indexes, Sequences
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO1
========================================================
*/

-- ===================== VIEWS =====================

-- 1. Simple view: Student with their department name (hides join complexity)
CREATE VIEW vw_student_department AS
SELECT s.Student_ID, s.Name AS Student_Name, d.Dept_Name
FROM STUDENT s
JOIN DEPARTMENT d ON s.Dept_ID = d.Dept_ID;

-- Use it like a normal table
SELECT * FROM vw_student_department;

-- 2. View with aggregate: student count per department
CREATE VIEW vw_dept_student_count AS
SELECT d.Dept_Name, COUNT(s.Student_ID) AS Total_Students
FROM DEPARTMENT d
LEFT JOIN STUDENT s ON d.Dept_ID = s.Dept_ID
GROUP BY d.Dept_Name;

SELECT * FROM vw_dept_student_count;

-- Drop a view (if needed)
-- DROP VIEW vw_student_department;


-- ===================== INDEXES =====================

-- 3. Index on a column frequently used in WHERE/JOIN (Dept_ID in STUDENT)
CREATE INDEX idx_student_dept ON STUDENT(Dept_ID);

-- 4. Composite index example (multiple columns together)
CREATE INDEX idx_enrollment_student_course ON ENROLLMENT(Student_ID, Course_ID);

-- View existing indexes on a table
SELECT index_name, column_name
FROM user_ind_columns
WHERE table_name = 'STUDENT';

-- Drop an index (if needed)
-- DROP INDEX idx_student_dept;


-- ===================== SEQUENCES =====================

-- 5. Sequence for auto-generating Enrollment_IDs
CREATE SEQUENCE seq_enrollment
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Use the sequence while inserting (no need to manually pick next ID)
INSERT INTO ENROLLMENT (Enrollment_ID, Student_ID, Course_ID, Enroll_Date)
VALUES (seq_enrollment.NEXTVAL, 1004, 201, SYSDATE);

-- Check current value of the sequence
SELECT seq_enrollment.CURRVAL FROM dual;

COMMIT;