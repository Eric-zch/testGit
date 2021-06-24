-- create a database if it doesn't already exist
CREATE DATABASE ingest_data;

USE DATABASE ingest_data;


-- create an external stage using an S3 bucket
CREATE OR REPLACE STAGE snowpipe_copy_example_stage url='s3://snowpipe-streaming/transactions';

-- list the files in the bucket
LIST @snowpipe_copy_example_stage;

CREATE TABLE transactions
(

Transaction_Date DATE,
Customer_ID NUMBER,
Transaction_ID NUMBER,
Amount NUMBER
);

CREATE OR REPLACE PIPE transaction_pipe 
auto_ingest = true
AS COPY INTO transactions FROM @snowpipe_copy_example_stage
file_format = (type = csv field_delimiter = '|' skip_header = 1);

SELECT * FROM transactions;

-- check column notification_channel for later use
-- arn:aws:sqs:ap-southeast-2:967343264863:sf-snowpipe-AIDA6CORG2RPUI3BGVEEM-AGuWp2nVu-gkYRUy1NXLKw
SHOW PIPES;

-- setup S3 event notification here

SELECT COUNT(*) FROM transactions;

-- Option 1:
-- Configure cloud event
-- Use Cloud native Event triggers to trigger Snow pipe
   Amazone S3 -> bucket name -> Properties
   Events -> Add notification
   Name: Snowflake Notification
   Events: All object create events
   Prefix: transactions
   Send to: SQS Queue
   SQS: Add SQS queue ARN
   SQS queue ARN: arn:aws:sqs:ap-southeast-2:967343264863:sf-snowpipe-AIDA6CORG2RPUI3BGVEEM-AGuWp2nVu-gkYRUy1NXLKw


-- Option 2:
-- Call REST APIs
-- Call Snow Pipe Rest APIs to trigger the snow pipe
