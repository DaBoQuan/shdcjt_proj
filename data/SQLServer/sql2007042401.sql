DELETE FROM HtmlLabelIndex WHERE id = 20312
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20312
GO

INSERT INTO HtmlLabelIndex values(20312,'����ʱ��Ӧ�ô���0��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20312,'����ʱ��Ӧ�ô���0��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20312,'Persistent Time should be more than 0!',8) 
GO