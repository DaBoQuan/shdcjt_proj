delete from HtmlLabelIndex where id in (20040,20041)
go
delete from HtmlLabelInfo where indexid in (20040,20041)
go
INSERT INTO HtmlLabelIndex values(20040,'Excel�ļ�����ʧ�ܣ�����Excel�ļ���ʽ�Ƿ���ȷ��') 
go
INSERT INTO HtmlLabelIndex values(20041,'�ļ�������!') 
go
INSERT INTO HtmlLabelInfo VALUES(20040,'Excel�ļ�����ʧ�ܣ�����Excel�ļ���ʽ�Ƿ���ȷ��',7) 
go
INSERT INTO HtmlLabelInfo VALUES(20040,'Excel File Imported Error,Please Check File!',8) 
go
INSERT INTO HtmlLabelInfo VALUES(20041,'�ļ�������!',7) 
go
INSERT INTO HtmlLabelInfo VALUES(20041,'File is not existed!',8) 
go
