-- Link: https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1
-- Level: Easy
-- Description: Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0e9e1d02-83ac-43ab-951d-452e4a4a2925
select
    abs(
        max(case when d.department = 'marketing' then e.salary else 0 end)
		- max(case when d.department = 'engineering' then e.salary else 0 end)
    ) salary_diff
from db_employee e
join db_dept d
	on e.department_id = d.id