-- Link: https://leetcode.com/problems/second-highest-salary/description/
-- Level: Medium
-- Description: Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/3e89d5c6-aebb-41b0-b7d7-6eedc87916c7
SELECT MAX(salary) AS "SecondHighestSalary"
FROM Employee
WHERE salary NOT IN (
  SELECT MAX(salary)
  FROM Employee
)
