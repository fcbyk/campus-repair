-- 创建学生信息视图
create view student_information as
select user_id as sid, user_name as sname, user_gender as gender,user_phone as phone
from user_information where user_sort='student';

-- 创建教职工信息视图
create view staff_information as
select user_id as tid, user_name as tname, user_gender as gender,user_phone as phone
from user_information where user_sort='staff';

-- 创建维修师傅信息视图
create view repairMan_information as
select user_id as rid, user_name as rname, user_gender as gender,user_phone as phone
from user_information where user_sort='repairMan';

-- 创建简单用户信息视图，用于在测试账号板块
create view simple_account as 
select register.id, register.pw, user_information.user_name as name
from register,user_information 
where register.id = user_information.user_id;

-- 删除视图
drop view student_information;