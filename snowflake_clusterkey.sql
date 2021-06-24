You can custom cluster keys to partition the table according to your needs.
Normally you would use those columns in cluster keys which are frequently used in WHERE clauses or are frequently used in JOINS or ORDER BY statements.
Cluster key, cardinality of the cluster column
Large tables in multi terabyte size will benefit from clustering

select sum(AMT) from TRANSACTIONS WHERE TXN_DATE='2019-10-05';
The query requires scanning all partitions.
If we partition on TXN_DATE column...

Can even use expressions to cluster your table.

CREATE TABLE <table_name>... cluster by(column, column)
CREATE TABLE <table_name>... cluster by(column, expression)


See query plan-> Profile
Pruning
Partitions scanned
Partitions total

Check the cluster method can eliminate partitons scanned.
