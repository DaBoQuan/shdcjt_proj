delete from SystemRights where id = 906
/
delete from SystemRightsLanguage where id = 906
/
delete from SystemRightDetail where id = 4432
/
insert into SystemRights (id,rightdesc,righttype) values (906,'��н����������������','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (906,7,'��н����������������','��н����������������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (906,8,'Paid sick leave batch processing settings','Paid sick leave batch processing settings') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (906,9,'��н��������̎���O��','��н��������̎���O��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4432,'��н����������������','PSLBatch:All',906) 
/

delete from SystemRights where id = 907
/
delete from SystemRightsLanguage where id = 907
/
delete from SystemRightDetail where id = 4433
/
insert into SystemRights (id,rightdesc,righttype) values (907,'��н������Ч������','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (907,7,'��н������Ч������','��н������Ч������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (907,8,'Paid sick leave period is set','Paid sick leave period is set') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (907,9,'��н������Ч���O��','��н������Ч���O��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4433,'��н������Ч������','PSLPeriod:All',907) 
/

delete from SystemRights where id = 908
/
delete from SystemRightsLanguage where id = 908
/
delete from SystemRightDetail where id = 4434
/
insert into SystemRights (id,rightdesc,righttype) values (908,'��н���ٹ���','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (908,7,'��н���ٹ���','��н���ٹ���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (908,8,'Paid sick leave management','Paid sick leave management') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (908,9,'��н���ٹ���','��н���ٹ���') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4434,'��н���ٹ���','PaidSickLeave:All',908) 
/
