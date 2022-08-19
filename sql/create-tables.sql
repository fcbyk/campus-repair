-- 创建用户信息表
create table user_information(
	user_id varchar(20) primary key,
    user_name varchar(20) default '新用户',
    user_gender char check(user_gender in('男','女')),
    user_phone varchar(20) default '未绑定',
    user_sort varchar(10) check(user_sort in('student','staff','repairMan')) not null,
    user_addr varchar(50) default '未填写'
);

-- 创建账号信息表
create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan'))
);

-- 创建故障单信息表
create table repair_order(
	rnumber varchar(20) primary key,
    rsort varchar(10) check(rsort in('后勤报修','水表、一卡通','空调维修',
    '室内热水','楼道饮水机维修','消防','未选择')),
    f_equ varchar(20) not null,
    init_id varchar(20) not null,
    place varchar(50) not null,
    rtime datetime,
    rid varchar(20),
    note varchar(100),
    order_state varchar(10) 
    check(order_state in('派送中','以接单','已完成'))
    default '派送中'
);

-- 创建维修人员类别表
create table category(
    rid varchar(20) primary key,
    category varchar(10) 
    check(category in('后勤报修','水表、一卡通','空调维修',
    '室内热水','楼道饮水机维修','消防','未选择')) default '未选择'
);

-- 删除表,和查看表的创建信息
drop table user_information;
show create table register;

-- 往表插入数据
insert into register values('s123','123456','student');

-- 删除表中的某一条数据
delete from register where id='s123';

-- 清空数据表的所有数据
TRUNCATE TABLE register;
TRUNCATE TABLE user_information;

-- 选择查询
select * from register;
select pw from register where id='123';