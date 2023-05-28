WITH Orders AS (
	SELECT OrderId, SUM(OrderExpenditure) AS Expenditure 
	FROM (
		SELECT OrderId, (UnitPrice * Quantity) AS OrderExpenditure
		FROM OrderDetail od
	)
	GROUP BY OrderId
), Customers AS (
	SELECT 
		o.Id AS OrderId,
		IFNULL(CompanyName, 'MISSING_NAME') AS CompanyName,
		CustomerId
	FROM "Order" o LEFT JOIN Customer c ON o.CustomerId = c.Id
), ExpenditurePerCustomers AS (
	SELECT CompanyName, CustomerId, ROUND(SUM(Expenditure), 2) AS TotalExpenditure
	FROM Orders INNER JOIN Customers
		ON Orders.OrderId = Customers.OrderId
	GROUP BY CustomerId
), ExpenditurePerCustomersPerQuartiles AS (
	SELECT *, NTILE(4) OVER (
		ORDER BY TotalExpenditure ASC
	) AS Quartiles
	FROM ExpenditurePerCustomers
)
SELECT *
FROM ExpenditurePerCustomersPerQuartiles
WHERE Quartiles = 1
