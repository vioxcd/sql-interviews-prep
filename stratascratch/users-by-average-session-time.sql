-- Link: https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1
-- Level: Medium
-- Description: Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time. 
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/f3d1bb13-f288-45d0-9867-325dcb719821
WITH user_page_load AS (
    SELECT user_id,
        DATE(timestamp),
        MAX(timestamp) last_page_load
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY 1, 2
), user_page_exit AS (
    SELECT user_id,
        DATE(timestamp),
        MAX(timestamp) AS last_page_exit
    FROM facebook_web_log
    WHERE action = 'page_exit'
    GROUP BY 1, 2
)
SELECT user_id, AVG(last_page_exit - last_page_load)
FROM user_page_load
JOIN user_page_exit
USING (user_id, date)
GROUP BY user_id
