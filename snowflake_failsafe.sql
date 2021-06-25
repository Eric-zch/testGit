Time Travel Queries allowed
SELECT ... AT | BEFORE
CLONE  ... AT | BEFORE
UNDROP databases,tables etc.
Users can retrieve data themselves.
Time travel for tables is by default 1 days(unless disabled specifically)
Maximum time travel can be 90 days

Failsafe data retention
(0-7) days
No User queries allowed
Data can only be recovered by Snowflake support
For permanent tables, the failsafe period is 7 days
For transient tables, the failsafe period is 0 days

Temporary Tables - There are pure temporary tables and exist only for the lifetime of a session. They are not visiable to other sessions and are removed immediately once session ends.

Transient Tables - There are sort of temporary tables, but they persist between sessions. They are designed to hold temporary data that needs to be accessed across sessions e.g. ETL jobs

Permanent Table   Time Travel (0-90 days)    Failsafe (7 days)
Transient Table   Time Travel (0-1) day)     Failsafe (no failsafe)
Temporary Table   Time Travel (0-1) day)     Failsafe (no failsafe)



-- you can check storage usage through the ACCOUNT_USAGE.STORAGE_USAGE
-- view which will give you information about storage used by data,
-- storage used by internal stages & storage used by failsafe
-- Change role to ACCOUNTADMIN before run below queries

SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE ORDER BY USAGE_DATE DESC;

-- let's convert the above information into GBs
SELECT 	USAGE_DATE, 
		STORAGE_BYTES / (1024*1024*1024) AS STORAGE_GB,  
		STAGE_BYTES / (1024*1024*1024) AS STAGE_GB,
		FAILSAFE_BYTES / (1024*1024*1024) AS FAILSAGE_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.STORAGE_USAGE
ORDER BY USAGE_DATE DESC;



-- You can also check on failsafe storage usage by querying the 
-- TABLE_STORAGE_METRICS view
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS;

--let's improve the result & convert to GBs as well
SELECT 	ID, 
		TABLE_NAME, 
		TABLE_SCHEMA,
		ACTIVE_BYTES / (1024*1024*1024) AS STORAGE_USED_GB,
		TIME_TRAVEL_BYTES / (1024*1024*1024) AS TIME_TRAVEL_STORAGE_USED_GB,
		FAILSAFE_BYTES / (1024*1024*1024) AS FAILSAFE_STORAGE_USED_GB
FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
ORDER BY STORAGE_USED_GB DESC,TIME_TRAVEL_STORAGE_USED_GB DESC, FAILSAFE_STORAGE_USED_GB DESC;
