SQL Server clauses:

SELECT
FROM
WHERE
ORDER BY
GROUP BY
HAVING
JOIN
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN
DISTINCT
FETCH
OFFSET



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



select * from movie
where mov_title != 'Vertigo'

select * from movie
where not mov_title = 'Vertigo'


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- case = 


use MOVIES_W3

select mov_year,
		CASE
           WHEN mov_year < 1990 THEN 'old'
           WHEN mov_year > 2000 THEN 'new'
           ELSE 'not new'
		END AS movyear
from movie

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- row number = 


use MOVIES_W3

select * from (
	select * , ROW_NUMBER() over (order by mov_title) as r
	from movie
) as table1
where table1.r=1


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- avg then , sum over = 


use testing
SELECT Name, Salary, Department, sum(Salary) OVER (PARTITION BY Department ) as dept_total_sal , avg(Salary) OVER (PARTITION BY Department ) as dept_avg_sal ,
	CASE 
		WHEN SALARY > avg(Salary) OVER (PARTITION BY Department ) THEN 'salary more than avg'
		WHEN SALARY < avg(Salary) OVER (PARTITION BY Department ) THEN 'salary less than avg'
	END as STATUS
FROM Employees


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- user defined function = 

--	2 types = 

--  1. scalar (user defined function) = 



				--SYNTAX				
								CREATE FUNCTION ____ ()
									RETURNS __
									AS
									BEGIN
									RETURN ___
								END;


				--1 scalar 
				CREATE FUNCTION dbo.GetFullName(@firstName VARCHAR(50), @lastName VARCHAR(50)) 
					RETURNS VARCHAR(100) 
					AS 
					BEGIN 
					RETURN @firstName + ' ' + @lastName;
				END;

				use testing
				select dbo.GetFullName ('kunj','vaishnani')



				--2
				CREATE FUNCTION dbo.f1(@n1 int)
					RETURNS int
					AS
					BEGIN
					RETURN (@n1)
				END;


				use testing
				select dbo.f1 (5) as 'Output'




				drop function dbo.f1






-- 2. table valued (user defined function ) = 


			--SYNTAX				
								CREATE FUNCTION ____ ()
									RETURNS table
									AS
									RETURN ( query )



			-- example = 
			CREATE FUNCTION dbo.f2()
				RETURNS table
				AS
				RETURN (select * from employees)


			use testing
			select * from dbo.f2()



			-- example = 
			CREATE FUNCTION dbo.f3(@n varchar(10))
				RETURNS table
				AS
				RETURN (
							select * from employees 
							where name = @n
						)


			use testing
			select * from dbo.f3('Stokes')


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- calling view from function 

			-- creating view
			create view [test]
			as select * from employees
				where name = 'James'

			
			-- creating function and calling view from it
			CREATE FUNCTION dbo.calling_view()
			returns table 
			as
			return ( select * from [test] )

			-- executing function
			use testing
			select * from dbo.calling_view()


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- offset and fetch ( used in pagination )

-- syntax =
select ___ from ___
order by ______
offset 2 rows
fetch next 2 rows only

-- have to be used with Order BY
-- offset will ship particular no. of rows and fetch will display given no. of rows

use testing

select NAME,department,SALARY from employees
order by SALARY
offset 2 rows
fetch next 2 rows only





set statistics time on

select NAME,department,SALARY from employees
order by SALARY
offset 2 rows
fetch next 2 rows only

set statistics time  off



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CURSOR

-- forward only cursor .
-- it can only go in 1 direction that is forward . 
-- to use this we have to use (FETCH next FROM EMP_CURSOR) instead of (FETCH first FROM EMP_CURSOR)

DECLARE EMP_CURSOR CURSOR For
select * from employees

OPEN emp_cursor;	

FETCH next FROM EMP_CURSOR 
FETCH next FROM EMP_CURSOR 

CLOSE  emp_cursor

DEALLOCATE  emp_cursor

---------------------------------------
-- scroll cursor
-- it can go forward and backward

DECLARE EMP_CURSOR CURSOR scroll For
select * from employees

OPEN emp_cursor;	

FETCH first FROM EMP_CURSOR 
FETCH next FROM EMP_CURSOR 

CLOSE  emp_cursor

DEALLOCATE  emp_cursor


---------------------------------------

1.

DECLARE EMP_CURSOR CURSOR scroll For
select * from employees

open myCursor

fetch first from myCursor
fetch next from myCursor
fetch last from myCursor
fetch prior from myCursor
fetch absolute 4 from myCursor

close myCursor
deallocate myCursor



2. 

DECLARE EMP_CURSOR CURSOR scroll For
select * from employees

OPEN emp_cursor;	

FETCH first FROM EMP_CURSOR 
FETCH next FROM EMP_CURSOR 

CLOSE  emp_cursor

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- while loop

-- while loop to printing 1 to 10
DECLARE @count int
SET @count=1

WHILE(@count<=10)
BEGIN
	PRINT @count;
	SET @count= @count+1
END






-- while loop to insert in table
DECLARE @count int
SET @count=13

WHILE (@count<15)
BEGIN
	INSERT INTO employees (ID, Name, Department, Salary) VALUES (@count, 'l', 'm', 19990)
	SET @count=@count+1
END






-- while loop with offset-fetch (pagination)
DECLARE @count int
SET @count=0

DECLARE @pagesize int=2;
WHILE (@count<10)
BEGIN
	SELECT * FROM Employees
	ORDER BY ID
	OFFSET @count ROWS
	FETCH NEXT @pagesize ROW ONLY

	SET @count= @count+2
END


-- while loop with break
DECLARE @count int
SET @count=1

WHILE(@count<10)
BEGIN
	PRINT @count;

	IF(@count=5)
		BREAK;

	SET @count=@count+1
END

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 types of  temporary table =

-- local temporary table

CREATE TABLE #LocalTempTab (coll int, col2 int)				-- create local temporary table by #
insert into #LocalTempTab values (2,2)						-- insert value

select * from #LocalTempTab									-- to display local temporary table named TempTab



-- global temporary table

CREATE TABLE #GlobalT (coll int, col2 int)				-- create global temporary table by ##
insert into #GlobalT values (2,2)						-- insert value

select * from #GlobalT									-- to display global temporary table named TempTab

------------------------------------------------------------------------------------------------------------

select * from tempdb.INFORMATION_SCHEMA.TABLES			-- to see all temporary tables present in database	


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- exeception handle using try-catch block

--1
BEGIN TRY
	SELECT * FROM Employees
END TRY

BEGIN CATCH
	PRINT 'NO SUCH TABLE IN'
END CATCH


--2
begin try
	update Employees 
	set Department = 12 
	where name = 1
end try

begin catch
	print 'error'
end catch



--3. try catch in query
begin try
	update Employees set salary = 'abc' where id = 1
end try

begin catch
	select
	Error_number () as [Error Number],
	Error_severity() as [Error Severity],
	Error_State() as [Error State Number],
	Error_procedure () as [SP Name],
	Error_Line () as [Error on line],
	Error_Message() as [Error Message]
end catch


-- 4. try catch in stored procedure
create proc MyProc1
as
begin

	begin try
		update Employees set salary = 'abc' where id = 1
	end try

	begin catch
		select
		Error_number () as [Error Number],
		Error_severity() as [Error Severity],
		Error_State() as [Error State Number],
		Error_procedure () as [SP Name],
		Error_Line () as [Error on line],
		Error_Message() as [Error Message]
	end catch

end

-- execute this =
exec MyProc1



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 User-defined types

-- 1. Structured User-Defined Types =

 CREATE TYPE PersonType 
 AS TABLE ( FirstName VARCHAR(50), LastName VARCHAR(50), Age INT );

 -- execute all 3 below together
 declare @n PersonType									-- here we are giving table variable n a datatype PersonType

 Insert into @n (FirstName , LastName , Age) 
 values ('a','A',24), ('B','b',30);						-- inserting in tabl variable n

 select * from @n										-- select from table n


 -- 2. Distinct User-Defined Types:

	