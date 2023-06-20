-- Link: https://platform.stratascratch.com/coding/10049-reviews-of-categories
-- Level: Medium
-- Description: Find the top business categories based on the total number of reviews. Output the category along with the total number of reviews. Order by total reviews in descending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/d205b9a5-177b-459c-b1bb-22ac78262c46
;select
    unnest(string_to_array(categories, ';')) as category
    ,sum(review_count) as category_review_count
from yelp_business
group by 1
order by 2 desc
