delete from SystemRightDetail where rightid = 902
GO
delete from SystemRightsLanguage where id = 902
GO
delete from SystemRights where id = 902
GO

insert into SystemRights (id,rightdesc,righttype) values (902,'Ⱥ������','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (902,7,'Ⱥ������','Ⱥ������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (902,8,'Groups Set','Groups Set') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (902,9,'Ⱥ�M�O��','Ⱥ�M�O��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4428,'Ⱥ������','GroupsSet:Maintenance',902) 
GO
