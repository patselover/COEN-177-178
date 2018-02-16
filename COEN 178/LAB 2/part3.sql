--DROP TABLES IF THEY EXIST
DROP TABLE L_EMP;
DROP TABLE L_DEPT;
--CREATE L_EMP AND L_DEPT TABLES
Create table L_EMP (empNo Integer Primary Key, empname CHAR(10),deptId CHAR(5));
Create table L_DEPT (deptId CHAR(5) Primary Key, deptname CHAR(10));
insert into L_EMP values(1,'smith','d1');
--INSERT TUPLES INTO L_EMP TABLE
insert into L_EMP values(2,'jones','d2');
insert into L_EMP values(3,'wayne','d1');
insert into L_EMP values(4,'moor','d3');
insert into L_EMP values(5,'king','d1');
insert into L_EMP values(6,'chen','d1');
insert into L_EMP values(7,'winger','d3');
--INSERT TUPLES INTO L_DEPT TABLE
insert into L_DEPT values('d1','Research');
insert into L_DEPT values('d2','Devt');
insert into L_DEPT values('d3','Testing');
insert into L_DEPT values('d4','Advert');
start lab2_queries2.sql;
