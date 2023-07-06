
-- Automated in Hevo
select 
st.student_id||'_'||st.enrollment_no||'_'||COALESCE(st.session_id::VARCHAR, '') as key,
current_date as last_Updated_at,
st.student_id ,
st.enrollment_no,
st.student_name,
st.fname as father_name,
st.mname as Mother_name,
st.city_id,
st.state_id,
case when st.session_id=5 then '2023-2024'
when st.session_id=4 then '2022-2023'
when st.session_id=3 then '2021-2022'
when  st.session_id=2 then '2020-2021'
when st.session_id=0 then '0-2019-2020'
else 'Blank' end as Session_name,
--st.status as status,
case when st.status=7 then 'Active'
when st.status=8 then 'Inactive'
when st.status=9 then 'Enrolled'
else 'Blank' end as student_status,
case 
	when center_name_campus like '%DIGITAL%' then 'ONLINE'
	else 'OFFLINE' end as STUDENT_PLATFORM_TYPE ,
	st.dob,
	datediff('year', st.dob, CURRENT_DATE) AS student_age,
	st.gender,
st.stream,
st.class_value,-- to identify the course name use Stream and Class_value combination
st.course_id,
st.course_name,
st.course_original_name,
st.studycode,
st.batch_id,
st.batch_name,
st.center_name,
st.center_name_campus,
--st.batch_session,
CASE WHEN POSITION(',' IN st.center_name_campus) > 0 
         THEN SUBSTRING(st.center_name_campus, 1, POSITION(',' IN st.center_name_campus) - 1) 
         WHEN POSITION('-' IN st.center_name_campus) > 0
              THEN SUBSTRING(st.center_name_campus, 1, POSITION('-' IN st.center_name_campus) - 1) 
         ELSE st.center_name_campus 
    END AS CITY_name
from prod.student  st
