delete from HtmlLabelIndex where id=21400 
/
delete from HtmlLabelInfo where indexid=21400 
/
INSERT INTO HtmlLabelIndex values(21400,'�����ϴ�') 
/
INSERT INTO HtmlLabelInfo VALUES(21400,'�����ϴ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21400,'Docs Upload',8) 
/


delete from HtmlLabelIndex where id=21406 
/
delete from HtmlLabelInfo where indexid=21406 
/
INSERT INTO HtmlLabelIndex values(21406,'ѡȡ����ļ�') 
/
delete from HtmlLabelIndex where id=21409 
/
delete from HtmlLabelInfo where indexid=21409 
/
INSERT INTO HtmlLabelIndex values(21409,'���д���Ȩ�޵�Ŀ¼') 
/
delete from HtmlLabelIndex where id=21407 
/
delete from HtmlLabelInfo where indexid=21407 
/
INSERT INTO HtmlLabelIndex values(21407,'�������ѡ��') 
/
delete from HtmlLabelIndex where id=21408 
/
delete from HtmlLabelInfo where indexid=21408 
/
INSERT INTO HtmlLabelIndex values(21408,'ѡ���µ�Ŀ¼��,ҳ�����Խ���Ҫ�������ã��Ƿ���Ҫ����?') 
/
delete from HtmlLabelIndex where id=21405 
/
delete from HtmlLabelInfo where indexid=21405 
/
INSERT INTO HtmlLabelIndex values(21405,'�ļ��ϴ��б�') 
/
INSERT INTO HtmlLabelInfo VALUES(21405,'�ļ��ϴ��б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21405,'Doc Upload List',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21406,'ѡȡ����ļ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21406,'Select Multi Doc',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21407,'�������ѡ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21407,'Clean all selected',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21408,'ѡ���µ�Ŀ¼��,ҳ�����Խ���Ҫ�������ã��Ƿ���Ҫ����?',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21408,'After selected new category,prop will be reset, Are you sure?',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21409,'���д���Ȩ�޵�Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21409,'Category with create',8) 
/





insert into SystemRights (id,rightdesc,righttype) values (774,'�����ϴ�Ȩ��','1') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (774,8,'MultiDocUpload','MultiDocUpload') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (774,7,'�����ϴ�Ȩ��','�����ϴ�Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4284,'�����ϴ�Ȩ��','MultiDocUpload:maint',774) 
/

insert into SystemRightToGroup (groupid, rightid) values (1,774)
/