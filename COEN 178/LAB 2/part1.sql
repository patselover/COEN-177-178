--DROP TABLES IF THEY EXIST
DROP TABLE Schedule;
DROP TABLE Customer;
DROP TABLE DeliveryService;
--CREATE CUSTOMER, DELIVERYSERVICE AND SCHEDULE TABLES
CREATE TABLE Customer(
	custid VARCHAR(5), 
	firstname VARCHAR(10), 
	lastname VARCHAR(15), 
	city VARCHAR(10), 
	PRIMARY KEY(custid));
CREATE TABLE DeliveryService(
	serviceid VARCHAR(10), 
	item CHAR(15), 
	location VARCHAR(15), 
	servicefee float, 
	PRIMARY KEY(serviceid));
CREATE TABLE Schedule(
	serviceid VARCHAR(10) REFERENCES DeliveryService(serviceid), 
	custid VARCHAR(5) REFERENCES Customer(custid),
	day VARCHAR(2) NOT NULL, 
	CHECK (day in ('m','t','w','r','f')));
--INSERT TUPLES INTO CUSTOMER TABLE
INSERT INTO Customer VALUES('c1', 'John ', 'Smith','SJ');
INSERT INTO Customer VALUES('c2', 'Mary ', 'Jones','SFO');
INSERT INTO Customer VALUES('a1', 'Vincent ','Chen','SJ');
INSERT INTO Customer VALUES('a12', 'Greg ', 'King','SJ');
INSERT INTO Customer VALUES('c7', 'James ', 'Bond','LA');
INSERT INTO Customer VALUES('x10', 'Susan ','Blogg','SFO');
--INSERT TUPLES INTO DELIVERYSERVICE TABLE
INSERT INTO DeliveryService VALUES('dsg1','grocery','SJ',25.0);
INSERT INTO DeliveryService VALUES('dsb1','books','SJ',10.0);
INSERT INTO DeliveryService VALUES('dsm2','movies','LA',10.0);
INSERT INTO DeliveryService VALUES('dby3','babygoods','SFO',15.0);
INSERT INTO DeliveryService VALUES('dsg2','grocery','SFO',20.0);
INSERT INTO DeliveryService VALUES('dg5','greengoods','SFO',30.0);
--INSERT TUPLES INTO SCHEDULE TABLE
INSERT INTO Schedule VALUES('dsg1','c1','m');
INSERT INTO Schedule VALUES('dsg1','a12','w');
INSERT INTO Schedule VALUES('dby3','x10','f');
INSERT INTO Schedule VALUES('dg5','c1','r');
INSERT INTO Schedule VALUES('dg5','c1','t');
INSERT INTO Schedule VALUES('dg5','c32','t');
INSERT INTO Schedule VALUES('dsg2','c1','s');
