show databases;
select database();
create database hntou_repair;
use hntou_repair;
show tables from hntou_repair;
show create database hntou_repair;
show variables like 'character_%';
drop database hntou_repair;

create table user_information(
	user_id varchar(20) primary key,
    user_name varchar(20) default '新用户',
    user_gender char check(user_gender in('男','女')),
    user_phone varchar(20) default '未绑定',
    user_sort varchar(10) check(user_sort in('student','staff','repairMan')) not null,
    user_addr varchar(50) default '未填写'
);

create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan'))
);
drop table user_information;
show create table register;

insert into register values('s123','123456','student');
select * from register;

create table repair_order(
	rnumber varchar(20) primary key,
    rsort varchar(20) not null,
    f_equ varchar(20) not null,
    init_id varchar(20) not null,
    place varchar(50) not null,
    rtime datetime not null,
    rid varchar(20),
    note varchar(100)
);

TRUNCATE TABLE register;
TRUNCATE TABLE user_information;
select pw from register where id='123';

DELIMITER //
create trigger new_register
after insert on register 
for each row
begin
insert into user_information(user_id,user_sort) value(new.id,new.sort);
end //
DELIMITER ;

SHOW TRIGGERS;
DROP TRIGGER new_register;

create view simple_account as 
select register.id, register.pw, user_information.user_name as name
from register,user_information 
where register.id = user_information.user_id;

select * from simple_account;
drop view student_information;

create view student_information as
select user_id as sid, user_name as sname, user_gender as gender,user_phone as phone
from user_information where user_sort='student';

create view staff_information as
select user_id as tid, user_name as tname, user_gender as gender,user_phone as phone
from user_information where user_sort='staff';

create view repairMan_information as
select user_id as rid, user_name as rname, user_gender as gender,user_phone as phone
from user_information where user_sort='repairMan';

select * from student_information;

DELIMITER //
create trigger delete_user
after delete on register 
for each row
begin
delete from user_information where user_id = old.id;
end //
DELIMITER ;

delete from register where id='s123';