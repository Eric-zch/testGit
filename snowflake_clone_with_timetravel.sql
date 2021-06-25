Clone a database, schema or table while time traveling.
Clone of the object is created as it was at a specific time or before a query.

-- clone our custome table
create table CUSTOMER_dev_b4_time clone customer before(timestamp => '2019-05-28 09:53:20.105'::timestamp);

-- clone our custome table
create table CUSTOMER_dev_b4_insert clone customer (statement => '018c7bd3-0071-ede9-0000-00000e99db39');
