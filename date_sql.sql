
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- get current date

select GETDATE() 
-- (output =2024-01-18 10:11:51.130)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- add 2 day , month , year		

-- select dateadd(day/month/year , no. of month to add, date on which you want to add)

SELECT DATEADD(DAY, 7, GETDATE()) AS SevenDaysLater;	-- it will add 7 days to current date 
-- (output = 2024-01-25 10:10:47.720)

SELECT DATEADD(MONTH, 7, GETDATE()) AS SevenMonth;
-- 2024-08-18 17:06:51.947
------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- difference between 2 dates

SELECT DATEDIFF(day, '2024-01-16', GETDATE()) AS Days_Difference;	-- it will give difference of number of days between given date and current date 
SELECT DATEDIFF(month, '2024-01-16', GETDATE()) AS Days_Difference;	-- it will give difference of number of days between given month and current month 
SELECT DATEDIFF(YEAR, '2024-01-16', GETDATE()) AS Days_Difference;	-- it will give difference of number of days between given year and current year 

-- (output = 2)    GETDATE() = 18/01/2024				2024/01/18 - 2024-01-16


--	select datediff(day, old , new)
SELECT DATEDIFF(DAY, '2023-07-28', '2023-08-15');
-- (output = 18)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT YEAR(GETDATE()) AS CurrentYear,
       MONTH(GETDATE()) AS CurrentMonth,
       DAY(GETDATE()) AS CurrentDay;

SELECT YEAR('2023-07-28') AS CurrentYear,		-- 2023
	   MONTH('2023-07-28') AS CurrentMonth,		-- 7
	   DAY('2023-07-28') AS CurrentDay;		-- 28

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	   
-- GETDATE() = 19/1/2024
SELECT DATEPART(YEAR, GETDATE()) AS CurrentYear,			--	2024
       DATEPART(MONTH, GETDATE()) AS CurrentMonth,			--	1
       DATEPART(DAY, GETDATE()) AS CurrentDay;				--	19

SELECT DATEPART(YEAR, '2023-07-28') AS CurrentYear,	
       DATEPART(MONTH, '2023-07-28') AS CurrentMonth,
       DATEPART(DAY, '2023-07-28') AS CurrentDay;	

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


SELECT EOMONTH(GETDATE()) AS LastDayOfMonth;  -- it will retur Last Day Of Current Month
SELECT EOMONTH('1558-01-09') AS LastDayOfMonth;
-- (output = 2024-01-31)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--1. case sensitive ( COLLATE SQL_Latin1_General_CP1_CS_AS )=
-- how to make case sensitive 


 SELECT * FROM Employees
 where name = 'Anurag' COLLATE SQL_Latin1_General_CP1_CS_AS			-- this will consider Kunj , kunj , KUNJ all 3 different
 



-- 2. case in-sensitive (  COLLATE Latin1_General_CI_AI ) =
 -- by default it is in-sensetive . also use external keyword =

 SELECT * FROM Employees
 where name = 'Anurag'  COLLATE Latin1_General_CI_AI			-- this will consider Kunj , kunj , KUNJ all 3 same
 

 SELECT name, 
		CASE 
			WHEN name = 'david' 
			THEN 'Match' 
			
			WHEN UPPER(name) = 'DRAVID' 
			THEN 'Case-insensitive Match' 
			
			ELSE 'No Match' 
		END AS MatchStatus 
FROM employees;