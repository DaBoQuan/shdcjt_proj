delete from SystemRightDetail where rightid = 856
GO
delete from SystemRightsLanguage where id = 856
GO
delete from SystemRights where id = 856
GO
insert into SystemRights (id,rightdesc,righttype) values (856,'��ҳ��ʽά��','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (856,8,'Homepage Style Maintance','Homepage Style Maintance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (856,9,'��ҳ��ʽά��','��ҳ��ʽά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (856,7,'��ҳ��ʽά��','��ҳ��ʽά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4371,'��ҳ��ʽά��','hompage:stylemaint',856) 
GO
