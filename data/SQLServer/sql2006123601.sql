DELETE FROM HtmlLabelIndex WHERE id = 20114
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20114
GO
INSERT INTO HtmlLabelIndex values(20114,'��ȡ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20114,'��ȡ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20114,'Have Been Canceled',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 20115
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20115
GO
INSERT INTO HtmlLabelIndex values(20115,'ȡ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20115,'ȡ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20115,'Cancel Meeting',8) 
GO

DELETE FROM HtmlLabelIndex WHERE id = 20117
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20117
GO
INSERT INTO HtmlLabelIndex values(20117,'��ȷ��Ҫȡ��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20117,'��ȷ��Ҫȡ��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20117,'Are you sure to cancel the meeting?',8) 
GO