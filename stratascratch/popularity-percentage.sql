-- Link: https://platform.stratascratch.com/coding/10284-popularity-percentage
-- Level: Hard
-- Description: Find the popularity percentage for each user on Meta/Facebook. The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100. Output each user along with their popularity percentage. Order records in ascending order by user id. The 'user1' and 'user2' column are pairs of friends.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/f6db5236-4027-4b4b-a48e-31b18424dc08
with
reordered_ff as (
    select user1, user2 from facebook_friends
    union
    select user2 as user1, user1 as user2 from facebook_friends
)

select
    user1,
    (count(1)::numeric /
        (select count(distinct user1) from reordered_ff)) * 100
        as popularity_percentage
from reordered_ff
group by 1
order by 1
