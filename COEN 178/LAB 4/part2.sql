Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	--prints 'Hello' and a message you input
	DBMS_OUTPUT.put_line('Hello '||message);

END;
/
Show Errors;

exec DisplayMessage('include a message');

Select ROUND(DBMS_RANDOM.value (10,100)) from DUAL;

Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	-- Local variables
	l_emprec Emp_cur%rowtype;
	
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name;
		 
   END LOOP;
   commit;
END;
/
show errors;
--set the salaries of all employees to a number between 50,000 and 100,000
exec setSalaries (50000,100000);

SELECT name FROM AlphaCoEmp WHERE Salary > 80000 and salary < 90000;

Create or Replace Procedure setEmpSalary(p_name in VARCHAR, low in INTEGER, high in INTEGER)
As
	l_salary AlphaCoEmp.salary%type;
		
BEGIN	
	--set l_salary to a random number between low and hight
	l_salary := ROUND(dbms_random.value(low,high));
	--change the salary of a particular name to that salary above
	update AlphaCoEmp SET salary = l_salary WHERE lower(name) = lower(p_name);	 
   commit;
END;
/
show errors;

Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)
Return NUMBER IS
	l_salary AlphaCoEmp.salary%type;
BEGIN
	--set l_salary to the salary of the name chosen
	Select salary into l_salary 
	from AlphaCoEmp where lower(name) = lower(p_name);
			 
   	return l_salary;
END;
/
show errors;

--print the salary of weiser
Select getEmpSalary('Weiser')
From Dual;
