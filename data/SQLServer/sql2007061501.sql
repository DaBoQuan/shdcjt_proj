delete from HtmlLabelIndex where id in (20494,20495,20496)
go
delete from HtmlLabelInfo where indexid in (20494,20495,20496)
go

INSERT INTO HtmlLabelIndex values(20494,'���½���') 
GO
INSERT INTO HtmlLabelIndex values(20495,'���ڽ����ʼ������Ժ�...') 
GO
INSERT INTO HtmlLabelInfo VALUES(20494,'���½���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20494,'Re-Parse',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20495,'���ڽ����ʼ������Ժ�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20495,'Parsing, Please wait...',8) 
GO
INSERT INTO HtmlLabelIndex values(20496,'ȷ�����½����ʼ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20496,'ȷ�����½����ʼ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20496,'Do you confirm re-parse the mail?',8) 
GO