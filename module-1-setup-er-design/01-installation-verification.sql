/*
========================================================
Experiment No : 1
Title         : Installation of Oracle Database & First SQL Command
Course        : DBMS Lab (BCS551 / KCS551)
DB            : Oracle 21c XE
CO Mapping    : CO1
========================================================
Concepts covered:
- CDB (root container) vs PDB (pluggable database)
- Creating a database user/schema
- Granting basic privileges
- dual table
========================================================
*/

-- Step 1: Check which container we are connected to
SHOW CON_NAME;

-- Step 2: Verify Oracle is working (first SQL command)
SELECT 'Oracle install ho gaya!' AS message FROM dual;

-- Step 3: Create a dedicated user/schema for this lab
-- (Run this as SYSTEM, connected to service XEPDB1, NOT SID xe)
CREATE USER college IDENTIFIED BY college123;
GRANT CONNECT, RESOURCE TO college;
ALTER USER college QUOTA UNLIMITED ON USERS;

-- Step 4: Verify the new user (Run this as COLLEGE)
SELECT USER FROM dual;