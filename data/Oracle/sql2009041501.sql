delete from HtmlLabelIndex where id=22814 
/
delete from HtmlLabelInfo where indexid=22814 
/
INSERT INTO HtmlLabelIndex values(22814,'�������ѡ��ӵ��ά��Ȩ�޵ķֲ���') 
/
INSERT INTO HtmlLabelInfo VALUES(22814,'�������ѡ��ӵ��ά��Ȩ�޵ķֲ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22814,'Please choose the subCompany of having maintenance right in the left!',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22814,'Ո������x����оS�o�S�ə�ķֲ���',9) 
/

delete from HtmlLabelIndex where id=22815 
/
delete from HtmlLabelInfo where indexid=22815 
/
INSERT INTO HtmlLabelIndex values(22815,'�����Ͳ�����Էֲ����ã���ѡ���������ͣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(22815,'�����Ͳ�����Էֲ����ã���ѡ���������ͣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22815,'Because of this type can not be set for the subCompany, please choose other type!',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22815,'ԓ��Ͳ���ᘌ��ֲ��O�ã�Ո�x��������ͣ�',9) 
/ 

delete from SystemRightDetail  where rightid in(837,838)
/
delete from SystemRightsLanguage  where id in(837,838)
/
delete from SystemRights  where id in(837,838)
/

insert into SystemRights (id,rightdesc,righttype) values (837,'��ʼ���ά��','5') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (837,7,'��ʼ���ά��','��ʼ���ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (837,8,'Start Code Maintenance','Start Code Maintenance') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (837,9,'��ʼ��̖�S�o','��ʼ��̖�S�o') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4352,'��ʼ���ά��','StartCode:Maintenance',837) 
/


insert into SystemRights (id,rightdesc,righttype) values (838,'Ԥ�����ά��','5') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (838,9,'�A����̖�S�o','�A����̖�S�o') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (838,7,'Ԥ�����ά��','Ԥ�����ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (838,8,'Reserved Code Maintenance','Reserved Code Maintenance') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4353,'Ԥ�����ά��','ReservedCode:Maintenance',838) 
/


