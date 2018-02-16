--drop Emp_Work if it exists
DROP TABLE Emp_Work;
--drop AlphaCoEmp if it exists
DROP TABLE AlphaCoEmp;

--create AlphaCoEmp
CREATE TABLE AlphaCoEmp(Name VARCHAR(25) Primary Key, Title VARCHAR(20) DEFAULT NULL, Salary Number(10,2) DEFAULT 0);

--copy all distinct names from Staff_2010
INSERT INTO AlphaCoEmp (name) SELECT distinct last from Staff_2010;

--display all values from AlphaCoEmp
SELECT * FROM AlphaCoEmp;

--create Emp_Work
Create Table Emp_Work(name VARCHAR(25) Primary Key, Project VARCHAR(20) default NULL, Constraint FK_AlphaCo Foreign Key (name) REFERENCES AlphaCoEmp(name));

--copy all names from alphacoemp and remove case sensitivity
insert into Emp_Work(name) Select Name from AlphaCoEmp where 
REGEXP_LIKE(name,'(^[ags])','i');

Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i');

--attempt to delete the name smith - throw error cannot delete a variable that is from another table
Delete from AlphaCoEmp Where name='Smith';

--alter the table to drop the constraints
Alter table Emp_Work drop constraint FK_AlphaCo;

Alter table Emp_Work add constraint FK_AlphaCo FOREIGN KEY (name) references AlphaCoEmp(name) on delete cascade;

--delete the name smith
DELETE from AlphaCoEmp Where name='Smith';
