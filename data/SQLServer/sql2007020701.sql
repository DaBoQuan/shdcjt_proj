DELETE FROM HtmlLabelIndex WHERE id = 20232
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20232
GO
INSERT INTO HtmlLabelIndex values(20232,'���ܿ�ʼ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20232,'���ܿ�ʼ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20232,'Begin Date in Last Week',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 20233
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20233
GO
INSERT INTO HtmlLabelIndex values(20233,'���¿�ʼ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20233,'���¿�ʼ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20233,'Begin Date in Last Month',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 20234
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20234
GO
INSERT INTO HtmlLabelIndex values(20234,'��ʾȫ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20234,'��ʾȫ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20234,'Display All WorkPlan',8) 
GO
