-- Link: https://www.hackerrank.com/challenges/weather-observation-station-19
-- Level: Medium
-- Description: Consider P1(a, b) and P2(c, d) to be two points on a 2D plane: a happens to equal the minimum value in Northern Latitude (LAT_N in STATION). b happens to equal the minimum value in Western Longitude (LONG_W in STATION). c happens to equal the maximum value in Northern Latitude (LAT_N in STATION). d happens to equal the maximum value in Western Longitude (LONG_W in STATION). Query the Eucliedean Distance between points P1 and P2 and and round it to a scale of 4 decimal places.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0d58ecb2-8e76-4f61-966e-ba1069692a8c
SELECT
    /*
    MIN(LAT_N) AS a,
    MAX(LAT_N) AS b,
    MIN(LONG_W) AS c,
    MAX(LONG_W) AS d
    */
    ROUND(
        SQRT(
            POW(MAX(LAT_N) - MIN(LAT_N), 2)
            +
            POW(MAX(LONG_W) - MIN(LONG_W), 2)
        )
        , 4
    )
FROM station
