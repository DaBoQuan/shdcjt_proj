/*for id=69 by ������*/
update SystemRightsLanguage set rightdesc='�ֲ����½����༭����ʾ��ɾ�����鿴��־' where id=18 and languageid=7
go
/*
BUG 79 ����ְ�����Ȩ�޵��û���û��Ȩ�޲鿴ְ��������־��Ϣ.����ϵͳ����Ա���Բ鿴��־��Ϣ-����
*/
Delete From SystemRightDetail Where rightid = 126
Go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (426,'ְ��������','HrmJobGroupsAdd:Add',126) 
Go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (427,'ְ�����༭','HrmJobGroupsEdit:Edit',126) 
Go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (428,'ְ�����ɾ��','HrmJobGroupsEdit:Delete',126) 
Go
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (429,'ְ�������־�鿴','HrmJobGroups:Log',126) 
Go
/*
bug:92 �޸�112��Ȩ�޵�Ĭ������ by hy 
*/
DELETE FROM SystemRights WHERE id = 112
GO
DELETE FROM SystemRightsLanguage WHERE id = 112
GO
DELETE FROM SystemRightDetail WHERE rightid = 112
GO
insert into SystemRights (id,rightdesc,righttype) values (112,'������Ϣά��','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,8,'other info maintenance','other info maintenance') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,7,'������Ϣά��','������Ϣά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (391,'������Ϣ���','HrmOtherInfoTypeAdd:Add',112) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (392,'������Ϣ�༭','HrmOtherInfoTypeEdit:Edit',112) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (393,'������Ϣɾ��','HrmOtherInfoTypeEdit:Delete',112) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (394,'������Ϣ��־�鿴','HrmOtherInfoType:Log',112) 
GO
/*����Ĭ��Ȩ��Ϊ������Դ���ܲ�����*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=112
GO
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,112)
GO
DELETE FROM SystemRightRoles WHERE RightID = 112 and RoleID = 4
GO
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (112,4,2)
GO
