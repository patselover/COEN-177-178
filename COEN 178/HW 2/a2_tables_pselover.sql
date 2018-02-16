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