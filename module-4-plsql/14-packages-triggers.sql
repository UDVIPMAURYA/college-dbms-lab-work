/*
========================================================
Experiment No : 8
Title         : Packages and Triggers
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO4
========================================================
Concepts covered:
- Package specification and body
- BEFORE/AFTER trigger, row-level trigger
- :OLD and :NEW
Interview angle:
- Why triggers should be used carefully (hidden side-effects)
========================================================
*/

SET SERVEROUTPUT ON

-- ===================== PACKAGE =====================

-- 1. Package Specification: declares what's available
CREATE OR REPLACE PACKAGE student_pkg AS
    PROCEDURE add_student(p_id NUMBER, p_name VARCHAR2, p_dept NUMBER);
    FUNCTION total_students_in_dept(p_dept NUMBER) RETURN NUMBER;
END student_pkg;
/

-- 2. Package Body: actual implementation
CREATE OR REPLACE PACKAGE BODY student_pkg AS

    PROCEDURE add_student(p_id NUMBER, p_name VARCHAR2, p_dept NUMBER) IS
    BEGIN
        INSERT INTO STUDENT (Student_ID, Name, Dept_ID)
        VALUES (p_id, p_name, p_dept);
        DBMS_OUTPUT.PUT_LINE('Student added: ' || p_name);
        COMMIT;
    END add_student;

    FUNCTION total_students_in_dept(p_dept NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM STUDENT WHERE Dept_ID = p_dept;
        RETURN v_count;
    END total_students_in_dept;

END student_pkg;
/

-- Using the package (dot notation: package_name.member_name)
BEGIN
    student_pkg.add_student(1006, 'Vikram Singh', 102);
    DBMS_OUTPUT.PUT_LINE('Total in Dept 102: ' || student_pkg.total_students_in_dept(102));
END;
/


-- ===================== TRIGGER =====================

-- 3. Audit table to log changes (trigger will write here)
CREATE TABLE STUDENT_AUDIT (
    Audit_ID    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Student_ID  NUMBER,
    Action_Type VARCHAR2(10),
    Action_Date DATE
);

-- 4. AFTER INSERT trigger: automatically log every new student
CREATE OR REPLACE TRIGGER trg_student_insert
AFTER INSERT ON STUDENT
FOR EACH ROW
BEGIN
    INSERT INTO STUDENT_AUDIT (Student_ID, Action_Type, Action_Date)
    VALUES (:NEW.Student_ID, 'INSERT', SYSDATE);
END;
/

-- Test it: insert a student, trigger fires automatically
INSERT INTO STUDENT (Student_ID, Name, Dept_ID) VALUES (1007, 'Neha Joshi', 103);
COMMIT;

-- Verify the trigger fired
SELECT * FROM STUDENT_AUDIT;

-- 5. BEFORE UPDATE trigger: prevent negative/invalid credits on COURSE
CREATE OR REPLACE TRIGGER trg_course_credit_check
BEFORE UPDATE ON COURSE
FOR EACH ROW
BEGIN
    IF :NEW.Credits < 1 OR :NEW.Credits > 6 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Credits must be between 1 and 6');
    END IF;
END;
/

-- Test: valid update (works)
UPDATE COURSE SET Credits = 5 WHERE Course_ID = 201;

-- Test: invalid update (trigger blocks it)
UPDATE COURSE SET Credits = 0 WHERE Course_ID = 202;