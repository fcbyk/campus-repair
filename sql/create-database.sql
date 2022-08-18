-- 创建数据库和选择数据库
create database hntou_repair;
use hntou_repair;

-- 查看系统当前已有数据库，和查看当前所选数据库
show databases;
select database();

-- 查看数据创建结构，查看数据库所拥有的表，查看数据库所使用的字符集
show create database hntou_repair;
show tables from hntou_repair;
show variables like 'character_%';

-- 删除数据库
drop database hntou_repair;