use hntou_repair;

# 查看系统当前已有数据库，和查看当前所选数据库
show databases;
select database();

# 查看数据创建结构，查看数据库所拥有的表，查看数据库所使用的字符集
show create database hntou_repair;
show tables from hntou_repair;
show variables like 'character_%';

# 查看表的创建信息
show create table register;
# 清空表的所有数据
truncate table register;
# 往表插入数据
insert into register values('s123','123456','student');
# 删除表中的某一条数据
delete from register where id='s123';
# 选择查询
select * from register;
select pw from register where id='123';

# 查看系统触发器
show triggers;

# 调用存储过程
call alter_user_info('篮湛','男','123456','新手村','t123','');
call new_orders('w123','楼道饮水机维修','饮水机','s123','云深不知处','速速来修');
call alter_orders('室内热水','读卡器','云深不知处','速速来修,555','w123');

