-- Link: https://leetcode.com/problems/nth-highest-salary
-- Level: Medium
-- Description: Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/3bd9e5a3-6acc-4bb0-9bd9-1cf68bf6eaef
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      select distinct salary
      from (
          select
            salary,
            dense_rank() over (order by salary desc) as row_num
          from
            employee
      ) as t
      where row_num = N
  );
END
