
delete from HtmlLabelIndex where id=20773
go
delete from HtmlLabelInfo where indexid=20773
go
INSERT INTO HtmlLabelIndex values(20773,'�Զ����ѯ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20773,'�Զ����ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20773,'custom query',8) 
GO

delete from HtmlLabelIndex where id=20785
go
delete from HtmlLabelInfo where indexid=20785
go
INSERT INTO HtmlLabelIndex values(20785,'�Զ����ѯ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20785,'�Զ����ѯ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20785,'set custom query',8) 
GO

delete from HtmlLabelIndex where id=20778
go
delete from HtmlLabelInfo where indexid=20778
go
INSERT INTO HtmlLabelIndex values(20778,'�Ƿ���Ϊ��ѯ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20778,'�Ƿ���Ϊ��ѯ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20778,'query condition',8) 
GO

delete from HtmlLabelIndex where id=20779
go
delete from HtmlLabelInfo where indexid=20779
go

INSERT INTO HtmlLabelIndex values(20779,'�Ƿ���Ϊ�б����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20779,'�Ƿ���Ϊ�б����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20779,'head or table',8) 
GO

delete from HtmlLabelIndex where id=20780
go
delete from HtmlLabelInfo where indexid=20780
go

INSERT INTO HtmlLabelIndex values(20780,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20780,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20780,'used',8) 
GO

delete from SystemRightsLanguage where id=719
go
delete from SystemRightDetail where id=4227
go
delete from SystemRights where id=719
go

insert into SystemRights (id,rightdesc,righttype) values (719,'�Զ����ѯ','5') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (719,8,'custom query','custom query') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (719,7,'�Զ����ѯ','�Զ����ѯ') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4227,'�����Զ����ѯȨ��','WorkflowCustomManage:All',719) 
GO
