delete from HtmlLabelIndex where id between 20000 and 20010
go
delete from HtmlLabelInfo where indexid between 20000 and 20010
go

INSERT INTO HtmlLabelIndex values(20000,'����������ÿռ��С') 
GO
INSERT INTO HtmlLabelInfo VALUES(20000,'����������ÿռ��С',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20000,'greater than used album size',8) 
GO
INSERT INTO HtmlLabelIndex values(20001,'�ϴ�ͼƬ') 
GO
INSERT INTO HtmlLabelIndex values(20005,'���ÿռ�') 
GO
INSERT INTO HtmlLabelIndex values(20006,'ʣ��ռ�') 
GO
INSERT INTO HtmlLabelIndex values(20008,'������ͼƬ����') 
GO
INSERT INTO HtmlLabelIndex values(20003,'���') 
GO
INSERT INTO HtmlLabelIndex values(20004,'�ռ��С') 
GO
INSERT INTO HtmlLabelIndex values(20002,'�½�Ŀ¼') 
GO
INSERT INTO HtmlLabelIndex values(20007,'ʹ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20001,'�ϴ�ͼƬ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20001,'Upload',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20002,'�½�Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20002,'Add Folder',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20003,'���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20003,'Album',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20004,'�ռ��С',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20004,'Album Size',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20005,'���ÿռ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20005,'Used Size',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20006,'ʣ��ռ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20006,'Free Size',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20007,'ʹ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20007,'Status',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20008,'������ͼƬ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20008,'Please input the photo title',8) 
GO
INSERT INTO HtmlLabelIndex values(20009,'��������') 
GO
INSERT INTO HtmlLabelIndex values(20010,'������������, ���Ժ�...') 
GO
INSERT INTO HtmlLabelInfo VALUES(20009,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20009,'Post Comment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20010,'������������, ���Ժ�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20010,'Loading comments, please wait...',8) 
GO

delete from HtmlLabelIndex where id in (20162,20163,20164)
go
delete from HtmlLabelInfo where indexid in (20162,20163,20164)
go

INSERT INTO HtmlLabelIndex values(20162,'�ҵ����') 
GO
INSERT INTO HtmlLabelIndex values(20163,'�����ҳ') 
GO
INSERT INTO HtmlLabelIndex values(20164,'����ѯ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20162,'�ҵ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20162,'Album',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20163,'�����ҳ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20163,'Home',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20164,'����ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20164,'Search',8) 
GO

insert into SystemRights (id,rightdesc,righttype,detachable) values (690,'���ά��Ȩ��','1',1) 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (690,7,'���ά��Ȩ��','���ά��Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (690,8,'Album Manage','Album Manage') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4198,'���ά��','Album:Maint',690) 
GO
