-- 创建更改用户信息的存储过程
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

-- 创建生成故障单的存储过程
DELIMITER //
CREATE PROCEDURE new_orders(in oid varchar(20),
in sort varchar(20),in equ varchar(20),
in uid varchar(20),in pla varchar(50),
in onote varchar(100))
BEGIN
insert into repair_order(rnumber,rsort,f_equ,
init_id,place,note,rtime) values(oid,sort,equ,uid,pla,onote,now());
END //
DELIMITER ;

-- -- 创建修改故障单的存储过程
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

-- 调用存储过程
call alter_user_info('篮湛','男','123456','新手村','t123','');  
call new_orders('w123','楼道饮水机维修','饮水机','s123','云深不知处','速速来修')
call alter_orders('室内热水','读卡器','云深不知处','速速来修,555','w123');