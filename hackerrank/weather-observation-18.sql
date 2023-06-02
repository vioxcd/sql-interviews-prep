-- Link: https://www.hackerrank.com/challenges/weather-observation-station-18
-- Level: Medium
-- Description: Consider P1(a, b) and P2(c, d) to be two points on a 2D plane: a happens to equal the minimum value in Northern Latitude (LAT_N in STATION). b happens to equal the minimum value in Western Longitude (LONG_W in STATION). c happens to equal the maximum value in Northern Latitude (LAT_N in STATION). d happens to equal the maximum value in Western Longitude (LONG_W in STATION). Query the Manhattan Distance between points P1 and P2 and and round it to a scale of 4 decimal places.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/8be3ddf6-cdf5-46e8-b2b4-3a5c19c80a88
SELECT
    ROUND(
        ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W))
    , 4)
FROM station
