-- Link: https://leetcode.com/problems/trips-and-users/
-- Level: Hard
-- Description: The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day. Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points. Return the result table in any order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/09dd1f6a-953d-42b1-b779-c2f887dbd1e8
SELECT
    t.request_at AS Day,
    ROUND(
        SUM(
            CASE
                WHEN status = 'completed' THEN 0
                ELSE 1
            END
        ) / COUNT(*)
    , 2) AS 'Cancellation Rate'
FROM Trips t
    INNER JOIN Users uc
        ON t.client_id = uc.users_id
    INNER JOIN Users ud
        ON t.driver_id = ud.users_id
WHERE
    uc.banned = 'No' AND ud.banned = 'No'
    AND uc.role = 'client' AND ud.role = 'driver'
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY
    request_at
ORDER BY
    Day ASC
