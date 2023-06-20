-- Link: https://www.hackerrank.com/challenges/harry-potter-and-wands
-- Level: Medium
-- Description: Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/5aa08d2e-8a34-43a6-8340-1257c4ee966d
select
    w.id, wp.age, w.coins_needed, w.power
from wands w
left join wands_property wp
    using(code)
where wp.is_evil = 0
    and w.coins_needed = (
        select min(w1.coins_needed)
        from wands w1
        where w1.code = w.code
            and w1.power = w.power
    )
order by w.power desc, wp.age desc
