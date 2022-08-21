use hntou_repair;
drop PROCEDURE new_orders;
create view tradition as 
select rid,category,rname as name,phone 
from repairMan_information;

update repair_order set order_state='已完成' where rnumber = 'x333';

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




