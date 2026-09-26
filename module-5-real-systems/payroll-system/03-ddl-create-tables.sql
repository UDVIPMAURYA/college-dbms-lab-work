/*
========================================================
Module        : Module 5 - Real World Systems
Project       : Payroll Processing System
Title         : DDL - Creating Tables with Constraints
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
Schema        : PAYROLL (independent schema, not linked to College DB)
========================================================
Concepts covered:
- CREATE TABLE with PRIMARY KEY, FOREIGN KEY, NOT NULL,
  UNIQUE, CHECK, DEFAULT constraints
- Table creation order (parent before child)
- Composite UNIQUE constraint to prevent duplicate
  payroll entries for the same employee in the same month
Design notes:
- Net_Salary is intentionally stored (not purely derived)
  to preserve historical accuracy even if Basic_Salary
  changes in future months (controlled denormalization)
========================================================
*/

--1. DEPARTMENT: no dependency on any other table, created first

CREATE TABLE DEPARTMENT (

        Dept_ID   NUMBER(3) PRIMARY KEY,
        Dept_Name VARCHAR2(50) NOT NULL UNIQUE

);

-- 2. EMPLOYEE: depends on DEPARTMENT

CREATE TABLE EMPLOYEE(
        Employee_ID     NUMBER(8) PRIMARY KEY,
        Emp_Name        VARCHAR2(50) NOT NULL,
        Emp_DOB         DATE,
        Emp_Email       VARCHAR2(50) NOT NULL UNIQUE,
        Emp_Phone       VARCHAR2(10) CHECK  (LENGTH(Emp_Phone)=10) UNIQUE,
        Designation     VARCHAR2(50) NOT NULL,
        Date_Of_Joining DATE NOT NULL,
        Basic_Salary    NUMBER(10) NOT NULL,
        Dept_ID         NUMBER(3) NOT NULL,
        CONSTRAINT fk_employee_dept FOREIGN KEY (Dept_ID) 
            REFERENCES DEPARTMENT(Dept_ID)
);

-- 3. PAYROLL: depends on EMPLOYEE AND DEPARTMENT

CREATE TABLE PAYROLL(
        Payroll_ID       NUMBER(12) PRIMARY KEY,    
        Employee_ID      NUMBER(8) NOT NULL,
        Pay_Month        DATE NOT NULL,    
        HRA              NUMBER(6) DEFAULT 0,    
        Travel_Allowance NUMBER(6) DEFAULT 0,      
        PF_Deduction     NUMBER(6) DEFAULT 0,       
        Tax_Deduction    NUMBER(6) DEFAULT 0,         
        Net_Salary       NUMBER(10) NOT NULL,         
        Payment_Date     DATE NOT NULL,
        CONSTRAINT fk_employee_id FOREIGN KEY (Employee_ID)
            REFERENCES EMPLOYEE(Employee_ID),
        CONSTRAINT un_emp_month UNIQUE (Employee_ID,Pay_Month)
);


--4. Verify table structure
DESC DEPARTMENT;
DESC EMPLOYEE;
DESC PAYROLL;


