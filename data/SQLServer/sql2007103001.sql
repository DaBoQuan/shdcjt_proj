delete from SystemRights where id=725
GO
delete from SystemRightsLanguage where id=725
GO
delete from SystemRightDetail where rightid=725
GO
insert into SystemRights (id,rightdesc,righttype) values (725,'Э���������','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (725,7,'Э���������','Э���������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (725,8,'set collaboration type','set collaboration type') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4233,'Э���������','collaborationtype:edit',725) 
GO

delete from SystemRights where id=726
GO
delete from SystemRightsLanguage where id=726
GO
delete from SystemRightDetail where rightid=726
GO
insert into SystemRights (id,rightdesc,righttype) values (726,'Э��������','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (726,7,'Э��������','Э��������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (726,8,'set collaboration area','set collaboration area') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4235,'Э��������','collaborationarea:edit',726) 
GO

delete from SystemRights where id=727
GO
delete from SystemRightsLanguage where id=727
GO
delete from SystemRightDetail where rightid=727
GO
insert into SystemRights (id,rightdesc,righttype) values (727,'Э�����','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (727,7,'Э�����','Э�����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (727,8,'collaboration Manage','collaboration Manage') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4234,'Э�����','collaborationmanager:edit',727) 
GO