CREATE FILE FORMAT
"DEMO_DB"."PUBLIC".COLORS_CSV
TYPE='CSV'
COMPRESSION = 'AUTO'
FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n'
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE'
TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE
ESCAPE = 'NONE'
ESCAPE_UNENCLOSED_FIELD = '\134'
DATE_FORMAT = 'AUTO'
TIMESTAMP_FORMAT = 'AUTO'
NULL_IF = ('\\N');


CREATE OR REPLACE SEQUENCE COLOR_UID_SEQ
START 1002
INCREMENT 1
COMMENT = 'Give a new unique id to each new color entered in Colors table';