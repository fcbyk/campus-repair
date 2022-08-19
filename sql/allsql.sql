use hntou_repair;
drop table repair_order;
create view tradition as 
select rid,category,rname as name,phone 
from repairMan_information;

update repair_order set order_state='已接单' where rnumber = 'abc333';