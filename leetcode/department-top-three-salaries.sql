-- Link: https://leetcode.com/problems/department-top-three-salaries/
-- Level: Hard
-- Description: A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department. Write an SQL query to find the employees who are high earners in each of the departments. Return the result table in any order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/671b9b52-db88-4ab5-88d0-f20ed6cc53e3
WITH salary_ranks AS (
  SELECT d.name AS Department,
         e.name AS Employee,
         e.salary AS Salary,
         dense_rank() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) ranks
  FROM Employee e
    INNER JOIN Department d
    ON e.departmentId = d.id
)
SELECT Department, Employee, Salary
FROM salary_ranks
WHERE ranks <= 3
ORDER BY Department, Salary
