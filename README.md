本系统为大三暑期的数据库课程设计

**摘  要：** 随着移动互联网的普及，我们的手机可以帮助我们完成很多事情。互联网好像覆盖了我们生活的方方面面，但其实并没有。比如学校的设备坏了，需要打电话去报修，存在很多不足，下文概述会详细阐述。我对此，开发了一个线上报修系统，去解决电话报修的不足。本文详细地描述了该系统的数据库设计过程
# 1 概述
学校的寝室设备报修，总是以电话打给维修人员。不同的设备坏了，要打不同的电话，打电话报修，维修人员需要用笔去记录，某学生公寓，几几号寝室，几号床下铺的电源坏了。效率很低。我们打电话时还得尽可能表达的清楚些。有的时候电话还打不通，还得去避开休息时间打电话。
当然其中也存在一些小优化，比如有个别维修人员叫我们给他们发短信，说清楚某学生公寓，几几号寝室，什么东西坏了。但是这样也不够好，对于维修人员而言，信息多了容易乱。
可以写一个管理系统，去解决这个问题。学生报修，只需要在管理系统上进行填写报修信息和类别。报修内容会推送给维修人员，维修人员也可以在底下留言，什么时候过去维修。
![image](https://github.com/fcbyk/campus-repair/assets/101487905/b87d4fac-f05e-43c1-aa01-0830379b2c4e)

# 2 需求分析
## 2.1系统处理功能及描述
热海大报修管理系统的主要功能是报修和维修。学生和维修人员初次使用该系统都需要注册一个账号，维修人员需要关联所属维修领域，以方便故障单推送。
学生端的报修系统功能分为：电话查询，故障上报，故障单更改，个人信息更改
维修端的报修系统功能分为：故障单推送，管理故障单，信息统计，个人信息更改

1. 故障上报时需要为故障单生成故障单号。故障单的内容包括维修分类目录号，故障设备名称，联系人，地点，故障描述，完成状态，故障单创建时间，接单时间，完成时间。
2. 维修人员如果觉得有其他事情无法及时维修，取消故障单，让其他维修人员接单
3. 维修完成后，维修人员需要更改故障单的完成状态，完成的故障单会自动进入历史故障单，以方便后续查询，和信息统计
## 2.2数据流图及数据字典
### 2.2.1系统数据流图
采用结构化方法对系统进行分析与设计，获得热海大报修管理系统的顶层图如图2.1所示；热海大报修管理系统的第0层DFD图如图2.2所示，其中，加工2的细化图如图2.3所示。
![image](https://github.com/fcbyk/campus-repair/assets/101487905/711ed7ab-2387-4651-a235-79b1dcee739f)
图2.1  热海大报修管理系统项层图
![image](https://github.com/fcbyk/campus-repair/assets/101487905/97d5b1cc-9334-4281-8a61-d09c3b0c6b9f)
图2.2  热海大报修管理系统第0层DFD图
![image](https://github.com/fcbyk/campus-repair/assets/101487905/e5a1e0a9-bf6a-4757-a213-d982d1b4b804)
图2.3  （其他查询）加工的细化图
### 2.2.2数据字典
根据系统功能和数据流图得到如下数据字典：

1. **数据流条目**

故障单查询= [故障单号，维修分类号，故障单发起人员id，负责人员id]
故障单信息= 故障单号 + 维修分类号 + 故障设备名称 + 故障单发起人员id + 地点 + 维修人员id 
+ 备注 + 预约时间 + 创建时间 + 接单时间 + 完成时间
故障上报=  维修分类号 + 故障设备名称 + 地点 + 预约时间 + 备注
修改故障单= [ 维修分类号，故障设备名称，地点，预约时间，备注 ]

2. **文件条目**

故障单文件 = 故障单号 + 维修分类号 + 故障设备名称 + 故障单发起人员id + 地点  
+ 接单人员id + 备注 + 预约时间 + 创建时间 + 接单时间 + 完成时间
教职工信息文件 = 教职工id + 姓名 + 性别 + 联系电话 
学生信息文件= 学生id + 姓名 + 性别 + 联系电话 
维修人员文件= 维修人员id + 所属维修类别 + 姓名 + 性别 + 联系电话 
# 3  概念设计阶段
根据需求阶段收集的信息，设计的实体属性如图3.1所示。
![image](https://github.com/fcbyk/campus-repair/assets/101487905/eaf59796-264a-4ecc-a17b-5e10de2e6d4e)
图3.1 实体属性图
具体的实体联系图如图3.2所示。
![image](https://github.com/fcbyk/campus-repair/assets/101487905/c7eb0efe-27e3-422f-9df1-cac0fe9c563a)
图3.2 E-R图
# 4 逻辑设计阶段
## 4.1 E-R模型
根据概念模型设计阶段完成的实体联系图，得出如下关系模式：

1. **账号**  (账号，登录密码，账号类别)
2. **用户信息表**(用户id，姓名，性别，联系电话，人员类别)
3. **故障单** (故障单号，维修分类号，故障设备名称，发起人员id，地点，接单人员id，备注，故障单状态，预约时间，创建时间，接单时间，完成时间)
4. **维修人员分类表**（维修人员id，所属维修分类号）
## 4.2 用户子模式设计
**( 1 )** 新建 simple_account 视图 ，里面记录每个用户的登录账号（id），密码，名字。该视图用于展示测试账号。
```plsql
create view simple_account as 
select register.id, register.pw, user_information.user_name as name
from register,user_information 
where register.id = user_information.user_id;
```
**( 2 )** 学生信息视图
```plsql
create view student_information as
select user_id as sid, user_name as sname, user_gender as gender,user_phone as phone,
user_addr as addr from user_information where user_sort='student';
```
**( 3 )** 教职工信息视图
```plsql
create view staff_information as
select user_id as tid, user_name as tname, user_gender as gender,user_phone as phone,
user_addr as addr from user_information where user_sort='staff';
```
**( 4 )** 维修人员信息视图
```plsql
create view repairMan_information as
select rid, user_name as rname, user_gender as gender,user_phone as phone,
user_addr as addr category from user_information,category where user_id = rid;
```
**( 5 )** 创建传统报修板块所用的电话查询视图
```plsql
create view tradition as 
select rid,category,rname as name,phone 
from repairMan_information;
```
# 5 物理设计
## 5.1 系统表创建
（1）创建系统数据库的SQL语句如下：
```plsql
create database hntou_repair;
```
（2）账号关系表具体结构如下表所示。

| **序号** | **字段** | **说明** | **数据类型（精度范围）** | **空/非空** | **约束条件** |
| --- | --- | --- | --- | --- | --- |
| 1 | 用户id |  | 字符型（20） | 非空 | 主键 |
| 2 | 登录密码 |  | 字符型（20） | 非空 |  |
| 3 | 人员类别 |  | 字符型（10） | 非空 |  |

创建账号关系表的SQL语句如下：
```plsql
create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan')) not null
);
```
（3）用户信息关系表具体结构如下表所示。

| **序号** | **字段** | **说明** | **数据类型（精度范围）** | **空/非空** | **约束条件** |
| --- | --- | --- | --- | --- | --- |
| 1 | 用户id |  | 字符型（20） | 非空 | 主键 |
| 2 | 姓名 |  | 字符型（20） |  |  |
| 3 | 性别 |  | 字符型（2） | |  |
| 4 | 联系电话 |  | 字符型（20） | |  |
| 5 | 人员类别 |  | 字符型（10） | 非空 |  |
| 6 | 默认地址 |  | 字符型（50） |  |  |

```plsql
create table user_information(
	user_id varchar(20) primary key,
    user_name varchar(20) default '新用户',
    user_gender char check(user_gender in('男','女')),
    user_phone varchar(20) default '未绑定',
    user_sort varchar(10) check(user_sort in('student','staff','repairMan')) not null,
    user_addr varchar(50) default '未填写'
);

```
（4）故障单关系表具体结构如下表所示。

| **序号** | **字段** | **说明** | **数据类型（精度范围）** | **空/非空** | **约束条件** |
| --- | --- | --- | --- | --- | --- |
| 1 | 故障单号 |  | 字符型（20） | 非空 | 主键 |
| 2 | 维修分类号 |  | 字符型（20） | 非空 |  |
| 3 | 故障设备名称 |  | 字符型（20） | 非空 |  |
| 4 | 发起人员id |  | 字符型（20） | 非空 | 外键 |
| 5 | 地点 |  | 字符型（20） | 非空 |  |
| 6 | 负责人员id |  | 字符型（20） |  | 外键 |
| 7 | 备注 |  | 字符型（100） | |  |
| 8 | 故障单状态 |  | 字符型（10） |  |  |
| 9 | 预约时间 |  | 日期 | |  |
| 10 | 创建时间 |  | 日期 |  |  |
| 11 | 接单时间 |  | 日期 |  |  |
| 12 | 完成时间 |  | 日期 |  |  |

```plsql
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
  default '推送中'
  appointment_time datetime,
  creation_time datetime,
  order_time datetime,
  finish_time datetime,
  -- foreign key(init_id) references user_information(user_id),
  -- foreign key(rid) references user_information(user_id)
);

```
（5）维修人员分类关系表具体结构如下表所示。

| **序号** | **字段** | **说明** | **数据类型（精度范围）** | **空/非空** | **约束条件** |
| --- | --- | --- | --- | --- | --- |
| 1 | 维修人员id |  | 字符型（20） | 非空 | 主键 |
| 2 | 所属维修分类号 |  | 字符型（10） | |  |

```plsql
create table category(
    rid varchar(20) primary key,
    category varchar(10) 
    check(category in('后勤报修','水表、一卡通','空调维修',
    '室内热水','楼道饮水机维修','消防','未选择')) default '未选择'
);
```
## 5.2 索引
(1) 给账号关系表的用户id列创建索引
```plsql
create index register_index on register(id);
```
(2) 给用户信息关系表的用户id列创建索引
```plsql
create index user_information_index on user_information(user_id);
```
(3) 给故障单关系表的故障单号列创建索引
```plsql
create index repair_order_index on repair_order(rnumber);
```
（4）给维修人员分类关系表的维修人员id创建索引
```plsql
create index category_index on category(category);
```
## 5.3 触发器
**(1)** new_register 触发器功能：账号关系表添加一条数据后，触发往用户信息表添加一条数据，若该账号为维修人员账号，往维修人员分类表添加一条新数据
```plsql
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
```
**(2)** new_register触发器功能：账号关系表删除一条数据后，触发用户信息表删除相关数据，若该账号为维修人员账号，同时删除维修人员分类表相关数据
```plsql
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
```
## 5.4 存储过程
**（1）** 创建更改用户信息的存储过程
```plsql
DELIMITER //
CREATE PROCEDURE alter_user_info(in uname varchar(20),
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
```
**(2)** 创建生成故障单的存储过程
```plsql
DELIMITER //
CREATE PROCEDURE new_orders(in oid varchar(20),
in sort varchar(20),in equ varchar(20),
in uid varchar(20),in pla varchar(50),
in onote varchar(100))
BEGIN
insert into repair_order(rnumber,rsort,f_equ,
init_id,place,note,creation_time) values(oid,sort,equ,uid,pla,onote,now());
END //
DELIMITER ;
```
**(3)** 创建修改故障单的存储过程
```plsql
DELIMITER //
CREATE PROCEDURE alter_orders(in sort varchar(20),
in equ varchar(20),in pla varchar(50),
in onote varchar(100),in oid varchar(20))
BEGIN
update repair_order set rsort=sort,f_equ=equ,
place=pla,note=onote,
where rnumber = oid;
END //
DELIMITER ;
```
# 6 结论
本次数据库课程设计依据，按照了结构化系统设计的方法，进行了需求分析，概念结构设计，逻辑结构设计，但没有进行物理结构设计。之后是数据库的实施，数据库的运行和维护。 在数据库实施阶段发现了自己对数据库中的数据类型的学习还不够，建表时，不知道如何选择数据类型。然后就大量使用了比较万能的字符串数据类型。其次是标识符写的不规范，影响了代码的可读性。


