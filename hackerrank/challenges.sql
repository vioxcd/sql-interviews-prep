-- Link: https://www.hackerrank.com/challenges/challenges
-- Level: Medium
-- Description: Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/d56013cc-d376-42b8-9cef-a34b705cd9f4
with
calculated_hacker_challenges as (
    select
        hacker_id, name, count(1) as total_challenges
    from hackers h
    join challenges c
        using (hacker_id)
    group by 1, 2
),

grouped_total_challenges as (
    select total_challenges
    from calculated_hacker_challenges
    where total_challenges < (
        select max(total_challenges) from calculated_hacker_challenges
    )
    group by total_challenges
    having count(1) > 1
)

select *
from calculated_hacker_challenges
where
    total_challenges not in (
        select total_challenges from grouped_total_challenges
    )
order by total_challenges desc, hacker_id asc
