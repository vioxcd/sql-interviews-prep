-- Link: https://leetcode.com/problems/exchange-seats
-- Level: Medium
-- Description: (**Broken test case**). Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped. Return the result table ordered by id in ascending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/e562ba48-70e5-4440-9e63-fd2a9b47e392
with
id_mod_id as (
  select id, student, id + mod(id, 2) as cc
  from seat
)
select
  row_number() over (order by cc, id desc) as id, student
from id_mod_id
