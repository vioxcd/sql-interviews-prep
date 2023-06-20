-- Link: https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1
-- Level: Medium
-- Description: You have been asked to find the job titles of the highest-paid employees. Your output should include the highest-paid title or multiple titles with the same salary.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0ebf6ebb-dbe7-4e52-9a8f-ac0530fd5562
select
	worker_title as best_paid_title
from worker
join title
	on worker.worker_id = title.worker_ref_id
where salary = (
    select max(salary)
    from worker
)
