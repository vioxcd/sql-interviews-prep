WITH BlonpFirstTenOrder AS (
	SELECT Id, OrderDate
	FROM "Order" o 
	WHERE CustomerId = 'BLONP'
	ORDER BY OrderDate ASC
	LIMIT 10
), BlonpOrderPreviousDate AS (
	SELECT
		Id,
		OrderDate,
		LAG(OrderDate, 1, OrderDate) OVER (
			ORDER BY OrderDate RANGE BETWEEN 1 PRECEDING AND CURRENT ROW
		) AS PreviousDate
	FROM BlonpFirstTenOrder 
)
SELECT
		Id,
		OrderDate,
		PreviousDate,
		ROUND(JULIANDAY(OrderDate) - JULIANDAY(PreviousDate), 2)
FROM BlonpOrderPreviousDate
ORDER BY OrderDate ASC
