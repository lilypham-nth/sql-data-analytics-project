/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/


-- Explore All objects in the Database

SELECT *
FROM INFORMATION_SCHEMA.TABLES


-- Explore All column in the Database

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS