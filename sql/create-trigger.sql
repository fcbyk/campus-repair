-- new_register触发器功能：账号关系表添加一条数据后，触发往用户信息表添加一条数据
-- 若该账号为维修师傅账号，往维修人员分类表添加一条新数据
DELIMITER //
create trigger new_register
after insert on register 
for each row
begin
insert into user_information(user_id,user_sort) value(new.id,new.sort);
if(LEFT(new.id,1) ='r')
then insert into category(rid) value(new.id);
end if;
end //
DELIMITER ;

-- new_register触发器功能：账号关系表删除一条数据后，触发用户信息表删除相关数据
-- 若该账号为维修师傅账号，同时删除维修人员分类表相关数据
DELIMITER //
create trigger delete_user
after delete on register 
for each row
begin
delete from user_information where user_id = old.id;
if(LEFT(old.id,1) ='r')
then delete from category where rid = old.id;
end if;
end //
DELIMITER ;

-- 查看系统触发器，和删除触发器
SHOW TRIGGERS;
DROP TRIGGER new_register;