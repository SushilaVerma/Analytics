--12th July 2023

-- created by Anuj

select date_add('day',-1*number ,current_date) as date  from analytics.number_list  order by 1 desc
