delete from SystemRightDetail where rightid = 909
GO
delete from SystemRightsLanguage where id = 909
GO
delete from SystemRights where id = 909
GO

insert into SystemRights (id,rightdesc,righttype) values (909,'������־Ȩ��','5') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,7,'������־Ȩ��','������־Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,8,'right for log of agent','right for log of agent') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (909,9,'�������I����','�������I����') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4435,'������־Ȩ��','AgentLog:View',909) 
GO
