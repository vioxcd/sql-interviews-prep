-- Link: https://platform.stratascratch.com/coding/9782-customer-revenue-in-march
-- Level: Medium
-- Description: Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019. Output the revenue along with the customer id and sort the results based on the revenue in descending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/60e6053d-0cf5-4a7a-b08b-1e858c3b1434
select
    cust_id
    ,sum(total_order_cost) as revenue
from orders
where extract(month from order_date) = 3
group by 1
order by 2 desc
