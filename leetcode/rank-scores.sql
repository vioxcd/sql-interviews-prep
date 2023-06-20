-- Link: https://leetcode.com/problems/rank-scores/
-- Level: Medium
-- Description: Write an SQL query to rank the scores. The ranking should be calculated according to the following rules: 1) The scores should be ranked from the highest to the lowest. 2) If there is a tie between two scores, both should have the same ranking. 3) After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks. Return the result table ordered by score in descending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/494c18c0-0247-4cb9-b508-eacb62ea0610
SELECT score,
       dense_rank() OVER (ORDER BY score DESC) AS "rank"
FROM Scores
