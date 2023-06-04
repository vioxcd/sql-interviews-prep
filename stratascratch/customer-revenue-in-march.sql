-- Link: https://platform.stratascratch.com/coding/9782-customer-revenue-in-march
-- Level: Medium
-- Description: Calculate the total revenue from each customer in March 2019. Include only customers who were active in March 2019. Output the revenue along with the customer id and sort the results based on the revenue in descending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/142a0279-2f64-416b-bcbf-75046ffd1f59
select
    cust_id
    ,sum(total_order_cost) as revenue
from orders
where extract(month from order_date) = 3
group by 1
order by 2 desc
