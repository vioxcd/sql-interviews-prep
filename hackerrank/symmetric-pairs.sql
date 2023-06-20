-- Link: https://www.hackerrank.com/challenges/symmetric-pairs
-- Level: Medium
-- Description: You are given a table, Functions, containing two columns: X and Y. Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1. Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/7b12caa7-9cbf-4373-a8e4-30cddcce4c9b
with
with_id as (
    select
        *,
        row_number() over () as id
    from functions
)
select distinct least(f1.X, f2.X) as X, greatest(f2.X, f2.Y) as Y
from with_id f1
join with_id f2
    on f1.X = f2.Y
        and f1.Y = f2.X
        and f1.id != f2.id
order by 1, 2
