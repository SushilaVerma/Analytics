select 

date(a.date) ||'_' || student_id as id, 
date(a.date) as date ,student_id,min(batch_id)as batch_id 
from (select student_id,batch_id,date(change_date) as date ,lead(date(change_date),1)
      over(partition by student_id order by change_date) as till  from prod.student_batch_log order by student_id  )main 
join analytics.date_list a on a.date between main.date and main.till 
where a.date >= date_add('day',-7,date(current_date))
group by 1,2 ,3
