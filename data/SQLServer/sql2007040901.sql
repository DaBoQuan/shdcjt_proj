delete HtmlLabelIndex where id in(20281,20282,20283,20284,20285)
GO
delete HtmlLabelInfo where  indexid in(20281,20282,20283,20284,20285)
GO
INSERT INTO HtmlLabelIndex values(20285,'����') 
GO
INSERT INTO HtmlLabelIndex values(20282,'����') 
GO
INSERT INTO HtmlLabelIndex values(20283,'����') 
GO
INSERT INTO HtmlLabelIndex values(20284,'����') 
GO
INSERT INTO HtmlLabelIndex values(20281,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20281,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20281,'roll direction',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20282,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20282,'Left',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20283,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20283,'Right',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20284,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20284,'Up',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20285,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20285,'Down',8) 
GO
