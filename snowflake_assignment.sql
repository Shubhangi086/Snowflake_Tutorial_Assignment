-- ============================================================
-- SNOWFLAKE TUTORIAL ASSIGNMENT
-- Student: Shubhangi Prasad
-- Database: COLLEGE_DB
-- Schema: STUDENT_SCHEMA
-- Warehouse: COLLEGE_WH
-- ============================================================


-- ============================================================
-- QUESTION 1: SNOWSQL LOGIN AND CONNECTION
-- ============================================================

-- After connecting to Snowflake using SnowSQL,
-- verify the current user, role, warehouse, database and schema.

SELECT
    CURRENT_USER() AS USER_NAME,
    CURRENT_ROLE() AS ROLE_NAME,
    CURRENT_WAREHOUSE() AS WAREHOUSE_NAME,
    CURRENT_DATABASE() AS DATABASE_NAME,
    CURRENT_SCHEMA() AS SCHEMA_NAME;

-- Expected:
-- USER_NAME       : SHUBHANGI086
-- ROLE_NAME       : ACCOUNTADMIN
-- WAREHOUSE_NAME  : COLLEGE_WH
-- DATABASE_NAME   : COLLEGE_DB
-- SCHEMA_NAME     : STUDENT_SCHEMA


-- ============================================================
-- QUESTION 2: CREATION OF SNOWFLAKE OBJECTS
-- ============================================================

-- Create Database

CREATE DATABASE IF NOT EXISTS COLLEGE_DB;


-- Create Schema

CREATE SCHEMA IF NOT EXISTS COLLEGE_DB.STUDENT_SCHEMA;


-- Create Warehouse

CREATE WAREHOUSE IF NOT EXISTS COLLEGE_WH
WAREHOUSE_SIZE = 'X-SMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;


-- Select the database and schema

USE WAREHOUSE COLLEGE_WH;
USE DATABASE COLLEGE_DB;
USE SCHEMA STUDENT_SCHEMA;


-- Create Student Table

CREATE TABLE IF NOT EXISTS STUDENTS (
    STUDENT_ID INT,
    NAME VARCHAR(50),
    AGE INT,
    DEPARTMENT VARCHAR(50),
    MARKS FLOAT
);


-- Insert sample records

INSERT INTO STUDENTS
VALUES
(101, 'Amit', 20, 'CSE', 85),
(102, 'Priya', 21, 'IT', 90),
(103, 'Rahul', 20, 'ECE', 78),
(104, 'Sneha', 22, 'CSE', 88),
(105, 'Karan', 21, 'IT', 92);


-- Display records

SELECT * FROM STUDENTS;


-- INSERT operation

INSERT INTO STUDENTS
VALUES
(106, 'Neha', 20, 'CSE', 95);


-- Verify INSERT

SELECT * FROM STUDENTS;


-- UPDATE operation

UPDATE STUDENTS
SET MARKS = 96
WHERE STUDENT_ID = 106;


-- Verify UPDATE

SELECT *
FROM STUDENTS
WHERE STUDENT_ID = 106;


-- DELETE operation

DELETE FROM STUDENTS
WHERE STUDENT_ID = 106;


-- Verify DELETE

SELECT * FROM STUDENTS;


-- Create Stage

CREATE STAGE IF NOT EXISTS STUDENT_STAGE;


-- Verify Stage

LIST @STUDENT_STAGE;


-- ============================================================
-- QUESTION 3: DATA LOADING USING SNOWSQL
-- ============================================================

-- Create table for loading CSV data

CREATE TABLE IF NOT EXISTS STUDENT_DATA (
    STUDENT_ID INT,
    NAME VARCHAR(50),
    AGE INT,
    DEPARTMENT VARCHAR(50),
    MARKS FLOAT
);


-- Create CSV file format

CREATE OR REPLACE FILE FORMAT CSV_FORMAT_TEST
TYPE = CSV
SKIP_HEADER = 0
FIELD_OPTIONALLY_ENCLOSED_BY = '"';


-- Upload the CSV file to STUDENT_STAGE using SnowSQL
--
-- The CSV file used:
--
-- STUDENT_ID,NAME,AGE,DEPARTMENT,MARKS
-- 201,Ravi,20,CSE,82
-- 202,Anjali,21,IT,91
-- 203,Vikash,20,ECE,76
-- 204,Pooja,22,CSE,89
-- 205,Neha,21,IT,95
--
-- SnowSQL PUT command example:
--
-- PUT 'file:///C:/Users/DELL/Documents/students_data2.csv'
-- @STUDENT_STAGE
-- AUTO_COMPRESS=TRUE;


-- Check files in stage

LIST @STUDENT_STAGE;


-- Check CSV data before loading

SELECT
    $1, $2, $3, $4, $5
FROM @STUDENT_STAGE/students_data2.csv.gz
(FILE_FORMAT => 'CSV_FORMAT_TEST');


-- Load CSV data into table
--
-- Since the CSV contains a header, use SKIP_HEADER = 1
-- with the actual file format used for loading.

CREATE OR REPLACE FILE FORMAT CSV_LOAD_FORMAT
TYPE = CSV
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"';


-- Copy data from stage into table

COPY INTO STUDENT_DATA
FROM @STUDENT_STAGE/students_data2.csv.gz
FILE_FORMAT = (
    FORMAT_NAME = 'CSV_LOAD_FORMAT'
);


-- Verify loaded data

SELECT * FROM STUDENT_DATA;


-- Count loaded records

SELECT COUNT(*) AS TOTAL_RECORDS
FROM STUDENT_DATA;


-- ============================================================
-- QUESTION 4: SNOWFLAKE TIME TRAVEL
-- ============================================================

-- Create a separate table for Time Travel demonstration

CREATE TABLE IF NOT EXISTS TIME_TRAVEL_STUDENTS (
    STUDENT_ID INT,
    NAME VARCHAR(50),
    AGE INT,
    DEPARTMENT VARCHAR(50),
    MARKS FLOAT
);


-- Insert sample records

INSERT INTO TIME_TRAVEL_STUDENTS
VALUES
(301, 'Arjun', 20, 'CSE', 84),
(302, 'Meera', 21, 'IT', 91),
(303, 'Rohan', 20, 'ECE', 79),
(304, 'Kavya', 22, 'CSE', 88),
(305, 'Aman', 21, 'IT', 93);


-- Display original data

SELECT *
FROM TIME_TRAVEL_STUDENTS;


-- Record current timestamp before changes

SELECT CURRENT_TIMESTAMP();


-- UPDATE operation

UPDATE TIME_TRAVEL_STUDENTS
SET MARKS = 95
WHERE STUDENT_ID = 301;


-- Verify UPDATE

SELECT *
FROM TIME_TRAVEL_STUDENTS;


-- DELETE operation

DELETE FROM TIME_TRAVEL_STUDENTS
WHERE STUDENT_ID = 305;


-- Verify DELETE

SELECT *
FROM TIME_TRAVEL_STUDENTS;


-- Use Time Travel to see the previous version
-- 60 seconds earlier

SELECT *
FROM TIME_TRAVEL_STUDENTS
AT (OFFSET => -60);


-- If more time has passed, use 5 minutes:

SELECT *
FROM TIME_TRAVEL_STUDENTS
AT (OFFSET => -300);


-- ============================================================
-- QUESTION 5: DATA RECOVERY USING TIME TRAVEL
-- ============================================================

-- Display current table

SELECT *
FROM TIME_TRAVEL_STUDENTS;


-- Example of accidental deletion

DELETE FROM TIME_TRAVEL_STUDENTS
WHERE STUDENT_ID = 304;


-- Verify that the record was deleted

SELECT *
FROM TIME_TRAVEL_STUDENTS
WHERE STUDENT_ID = 304;


-- Use Time Travel to identify the deleted record

SELECT *
FROM TIME_TRAVEL_STUDENTS
AT (OFFSET => -60)
WHERE STUDENT_ID = 304;


-- Recover the deleted record
--
-- Use an OFFSET that is before the deletion.
-- If more than 60 seconds have passed, use -300 or
-- another suitable value.

INSERT INTO TIME_TRAVEL_STUDENTS
SELECT *
FROM TIME_TRAVEL_STUDENTS
AT (OFFSET => -300)
WHERE STUDENT_ID = 304;


-- Verify recovery

SELECT *
FROM TIME_TRAVEL_STUDENTS
WHERE STUDENT_ID = 304;


-- Display complete recovered table

SELECT *
FROM TIME_TRAVEL_STUDENTS;


-- ============================================================
-- ADDITIONAL VERIFICATION COMMANDS
-- ============================================================

-- Show databases

SHOW DATABASES;


-- Show schemas

SHOW SCHEMAS;


-- Show tables

SHOW TABLES;


-- Show stages

SHOW STAGES;


-- Show warehouses

SHOW WAREHOUSES;


-- Final verification

SELECT
    CURRENT_USER() AS USER_NAME,
    CURRENT_ROLE() AS ROLE_NAME,
    CURRENT_WAREHOUSE() AS WAREHOUSE_NAME,
    CURRENT_DATABASE() AS DATABASE_NAME,
    CURRENT_SCHEMA() AS SCHEMA_NAME;


-- ============================================================
-- END OF SNOWFLAKE TUTORIAL ASSIGNMENT
-- ============================================================