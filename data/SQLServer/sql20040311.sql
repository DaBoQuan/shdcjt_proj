update SystemRights set rightdesc='ְ��ά��' where id=29
go
DELETE FROM SystemRights WHERE ID=30
GO
DELETE FROM SystemRightsLanguage WHERE ID =30
GO
DELETE FROM SystemRightDetail WHERE rightid = 30
GO
insert into SystemRights (id,rightdesc,righttype) values (30,'��λά��','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (30,7,'��λά��','��λ����ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (30,8,'HrmJobTitles','Add,delete,update and log HrmJobTitles') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (104,'��λ���','HrmJobTitlesAdd:Add',30) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (105,'��λ�༭','HrmJobTitlesEdit:Edit',30) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (106,'��λɾ��','HrmJobTitlesEdit:Delete',30) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (107,'��λ��־�鿴','HrmJobTitles:Log',30) 
GO