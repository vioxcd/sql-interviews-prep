-- Link: https://www.hackerrank.com/challenges/print-prime-numbers
-- Level: Medium
-- Description: Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/30ae2acc-18d7-4353-a2d6-0a805be5063f
/* use Oracle */
with
x as (
    select level + 1 x
    from dual
    connect by level <= 1000
)
select

    listagg(x.x, '&') within group (order by x.x) as prime_numbers
from x
where not exists (
    select 1 from x y
    where x.x > y.x and remainder( x.x, y.x ) = 0
)
