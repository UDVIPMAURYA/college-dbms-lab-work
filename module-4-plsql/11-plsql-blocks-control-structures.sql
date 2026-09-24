/*
========================================================
Experiment No : 5
Title         : PL/SQL Blocks and Control Structures
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO4
========================================================
Concepts covered:
- Basic anonymous block structure
- Variables and constants
- IF-ELSIF, CASE
- WHILE LOOP, FOR LOOP
Interview angle:
- PL/SQL vs SQL - why procedural extension was needed
========================================================
*/

SET SERVEROUTPUT ON;  -- enables DBMS_OUTPUT to actually print

-- 1. Simplest possible block
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello from PL/SQL!');
END;
/

-- 2. Variables and a simple calculation
DECLARE
    v_credits   NUMBER := 4;          -- variable with initial value
    v_hours     NUMBER;               -- declared, not yet assigned
    c_hours_per_credit CONSTANT NUMBER := 15;  -- constant
BEGIN
    v_hours := v_credits * c_hours_per_credit;
    DBMS_OUTPUT.PUT_LINE('Total hours for this course: ' || v_hours);
END;
/

-- 3. IF-ELSIF-ELSE: classify a course by credits
DECLARE
    v_credits NUMBER := 3;
BEGIN
    IF v_credits >= 4 THEN
        DBMS_OUTPUT.PUT_LINE('Major course');
    ELSIF v_credits = 3 THEN
        DBMS_OUTPUT.PUT_LINE('Standard course');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Minor course');
    END IF;
END;
/

-- 4. CASE statement: same logic, different syntax
DECLARE
    v_credits NUMBER := 3;
    v_result  VARCHAR2(20);
BEGIN
    CASE
        WHEN v_credits >= 4 THEN v_result := 'Major course';
        WHEN v_credits = 3  THEN v_result := 'Standard course';
        ELSE v_result := 'Minor course';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- 5. WHILE LOOP: print numbers 1 to 5
DECLARE
    v_counter NUMBER := 1;
BEGIN
    WHILE v_counter <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE('Count: ' || v_counter);
        v_counter := v_counter + 1;
    END LOOP;
END;
/

-- 6. FOR LOOP: cleaner way to do the same thing (no manual increment needed)
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Count: ' || i);
    END LOOP;
END;
/

-- 7. Practical example: fetch a real value from College DB and use logic on it
DECLARE
    v_total_students NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_students
    FROM STUDENT
    WHERE Dept_ID = 101;

    IF v_total_students > 2 THEN
        DBMS_OUTPUT.PUT_LINE('Department 101 has a healthy batch size: ' || v_total_students);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Department 101 has a small batch: ' || v_total_students);
    END IF;
END;
/