delete from HtmlLabelIndex where id=21400 
GO
delete from HtmlLabelInfo where indexid=21400 
GO
INSERT INTO HtmlLabelIndex values(21400,'�����ϴ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(21400,'�����ϴ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21400,'Docs Upload',8) 
GO


delete from HtmlLabelIndex where id=21406 
GO
delete from HtmlLabelInfo where indexid=21406 
GO
INSERT INTO HtmlLabelIndex values(21406,'ѡȡ����ļ�') 
GO
delete from HtmlLabelIndex where id=21409 
GO
delete from HtmlLabelInfo where indexid=21409 
GO
INSERT INTO HtmlLabelIndex values(21409,'���д���Ȩ�޵�Ŀ¼') 
GO
delete from HtmlLabelIndex where id=21407 
GO
delete from HtmlLabelInfo where indexid=21407 
GO
INSERT INTO HtmlLabelIndex values(21407,'�������ѡ��') 
GO
delete from HtmlLabelIndex where id=21408 
GO
delete from HtmlLabelInfo where indexid=21408 
GO
INSERT INTO HtmlLabelIndex values(21408,'ѡ���µ�Ŀ¼��,ҳ�����Խ���Ҫ�������ã��Ƿ���Ҫ����?') 
GO
delete from HtmlLabelIndex where id=21405 
GO
delete from HtmlLabelInfo where indexid=21405 
GO
INSERT INTO HtmlLabelIndex values(21405,'�ļ��ϴ��б�') 
GO
INSERT INTO HtmlLabelInfo VALUES(21405,'�ļ��ϴ��б�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21405,'Doc Upload List',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21406,'ѡȡ����ļ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21406,'Select Multi Doc',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21407,'�������ѡ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21407,'Clean all selected',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21408,'ѡ���µ�Ŀ¼��,ҳ�����Խ���Ҫ�������ã��Ƿ���Ҫ����?',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21408,'After selected new category,prop will be reset, Are you sure?',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21409,'���д���Ȩ�޵�Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21409,'Category with create',8) 
GO

insert into SystemRights (id,rightdesc,righttype) values (774,'�����ϴ�Ȩ��','1') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (774,8,'MultiDocUpload','MultiDocUpload') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (774,7,'�����ϴ�Ȩ��','�����ϴ�Ȩ��') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4284,'�����ϴ�Ȩ��','MultiDocUpload:maint',774) 
GO

insert into SystemRightToGroup (groupid, rightid) values (1,774)
GO
