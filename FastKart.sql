/* List the top 3 products based on the highest quantity available */
SELECT ProductId, ProductName, QuantityAvailable
FROM Products
ORDER BY QuantityAvailable DESC 
LIMIT 3;

/* List email IDs of customers who made more than 10 transactions, showing total quantity purchased, ordered by total transactions */
SELECT pd.EmailId, pd.QuantityPurchased as Total_Transactions
FROM PurchaseDetails pd
INNER JOIN Products p ON pd.ProductId = p.ProductId
GROUP BY EmailId
HAVING COUNT(QuantityPurchased) > 10
ORDER BY Total_Transactions DESC;

/* Show total quantity available for each product category, ordered by total quantity available */
SELECT c.CategoryName as NameOfTheCategory, p.QuantityAvailable as TotalQuantityAvailable
FROM Products p
INNER JOIN Categories c ON p.CategoryId = c.CategoryId
GROUP BY c.CategoryName
ORDER BY p.QuantityAvailable DESC;

/* Show total quantity purchased for each product, along with product and category names */
SELECT p.ProductId, p.ProductName, c.CategoryName, SUM(pd.QuantityPurchased) as Total_Purchased_Quantity
FROM Categories c
INNER JOIN Products p ON c.CategoryId = p.CategoryId
INNER JOIN PurchaseDetails pd ON p.ProductId = pd.ProductId;

/* Count the number of users for each gender */
SELECT Gender, COUNT(Gender)
FROM Users
GROUP BY Gender;

/* Classify products into pricing categories and list them with product details, ordered by price descending */
SELECT ProductId, ProductName, Price,
CASE
    WHEN Price < 2000 THEN 'Affordable'
    WHEN Price BETWEEN 2000 AND 50000 THEN 'High And Stuff'
    WHEN Price > 50000 THEN 'Luxury' 
    ELSE Price
END as ItemClasses
FROM Products
ORDER BY Price DESC;

/* Apply price adjustments based on category and show updated product prices */
SELECT p.ProductId, p.ProductName, c.CategoryName, p.Price,
CASE CategoryName
    WHEN 'Motors' THEN Price - 3000
    WHEN 'Electronics' THEN Price + 50
    WHEN 'Fashion' THEN Price + 150
    ELSE Price
END as NewPrice
FROM Products p
INNER JOIN Categories c ON p.CategoryId = c.CategoryId
ORDER BY ProductId;

/* Calculate the percentage of female users */
SELECT Gender, CONCAT(ROUND((COUNT(Gender='f') / (SELECT COUNT(Gender) FROM Users) * 100), 2), '%') AS percentage
FROM Users
WHERE Gender = 'f';

/* Show average balance for each card type, filtered by CVV number and cardholder's name ending in 'e' */
SELECT CardType, AVG(Balance)
FROM CardDetails
WHERE CVVNumber > 333 AND NameOnCard LIKE '%e'
GROUP BY CardType;

/* Calculate total inventory value of products (price * quantity), excluding Motors category, ordered by value */
SELECT p.ProductName, c.CategoryName, SUM(p.Price * p.QuantityAvailable) as VALUE
FROM Products p
INNER JOIN Categories c ON p.CategoryId = c.CategoryId
WHERE CategoryName != 'Motors'
ORDER BY VALUE;
