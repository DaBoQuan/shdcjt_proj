DELETE FROM HtmlLabelIndex WHERE id = 20354
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20354
GO
DELETE FROM HtmlLabelIndex WHERE id = 20347
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 2047
GO
INSERT INTO HtmlLabelIndex values(20354,'ְλʱ��') 
GO
INSERT INTO HtmlLabelIndex values(20347,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20347,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20347,'Workspace',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20354,'ְλʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20354,'Duty Limit',8) 
GO