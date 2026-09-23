/*
========================================================
Experiment No : 3 (Part 2)
Title         : DML - Insert Sample Data
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO3
========================================================
*/

-- 1. DEPARTMENT (insert first, nothing depends on it)
INSERT INTO DEPARTMENT VALUES (101, 'Computer Science', 'Dr. Sharma');
INSERT INTO DEPARTMENT VALUES (102, 'Information Technology', 'Dr. Verma');
INSERT INTO DEPARTMENT VALUES (103, 'Electronics', 'Dr. Singh');

-- 2. STUDENT
INSERT INTO STUDENT VALUES (1001, 'Rahul Kumar', 'rahul@example.com', '9876543210', DATE '2004-05-12', 101);
INSERT INTO STUDENT VALUES (1002, 'Priya Sharma', 'priya@example.com', '9876543211', DATE '2004-08-20', 101);
INSERT INTO STUDENT VALUES (1003, 'Amit Yadav',  'amit@example.com',  '9876543212', DATE '2003-11-05', 102);
INSERT INTO STUDENT VALUES (1004, 'Sneha Gupta', 'sneha@example.com', '9876543213', DATE '2004-02-17', 103);

-- 3. FACULTY
INSERT INTO FACULTY VALUES (501, 'Dr. Meena Roy', 'meena@example.com', 101);
INSERT INTO FACULTY VALUES (502, 'Dr. Arjun Nair', 'arjun@example.com', 102);
INSERT INTO FACULTY VALUES (503, 'Dr. Kavita Rao', 'kavita@example.com', 103);

-- 4. COURSE
INSERT INTO COURSE VALUES (201, 'Database Management System', 4, 101);
INSERT INTO COURSE VALUES (202, 'Web Technology', 4, 101);
INSERT INTO COURSE VALUES (203, 'Data Structures', 3, 102);
INSERT INTO COURSE VALUES (204, 'Digital Electronics', 3, 103);

-- 5. ENROLLMENT (references both STUDENT and COURSE)
INSERT INTO ENROLLMENT VALUES (1, 1001, 201, DATE '2026-01-10');
INSERT INTO ENROLLMENT VALUES (2, 1001, 202, DATE '2026-01-10');
INSERT INTO ENROLLMENT VALUES (3, 1002, 201, DATE '2026-01-11');
INSERT INTO ENROLLMENT VALUES (4, 1003, 203, DATE '2026-01-12');
INSERT INTO ENROLLMENT VALUES (5, 1004, 204, DATE '2026-01-13');
INSERT INTO ENROLLMENT VALUES (6, 1002, 202, DATE '2026-01-14');

-- IMPORTANT: make the data permanent
COMMIT;

--6. TEST INSERT value
INSERT INTO STUDENT (Student_ID, Name, Dept_ID) VALUES (1005, 'Test', 101);


--7. Verify Data
SELECT * FROM DEPARTMENT;
SELECT * FROM STUDENT;
SELECT * FROM FACULTY;
SELECT * FROM COURSE;
SELECT * FROM ENROLLMENT;

