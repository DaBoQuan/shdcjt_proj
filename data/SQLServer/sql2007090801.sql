delete from HtmlLabelIndex where id=20888
go
delete from HtmlLabelInfo  where indexid=20888
GO
delete from HtmlLabelIndex where id=20889
go
delete from HtmlLabelInfo  where indexid=20889
GO
INSERT INTO HtmlLabelIndex values(20888,'�Ѿ��������Զ������ص�') 
GO
INSERT INTO HtmlLabelIndex values(20889,'�Ѿ�ѡ���˻���ص�') 
GO
INSERT INTO HtmlLabelInfo VALUES(20888,'�Ѿ��������Զ������ص�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20888,'Already Customize Meeting Address',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20889,'�Ѿ�ѡ���˻���ص�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20889,'Selected Meeting Address',8) 
GO

UPDATE license set cversion = '4.000.0907'
go