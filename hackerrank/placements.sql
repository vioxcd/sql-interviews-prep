-- Link: https://www.hackerrank.com/challenges/placements
-- Level: Medium
-- Description: You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary. Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/dc43828d-83d2-4b61-a0b6-eb8393be15fc
select s.name
from students s  /* the student's name */
join friends f  /* their friends' id */
    on s.id = f.id
join packages ps  /* the student's salary */
    on s.id = ps.id
join packages pf  /* the student's friends' salary */
    on f.friend_id = pf.id
where pf.salary > ps.salary
order by pf.salary
