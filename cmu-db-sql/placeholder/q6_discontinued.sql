WITH ResultSet AS (
	SELECT ProductName, CompanyName, ContactName, MIN(OrderDate)
	FROM Product INNER JOIN OrderDetail ON Product.Id = OrderDetail.ProductId
				 INNER JOIN 'Order' ON OrderDetail.OrderId = 'Order'.Id
				 INNER JOIN Customer ON 'Order'.CustomerId = Customer.Id
	WHERE Product.Discontinued = 1
	GROUP BY ProductId
	ORDER BY ProductName
)
SELECT ProductName, CompanyName, ContactName
FROM ResultSet
