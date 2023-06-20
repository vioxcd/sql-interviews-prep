-- Link: https://platform.stratascratch.com/coding/10354-most-profitable-companies?code_type=1 
-- Level: Medium
-- Description: Find the 3 most profitable companies in the entire world. Output the result along with the corresponding company name. Sort the result based on profits in descending order.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/230013e0-b1df-4d38-ab91-4f22674b040b
select company, sum(profits) as profits
from forbes_global_2010_2014
group by 1
order by 2 desc
limit 3
