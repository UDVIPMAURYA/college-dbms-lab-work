/*
========================================================
Experiment No : 7
Title         : Procedures and Functions
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO4
========================================================
Concepts covered:
- CREATE OR REPLACE PROCEDURE with IN, OUT parameters
- CREATE OR REPLACE FUNCTION with RETURN
- Calling procedures/functions from PL/SQL and SQL
Interview angle:
- Procedure vs Function - when to use which
========================================================
*/

SET SERVEROUTPUT ON

-- ===================== PROCEDURE =====================

-- 1. Simple procedure: enroll a student in a course (IN parameters)
CREATE OR REPLACE PROCEDURE enroll_student (
    p_student_id IN NUMBER,
    p_course_id  IN NUMBER
) IS
    v_next_id NUMBER;
BEGIN
    v_next_id := seq_enrollment.NEXTVAL;

    INSERT INTO ENROLLMENT (Enrollment_ID, Student_ID, Course_ID, Enroll_Date)
    VALUES (v_next_id, p_student_id, p_course_id, SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Enrolled successfully. Enrollment_ID: ' || v_next_id);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Execute it
EXEC enroll_student(1003, 201);

-- 2. Procedure with OUT parameter: get student's department name
CREATE OR REPLACE PROCEDURE get_student_dept (
    p_student_id IN  NUMBER,
    p_dept_name  OUT VARCHAR2
) IS
BEGIN
    SELECT d.Dept_Name INTO p_dept_name
    FROM STUDENT s
    JOIN DEPARTMENT d ON s.Dept_ID = d.Dept_ID
    WHERE s.Student_ID = p_student_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_dept_name := 'Not Found';
END;
/

-- Execute it (need a variable to receive the OUT value)
DECLARE
    v_dept VARCHAR2(50);
BEGIN
    get_student_dept(1001, v_dept);
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept);
END;
/


-- ===================== FUNCTION =====================

-- 3. Function: calculate total credits a student is enrolled in
CREATE OR REPLACE FUNCTION get_total_credits (
    p_student_id IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(c.Credits), 0) INTO v_total
    FROM ENROLLMENT e
    JOIN COURSE c ON e.Course_ID = c.Course_ID
    WHERE e.Student_ID = p_student_id;

    RETURN v_total;
END;
/

-- Call it from a PL/SQL block
DECLARE
    v_credits NUMBER;
BEGIN
    v_credits := get_total_credits(1001);
    DBMS_OUTPUT.PUT_LINE('Student 1001 total credits: ' || v_credits);
END;
/

-- Call it DIRECTLY inside a normal SQL query (functions can do this, procedures cannot!)
SELECT Name, get_total_credits(Student_ID) AS Total_Credits
FROM STUDENT;