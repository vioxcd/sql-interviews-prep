-- Link: https://leetcode.com/problems/department-highest-salary/
-- Level: Medium
-- Description: Write an SQL query to find employees who have the highest salary in each of the departments. Return the result table in any order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/b794ab94-d25b-4f3c-9fe6-8bac5f01f135
WITH salary_ranked AS (
  SELECT e.id
         , rank() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
  FROM Employee e
)
SELECT d.name AS Department
       , e.name AS Employee
       , e.salary AS Salary
FROM Employee e
INNER JOIN Department d
  ON e.departmentId = d.id
INNER JOIN salary_ranked sr
  ON e.id = sr.id
WHERE sr.salary_rank = 1
ORDER BY e.name
