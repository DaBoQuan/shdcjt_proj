/*td:78.695.696 "ְ�����ά��"Ȩ����Ȩ����������ʾ����"��������ά��"; �����������Ȩ�������޸�Ϊ����������*/
delete SystemRights where id = 55 or id = 28
/
delete SystemRightsLanguage where id =55 or id =28
/
delete SystemRightDetail where rightid = 55 or rightid = 28 
/
insert into SystemRights (id,rightdesc,righttype) values (55,'��������ά��','6') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (55,8,'WorkType Maintenance','Add,delete,update and log WorkType') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (55,7,'��������ά��','�������͵���ӣ�ɾ�������º���־�鿴') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (198,'�����������','AddWorkType:Add',55) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (199,'�������ͱ༭','EditWorkType:Edit',55) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (200,'��������ɾ��','EditWorkType:Delete',55) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (201,'����������־�鿴','WorkType:Log',55) 
/
insert into SystemRights (id,rightdesc,righttype) values (28,'ְ�����ά��','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,7,'ְ�����ά��','ְ��������ӣ�ɾ�������º���־�鿴') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,8,'HrmJobGroups','Add,delete,update and log HrmJobGroups') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (96,'ְ��������','HrmJobGroupsAdd:Add',28) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (97,'ְ�����༭','HrmJobGroupsEdit:Edit',28) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (98,'ְ�����ɾ��','HrmJobGroupsEdit:Delete',28) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (99,'ְ�������־�鿴','HrmJobGroups:Log',28) 
/