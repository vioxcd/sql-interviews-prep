-- Link: https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices
-- Level: Hard
-- Description: You’re given a table of rental property searches by users. The table consists of search results and outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below: 0 reviews: New, 1 to 5 reviews: Rising, 6 to 15 reviews: Trending Up, 16 to 40 reviews: Popular, more than 40 reviews: Hot. Tip: The id column in the table refers to the search ID. You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews. Output host popularity rating and their minimum, average and maximum rental prices.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/3c67cff0-56be-4fb0-b957-d53d138ef08e
with
host_popularity_details as (
    select
        case
            when number_of_reviews = 0 then 'New'
            when number_of_reviews <= 5 then 'Rising'
            when number_of_reviews <= 15 then 'Trending Up'
            when number_of_reviews <= 40 then 'Popular'
            else 'Hot'
        end as host_popularity
        ,price
    from (
        select distinct
            price,
            room_type,
            host_since,
            zipcode,
            number_of_reviews
        from airbnb_host_searches
    ) t
)
select
    host_popularity
    ,min(price) as min_price
    ,avg(price) as avg_price
    ,max(price) as max_price
from host_popularity_details
group by host_popularity
