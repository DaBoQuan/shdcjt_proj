delete from HtmlLabelIndex where id in (20520,20521)
go
delete from HtmlLabelInfo where indexid in (20520,20521)
go


INSERT INTO HtmlLabelIndex values(20520,'��������') 
GO
INSERT INTO HtmlLabelIndex values(20521,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20520,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20520,'Import Tasks',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20521,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20521,'Export Tasks',8) 
GO


