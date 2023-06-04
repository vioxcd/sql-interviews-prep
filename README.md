# Doing SQL interview prep in various platforms

Mostly randomly doing problems here and there, and sometimes following [this DE study guide](https://docs.google.com/spreadsheets/d/1GOO4s1NcxCR8a44F0XnsErz5rYDxNbHAHznu4pJMRkw/edit#gid=0)

**Note: this README is generated**

## Table of Contents

- [Easy](#easy)

- [Medium](#medium)

- [Hard](#hard)

- [Others](#others)
## Easy

### Stratascratch | Salaries Difference

[Question:](https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1) Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

```sql
select
    abs(
        max(case when d.department = 'marketing' then e.salary else 0 end)
		- max(case when d.department = 'engineering' then e.salary else 0 end)
   ) salary_diff
from db_employee e
join db_dept d
	on e.department_id = d.id
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0e9e1d02-83ac-43ab-951d-452e4a4a2925)


## Medium

### Leetcode | Consecutive Numbers

[Question:](https://leetcode.com/problems/consecutive-numbers/) Write an SQL query to find all numbers that appear at least three times consecutively. Return the result table in any order.

```sql
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
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/d4098dc5-c9a4-4f09-994a-f0aa50fa0522)



### Leetcode | Department Highest Salary

[Question:](https://leetcode.com/problems/department-highest-salary/) Write an SQL query to find employees who have the highest salary in each of the departments. Return the result table in any order.

```sql
WITH salary_ranked AS (
  SELECT e.id
         , rank() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
  FROM Employee e
)
SELECT d.name AS Department
       , e.name AS Employee
       , e.salary AS Salary
FROM Employee e
INNER JOIN Department d
  ON e.departmentId = d.id
INNER JOIN salary_ranked sr
  ON e.id = sr.id
WHERE sr.salary_rank = 1
ORDER BY e.name
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/b794ab94-d25b-4f3c-9fe6-8bac5f01f135)



### Leetcode | Exchange Seats

[Question:](https://leetcode.com/problems/exchange-seats) (**Broken test case**). Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped. Return the result table ordered by id in ascending order.

```sql
with
id_mod_id as (
  select id, student, id + mod(id, 2) as cc
  from seat
)
select
  row_number() over (order by cc, id desc) as id, student
from id_mod_id
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/dfd146ef-4ab5-4dbd-ae00-a0329b84c6fa)



### Leetcode | Game Play Analysis Iv

[Question:](https://leetcode.com/problems/game-play-analysis-iv) Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

```sql
with
earliest_login as (
    select
        player_id,
        date(str_to_date(min(event_date), '%Y-%m-%d')) as event_date
    from activity
    group by 1
)

select
    round(count(1) / (select count(1) from earliest_login), 2) as fraction
from earliest_login a1
join activity a2
    on a1.player_id = a2.player_id
        and a1.event_date = a2.event_date - INTERVAL 1 DAY
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0e04b110-5cdb-4782-8d55-4871f2d0a8b3)



### Leetcode | Nth Highest Salary

[Question:](https://leetcode.com/problems/nth-highest-salary) Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

```sql
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
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/c98af11c-2db2-4361-879b-2f37dd6a0df0)



### Leetcode | Rank Scores

[Question:](https://leetcode.com/problems/rank-scores/) Write an SQL query to rank the scores. The ranking should be calculated according to the following rules: 1) The scores should be ranked from the highest to the lowest. 2) If there is a tie between two scores, both should have the same ranking. 3) After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks. Return the result table ordered by score in descending order.

```sql
SELECT score,
       dense_rank() OVER (ORDER BY score DESC) AS "rank"
FROM Scores
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/51422fbf-2248-4afc-82b7-48c729258267)



### Leetcode | Second Highest Salary

[Question:](https://leetcode.com/problems/second-highest-salary/description/) Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

```sql
SELECT MAX(salary) AS "SecondHighestSalary"
FROM Employee
WHERE salary NOT IN (
  SELECT MAX(salary)
  FROM Employee
)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/14219d4a-480b-40ed-920f-c4ba4e4d1483)



### Stratascratch | Acceptance Rate By Date

[Question:](https://platform.stratascratch.com/coding/10285-acceptance-rate-by-date?code_type=1) What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest. Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.

```sql
with
count_per_date AS (
    select
        date,
        sum(
            case when action = 'sent' then 1 else 0 end
       ) as fr_sent,
        sum(
            case when action = 'sent' and lead is not null then 1 else 0 end
       ) as fr_accepted
    from (
        select
            *,
            lead(action) over (partition by user_id_sender, user_id_receiver)
        from fb_friend_requests fr
   ) t
    group by date
)
select
    date,
    fr_accepted::float / fr_sent::float as percentage_acceptance
from count_per_date
where fr_accepted > 0
order by date asc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/c8587757-4d33-456e-b492-a4aee462c5ed)



### Stratascratch | Customer Revenue In March

[Question:](https://platform.stratascratch.com/coding/9782-customer-revenue-in-march) Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019. Output the revenue along with the customer id and sort the results based on the revenue in descending order.

```sql
select
    cust_id
    ,sum(total_order_cost) as revenue
from orders
where extract(month from order_date) = 3
group by 1
order by 2 desc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/142a0279-2f64-416b-bcbf-75046ffd1f59)



### Stratascratch | Finding User Purchases

[Question:](https://platform.stratascratch.com/coding/10322-finding-user-purchases?code_type=1) Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.

```sql
with time_lag as (
    select user_id,
        case when(created_at - LAG(created_at)
            over(partition by user_id order by created_at) <= 7)
            then True
            else False
        end as is_returning
    from amazon_transactions
    order by user_id, created_at
)
select distinct user_id
from time_lag
where is_returning
order by 1
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/fd71ca58-1d02-499e-9a92-f2accdf6cc29)



### Stratascratch | Highest Cost Orders

[Question:](https://platform.stratascratch.com/coding/9915-highest-cost-orders) Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date. For simplicity, you can assume that every first name in the dataset is unique.

```sql
with
calculated_order_cost as (
    select
        c.first_name
        ,o.order_date
        ,sum(o.total_order_cost) as total_order_cost
    from customers c
    join orders o
        on c.id = o.cust_id
    where o.order_date between '2019-02-01' and '2019-05-01'
    group by c.first_name, o.order_date
)

select
    first_name
    ,total_order_cost as highest_total_order_cost
    ,order_date
from calculated_order_cost
where total_order_cost = (select max(total_order_cost) from calculated_order_cost)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/f6668553-d7fe-4f21-b756-2514cd363d9e)



### Stratascratch | Highest Energy Consumption

[Question:](https://platform.stratascratch.com/coding/10064-highest-energy-consumption) Find the date with the highest total energy consumption from the Meta/Facebook data centers. Output the date along with the total energy consumption across all data centers.

```sql
with
all_region as (
    select
        date,
        sum(consumption) as total_consumption
    from (
        select * from fb_eu_energy
        union all
        select * from fb_asia_energy
        union all
        select * from fb_na_energy
   ) t
    group by date
)
select
    date,
    total_consumption as highest_consumption
from all_region
where total_consumption = (select max(total_consumption) from all_region)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/c7f974bf-03fc-4209-9c12-f308843ec1ab)



### Stratascratch | Most Profitable Companies

[Question:](https://platform.stratascratch.com/coding/10354-most-profitable-companies?code_type=1) Find the 3 most profitable companies in the entire world. Output the result along with the corresponding company name. Sort the result based on profits in descending order.

```sql
select company, sum(profits) as profits
from forbes_global_2010_2014
group by 1
order by 2 desc
limit 3
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/5733e1f9-fda6-4f04-ad3c-a2fad8e277e8)



### Stratascratch | Number Of Violations

[Question:](https://platform.stratascratch.com/coding/9728-inspections-that-resulted-in-violations) You're given a dataset of health inspections. Count the number of violation in an inspection in 'Roxanne Cafe' for each year. If an inspection resulted in a violation, there will be a value in the 'violation_id' column. Output the number of violations by year in ascending order.

```sql
select
    extract(year from inspection_date) as year,
    count(violation_id) as number_of_violations
from sf_restaurant_health_violations
where business_name = 'Roxanne Cafe'
group by 1
order by 1 asc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/a2dc51ec-86ad-4240-bfea-aa969d759ee3)



### Stratascratch | Reviews Of Categories

[Question:](https://platform.stratascratch.com/coding/10049-reviews-of-categories) Find the top business categories based on the total number of reviews. Output the category along with the total number of reviews. Order by total reviews in descending order.

```sql
;select
    unnest(string_to_array(categories, ';')) as category
    ,sum(review_count) as category_review_count
from yelp_business
group by 1
order by 2 desc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/d4a2c63e-30c4-48e9-b4f7-146e82c7c413)



### Stratascratch | Users By Average Session Time

[Question:](https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?code_type=1) Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time.

```sql
WITH user_page_load AS (
    SELECT user_id,
        DATE(timestamp),
        MAX(timestamp) last_page_load
    FROM facebook_web_log
    WHERE action = 'page_load'
    GROUP BY 1, 2
), user_page_exit AS (
    SELECT user_id,
        DATE(timestamp),
        MAX(timestamp) AS last_page_exit
    FROM facebook_web_log
    WHERE action = 'page_exit'
    GROUP BY 1, 2
)
SELECT user_id, AVG(last_page_exit - last_page_load)
FROM user_page_load
JOIN user_page_exit
USING (user_id, date)
GROUP BY user_id
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/589f3f37-3a2c-40b6-90ac-e5e84a66fa87)



### Stratascratch | Workers With The Highest Salaries

[Question:](https://platform.stratascratch.com/coding/10353-workers-with-the-highest-salaries?code_type=1) You have been asked to find the job titles of the highest-paid employees. Your output should include the highest-paid title or multiple titles with the same salary.

```sql
select
	worker_title as best_paid_title
from worker
join title
	on worker.worker_id = title.worker_ref_id
where salary = (
    select max(salary)
    from worker
)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/db8ff651-4dd0-46ec-b733-74a8008ebff4)



### Hackerrank | Binary Search Tree 1

[Question:](https://www.hackerrank.com/challenges/binary-search-tree-1) You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N. Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node: Root: If node is root node. Leaf: If node is leaf node. Inner: If node is neither root nor leaf node.

```sql
select distinct
    bst1.n,
    case
        when bst1.p is null then 'Root'
        when bst2.p is null then 'Leaf'
        else 'Inner'
    end as node_type
from bst bst1
left join bst bst2
    on bst1.n = bst2.p
order by bst1.n
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/e229b0f7-48a5-4770-b7a3-3def71316d20)



### Hackerrank | Challenges

[Question:](https://www.hackerrank.com/challenges/challenges) Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

```sql
with
calculated_hacker_challenges as (
    select
        hacker_id, name, count(1) as total_challenges
    from hackers h
    join challenges c
        using (hacker_id)
    group by 1, 2
),

grouped_total_challenges as (
    select total_challenges
    from calculated_hacker_challenges
    where total_challenges < (
        select max(total_challenges) from calculated_hacker_challenges
   )
    group by total_challenges
    having count(1) > 1
)

select *
from calculated_hacker_challenges
where
    total_challenges not in (
        select total_challenges from grouped_total_challenges
   )
order by total_challenges desc, hacker_id asc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/d56013cc-d376-42b8-9cef-a34b705cd9f4)



### Hackerrank | Harry Potter And Wands

[Question:](https://www.hackerrank.com/challenges/harry-potter-and-wands) Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

```sql
select
    w.id, wp.age, w.coins_needed, w.power
from wands w
left join wands_property wp
    using(code)
where wp.is_evil = 0
    and w.coins_needed = (
        select min(w1.coins_needed)
        from wands w1
        where w1.code = w.code
            and w1.power = w.power
   )
order by w.power desc, wp.age desc
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/a0f653d5-ea93-4eb0-9464-3e082b8f9cf4)



### Hackerrank | Occupations

[Question:](https://www.hackerrank.com/challenges/occupations/problem) Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively. Note: Print NULL when there are no more names corresponding to an occupation.

```sql
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
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/fc5de448-fcc0-424f-a15a-629d94b0b347)



### Hackerrank | Placements

[Question:](https://www.hackerrank.com/challenges/placements) You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary. Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

```sql
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
```

![Result]()



### Hackerrank | Print Prime Numbers

[Question:](https://www.hackerrank.com/challenges/print-prime-numbers) Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (DESCRIPTION) character as your separator (instead of a space).

```sql
/* use Oracle */
with
x as (
    select level + 1 x
    from dual
    connect by level <= 1000
)
select

    listagg(x.x, 'QUERY') within group (order by x.x) as prime_numbers
from x
where not exists (
    select 1 from x y
    where x.x > y.x and remainder( x.x, y.x) = 0
)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/2f5a4045-3117-4f23-9890-14d0522973fc)



### Hackerrank | Symmetric Pairs

[Question:](https://www.hackerrank.com/challenges/symmetric-pairs) You are given a table, Functions, containing two columns: X and Y. Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1. Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

```sql
with
with_id as (
    select
        *,
        row_number() over () as id
    from functions
)
select distinct least(f1.X, f2.X) as X, greatest(f2.X, f2.Y) as Y
from with_id f1
join with_id f2
    on f1.X = f2.Y
        and f1.Y = f2.X
        and f1.id != f2.id
order by 1, 2
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/7a730fb9-3fb3-4970-a4f5-be0591a79ef0)



### Hackerrank | The Pads

[Question:](https://www.hackerrank.com/challenges/the-pads/problem) Generate the following two result sets: 1) Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S). 2) Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: "There are a total of [occupation_count] [occupation]s." where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

```sql
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') AS t
FROM OCCUPATIONS
UNION ALL
SELECT CONCAT("There are a total of ", COUNT(Occupation), " ", LOWER(Occupation), "s.") AS t
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY t
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/87374307-9d95-45e5-8ed8-045c7b325d4d)



### Hackerrank | The Report

[Question:](https://www.hackerrank.com/challenges/the-report) Given two table Students and Grade, generate a report containing three columns: Name, Grade and Mark. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

```sql
select
    case when g.grade < 8 then 'NULL' else s.name end as name,
    g.grade,
    s.marks
from students s
    join grades g
    on s.marks between g.min_mark and g.max_mark
order by g.grade desc, s.name, s.marks
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/b3bc7c6b-8060-43fc-9c03-aafa57029925)



### Hackerrank | Weather Observation 18

[Question:](https://www.hackerrank.com/challenges/weather-observation-station-18) Consider P1(a, b) and P2(c, d) to be two points on a 2D plane: a happens to equal the minimum value in Northern Latitude (LAT_N in STATION). b happens to equal the minimum value in Western Longitude (LONG_W in STATION). c happens to equal the maximum value in Northern Latitude (LAT_N in STATION). d happens to equal the maximum value in Western Longitude (LONG_W in STATION). Query the Manhattan Distance between points P1 and P2 and and round it to a scale of 4 decimal places.

```sql
SELECT
    ROUND(
        ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W))
    , 4)
FROM station
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/8be3ddf6-cdf5-46e8-b2b4-3a5c19c80a88)



### Hackerrank | Weather Observation 19

[Question:](https://www.hackerrank.com/challenges/weather-observation-station-19) Consider P1(a, b) and P2(c, d) to be two points on a 2D plane: a happens to equal the minimum value in Northern Latitude (LAT_N in STATION). b happens to equal the minimum value in Western Longitude (LONG_W in STATION). c happens to equal the maximum value in Northern Latitude (LAT_N in STATION). d happens to equal the maximum value in Western Longitude (LONG_W in STATION). Query the Eucliedean Distance between points P1 and P2 and and round it to a scale of 4 decimal places.

```sql
SELECT
    /*
    MIN(LAT_N) AS a,
    MAX(LAT_N) AS b,
    MIN(LONG_W) AS c,
    MAX(LONG_W) AS d
    */
    ROUND(
        SQRT(
            POW(MAX(LAT_N) - MIN(LAT_N), 2)
            +
            POW(MAX(LONG_W) - MIN(LONG_W), 2)
       )
        , 4
   )
FROM station
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0d58ecb2-8e76-4f61-966e-ba1069692a8c)


## Hard

### Leetcode | Department Top Three Salaries

[Question:](https://leetcode.com/problems/department-top-three-salaries/) A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department. Write an SQL query to find the employees who are high earners in each of the departments. Return the result table in any order.

```sql
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
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/5cebe467-51fb-4106-b520-48dc3dd0f18b)



### Leetcode | Human Traffic Of Stadium

[Question:](https://leetcode.com/problems/human-traffic-of-stadium/) Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each. Return the result table ordered by visit_date in ascending order.

```sql
WITH
filtered AS (
    SELECT
        *
    FROM Stadium
    WHERE people >= 100
),
ordered_id AS (
    SELECT
        *,
        id - ROW_NUMBER() OVER (ORDER BY id) AS id_ordering
    FROM filtered
)
SELECT id, visit_date, people
FROM ordered_id
WHERE id_ordering IN (
    SELECT id_ordering
    FROM ordered_id
    GROUP BY 1
    HAVING COUNT(1) >= 3
)
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/0fffaecc-1f19-4255-8e2d-55ccacfe66f0)



### Leetcode | Trips And Users

[Question:](https://leetcode.com/problems/trips-and-users/) The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day. Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points. Return the result table in any order.

```sql
SELECT
    t.request_at AS Day,
    ROUND(
        SUM(
            CASE
                WHEN status = 'completed' THEN 0
                ELSE 1
            END
       ) / COUNT(*)
    , 2) AS 'Cancellation Rate'
FROM Trips t
    INNER JOIN Users uc
        ON t.client_id = uc.users_id
    INNER JOIN Users ud
        ON t.driver_id = ud.users_id
WHERE
    uc.banned = 'No' AND ud.banned = 'No'
    AND uc.role = 'client' AND ud.role = 'driver'
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY
    request_at
ORDER BY
    Day ASC
```

![Result](https://github.com/vioxcd/sql-interviews-prep/assets/31486724/1a1d05b2-eca1-4986-8073-eca2d8e25836)


## Others

### Caltech DE Exercises

Link to Caltech DE Exercises repo

### CMU Database SQL Assignment

A homework from [Carnegie Mellon University Database Course (Fall 2021)](https://15445.courses.cs.cmu.edu). I used this to refresh my SQL knowledge and certain advanced SQL features I didn't know before. Also, learned to use SQLite which I found to be really useful later on. There's a [video lecture to learn the materials](https://youtu.be/B2fWjPGh-EU) before working on this homework

