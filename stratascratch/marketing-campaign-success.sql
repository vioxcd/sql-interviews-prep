-- Link: https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced
-- Level: Hard
-- Description: You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign. The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/447fa27b-5bc3-430a-9245-893f827f9361
with
known_first_purchase_date as (
    select
        user_id
        ,created_at
        ,product_id
        ,first_value(created_at) over (partition by user_id
                                        order by created_at)
                                        as first_purchase_date
    from marketing_campaign
),

products_bought_in_first_purchase_date as (
    select
        user_id
        ,array_agg(product_id) as bought_products
    from known_first_purchase_date
    where created_at = first_purchase_date
    group by user_id
)

select
    count (distinct user_id)
from known_first_purchase_date fpd
    join products_bought_in_first_purchase_date pfpd
    using (user_id)
where
    fpd.created_at > fpd.first_purchase_date
    and not product_id = any(bought_products)
