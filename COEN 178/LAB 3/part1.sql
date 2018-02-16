--selects staff with max salary by choosing salary equal to max or by comparing vs all other salaries
SELECT first||last AS fullname,salary FROM Staff_2010 WHERE salary >= ALL (SELECT salary FROM Staff_2010);
SELECT first||last AS fullname,salary FROM Staff_2010 WHERE salary = (SELECT MAX(salary) FROM Staff_2010);

--Selects last name and salary from staff converting to lower case looking for pattern
SELECT last, salary FROM Staff_2010 WHERE salary = (SELECT salary FROM Staff_2010 WHERE lower(last) like '%zichal');
SELECT last, salary FROM Staff_2010 WHERE salary = (SELECT salary FROM Staff_2010 WHERE lower(last) like '%young');
SELECT last, salary FROM Staff_2010 WHERE salary = ANY (SELECT salary FROM Staff_2010 WHERE lower(last) like '%young');

--returns staff who's salary is greater than 100000
SELECT count(*) FROM Staff_2010 WHERE salary > 100000;

--returns the counts of staff who's salary is greater than 100000 grouped by salary
SELECT salary,count(*) FROM Staff_2010 WHERE salary > 100000 GROUP BY salary;

--returns the conts of staff who's salary is greater than 100000 and whos group is greater than 10
SELECT salary,num AS salaries_100K_above FROM (SELECT salary,count(*) AS num FROM Staff_2010 WHERE salary > 100000 GROUP BY salary) WHERE num >= 10;

--returns all last names who have repeated vowels, i means that the text is not case sensitive
SELECT last FROM Staff_2010 WHERE REGEXP_LIKE (last, '([aeiou])\1','i');
