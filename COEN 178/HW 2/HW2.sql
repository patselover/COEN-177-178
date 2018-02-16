DROP TABLE Order_Item;
DROP TABLE MealItem;
DROP TABLE MealOrder;

CREATE TABLE MealItem(
        itemId CHAR(2) PRIMARY KEY,
        name VARCHAR(20),
        price FLOAT(2),
        calories INTEGER
);

CREATE TABLE MealOrder(
        orderId CHAR(2) PRIMARY KEY,
        name VARCHAR(10),
        phone CHAR(10)
);

CREATE TABLE Order_Item(
        orderId CHAR(2) REFERENCES MealOrder(orderId),
        itemId CHAR(2) REFERENCES MealItem(itemId),
        PRIMARY KEY(orderId,itemId)
);

INSERT INTO MealItem VALUES('I1', 'oatmeal',3.00,120);
INSERT INTO MealItem VALUES('I2', 'fruit_plate',7.50,220);
INSERT INTO MealItem VALUES('I3', 'steak',20.99,420);
INSERT INTO MealItem VALUES('I4', 'chicken pie',12.50,350);
INSERT INTO MealItem VALUES('I5', 'broccoli pie',10.00,200);

INSERT INTO MealOrder VALUES('O1','Smith','4085551212');
INSERT INTO MealOrder VALUES('O2','Jones','4085554444');
INSERT INTO MealOrder VALUES('O5','Clark','4083331212');
INSERT INTO MealOrder VALUES('O7','Chen','4086661212' );
INSERT INTO MealOrder VALUES('O8','Smith','4085551212');

INSERT INTO Order_Item VALUES('O1','I1');
INSERT INTO Order_Item VALUES('O1','I2');
INSERT INTO Order_Item VALUES('O1','I3');
INSERT INTO Order_Item VALUES('O2','I4');
INSERT INTO Order_Item VALUES('O8','I1');

--Show the names of MealItems and prices, sorted by price
SELECT name,price FROM MealItem ORDER BY price;

--Show the names of MealItems, price and calories, sorted by price and calories
SELECT name,price,calories FROM MealItem ORDER BY price,calories;

--Show the name of the MealItem and calories with most no. of calories
SELECT name,calories FROM MealItem WHERE calories = (SELECT MAX(calories) FROM MealItem);

--Show the name of the item that is most popular (most no. of occurences) in the Order_Item table
SELECT name 
FROM MealItem 
WHERE itemId = (
        SELECT itemId 
        FROM Order_Item 
        HAVING count(*) >= ALL (SELECT count(*) FROM Order_Item GROUP BY itemId) 
        GROUP BY itemId);
        
--Show the names and prices of the items that are not in Order_Item table
SELECT name,price FROM MealItem WHERE itemId NOT IN (SELECT itemId FROM Order_Item);

--Show the phone of the person with most orders in the Orders table. An incomplete query is given below. Complete it
SELECT phone 
FROM MealOrder 
WHERE orderId = (
        SELECT orderId 
        FROM Order_Item 
        HAVING count(*) >= ALL (SELECT count(*) 
                                FROM Order_Item 
                                GROUP BY orderId) 
        GROUP BY orderId);

--Show the orderId and total calories for all the items in that order (from Order_Item table)
SELECT Order_Item.orderId,SUM(MealItem.calories) FROM Order_Item INNER JOIN MealOrder ON Order_Item.orderId = MealOrder.orderId INNER JOIN MealItem ON Order_Item.itemId = MealItem.itemId GROUP BY Order_Item.orderId;

--Change the price of those items (in MealItem table) to 10% less than the current price, if that item is not in any of the orders (Order_Item table)
UPDATE MealItem SET price = price*(1-.1) WHERE itemId NOT IN (SELECT itemId FROM Order_Item);
SELECT * FROM MealItem;