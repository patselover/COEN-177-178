Create or Replace Procedure assignJobTitlesAndSalaries
As
type titlesList IS VARRAY(5) OF AlphaCoEmp.title%type;
type salaryList IS VARRAY(5) of AlphaCoEmp.salary%type;

v_titles titlesList; 
v_salaries salaryList;

Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	
l_emprec Emp_cur%rowtype;
l_title AlphaCoEmp.title%type;
l_salary AlphaCoEmp.salary%type;
l_randomnumber INTEGER := 1;

BEGIN
	v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor');
	
	v_salaries := salaryList(130000, 100000, 600000, 500000, 800000); 
	
	for l_emprec IN Emp_cur
	loop
		l_randomnumber := dbms_random.value(1,5);
		
		l_title := v_titles(l_randomnumber);
		l_salary := v_salaries(l_randomnumber);
		
		 update AlphaCoEmp
		 set title = l_title
		 where name = l_emprec.name;
		 
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name; 
		 
   END LOOP;
  commit;
END;
/
Show errors;


-- Compiles Procedure above and calls it when you call execute and then we display the result of calling the procedure
execute assignJobTitlesAndSalaries;
select * from AlphaCoEmp;

Create or Replace Procedure assignJobTitlesAndSalaries
As
type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type;
type salaryList IS VARRAY(6) of AlphaCoEmp.salary%type;

v_titles titlesList; 
v_salaries salaryList;

Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	
l_emprec Emp_cur%rowtype;
l_title AlphaCoEmp.title%type;
l_salary AlphaCoEmp.salary%type;
l_randomnumber INTEGER := 1;

BEGIN
	v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor', 'coder');
	
	v_salaries := salaryList(130000, 100000, 600000, 500000, 800000, 3); 
	
	for l_emprec IN Emp_cur
	loop
		l_randomnumber := dbms_random.value(1,6);
		
		l_title := v_titles(l_randomnumber);
		l_salary := v_salaries(l_randomnumber);
		
		 update AlphaCoEmp
		 set title = l_title
		 where name = l_emprec.name;
		 
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name; 
		 
   END LOOP;
  commit;
END;
/
Show errors;


-- Compiles Procedure above and calls it when you call execute and then we display the result of calling the procedure
execute assignJobTitlesAndSalaries;
select * from AlphaCoEmp;


Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN NUMBER)
RETURN NUMBER 
IS

l_salary AlphaCoEmp.salary%type;
l_raise AlphaCoEmp.salary%type;
l_cnt Integer;

BEGIN
	-- Find the current salary of p_name from AlphaCoEMP table.

	Select salary into l_salary from AlphaCoEmp
	where name = p_name;
	
	-- Calculate the raise amount
	l_raise := l_salary * (percentRaise/100);
	
	-- Check if the p_name is in Emp_Work table. 
    -- If so, add a $1000 bonus to the 
	-- raise amount

	Select count(*) into l_cnt from Emp_Work
	where name = p_name;
	
	if l_cnt >= 1 THEN	
		l_raise := l_raise + 1000;
	End IF;
		
	return l_raise;

END;
/
Show Errors;


Select calcSalaryRaise('Stone',2) from Dual;

Select name, title, salary CURRENTSALARY, trunc(calcSalaryRaise(name,2)) NEWSALARY 
from AlphaCoEmp 
where upper(name) = upper('Stone');

Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN NUMBER)
RETURN NUMBER 
IS

l_salary AlphaCoEmp.salary%type;
l_raise AlphaCoEmp.salary%type;
l_cnt Integer;

BEGIN
	-- Find the current salary of p_name from AlphaCoEMP table.

	Select salary into l_salary from AlphaCoEmp
	where name = p_name;
	
	-- Calculate the raise amount
	l_raise := l_salary * (percentRaise/100);
	
	-- Check if the p_name is in Emp_Work table. 
    -- If so, add a $1000 bonus to the 
	-- raise amount

	Select count(*) into l_cnt from Emp_Work
	where lower(name) = lower(p_name);
	
	if l_cnt >= 1 THEN	
		l_raise := l_raise + 1000;
	End IF;
		
	return l_raise;

END;
/
Show Errors;

Select name, title, salary CURRENTSALARY, trunc(calcSalaryRaise(name,2)) NEWSALARY 
from AlphaCoEmp 
where upper(name) = upper('Stone');

Create table EmpStats (title VARCHAR(20) Primary KEY,empcount INTEGER, lastModified DATE);

Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type)

RETURN NUMBER IS
l_cnt Integer;

BEGIN
	
	Select count(*) into l_cnt from AlphaCoEmp
	Group by title
	Having lower(title) = lower(p_title);
	
	return l_cnt;

END;
/
Show Errors; 

select countByTitle('director') from Dual;
select countByTitle('advisor') from Dual;


CREATE or REPLACE procedure saveCountByTitle
AS
Cursor Emp_cur IS Select * from AlphaCoEmp;
l_emprec Emp_cur%rowtype;

l_pos INTEGER := 1;
l_cnt INTEGER := 1;

l_title AlphaCoEmp.title%type;

type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type;
v_titles titlesList; 

BEGIN
	v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor','coder');
	delete from EmpStats;
	
	for l_emprec IN Emp_cur
	loop
		l_cnt := countByTitle(v_titles(l_pos));
		l_title := v_titles(l_pos);
		insert into EmpStats values (l_title,l_cnt,SYSDATE);
		l_pos := l_pos + 1;
   END LOOP;
  commit;
	
END;
/
Show errors;

execute saveCountByTitle;
select * from EmpStats;