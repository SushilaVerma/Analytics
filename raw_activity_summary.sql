-- 12th July 2023
-- Created by Anuj


select student_id || '_'||log_date as id, student_id,log_date, 
count( case when page_name = 'Doubt Solution' then 1 else null end ) as doubt_solution,
count( case when page_name = 'Excercise Solution' then 1 else null end ) as excercise_solution,
count( case when page_name = 'Test Report Page' then 1 else null end ) as test_report_page,
count( case when page_name = 'Password' then 1 else null end ) as password,
count( case when page_name = 'Change Password' then 1 else null end ) as change_password,
count( case when page_name = 'Choose Course' then 1 else null end ) as choose_course,
count( case when page_name = 'Solution Report' then 1 else null end ) as solution_report,
count( case when page_name = 'Login' then 1 else null end ) as login,
count( case when page_name = 'Notice Board' then 1 else null end ) as notice_board,
count( case when page_name = 'Help & Support' then 1 else null end ) as help_support,
count( case when page_name = 'Test Videos' then 1 else null end ) as test_videos,
count( case when page_name = 'Test Start' then 1 else null end ) as test_start,
count( case when page_name = 'Schedule' then 1 else null end ) as schedule,
count( case when page_name = 'Digital Material' then 1 else null end ) as digital_material

 from allen_digital_reporting.activity_log main 
join allen_digital_reporting.event_activity_log  a on a.id = main.event_id 
where log_date >= date_add('day',-7,date(current_date))
 group by 1 ,2 ,3
