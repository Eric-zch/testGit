CREATE DATABASE crm_data;
USE DATABASE crm_data;

CREATE TABLE customer (
  id STRING,
  name STRING ,
  address STRING ,
  city string ,
  postcode string ,
  state string,
  company string,
  contact string
  );

--sample data for the table above is present in AWS S3 at
--https://s3.ap-southeast-2.amazonaws.com/snowflake-essentials/customer.csv
create or replace stage my_s3_stage url='s3://snowflake-essentials/';

copy into customer
  from s3://snowflake-essentials/customer.csv
  file_format = (type = csv field_delimiter = '|' skip_header = 1);

SELECT * FROM customer;
SELECT COUNT(*) FROM customer;

=================================================================================================================
-- Produce share
-- create the share object to which we will then add data to be shared. 
CREATE SHARE share_customer_data;

-- grant usage on the database in which our table is contained
-- this step is necessary to subsequently provide access to the table
GRANT USAGE ON DATABASE crm_data TO SHARE share_customer_data;

-- grant usage on the schema in which our table is contained.
-- again this step is necessary to subsequently provide access to the table
GRANT USAGE ON SCHEMA crm_data.public TO SHARE share_customer_data;

-- add the customer table to the share
-- We have provided only SELECT on the shared table so the consumer can 
-- only read the data but will not be able to modify
GRANT SELECT ON TABLE crm_data.public.customer TO SHARE share_customer_data;

-- Validate what objects does the share has access to
SHOW GRANTS TO SHARE share_customer_data;

-- allow consumer account access on the Share
-- to find the consumer_account_number look at the URL of the snowflake
-- instance of the consumer. So if the URL is https://jy80556.ap-southeast-2.snowflakecomputing.com/console/login
-- the consumer account_number is jy80556
ALTER SHARE share_customer_data ADD ACCOUNT=consumer_account_number_here;

-- Find who has been granted access to the share
SHOW GRANTS OF SHARE share_customer_data;
========================================================================================================================
-- Consume share
-- List the inbound and outbound shares that are currently present in the system
SHOW SHARES;

-- Find the share details by running describe. 
-- Always use provider_account.share_name
DESC SHARE <provider_account_number>.SHARE_CUSTOMER_DATA;

-- create a database in consumer snowflake instance based on the share.
CREATE DATABASE CUSTOMER_DATABASE FROM SHARE <provider_account_number>.SHARE_CUSTOMER_DATA;

-- SELECT>>>
========================================================================================================================
-- Test share
-- Run this on the consumer to select one row
SELECT * FROM CUSTOMER WHERE NAME LIKE '%John%';
-- note that the Post Code is 2099

-- On the producer let's update the data 
UPDATE CUSTOMER SET PostCode = 2100 WHERE NAME LIKE '%John%';

-- Run this on the consumer to select one row
SELECT * FROM CUSTOMER WHERE NAME LIKE '%John%';
-- note that the Post Code is b
