delete from HtmlLabelIndex where  id=20247
go
delete from HtmlLabelIndex where id=20246
go
delete from HtmlLabelInfo where indexid=20247
go
delete from HtmlLabelInfo where indexid=20246
go
INSERT INTO HtmlLabelIndex values(20247,'1�������ַ�����2������') 
GO
INSERT INTO HtmlLabelIndex values(20246,'�ı����Ȳ��ܳ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(20246,'�ı����Ȳ��ܳ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20246,'text length can not exceed',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20247,'1�������ַ�����2������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20247,'one gb2312 char equals tow char',8) 
GO
