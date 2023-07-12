--12-07-2023
-- Created by Anuj

select *,case when sum(present) over(partition by test_id ) > 0 then 1 else 0 end  as valid_test 
from 
(select main.*, case when a.student_id is null then 0 else 1 end as present,
  a.start_time as student_start_time, 

a.total_marks as student_marks,correct_marks,negative_marks,left_marks,pro_time,unpro_time,idle_time,total_time,cbt, right_que,wrong,left_que 


from (select main.test_id,
main.test_name,
main.test_description,
main.total_question,
main.difficulty_level,
main.start_date,
main.end_time,
main.start_time,
main.duration,
main.free_test,
main.test_type,
main.instruction,
main.benchmark,
main.publish,
main.total_marks,
main.end_date,
main.section,
main.test_answer,
main.lab,
main.test_flag,
main.test_slot,
main.category,
main.template,
main.client_id,
main.test_code,
main.centre,
main.campus,
main.course,
main.batch,
main.stream,
main.class,
main.mode,
main.paper_code,
main.review,
main.question_stream,
main.pattern,
main.lang1,
main.lang2,a.student_id,a.center_name,a.center_name_campus,a.bid as batch_id  from prod.test main 
join (select a.*,b.date,b.batch_id as bid from prod.student a 

join analytics.raw_student_date_batch_mapping b on b.student_id = a.student_id )a 

 on 
 a.date = date(main.start_date) and 
 a.center_name = main.centre 
and a.stream = main.stream 
and  (','||main.course||','  like '%,'||a.course_id||',%'   or main.course is null ) 
and 
(','||main.batch||','  like '%,'||a.bid||',%'   or main.batch is null ) 

and 
(','||main.campus||','  like '%,'||a.studycode||',%'   or main.campus is null ) 
where main.start_date >= date_add('day',-7,date(current_date))
)main 

left join  
(select student_id,test_id, total_marks,correct_marks,negative_marks,left_marks,pro_time,unpro_time,idle_time,total_time,cbt,start_time, right_que,wrong,left_que 
from (select *,row_number() over(partition by student_id,test_id order by exam_date ) as r  from prod.result_examination) where r =1 )a on a.test_id = main.test_id and a.student_id = main.student_id )
