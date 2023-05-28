WITH ShipperOrder AS (
	SELECT Shipper.CompanyName,
		   COUNT(CASE WHEN 'Order'.ShippedDate > 'Order'.RequiredDate THEN 1 END) AS Late,
		   COUNT(CASE WHEN 'Order'.ShippedDate <= 'Order'.RequiredDate THEN 1 END) AS OnTime
	FROM Shipper INNER JOIN 'Order'
	ON Shipper.Id = 'Order'.ShipVia
	GROUP BY Shipper.CompanyName
)
SELECT CompanyName,
	   PRINTF("%.2f", (Late * 100.0 / (Late + OnTime))) AS Percentage
FROM ShipperOrder
ORDER BY Percentage DESC;
