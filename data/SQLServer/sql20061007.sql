
delete from HtmlLabelIndex where id=19789
GO
delete from HtmlLabelInfo where indexid=19789
GO

INSERT INTO HtmlLabelIndex values(19789,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19789,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19789,'News Format',8)
GO

INSERT INTO HtmlLabelIndex values(19790,'��������Ϊ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19790,'��������Ϊ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19790,'can be set to news',8) 
GO

update DocSecCategoryDocProperty set labelid = 19789 where labelid = 114
GO

