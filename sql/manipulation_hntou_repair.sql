use hntou_repair;

# �鿴ϵͳ��ǰ�������ݿ⣬�Ͳ鿴��ǰ��ѡ���ݿ�
show databases;
select database();

# �鿴���ݴ����ṹ���鿴���ݿ���ӵ�еı��鿴���ݿ���ʹ�õ��ַ���
show create database hntou_repair;
show tables from hntou_repair;
show variables like 'character_%';

# �鿴��Ĵ�����Ϣ
show create table register;
# ��ձ����������
truncate table register;
# �����������
insert into register values('s123','123456','student');
# ɾ�����е�ĳһ������
delete from register where id='s123';
# ѡ���ѯ
select * from register;
select pw from register where id='123';

# �鿴ϵͳ������
show triggers;

# ���ô洢����
call alter_user_info('��տ','��','123456','���ִ�','t123','');
call new_orders('w123','¥����ˮ��ά��','��ˮ��','s123','���֪��','��������');
call alter_orders('������ˮ','������','���֪��','��������,555','w123');

