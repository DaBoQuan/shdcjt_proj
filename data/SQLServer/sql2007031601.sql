delete from mainmenuinfo where id=368
go

delete from mainmenuconfig where infoid=368
go


delete from HtmlLabelIndex where id=20253
go

delete from HtmlLabelIndex where id=20254
go

delete from HtmlLabelIndex where id=20255
go
delete from HtmlLabelIndex where id=20256
go

delete from HtmlLabelInfo where indexid=20253
go

delete from HtmlLabelInfo where indexid=20254
go

delete from HtmlLabelInfo where indexid=20255
go
delete from HtmlLabelInfo where indexid=20256
go


INSERT INTO HtmlLabelIndex values(20253,'���ڼ���ļ��ϴ���С�Ŀؼ�û�а�װ������IE���ã��������Ա��ϵ') 
GO
INSERT INTO HtmlLabelIndex values(20255,'��Ŀ¼�²����ϴ�����') 
GO
INSERT INTO HtmlLabelIndex values(20256,'���ļ�,�����Ҫ���ʹ��ļ�,�������Ա��ϵ!') 
GO
INSERT INTO HtmlLabelIndex values(20254,'��������Ϊ:') 
GO
INSERT INTO HtmlLabelInfo VALUES(20253,'���ڼ���ļ��ϴ���С�Ŀؼ�û�а�װ������IE���ã��������Ա��ϵ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20253,'don not install activex',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20254,'��������Ϊ:',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20254,'you upload file is:',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20255,'��Ŀ¼�²����ϴ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20255,'this catelog con not uplaod file exceed',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20256,'���ļ�,�����Ҫ���ʹ��ļ�,�������Ա��ϵ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20256,'''file,if you want send max file,please contact to administrator!',8) 
GO
