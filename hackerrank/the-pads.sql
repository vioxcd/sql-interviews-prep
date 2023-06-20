-- Link: https://www.hackerrank.com/challenges/the-pads/problem
-- Level: Medium
-- Description: Generate the following two result sets: 1) Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S). 2) Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: "There are a total of [occupation_count] [occupation]s." where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/1da8e178-0154-41ae-b092-b52fa3b78c5b
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') AS t
FROM OCCUPATIONS
UNION ALL
SELECT CONCAT("There are a total of ", COUNT(Occupation), " ", LOWER(Occupation), "s.") AS t
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY t
