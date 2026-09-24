/*
========================================================
Experiment No : 3 (Part 7)
Title         : DCL and TCL
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO3, CO5
========================================================
*/

-- ===================== DCL =====================
-- Run these as SYSTEM (college user cannot grant its own privileges)

-- 1. Create a second demo user to practice granting privileges
-- CREATE USER college_readonly IDENTIFIED BY readonly123;
-- GRANT CONNECT TO college_readonly;

-- 2. Give read-only access to STUDENT table (run as COLLEGE, since COLLEGE owns the table)
-- GRANT SELECT ON STUDENT TO college_readonly;

-- 3. Give full access
-- GRANT SELECT, INSERT, UPDATE, DELETE ON STUDENT TO college_readonly;

-- 4. Take away a privilege
-- REVOKE INSERT ON STUDENT FROM college_readonly;


-- ===================== TCL =====================

-- 5. Basic COMMIT (make changes permanent)
INSERT INTO DEPARTMENT VALUES (104, 'Mechanical', 'Dr. Patel');
COMMIT;

-- 6. ROLLBACK (undo changes NOT yet committed)
INSERT INTO DEPARTMENT VALUES (105, 'Civil', 'Dr. Joshi');
-- Suppose we change our mind before committing:
ROLLBACK;
-- Verify: Dept_ID 105 will NOT exist
SELECT * FROM DEPARTMENT WHERE Dept_ID = 105;

-- 7. SAVEPOINT - partial rollback within a transaction
INSERT INTO DEPARTMENT VALUES (106, 'Chemical', 'Dr. Rana');
SAVEPOINT sp1;

INSERT INTO DEPARTMENT VALUES (107, 'Biotech', 'Dr. Kapoor');
SAVEPOINT sp2;

INSERT INTO DEPARTMENT VALUES (108, 'Aerospace', NULL);

-- Rollback ONLY up to sp2 (undoes the Aerospace insert, keeps 106 and 107)
ROLLBACK TO sp2;

COMMIT;

-- Verify final state
SELECT * FROM DEPARTMENT ORDER BY Dept_ID;