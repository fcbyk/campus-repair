use hntou_repair;

# 删除触发器
drop trigger new_register;
drop trigger delete_user;

# 删除存储过程
drop procedure alter_orders;
drop procedure alter_user_info;
drop procedure new_orders;

# 删除视图
drop view repairMan_information;
drop view simple_account;
drop view staff_information;
drop view student_information;
drop view tradition;

# 删除表
drop table category;
drop table register;
drop table repair_order;
drop table user_information;

# 删除数据库
drop database hntou_repair;