-- Link: https://leetcode.com/problems/consecutive-numbers/
-- Level: Medium
-- Description: Write an SQL query to find all numbers that appear at least three times consecutively. Return the result table in any order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/f483413a-8501-4bfd-9c75-5370e7ea2f25
WITH stats AS (
  SELECT num,
         min(num) OVER three_consecutives AS min_num,
         max(num) OVER three_consecutives AS max_num,
         sum(num) OVER three_consecutives AS sum_num
  FROM Logs
  WINDOW three_consecutives AS
    (ORDER BY id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
)
SELECT DISTINCT num AS ConsecutiveNums
FROM stats
WHERE min_num = max_num AND (num * 3) = sum_num
