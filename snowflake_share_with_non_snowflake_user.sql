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
USE ROLE ACCOUNTADMIN;
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

-- Find who has been granted access to the share
SHOW GRANTS OF SHARE share_customer_data;
=================================================================================================================
-- Assuming that we have to share data with a non-snowflake customer
-- we will first create a new reader account for the non-snowflake user
CREATE MANAGED ACCOUNT test_account
ADMIN_NAME = testadmin , ADMIN_PASSWORD = 'Test_P@ssword123' ,
TYPE = READER;

-- The above statement onces it successfully runs will show you the account 
-- & the URL for the newly created account
-- {"accountName":"MM89548","loginUrl":"https://mm89548.ap-northeast-1.aws.snowflakecomputing.com"}


-- See which reader accounts exist
-- you can also use this command to see the URL through which a reader
-- should access the data
SHOW MANAGED ACCOUNTS;

-- Share the data with the reader account
-- We will use the existing share that we created earlier in the lab
-- find the account name using the above command and then use that in the statement below.
-- the account name or number can be found under the locator field when running SHOW MANAGED ACCOUNTS;
ALTER SHARE share_customer_data ADD ACCOUNT=MM89548;

-- Validate what objects does the share has access to
SHOW GRANTS TO SHARE share_customer_data;

-- Find who has been granted access to the share
SHOW GRANTS OF SHARE share_customer_data;
=================================================================================================================
-- Perform as a consumer
-- next we must login into the target reader account and set it up
-- https://mm89548.ap-northeast-1.aws.snowflakecomputing.com
CREATE USER john PASSWORD = 'Test123!' MUST_CHANGE_PASSWORD = FALSE;

-- List the inbound and outbound shares that are currently present in the system
SHOW SHARES;

-- create a database in reader snowflake instance based on the share.
CREATE DATABASE MYCUSTOMER FROM SHARE ZQ20615.SHARE_CUSTOMER_DATA;

-- grant privileges on MYCUSTOMER database to the public role 
GRANT IMPORTED PRIVILEGES ON DATABASE MYCUSTOMER TO ROLE public;

-- create virtual warehouse
CREATE WAREHOUSE miniVWH WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE;

GRANT USAGE ON WAREHOUSE miniVWH TO ROLE public;
=================================================================================================================
-- Login with consumer john
-- https://mm89548.ap-northeast-1.aws.snowflakecomputing.com
USE DATABASE MYCUSTOMER;
SELECT * FROM PUBLIC.CUSTOMER LIMIT 10;
=================================================================================================================



