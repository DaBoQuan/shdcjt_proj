delete from HtmlLabelIndex where id in (20179,20180,20181)
go
delete from HtmlLabelInfo where indexid in (20179,20180,20181)
go

INSERT INTO HtmlLabelIndex values(20179,'ͼƬ�ϴ����') 
GO
INSERT INTO HtmlLabelIndex values(20180,'����ʵ�������ϴ�ͼƬ�Ĺ���') 
GO
INSERT INTO HtmlLabelIndex values(20181,'������ʹ�õĲ���ϵͳ�汾������Ӧ���ļ�����ѹ������setup.exe��װ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20179,'ͼƬ�ϴ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20179,'Image Uploader',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20180,'����ʵ�������ϴ�ͼƬ�Ĺ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20180,'support batch image uploader, support image thumbnail view and image preview functiond',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20181,'������ʹ�õĲ���ϵͳ�汾������Ӧ���ļ�����ѹ������setup.exe��װ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20181,'Extract the zip file.',8) 
GO