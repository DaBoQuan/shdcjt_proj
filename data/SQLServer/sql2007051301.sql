delete from HtmlLabelIndex where id in (20305,20306,20307)
go

delete from HtmlLabelInfo where indexid in (20305,20306,20307)
go

INSERT INTO HtmlLabelIndex values(20305,'���Ȩ��') 
GO
INSERT INTO HtmlLabelIndex values(20306,'�ɲ鿴') 
GO
INSERT INTO HtmlLabelIndex values(20307,'��ɾ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20305,'���Ȩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20305,'monitor rights',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20306,'�ɲ鿴',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20306,'can view',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20307,'��ɾ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20307,'can delete',8) 
GO