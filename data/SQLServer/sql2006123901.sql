delete from HtmlLabelIndex where id in (19516)
go
delete from HtmlLabelInfo where indexid in (19516)
go
delete from HtmlLabelIndex where id in (20151)
go
delete from HtmlLabelInfo where indexid in (20151)
go

INSERT INTO HtmlLabelIndex values(19516,'�Զ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19516,'�Զ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19516,'user-defined',8) 
GO
INSERT INTO HtmlLabelIndex values(20151,'���������õļ�¼������ɾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20151,'���������õļ�¼������ɾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20151,'can not delete.',8) 
GO