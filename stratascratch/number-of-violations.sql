-- Link: https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations
-- Level: Medium
-- Description: You're given a dataset of health inspections. Count the number of violation in an inspection in 'Roxanne Cafe' for each year. If an inspection resulted in a violation, there will be a value in the 'violation_id' column. Output the number of violations by year in ascending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/a2dc51ec-86ad-4240-bfea-aa969d759ee3
select
    extract(year from inspection_date) as year,
    count(violation_id) as number_of_violations
from sf_restaurant_health_violations
where business_name = 'Roxanne Cafe'
group by 1
order by 1 asc
