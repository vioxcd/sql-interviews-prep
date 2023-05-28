SELECT Category.CategoryName,
	   ROUND(AVG(Product.UnitPrice), 2),
	   MIN(Product.UnitPrice),
	   MAX(Product.UnitPrice),
	   SUM(Product.UnitsOnOrder)
FROM Product
INNER JOIN Category
ON Product.CategoryId = Category.Id
GROUP BY Product.CategoryId
HAVING COUNT(1) > 10
ORDER BY Product.CategoryId;
