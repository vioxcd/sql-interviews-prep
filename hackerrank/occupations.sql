-- Link: https://www.hackerrank.com/challenges/occupations/problem
-- Level: Medium
-- Description: Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively. Note: Print NULL when there are no more names corresponding to an occupation.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/fc5de448-fcc0-424f-a15a-629d94b0b347
SELECT
  MAX(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
  MAX(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
  MAX(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
  MAX(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM
  (SELECT
    Occupation,
    Name,
    ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) rn
   FROM OCCUPATIONS
  ) o
GROUP BY rn
