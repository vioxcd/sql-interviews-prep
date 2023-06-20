-- Link: https://leetcode.com/problems/human-traffic-of-stadium/
-- Level: Hard
-- Description: Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each. Return the result table ordered by visit_date in ascending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/8424a10d-ac7d-414b-b852-24a95124b641
WITH
filtered AS (
    SELECT
        *
    FROM Stadium
    WHERE people >= 100
),
ordered_id AS (
    SELECT
        *,
        id - ROW_NUMBER() OVER (ORDER BY id) AS id_ordering
    FROM filtered
)
SELECT id, visit_date, people
FROM ordered_id
WHERE id_ordering IN (
    SELECT id_ordering
    FROM ordered_id
    GROUP BY 1
    HAVING COUNT(1) >= 3
)
