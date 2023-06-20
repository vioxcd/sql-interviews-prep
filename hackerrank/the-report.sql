-- Link: https://www.hackerrank.com/challenges/the-report
-- Level: Medium
-- Description: Given two table Students and Grade, generate a report containing three columns: Name, Grade and Mark. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/fd8d2f4d-55ba-4642-b4cb-666099cb8349
select
    case when g.grade < 8 then 'NULL' else s.name end as name,
    g.grade,
    s.marks
from students s
    join grades g
    on s.marks between g.min_mark and g.max_mark
order by g.grade desc, s.name, s.marks
