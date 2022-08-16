show databases;
select database();
create database hntou_repair;
use hntou_repair;
show tables from hntou_repair;
show create database hntou_repair;
show variables like 'character_%';
drop database hntou_repair;

create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan'))
);
drop table repairMan;
show create table register;

insert into register values('s123','123456','student');
select * from register;

create table student(
	sid varchar(20) primary key,
    sname varchar(20) default '新用户',
    gender char check(gender in('男','女')),
    phone varchar(20) default '未绑定'
);

insert into student(sid) value('s123');
select * from student;

create table staff(
    tid varchar(20) primary key,
    tname varchar(20) default '新用户',
    gender char check(gender in('男','女')),
    phone varchar(20) default '未绑定'
);

create table repairMan(
    rid varchar(20) primary key,
    rsort varchar(20),
    rname varchar(20) default '新用户',
    gender char check(gender in('男','女')),
    phone varchar(20) default '未绑定'
);

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
TRUNCATE TABLE student;
select pw from register where id='123';

DELIMITER //
create trigger new_register
after insert on register 
for each row
begin
if(LEFT(new.id,1) ='s')
then insert into student(sid) value(new.id);
end if;
if(LEFT(new.id,1) ='t')
then insert into staff(tid) value(new.id);
end if;
if(LEFT(new.id,1) ='r')
then insert into repairMan(rid) value(new.id);
end if;
end //
DELIMITER ;

SHOW TRIGGERS;

DROP TRIGGER new_register;