DELETE FROM HtmlLabelIndex WHERE id >= 20216 and id<=20220
GO
DELETE FROM HtmlLabelInfo WHERE  indexId>= 20216 and indexId<=20220
GO
DELETE FROM HtmlLabelIndex WHERE id >= 20222 and id<=20224
GO
DELETE FROM HtmlLabelInfo WHERE  indexId>= 20222 and indexId<=20224
GO
DELETE FROM HtmlLabelIndex WHERE id = 20198
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20198
GO
DELETE FROM HtmlLabelIndex WHERE id = 20201
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20201
GO
DELETE FROM HtmlLabelIndex WHERE id = 20200
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20200
GO

DELETE FROM HtmlLabelIndex WHERE id = 20202
GO
DELETE FROM HtmlLabelInfo WHERE indexId = 20202
GO
INSERT INTO HtmlLabelIndex values(20198,'���ι���ת��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20198,'���ι���ת��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20198,'Zhong Yan Archives Convert',8) 
GO  
INSERT INTO HtmlLabelIndex values(20201,'���ι��ĸ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20200,'���ι����׺�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20200,'Zhong Yan Archive Templet',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20201,'���ι��ĸ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20201,'Zhong Yan Archive Stamp',8) 
GO
INSERT INTO HtmlLabelIndex values(20200,'���ι����׺�') 
GO
INSERT INTO HtmlLabelIndex values(20202,'���ι��ķ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20202,'���ι��ķ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20202,'Zhong Yan Archive Public',8) 
GO
INSERT INTO HtmlLabelIndex values(20197,'���ι�����ת��') 
GO
INSERT INTO HtmlLabelIndex values(20216,'���ĵ�λ') 
GO
INSERT INTO HtmlLabelIndex values(20218,'��������') 
GO
INSERT INTO HtmlLabelIndex values(20217,'���ĵ�λ') 
GO
INSERT INTO HtmlLabelIndex values(20219,'��ӡ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20197,'���ι�����ת��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20216,'���ĵ�λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20217,'���ĵ�λ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20218,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20219,'��ӡ����',7) 
GO
INSERT INTO HtmlLabelIndex values(20220,'���ĸ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20220,'���ĸ���',7) 
GO

INSERT INTO HtmlLabelIndex values(20222,'���ι������ĵ�') 
GO
INSERT INTO HtmlLabelIndex values(20223,'���ι�������') 
GO
INSERT INTO HtmlLabelIndex values(20224,'���ι��ĸ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20222,'���ι������ĵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20223,'���ι�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20223,'',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20224,'���ι��ĸ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20224,'���ι��ĸ���',8) 
GO