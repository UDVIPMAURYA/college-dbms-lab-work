/*
========================================================
Experiment No : 3
Title         : DDL - Creating Tables with Constraints
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
CO Mapping    : CO1, CO5
========================================================
Concepts covered:
- CREATE TABLE with PRIMARY KEY, FOREIGN KEY, NOT NULL,
  UNIQUE, CHECK, DEFAULT constraints
- Table creation order (parent before child)
Interview angle:
- Why parent tables must exist before child tables
  reference them via FOREIGN KEY
========================================================
*/

-- 1. DEPARTMENT: no dependency on any other table, created first
CREATE TABLE DEPARTMENT (
    Dept_ID     NUMBER(3)       PRIMARY KEY,
    Dept_Name   VARCHAR2(50)    NOT NULL UNIQUE,
    HOD_Name    VARCHAR2(50)
);

-- 2. STUDENT: depends on DEPARTMENT
CREATE TABLE STUDENT (
    Student_ID  NUMBER(5)       PRIMARY KEY,
    Name        VARCHAR2(50)    NOT NULL,
    Email       VARCHAR2(50)    UNIQUE,
    Phone       VARCHAR2(10)    CHECK (LENGTH(Phone) = 10),
    DOB         DATE,
    Dept_ID     NUMBER(3),
    CONSTRAINT fk_student_dept FOREIGN KEY (Dept_ID)
        REFERENCES DEPARTMENT(Dept_ID)
);

-- 3. FACULTY: depends on DEPARTMENT
CREATE TABLE FACULTY (
    Faculty_ID  NUMBER(5)       PRIMARY KEY,
    Name        VARCHAR2(50)    NOT NULL,
    Email       VARCHAR2(50)    UNIQUE,
    Dept_ID     NUMBER(3),
    CONSTRAINT fk_faculty_dept FOREIGN KEY (Dept_ID)
        REFERENCES DEPARTMENT(Dept_ID)
);

-- 4. COURSE: depends on DEPARTMENT
CREATE TABLE COURSE (
    Course_ID   NUMBER(5)       PRIMARY KEY,
    Course_Name VARCHAR2(50)    NOT NULL,
    Credits     NUMBER(1)       CHECK (Credits BETWEEN 1 AND 6),
    Dept_ID     NUMBER(3),
    CONSTRAINT fk_course_dept FOREIGN KEY (Dept_ID)
        REFERENCES DEPARTMENT(Dept_ID)
);

-- 5. ENROLLMENT: junction table, depends on STUDENT and COURSE
CREATE TABLE ENROLLMENT (
    Enrollment_ID  NUMBER(6)    PRIMARY KEY,
    Student_ID     NUMBER(5)    NOT NULL,
    Course_ID      NUMBER(5)    NOT NULL,
    Enroll_Date    DATE         DEFAULT SYSDATE,
    CONSTRAINT fk_enroll_student FOREIGN KEY (Student_ID)
        REFERENCES STUDENT(Student_ID),
    CONSTRAINT fk_enroll_course FOREIGN KEY (Course_ID)
        REFERENCES COURSE(Course_ID),
    CONSTRAINT uq_student_course UNIQUE (Student_ID, Course_ID)
);



--6. Verify table structure
DESC DEPARTMENT;
DESC STUDENT;
DESC ENROLLMENT;









