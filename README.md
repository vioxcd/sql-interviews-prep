# Doing SQL interview prep in various platforms

Insert table here

Type: Strata Scratch, Leetcode, Hackerrank

Target: 55 (21 Katie's + 25 (first SQL Sundays initialization) + 9 (late May update))

Timeline:

- (1st April) It's first initialized in 11th October, and I need to catch up for 25 weeks as of this README is written
- (26th May) It's 8 or 9 weeks more now...

**Note: this README is generated.**

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

## Hard
## Others
