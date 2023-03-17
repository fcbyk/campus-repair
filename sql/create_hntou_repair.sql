/***** 创建数据库和选择数据库 *****/
create database hntou_repair;
use hntou_repair;

/*****
创建基本表
账号  (账号，登录密码，账号类别)
用户信息表 (用户id，姓名，性别，联系电话，人员类别, 地址)
故障单  (故障单号，维修分类号，故障设备名称，发起人员id，地点，接单人员id，备注，故障单状态，创建时间)
维修人员分类表（维修人员id，所属维修分类号）
*****/

# 账号信息表
create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan'))
);

# 用户信息表
create table user_information(
	user_id varchar(20) primary key,
    user_name varchar(20) default '新用户',
    user_gender char check(user_gender in('男','女')),
    user_phone varchar(20) default '未绑定',
    user_sort varchar(10) check(user_sort in('student','staff','repairMan')) not null,
    user_addr varchar(50) default '未填写'
);

# 创建故障单信息表
create table repair_order(
	rnumber varchar(20) primary key,
    rsort varchar(10) check(rsort in('后勤报修','水表、一卡通','空调维修',
    '室内热水','楼道饮水机维修','消防','未选择')),
    f_equ varchar(20) not null,
    init_id varchar(20) not null,
    place varchar(50) not null,
    rid varchar(20),
    note varchar(100),
    order_state varchar(10)
    check(order_state in('推送中','已接单','已完成'))
    default '推送中',
    rtime datetime,
    foreign key(init_id) references user_information(user_id),
    foreign key(rid) references user_information(user_id)
);

# 创建维修人员类别表
create table category(
    rid varchar(20) primary key,
    category varchar(10)
    check(category in('后勤报修','水表、一卡通','空调维修',
    '室内热水','楼道饮水机维修','消防','未选择')) default '未选择'
);

/***** 创建视图
学生信息 (sid,sname,gender,phone,addr)
教职工信息 (tid,tname,gender,phone,addr)
维修师傅信息(rid,rname,gender,phone,addr,category)
简单用户信息(id,pw,name)
传统报修电话信息(rid,category,name,phone)
*****/

# 创建学生信息视图
create view student_information as
select user_id as sid,
       user_name as sname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr
from user_information
where user_sort='student';

# 创建教职工信息视图
create view staff_information as
select user_id as tid,
       user_name as tname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr
from user_information
where user_sort='staff';

# 创建维修师傅信息视图
create view repairMan_information as
select rid, user_name as rname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr,
       category
from user_information,category
where user_id = rid;

# 创建简单用户信息视图，用于在测试账号板块
create view simple_account as
select register.id,
       register.pw,
       user_information.user_name as name
from register,user_information
where register.id = user_information.user_id;

# 创建传统报修板块所用的数据视图
create view tradition as
select rid,
       category,
       rname as name,
       phone
from repairMan_information;

/***** 创建索引 *****/
# create index register_index on register(id);
# create index user_information_index on user_information(user_id);
# create index repair_order_index on repair_order(rnumber);
# create index category_index on category(category);

/***** 创建触发器 *****/
# new_register 触发器功能
# 账号关系表添加一条数据后，触发往用户信息表添加一条数据，若该账号为维修人员账号，往维修人员分类表添加一条新数据
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

# new_register触发器功能
# 账号关系表删除一条数据后，触发用户信息表删除相关数据，若该账号为维修人员账号，同时删除维修人员分类表相关数据
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

/***** 存储过程 *****/
# 创建更改用户信息的存储过程
DELIMITER //
CREATE PROCEDURE alter_user_info(
    in uname varchar(20),
    in gender char,in phone varchar(20),
    in addr varchar(50),in id varchar(20),
    in categ varchar(10))
BEGIN
    update user_information
    set user_name = uname, user_gender= gender,
        user_phone= phone,user_addr = addr
    where user_id = id;
    if(LEFT(id,1) ='r')
    then update category set category = categ where rid = id;
    end if;
END //
DELIMITER ;

# 创建生成故障单的存储过程
DELIMITER //
CREATE PROCEDURE new_orders(
    in oid varchar(20),
    in sort varchar(20),in equ varchar(20),
    in uid varchar(20),in pla varchar(50),
    in onote varchar(100))
BEGIN
    insert into repair_order(rnumber,rsort,f_equ,init_id,place,note,creation_time)
    values(oid,sort,equ,uid,pla,onote,now());
END //
DELIMITER ;

# 创建修改故障单的存储过程
DELIMITER //
CREATE PROCEDURE alter_orders(
    in sort varchar(20),
    in equ varchar(20),in pla varchar(50),
    in onote varchar(100),in oid varchar(20))
BEGIN
    update repair_order set
    rsort=sort,f_equ=equ,place=pla,note=onote
    where rnumber = oid;
END //
DELIMITER ;
