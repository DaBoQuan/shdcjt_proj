delete from HtmlLabelIndex where id=20221 
GO
delete from HtmlLabelInfo where indexid=20221 
GO
INSERT INTO HtmlLabelIndex values(20221,'�ճ̹�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20221,'�ճ̹�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20221,'Work Plan Share Setting',8) 
GO

delete from HtmlLabelIndex where id=21503 
GO
delete from HtmlLabelInfo where indexid=21503 
GO
INSERT INTO HtmlLabelIndex values(21503,'�����ճ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(21503,'�����ճ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21503,'share calendar',8) 
GO

delete from HtmlLabelIndex where id=21504 
GO
delete from HtmlLabelInfo where indexid=21504 
GO
INSERT INTO HtmlLabelIndex values(21504,'���������') 
GO
INSERT INTO HtmlLabelInfo VALUES(21504,'���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21504,'shared object',8) 
GO

delete from HtmlLabelIndex where id=19117 
GO
delete from HtmlLabelInfo where indexid=19117 
GO
INSERT INTO HtmlLabelIndex values(19117,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19117,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19117,'Share Object',8) 
GO

delete from SystemRights where id=784
GO
insert into SystemRights (id,rightdesc,righttype) values (784,'�ճ̹���','7') 
GO
delete from SystemRightsLanguage where id=784
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (784,8,'clander share','clander share') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (784,7,'�ճ̹���','�ճ̹���') 
GO
delete from SystemRightDetail where id=4294
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4294,'�ճ̹���','SHARERIGHT:WORKPLAN',784) 
GO
