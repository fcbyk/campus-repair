/***** �������ݿ��ѡ�����ݿ� *****/
create database hntou_repair;
use hntou_repair;

/*****
����������
�˺�  (�˺ţ���¼���룬�˺����)
�û���Ϣ�� (�û�id���������Ա���ϵ�绰����Ա���, ��ַ)
���ϵ�  (���ϵ��ţ�ά�޷���ţ������豸���ƣ�������Աid���ص㣬�ӵ���Աid����ע�����ϵ�״̬������ʱ��)
ά����Ա�����ά����Աid������ά�޷���ţ�
*****/

# �˺���Ϣ��
create table register(
    id varchar(20) primary key,
    pw varchar(20) not null,
    sort varchar(10) check(sort in('student','staff','repairMan'))
);

# �û���Ϣ��
create table user_information(
	user_id varchar(20) primary key,
    user_name varchar(20) default '���û�',
    user_gender char check(user_gender in('��','Ů')),
    user_phone varchar(20) default 'δ��',
    user_sort varchar(10) check(user_sort in('student','staff','repairMan')) not null,
    user_addr varchar(50) default 'δ��д'
);

# �������ϵ���Ϣ��
create table repair_order(
	rnumber varchar(20) primary key,
    rsort varchar(10) check(rsort in('���ڱ���','ˮ��һ��ͨ','�յ�ά��',
    '������ˮ','¥����ˮ��ά��','����','δѡ��')),
    f_equ varchar(20) not null,
    init_id varchar(20) not null,
    place varchar(50) not null,
    rid varchar(20),
    note varchar(100),
    order_state varchar(10)
    check(order_state in('������','�ѽӵ�','�����'))
    default '������',
    rtime datetime,
    foreign key(init_id) references user_information(user_id),
    foreign key(rid) references user_information(user_id)
);

# ����ά����Ա����
create table category(
    rid varchar(20) primary key,
    category varchar(10)
    check(category in('���ڱ���','ˮ��һ��ͨ','�յ�ά��',
    '������ˮ','¥����ˮ��ά��','����','δѡ��')) default 'δѡ��'
);

/***** ������ͼ
ѧ����Ϣ (sid,sname,gender,phone,addr)
��ְ����Ϣ (tid,tname,gender,phone,addr)
ά��ʦ����Ϣ(rid,rname,gender,phone,addr,category)
���û���Ϣ(id,pw,name)
��ͳ���޵绰��Ϣ(rid,category,name,phone)
*****/

# ����ѧ����Ϣ��ͼ
create view student_information as
select user_id as sid,
       user_name as sname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr
from user_information
where user_sort='student';

# ������ְ����Ϣ��ͼ
create view staff_information as
select user_id as tid,
       user_name as tname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr
from user_information
where user_sort='staff';

# ����ά��ʦ����Ϣ��ͼ
create view repairMan_information as
select rid, user_name as rname,
       user_gender as gender,
       user_phone as phone,
       user_addr as addr,
       category
from user_information,category
where user_id = rid;

# �������û���Ϣ��ͼ�������ڲ����˺Ű��
create view simple_account as
select register.id,
       register.pw,
       user_information.user_name as name
from register,user_information
where register.id = user_information.user_id;

# ������ͳ���ް�����õ�������ͼ
create view tradition as
select rid,
       category,
       rname as name,
       phone
from repairMan_information;

/***** �������� *****/
# create index register_index on register(id);
# create index user_information_index on user_information(user_id);
# create index repair_order_index on repair_order(rnumber);
# create index category_index on category(category);

/***** ���������� *****/
# new_register ����������
# �˺Ź�ϵ�����һ�����ݺ󣬴������û���Ϣ�����һ�����ݣ������˺�Ϊά����Ա�˺ţ���ά����Ա��������һ��������
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

# new_register����������
# �˺Ź�ϵ��ɾ��һ�����ݺ󣬴����û���Ϣ��ɾ��������ݣ������˺�Ϊά����Ա�˺ţ�ͬʱɾ��ά����Ա������������
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

/***** �洢���� *****/
# ���������û���Ϣ�Ĵ洢����
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

# �������ɹ��ϵ��Ĵ洢����
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

# �����޸Ĺ��ϵ��Ĵ洢����
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
