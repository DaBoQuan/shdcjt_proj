delete from SystemRightDetail where rightid = 869
/
delete from SystemRightsLanguage where id = 869
/
delete from SystemRights where id = 869
/

insert into SystemRights (id,rightdesc,righttype) values (869,'�����ļ�����','0') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,8,'service file setting','service file setting') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,7,'�����ļ�����','�����ļ�����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,9,'�����ļ��O��','�����ļ��O��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4391,'�����ļ�����','ServiceFile:Manage',869) 
/
