-- Link: https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1
-- Level: Medium
-- Description: Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/88461faa-9f53-4923-8e91-37d9ca3d12c5
with time_lag as (
    select user_id,
        case when(created_at - LAG(created_at)
            over(partition by user_id order by created_at) <= 7)
            then True
            else False
        end as is_returning
    from amazon_transactions
    order by user_id, created_at
)
select distinct user_id
from time_lag
where is_returning
order by 1
