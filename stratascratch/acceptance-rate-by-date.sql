-- Link: https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1
-- Level: Medium
-- Description: What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest. Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/002627e7-725f-4990-8ec6-0a99ab92f37f
with
count_per_date AS (
    select
        date,
        sum(
            case when action = 'sent' then 1 else 0 end
        ) as fr_sent,
        sum(
            case when action = 'sent' and lead is not null then 1 else 0 end
        ) as fr_accepted
    from (
        select
            *,
            lead(action) over (partition by user_id_sender, user_id_receiver)
        from fb_friend_requests fr
    ) t
    group by date
)
select
    date,
    fr_accepted::float / fr_sent::float as percentage_acceptance
from count_per_date
where fr_accepted > 0
order by date asc
