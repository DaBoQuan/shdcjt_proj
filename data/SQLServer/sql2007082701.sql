delete from HtmlLabelIndex where id in(20855,20856)
GO
delete from HtmlLabelInfo where indexid in(20855,20856)
GO
INSERT INTO HtmlLabelIndex values(20855,'�������') 
GO
INSERT INTO HtmlLabelIndex values(20856,'�̻����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20855,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20855,'Order Manager',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20856,'�̻����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20856,'SellChange Manage',8) 
GO

