-- Link: https://platform.stratascratch.com/coding/10319-monthly-percentage-difference
-- Level: Hard
-- Description: Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year. The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / by last month's revenue) * 100.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/faf298cf-4109-44cd-a15a-2ea98f73358a
with
augmented_transactions as (
    select
        date_trunc('month', created_at) as year_month
        ,sum(value) as revenue
        ,lag(sum(value)) over (order by date_trunc('month', created_at)) as last_month_revenue
    from sf_transactions
    group by date_trunc('month', created_at)
)

select
    concat_ws('-', extract(year from year_month), lpad(extract(month from year_month)::text, 2, '0')) as year_month_format
    ,round(
        ((revenue - last_month_revenue)::numeric / last_month_revenue) * 100, 2
    ) as revenue_diff_pct
from augmented_transactions
order by year_month
