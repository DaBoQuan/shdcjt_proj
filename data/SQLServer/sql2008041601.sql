delete from SystemRights where id = 776
GO
delete from SystemRightsLanguage where id = 776
GO
delete from SystemRightDetail where id = 4286
GO

insert into SystemRights (id,rightdesc,righttype) values (776,'������Դ��Ƭϵͳ��Ϣά��','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (776,7,'������Դ��Ƭϵͳ��Ϣά��','������Դ��Ƭϵͳ��Ϣά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (776,8,'ResourcesInformationSystem','ResourcesInformationSystem') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4286,'������Դ��Ƭϵͳ��Ϣά��','ResourcesInformationSystem:All',776) 
GO