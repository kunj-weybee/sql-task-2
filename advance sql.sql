
-- 1

create FUNCTION dbo.ValidateEmail(@email VARCHAR(50))
RETURNS BIT
	AS 
	BEGIN
	declare @isValid bit
	SET @isValid = CASE 
					WHEN @email LIKE '%@%.%'
                    THEN 1 
                    ELSE 0 
                  END
	Return @isValid;
END;

DECLARE @email NVARCHAR(50) = 'kunjv25@gmail.com'
DECLARE @result BIT;
SET @result = dbo.ValidateEmail(@email);

IF (@result = 1)
    PRINT 'The email is valid.';
ELSE
    PRINT 'The email is not valid.';



drop function dbo.ValidateEmail


2

create FUNCTION dbo.GetDepartment(@dName varchar(10))
	RETURNS table
	AS
	RETURN (select * from employee
			where department_id = ( select department_id 
									from departments
									where department_name = @dName) )


select * from dbo.GetDepartment('IT')



3

CREATE FUNCTION dbo.GetRecordofPage(@show_page int , @row_in_one_page int)
RETURNS table
AS
RETURN (
			select * 
			from employee
			order by employee_id
			offset (@show_page - 1) * @row_in_one_page rows
			fetch next @row_in_one_page rows only
		)

	
select * from dbo.GetRecordofPage(5, 6)



4.

alter procedure pr_5
as
declare @count int = 0

while @count = 0
BEGIN
	select top 10 concat(first_name,' hired on ',hire_date,' has salary package of ',salary) from employee
	set @count=@count+1
END

exec pr_5



alter PROCEDURE GetEmployeeInfo
AS
BEGIN

    DECLARE @name VARCHAR(255);
    DECLARE @joining_date DATE;
    DECLARE @salary int;

    DECLARE employee_cursor CURSOR FOR
        SELECT TOP 10 first_name, hire_date, salary FROM Employee;

    OPEN employee_cursor;

    FETCH NEXT FROM employee_cursor INTO @name, @joining_date, @salary;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Print employee information
        PRINT CONCAT(@name, ' hired on ', @joining_date, ' has a salary package of ', @salary);

        FETCH NEXT FROM employee_cursor INTO @name, @joining_date, @salary;
    END;

    CLOSE employee_cursor;
    DEALLOCATE employee_cursor;

END;

exec GetEmployeeInfo




	DECLARE @name VARCHAR(255);
	DECLARE @joining_date DATE;
	DECLARE @salary int;

	DECLARE employee_cursor CURSOR scroll FOR
		SELECT TOP 10 first_name, hire_date, salary FROM Employee;

	OPEN employee_cursor;

		FETCH first FROM employee_cursor INTO @name, @joining_date, @salary;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Print employee information
		PRINT CONCAT(@name, ' hired on ', @joining_date, ' has a salary package of ', @salary);

		FETCH NEXT FROM employee_cursor INTO @name, @joining_date, @salary;
	END;

	CLOSE employee_cursor;
	DEALLOCATE employee_cursor;