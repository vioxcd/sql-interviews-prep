SELECT Id, ShipCountry, CASE
						WHEN ShipCountry IN ('USA', 'Mexico', 'Canada')
							THEN 'NorthAmerica'
						ELSE 'OtherPlace'
						END Country
FROM 'Order'
ORDER BY Id ASC
LIMIT 20 OFFSET (15445 - (SELECT MIN(Id) FROM 'Order'));
