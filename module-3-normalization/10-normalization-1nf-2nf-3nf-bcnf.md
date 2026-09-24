# Experiment No. 4

**Title:** Normalization — 1NF, 2NF, 3NF, BCNF

**Course:** DBMS Lab (BCS551 / KCS551)
**CO Mapping:** CO2
**Bloom's Knowledge Level:** K2, K3

**Aim:** To understand functional dependencies and normalize an unnormalized relation step-by-step up to BCNF.

---

## Theory — Basic Terms

| Term | Simple Meaning |
|---|---|
| **Functional Dependency (FD)** | If knowing the value of column A fixes the value of column B, we write `A → B` ("A determines B") |
| **Prime Attribute** | An attribute that is part of some candidate key |
| **Non-Prime Attribute** | An attribute that is not part of any candidate key |
| **Partial Dependency** | When a non-prime attribute depends on only **part of** a composite key, not the whole key |
| **Transitive Dependency** | When a non-prime attribute depends on the primary key indirectly, through another non-prime attribute (A→B→C) |

## Why Normalize? — Anomalies

Without normalization, a poorly designed table suffers from:

1. **Insertion Anomaly** — Cannot add new data without also having unrelated, currently-unavailable data.
2. **Update Anomaly** — The same value must be updated in multiple places, risking inconsistency.
3. **Deletion Anomaly** — Deleting one record accidentally removes other important information.

---

## Practical Example — Step by Step

Consider an unnormalized table similar to our College schema (deliberately poor design):

```
STUDENT_COURSE_INFO (Unnormalized)
---------------------------------------------------------------
Student_ID | Student_Name | Course_ID | Course_Name | Dept_Name
---------------------------------------------------------------
1001       | Rahul Kumar  | 201       | DBMS        | Computer Science
1001       | Rahul Kumar  | 202       | Web Tech    | Computer Science
1002       | Priya Sharma | 201       | DBMS        | Computer Science
```

### Problems in this table

- **Insertion Anomaly:** A new course with no enrolled student yet cannot be added (Student_ID would be NOT NULL / missing).
- **Update Anomaly:** Renaming course "DBMS" requires updating every row where Course_ID is 201 — if one row is missed, data becomes inconsistent.
- **Deletion Anomaly:** Deleting Rahul's row could accidentally delete the only record of the "Web Tech" course.

### Functional Dependencies identified

```
Student_ID → Student_Name
Course_ID  → Course_Name, Dept_Name
{Student_ID, Course_ID} → (entire row; this is the composite key)
```

---

## Step 1: First Normal Form (1NF)

**Rule:** Every column must contain a single, atomic value (no repeating groups, no multi-valued columns).

The table above is already in 1NF — no column contains comma-separated or multiple values (e.g., `Course_ID: 201,202`). If it did, it would need to be split into separate rows first.

---

## Step 2: Second Normal Form (2NF)

**Rule:** Must be in 1NF, and there must be **no partial dependency** (only relevant when the primary key is composite).

The primary key here is the composite key `{Student_ID, Course_ID}`. Checking dependencies:

```
Student_Name depends only on Student_ID (not the whole key)  → Partial Dependency
Course_Name  depends only on Course_ID  (not the whole key)  → Partial Dependency
Dept_Name    depends only on Course_ID  (not the whole key)  → Partial Dependency
```

**Fix:** Split the table so every non-key attribute depends on the **entire** composite key:

```
STUDENT    (Student_ID PK, Student_Name)
COURSE     (Course_ID PK, Course_Name, Dept_Name)
ENROLLMENT (Student_ID FK, Course_ID FK)   ← now in 2NF
```

*(This is exactly the structure already used in our College database from Experiment 3 — our original design was already normalized.)*

---

## Step 3: Third Normal Form (3NF)

**Rule:** Must be in 2NF, and there must be **no transitive dependency**.

Checking `COURSE (Course_ID, Course_Name, Dept_Name)`:

```
Course_ID → Course_Name   (direct — fine)
Course_ID → Dept_Name     (Dept_Name actually depends on Dept_ID, not directly on Course)
```

If the table also included `Dept_HOD`, we would have a clear problem:

```
Course_ID → Dept_Name → Dept_HOD   ← Transitive Dependency
(Course_ID does not directly determine Dept_HOD; it goes through Dept_Name)
```

**Fix:** Move department information into its own table:

```
COURSE     (Course_ID PK, Course_Name, Dept_ID FK)
DEPARTMENT (Dept_ID PK, Dept_Name, HOD_Name)   ← transitive dependency removed
```

*(Again, this matches our existing College database design.)*

---

## Step 4: Boyce-Codd Normal Form (BCNF)

**Rule:** Must be in 3NF, and every determinant (an attribute that determines another) must itself be a candidate key.

BCNF differs from 3NF only when a table has **overlapping candidate keys**. Classic example:

```
Assume each Faculty member teaches only one Course, but a Course can be taught by multiple Faculty:

TEACHES (Course_ID, Faculty_ID, Dept_ID)

FD: Faculty_ID → Dept_ID          (each faculty belongs to one department)
FD: {Course_ID, Faculty_ID} → entire row

Here, "Faculty_ID → Dept_ID" exists, but Faculty_ID alone is NOT a candidate key
→ This table is in 3NF but NOT in BCNF.
```

**Fix:** Decompose further:

```
FACULTY (Faculty_ID PK, Dept_ID FK)
TEACHES (Course_ID FK, Faculty_ID FK)
```

---

## Summary Flow

```
Unnormalized (repeating / multi-valued data)
         ↓  make all values atomic
1NF
         ↓  remove partial dependency (only relevant for composite keys)
2NF
         ↓  remove transitive dependency
3NF
         ↓  ensure every determinant is a candidate key
BCNF
```

---

## Result

A sample `STUDENT_COURSE_INFO` relation was normalized step-by-step from an unnormalized state to BCNF. Functional dependencies were identified, and partial and transitive dependencies were removed at each stage. This confirmed that the College database schema designed in Experiment 3 already follows a normalized design.

---

## Viva Questions

| Question | Short Answer |
|---|---|
| Why do we normalize? | To reduce redundancy and avoid insertion/update/deletion anomalies |
| What is the rule for 1NF? | Every column must contain a single atomic value |
| When is 2NF relevant? | Only when the primary key is composite — partial dependency is checked |
| What is a transitive dependency? | When a non-prime attribute depends on the primary key indirectly, through another non-prime attribute |
| Difference between 3NF and BCNF? | BCNF is stricter — every determinant must be a candidate key, not just checking dependencies on non-prime attributes |
| When is denormalization used? | Deliberately introducing some redundancy for query performance, e.g., in reporting/analytics systems |

## Common Confusions

| Confusion | Clarification |
|---|---|
| "2NF applies to every table" | No — 2NF is only meaningful when the primary key is composite. A single-column PK table is automatically in 2NF (if it's already in 1NF) |
| "Normalization always improves performance" | Normalization reduces **redundancy**, but more tables mean more joins, which can sometimes make queries **slower** — this is a real trade-off |