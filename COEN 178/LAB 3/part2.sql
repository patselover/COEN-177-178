--returns the deptid and the counts of each department
SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid;

--returns deptname and the counts of each department with natural join
SELECT deptname, count(*) FROM L_EMP NATURAL JOIN L_DEPT GROUP BY deptname;

--returns the combination of deptname and deptid
SELECT deptno,deptname,empcount FROM (SELECT deptid as deptno, count(*) AS empcount FROM L_EMP GROUP BY deptid),L_DEPT WHERE deptno = L_DEPT.deptid;

--same as one before but now ordered by count
SELECT deptno,deptname,empcount FROM (SELECT deptid as deptno, count(*) AS empcount FROM L_EMP GROUP BY deptid),L_DEPT WHERE deptno = L_DEPT.deptid ORDER BY empcount ASC;

--returns the deptid and max count THROWS ERROR
SELECT deptid, max(count(*)) FROM L_EMP GROUP BY deptid;

--The first query throws and error by using equals for comparing one value to multiple functions
Select deptid from L_EMP Group by deptid Having count(*) = (Select count(*) from L_EMP Group by deptid);
Select deptid from L_EMP Group by deptid Having count(*) = ANY (Select count(*) from L_EMP Group by deptid);

--returns deptname of max count
SELECT deptname FROM L_DEPT NATURAL JOIN L_EMP GROUP BY deptname HAVING count(*) = (SELECT max(count(*)) as max FROM L_EMP GROUP BY deptid);

--returns all columns of the natrual join
SELECT * FROM L_EMP NATURAL JOIN L_DEPT;

--same as above but with additional deptid column
SELECT * FROM L_EMP,L_DEPT WHERE L_EMP.deptid = L_DEPT.deptid;
