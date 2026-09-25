/*
========================================================
Experiment No : 6
Title         : Implicit and Explicit Cursors
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO4
========================================================
Concepts covered:
- Implicit cursor attributes (SQL%FOUND, SQL%ROWCOUNT)
- Explicit cursor: DECLARE, OPEN, FETCH, CLOSE
- Cursor FOR loop (simplified syntax)
Interview angle:
- Why cursor FOR loop is preferred over manual FETCH in practice
========================================================
*/

SET SERVEROUTPUT ON

-- ===================== IMPLICIT CURSOR =====================

-- 1. Implicit cursor attributes after an UPDATE
DECLARE
    v_rows_updated NUMBER;
BEGIN
    UPDATE STUDENT
    SET Phone = '9999999999'
    WHERE Student_ID = 1005;   -- our 'Test' student with no phone

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Rows updated: ' || SQL%ROWCOUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No matching student found.');
    END IF;

    COMMIT;
END;
/


-- ===================== EXPLICIT CURSOR =====================

-- 2. Explicit cursor with manual FETCH loop:
--    Print all students of Department 101
DECLARE
    -- Step 1: DECLARE - define the cursor's query
    CURSOR c_students IS
        SELECT Name, Email FROM STUDENT WHERE Dept_ID = 101;

    v_name  STUDENT.Name%TYPE;   -- variable matching the STUDENT.Name column type
    v_email STUDENT.Email%TYPE;
BEGIN
    -- Step 2: OPEN - activate the cursor
    OPEN c_students;

    LOOP
        -- Step 3: FETCH - get one row at a time
        FETCH c_students INTO v_name, v_email;

        -- Stop the loop when no more rows are left
        EXIT WHEN c_students%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Student: ' || v_name || ' | Email: ' || v_email);
    END LOOP;

    -- Step 4: CLOSE - release the cursor
    CLOSE c_students;
END;
/


-- ===================== CURSOR FOR LOOP =====================

-- 3. Cursor FOR loop - Oracle handles OPEN, FETCH, EXIT, CLOSE automatically
DECLARE
    CURSOR c_courses IS
        SELECT Course_Name, Credits FROM COURSE;
BEGIN
    FOR course_rec IN c_courses LOOP
        DBMS_OUTPUT.PUT_LINE(course_rec.Course_Name || ' - ' || course_rec.Credits || ' credits');
    END LOOP;
END;
/

-- 4. Practical example: calculate total credits per student using a cursor
DECLARE
    CURSOR c_enroll IS
        SELECT s.Name, c.Credits
        FROM STUDENT s
        JOIN ENROLLMENT e ON s.Student_ID = e.Student_ID
        JOIN COURSE c ON e.Course_ID = c.Course_ID
        WHERE s.Student_ID = 1001;

    v_total_credits NUMBER := 0;
BEGIN
    FOR rec IN c_enroll LOOP
        v_total_credits := v_total_credits + rec.Credits;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total credits for Student 1001: ' || v_total_credits);
END;
/