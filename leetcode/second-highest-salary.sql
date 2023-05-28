-- Link: https://leetcode.com/problems/second-highest-salary/description/
-- Level: Medium
-- Description: Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/14219d4a-480b-40ed-920f-c4ba4e4d1483
SELECT MAX(salary) AS "SecondHighestSalary"
FROM Employee
WHERE salary NOT IN (
  SELECT MAX(salary)
  FROM Employee
)
