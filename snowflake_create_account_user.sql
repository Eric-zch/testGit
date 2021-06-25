-- we will perform activities in this script using the user Jake
-- that we earlier created who has the ACCOUNTADMIN role

-- let's query the usage metering history containing virtual warehouse usage
-- this query usually would not execute without ACCOUNTADMIN role
SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.METERING_HISTORY;

-- create a new reader account, a privilege that reserved for the 
-- ACCOUNTADMIN role in a standard Snowflake instance
CREATE MANAGED ACCOUNT Testing_Reader_Account admin_name='ReaderAdmin', admin_password='Johndoe123', type=reader, COMMENT='';
=================================================================================================================================
CREATE USER jake PASSWORD = 'doe' DEFAULT_ROLE = ACCOUNTADMIN MUST_CHANGE_PASSWORD = TRUE;
GRANT ROLE ACCOUNTADMIN TO USER jake;

CREATE USER john PASSWORD = 'doe' DEFAULT_ROLE = SECURITYADMIN MUST_CHANGE_PASSWORD = TRUE;
GRANT ROLE SECURITYADMIN TO USER john;

CREATE USER jane PASSWORD = 'doe' DEFAULT_ROLE = SYSADMIN MUST_CHANGE_PASSWORD = TRUE;
GRANT ROLE SYSADMIN TO USER jane;




