delete from SystemRightDetail where rightid = 873
GO
delete from SystemRightsLanguage where id = 873
GO
delete from SystemRights where id = 873
GO

insert into SystemRights (id,rightdesc,righttype) values (873,'�ĵ���־�鿴','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,7,'�ĵ���־�鿴','�ĵ���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,8,'File log view','File log view') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (873,9,'��?��?�鿴','��?��?�鿴') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4395,'�ĵ���־�鿴Ȩ��','FileLogView:View',873) 
GO
