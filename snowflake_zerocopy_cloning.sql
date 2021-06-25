Zero Copy Cloning

Creates a copy of database, schema or table
Metadata operation, doesn't actually copy the data
A snapshot of the original data is made available to the cloned object.
The cloned object is independent of the original object & can be modified.
Modification to the original object & cloned object are independent

USE ROLE SYSADMIN;
USE DATABASE PROD_CRM;
USE WAREHOUSE COMPUTE_WH;

select * from customer;
select count(*) from customer;

-- clone our customer table
create table customer_copy clone customer;

-- validate data is similar
select * from customer_copy;

UPDATE customer_copy set JOB = 'Snowflake Architect' where NAME='Jeffrey Garrett';

-- validate data changes are tracked independently in both tables
select * from customer_copy where NAME='Jeffrey Garrett';
select * from customer where NAME='Jeffrey Garrett';

-- drop the cloned table so that it doesn't cause confusion
drop table customer_copy;
-- clone the public schema
create schema public_copy clone public;


