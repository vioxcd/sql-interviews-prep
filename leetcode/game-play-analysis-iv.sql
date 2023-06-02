-- Link: https://leetcode.com/problems/game-play-analysis-iv
-- Level: Medium
-- Description: Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0e04b110-5cdb-4782-8d55-4871f2d0a8b3
with
earliest_login as (
    select
        player_id,
        date(str_to_date(min(event_date), '%Y-%m-%d')) as event_date
    from activity
    group by 1
)

select
    round(count(1) / (select count(1) from earliest_login), 2) as fraction
from earliest_login a1
join activity a2
    on a1.player_id = a2.player_id
        and a1.event_date = a2.event_date - INTERVAL 1 DAY
