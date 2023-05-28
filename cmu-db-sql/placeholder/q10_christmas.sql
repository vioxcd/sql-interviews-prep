WITH ProductsResult AS (
	SELECT 
		ROW_NUMBER() OVER (ORDER BY p.id) AS RowId,
		p.ProductName
	FROM "Order" o
		INNER JOIN Customer c
			ON o.CustomerId = c.Id 
		INNER JOIN OrderDetail od 
			ON o.Id = od.OrderId
		INNER JOIN Product p 
			ON od.ProductId = p.Id 
	WHERE c.CompanyName = 'Queen Cozinha'
		AND o.OrderDate BETWEEN DATETIME('2014-12-25 00:00:00')
						AND DATETIME('2014-12-25 23:59:59')
	ORDER BY p.Id ASC
), ConcatResult (ProductsConcatenated, Counter) AS (
	SELECT ProductName, 1
	FROM ProductsResult
	WHERE RowId = 1
	
	UNION ALL
	
	SELECT ProductsConcatenated || ', ' || ProductName, Counter + 1
	FROM ConcatResult, ProductsResult
	WHERE RowId = (Counter + 1)
)
SELECT ProductsConcatenated
FROM ConcatResult
ORDER BY Counter DESC
LIMIT 1
