delete from SystemRightDetail where rightid = 869
GO
delete from SystemRightsLanguage where id = 869
GO
delete from SystemRights where id = 869
GO

insert into SystemRights (id,rightdesc,righttype) values (869,'�����ļ�����','0') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,8,'service file setting','service file setting') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,7,'�����ļ�����','�����ļ�����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (869,9,'�����ļ��O��','�����ļ��O��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4391,'�����ļ�����','ServiceFile:Manage',869) 
GO
