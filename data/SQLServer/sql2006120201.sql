delete from htmllabelindex where id=17717 or id=17718 or id=19985
go
delete from htmllabelinfo where indexid=17717 or indexid=17718 or indexid=19985
go
INSERT INTO HtmlLabelIndex values(17717,'Э��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17717,'Э��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17717,'Cowork Management',8) 
GO
 
INSERT INTO HtmlLabelIndex values(17718,'Э��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17718,'Э��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17718,'Cowork Set',8) 
GO

INSERT INTO HtmlLabelIndex values(19985,'Э�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19985,'Э�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19985,'Cowork Monitor',8) 
GO
INSERT INTO SystemLogItem VALUES(90,17855,'Э��')
GO
