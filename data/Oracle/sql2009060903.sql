create table overworkplan
(
     id int NOT NULL ,
     workplanname varchar2(1000) not null,
     workplancolor varchar2(100) not null,
     wavailable int default 1
)
/

insert into overworkplan(id,workplanname,workplancolor,wavailable) values(1,'����ճ�','#c3c3c2',0)
/
insert into overworkplan(id,workplanname,workplancolor,wavailable) values(2,'�鵵�ճ�','#937a47',0)
/
