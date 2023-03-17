use hntou_repair;

# É¾³ý´¥·¢Æ÷
drop trigger new_register;
drop trigger delete_user;

# É¾³ý´æ´¢¹ý³Ì
drop procedure alter_orders;
drop procedure alter_user_info;
drop procedure new_orders;

# É¾³ýÊÓÍ¼
drop view repairMan_information;
drop view simple_account;
drop view staff_information;
drop view student_information;
drop view tradition;

# É¾³ý±í
drop table category;
drop table register;
drop table repair_order;
drop table user_information;

# É¾³ýÊý¾Ý¿â
drop database hntou_repair;