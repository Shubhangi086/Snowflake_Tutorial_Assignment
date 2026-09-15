# Snowflake Tutorial Assignment

## Student Information

**Name:** Shubhangi Prasad

**Course:** B.Tech Computer Science and Engineering – Big Data Analytics

**Database:** `COLLEGE_DB`

**Schema:** `STUDENT_SCHEMA`

**Warehouse:** `COLLEGE_WH`

---

## About the Project

This repository contains my **Snowflake Tutorial Assignment**, completed using **SnowSQL and Snowflake**.

The assignment demonstrates the creation and management of Snowflake objects, loading CSV data, performing SQL operations, and using Snowflake Time Travel for data recovery.

---

## Topics Covered

### Question 1 – SnowSQL Login and Connection

* Verified current user
* Verified current role
* Verified warehouse
* Verified database
* Verified schema

### Question 2 – Creation of Snowflake Objects

* Created database
* Created schema
* Created warehouse
* Created student table
* Performed `INSERT`, `UPDATE`, and `DELETE`
* Created and verified an internal stage

### Question 3 – Data Loading Using SnowSQL

* Created a student data table
* Created CSV file formats
* Uploaded CSV data to a Snowflake stage
* Verified staged data
* Loaded CSV data using `COPY INTO`
* Verified the loaded records

### Question 4 – Snowflake Time Travel

* Created a Time Travel demonstration table
* Inserted student records
* Performed `UPDATE` and `DELETE` operations
* Retrieved previous versions of data using Time Travel

### Question 5 – Data Recovery Using Time Travel

* Demonstrated accidental deletion
* Used Time Travel to retrieve deleted data
* Recovered the deleted student record
* Verified the recovered data

---

## Technologies Used

* **Snowflake**
* **SnowSQL**
* **SQL**
* **CSV**
* **GitHub**

---

## Snowflake Objects Used

| Object             | Name                   |
| ------------------ | ---------------------- |
| Database           | `COLLEGE_DB`           |
| Schema             | `STUDENT_SCHEMA`       |
| Warehouse          | `COLLEGE_WH`           |
| Student Table      | `STUDENTS`             |
| Data Loading Table | `STUDENT_DATA`         |
| Time Travel Table  | `TIME_TRAVEL_STUDENTS` |
| Stage              | `STUDENT_STAGE`        |
| File Format        | `CSV_LOAD_FORMAT`      |

---

## Repository Contents

```text
Snowflake-Tutorial-Assignment/
│
├── snowflake_assignment.sql
└── README.md
```

---

## Learning Outcome

Through this assignment, I learned how to:

* Work with Snowflake databases, schemas, and warehouses
* Create and manage tables
* Perform basic SQL data manipulation
* Upload and load CSV files into Snowflake
* Work with Snowflake stages and file formats
* Use Time Travel to access historical data
* Recover accidentally deleted data
* Manage and document a Snowflake project using GitHub

---

## Author

**Shubhangi Prasad**

B.Tech CSE – Big Data Analytics
