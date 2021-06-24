CREATE WAREHOUSE AS_WH 
WITH WAREHOUSE_SIZE = 'XSMALL' 
MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 3 
SCALING_POLICY = 'STANDARD'
AUTO_SUSPEND = 300 
AUTO_RESUME = TRUE 
;

-- store in C:\temp\scale-out\complex_query.sql
SELECT * FROM 
(
    SELECT RANK() OVER ( ORDER BY COL1 DESC ) AS RNK FROM 
    (
        SELECT UUID_STRING() AS COL1 FROM large_table
    ) A
)
WHERE RNK < 100;

-- put in C:\temp\scale-out\test.bat file
@echo off
set SNOWSQL_PWD=password
@echo on
snowsql -a zq12345.ap-northeast-1 -u username -w AS_WH -d TEST_SCALE_OUT -s PUBLIC -f complex_query.sql

-- install snowsql

-- run test.bat file

-- put in C:\temp\scale-out\run_simultaneous.ps1
#if you are running this power shell script
#change the path acoording to the location of files on your system
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out1.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out2.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out3.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out4.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out5.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out6.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out7.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out8.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out9.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out10.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out11.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out12.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out13.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out14.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out15.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out16.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out17.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out18.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out19.txt"
Start-Process -FilePath "C:\temp\scale-out\test.bat" -RedirectStandardOutput "out20.txt"
