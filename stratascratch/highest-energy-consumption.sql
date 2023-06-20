-- Link: https://platform.stratascratch.com/coding/10064-highest-energy-consumption
-- Level: Medium
-- Description: Find the date with the highest total energy consumption from the Meta/Facebook data centers. Output the date along with the total energy consumption across all data centers.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/503cbacf-2b48-45e5-b641-a344cfbc6547
with
all_region as (
    select
        date,
        sum(consumption) as total_consumption
    from (
        select * from fb_eu_energy
        union all
        select * from fb_asia_energy
        union all
        select * from fb_na_energy
    ) t
    group by date
)
select
    date,
    total_consumption as highest_consumption
from all_region
where total_consumption = (select max(total_consumption) from all_region)
