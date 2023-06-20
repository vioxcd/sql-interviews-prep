-- Link: https://platform.stratascratch.com/coding/9915-highest-cost-orders
-- Level: Medium
-- Description: Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date. For simplicity, you can assume that every first name in the dataset is unique.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/52066414-8e58-48da-93d1-d0802d1c2639
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
