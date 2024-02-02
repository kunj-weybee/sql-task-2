-- 1
--  select max(salary) as max, (select salary from employeeposition order by salary desc offset 1 rows fetch next 1 row only) as SecondMax
--			,min(salary) as min, (select salary from employeeposition order by salary asc offset 1 rows fetch next 1 row only) as SecondMin
--	from employeeposition

-- 2
--	SELECT TOP 50 PERCENT * FROM EMPLOYEEINFO

-- 3
--	SELECT TOP 3 * FROM EMPLOYEEINFO
--	ORDER BY EMPID DESC


-- 4
--	SELECT * FROM EMPLOYEEPOSITION
--	ORDER BY SALARY DESC
--	OFFSET 2 ROWS
--	FETCH NEXT 1 ROW ONLY


-- 5
--	SELECT * INTO NEWTABLE
--	FROM EMPLOYEEPOSITION
--	WHERE 1 = 0;


-- 6
--	WITH EMPLOYEE AS(SELECT DEPARTME, COUNT(DEPARTME) AS I FROM EMPLOYEEINFO
--	GROUP BY DEPARTME) 

--	SELECT * FROM EMPLOYEE
--	WHERE I < 2


-- 7

--	WITH I AS
--		(
--			SELECT	EMPFNAM, 
--					DEPARTME,
--					SALARY,
--					DENSE_RANK() OVER (PARTITION BY DEPARTME ORDER BY SALARY DESC) AS R,
--					MAX(SALARY) OVER (PARTITION BY DEPARTME ORDER BY DEPARTME) AS MAXSALARY
--			FROM EMPLOYEEINFO EI
--			INNER JOIN EMPLOYEEPOSITION EP
--			ON EI.EMPID = EP.EMPID
--		)
--	SELECT * FROM I
--	WHERE R=1
