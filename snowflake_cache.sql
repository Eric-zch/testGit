-- Results are cached for 24 hours (from the point of last re-use)
-- Because the metadata management in Snowflake is quite strong, Snowflake knows when the underlying data has changed and therefore re-execute the query
-- Allocate virtual warehouse to run common queries on the same warehouse
-- Look at Profile of a query after run it

-- QUERY RESULT REUSE means using cache.
