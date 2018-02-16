--A custid, fullname, city,
SELECT custid, firstname || lastname AS fullname, city FROM Customer;
--B Show data in the Customer, sorted by Customer last name
SELECT * FROM Customer ORDER BY lastname ASC;
--C Show data in the Schedule table, sorted by service id and then by customer id in descending order
SELECT * FROM Schedule ORDER BY serviceid DESC, custid DESC;
--D Show service ids of delivery services that are not in the schedule table
(SELECT serviceid FROM DeliveryService) MINUS (SELECT serviceid FROM Schedule);
--E The following query is given to show the names of customers who ordered a delivery service on Monday
Select firstname || lastname AS name from customer, schedule where day = 'm' AND customer.custid = schedule.custid;
--F Show the last names of the customers that are scheduled delivery services
SELECT lastname FROM Customer WHERE custid in (SELECT custid FROM Schedule, DeliveryService WHERE Schedule.serviceid = DeliveryService.serviceid);
--G Show the highest servicefee in Delivery Services (think of the aggregate function, max) renaming the result as highest_Servicefee
SELECT MAX(servicefee) AS highest_Servicefee FROM DeliveryService;
--H Show the number of delivery services scheduled by day
SELECT count(day) FROM Schedule Group BY(day);
--I The incomplete query below is given to show pairs of customer ids from the same city
Select A.custid,B.custid,A.city from Customer A, Customer B where A.city = B.city AND A.custid > B.custid;
--J Write a query to show the customers (who scheduled delivery services) where the customer city and location of the delivery services are in the same city
Select * From Customer where city in (Select location as City From DeliveryService);
--K Write a query to show the minimum salary and maximum salary of staff members in staff_2010 table. Display appropriate headings
Select MIN(salary),MAX(salary) From staff_2010;
