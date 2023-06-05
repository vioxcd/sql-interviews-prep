-- Link: https://platform.stratascratch.com/coding/10300-premium-vs-freemium
-- Level: Medium
-- Description: Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.
-- Result: https://github.com/vioxcd/sql-interviews-prep/assets/31486724/74a3da1e-c510-4648-baae-ac5161f393b1
with
download_fct as (
    select
        date
        ,sum(case when paying_customer = 'no' then downloads else 0 end) as non_paying
        ,sum(case when paying_customer = 'yes' then downloads else 0 end) as paying
    from ms_user_dimension u
        join ms_acc_dimension a
            on u.acc_id = a.acc_id
        join ms_download_facts d
        on u.user_id = d.user_id
    group by date
    order by date asc
)
select *
from download_fct
where non_paying > paying
