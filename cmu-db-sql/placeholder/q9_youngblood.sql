WITH TerritoryRegion AS (
	SELECT DISTINCT et.EmployeeId, RegionDescription
	FROM Region r
		INNER JOIN Territory t
			ON r.Id = t.RegionId
		INNER JOIN EmployeeTerritory et 
			ON t.Id = et.TerritoryId
), RankedPerRegion AS (
	SELECT *, RANK() OVER (
							PARTITION BY tr.RegionDescription
							ORDER BY e.BirthDate DESC
						) AS YouthToOldRank
	FROM Employee e
		INNER JOIN TerritoryRegion tr
		ON e.Id = tr.EmployeeId
)
SELECT RegionDescription, FirstName, LastName, BirthDate
FROM RankedPerRegion
WHERE YouthToOldRank = 1
