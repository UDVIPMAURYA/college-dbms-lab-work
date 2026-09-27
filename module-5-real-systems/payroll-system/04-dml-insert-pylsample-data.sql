/*
========================================================
Module        : Module 5 - Real World Systems
Project       : Payroll Processing System
Title         : DML - Insert Sample Data
Course        : DBMS Lab (BCS551)
DB            : Oracle 21c XE
Schema        : PAYROLL
========================================================
Concepts covered:
- INSERT in parent-first order (DEPARTMENT -> EMPLOYEE -> PAYROLL)
- Net_Salary calculated manually here to demonstrate the
  formula: Net_Salary = Basic_Salary + HRA + Travel_Allowance
                          - PF_Deduction - Tax_Deduction
  (In a later experiment, this calculation will be automated
  using a PL/SQL function/procedure instead of doing it by hand)
========================================================
*/

-- ===================== 1. DEPARTMENT =====================
INSERT INTO DEPARTMENT VALUES (101, 'HR');
INSERT INTO DEPARTMENT VALUES (102, 'IT');
INSERT INTO DEPARTMENT VALUES (103, 'CONSULTANT');


-- ===================== 2. EMPLOYEE =====================
INSERT INTO EMPLOYEE VALUES (
    12938981, 'RAMESH', DATE '1998-01-24', 'ramesh@re.com',
    '9832893421', 'Software Engineer', DATE '2023-05-12', 320000, 102
);

INSERT INTO EMPLOYEE VALUES (
    12938982, 'Rahul Kumar', DATE '2004-05-12', 'rahul@example.com',
    '9876543210', 'Data Analyst', DATE '2024-06-12', 36000, 102
);

INSERT INTO EMPLOYEE VALUES (
    12938983, 'Priya Sharma', DATE '2002-05-05', 'priya@example.com',
    '9876543211', 'Frontend Developer', DATE '2025-06-03', 12000, 102
);

INSERT INTO EMPLOYEE VALUES (
    12938984, 'Amit Yadav', DATE '2003-11-12', 'amit@example.com',
    '9876543212', 'Backend Developer', DATE '2023-04-05', 20000, 102
);

INSERT INTO EMPLOYEE VALUES (
    13938981, 'Sneha Gupta', DATE '1995-06-30', 'sneha@example.com',
    '9876543213', 'Recruiter', DATE '2022-02-17', 460000, 101
);

INSERT INTO EMPLOYEE VALUES (
    13438582, 'Akansha Yadav', DATE '2005-07-25', 'akansha@example.com',
    '9234446734', 'Operator', DATE '2024-02-17', 10000, 103
);

INSERT INTO EMPLOYEE VALUES (
    13438981, 'Anshika Gupta', DATE '2000-06-30', 'anshika@example.com',
    '7245903224', 'Manager', DATE '2022-03-17', 350000, 103
);


-- ===================== 3. PAYROLL (Pay_Month: January 2026) =====================
-- Formula used: Net_Salary = Basic + HRA(20%) + Travel(2000) - PF(12%) - Tax(10%)

/*
========================================================
Module        : Module 5 - Real World Systems
Project       : Payroll Processing System
Title         : DML - Insert PAYROLL data (corrected for actual column order)
Course        : DBMS Lab (BCS551)
========================================================
Note: Dept_ID was added later via ALTER TABLE, so it now sits
at the END of the table structure. Using explicit column
names here avoids relying on positional order.
========================================================
*/

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5001, 12938981, DATE '2026-01-01', 64000, 2000, 38400, 32000, 315600, DATE '2026-01-31', 102);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5002, 12938982, DATE '2026-01-01', 7200, 2000, 4320, 3600, 37280, DATE '2026-01-31', 102);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5003, 12938983, DATE '2026-01-01', 2400, 2000, 1440, 1200, 13760, DATE '2026-01-31', 102);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5004, 12938984, DATE '2026-01-01', 4000, 2000, 2400, 2000, 21600, DATE '2026-01-31', 102);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5005, 13938981, DATE '2026-01-01', 92000, 2000, 55200, 46000, 452800, DATE '2026-01-31', 101);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5006, 13438582, DATE '2026-01-01', 2000, 2000, 1200, 1000, 11800, DATE '2026-01-31', 103);

INSERT INTO PAYROLL
    (Payroll_ID, Employee_ID, Pay_Month, HRA, Travel_Allowance, PF_Deduction, Tax_Deduction, Net_Salary, Payment_Date, Dept_ID)
VALUES
    (5007, 13438981, DATE '2026-01-01', 70000, 2000, 42000, 35000, 345000, DATE '2026-01-31', 103);

COMMIT;


-- ===================== Verify =====================
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PAYROLL;