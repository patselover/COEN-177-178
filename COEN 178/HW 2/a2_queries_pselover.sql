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
        HAVING count(*) >= ALL (SELECT count(*) 
                                FROM Order_Item 
                                GROUP BY itemId) 
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