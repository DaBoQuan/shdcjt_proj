delete from SystemRights where id = 816
GO
delete from SystemRightsLanguage where id = 816
GO
delete from SystemRightDetail where id = 4327
GO
insert into SystemRights (id,rightdesc,righttype) values (816,'�ⲿXML����Ȩ��','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,8,'Xml Report Role','Xml Report Role') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,7,'�ⲿXML����Ȩ��','�ⲿXML����Ȩ��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,9,'�ⲿXML������','�ⲿXML������') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4327,'XML����������','XmlReportSetting:Edit',816) 
GO

delete from HtmlLabelIndex where id=22375 
GO
delete from HtmlLabelInfo where indexid=22375 
GO
INSERT INTO HtmlLabelIndex values(22375,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22375,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22375,'Report Type',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22375,'������',9) 
GO

delete from HtmlLabelIndex where id=22376 
GO
delete from HtmlLabelInfo where indexid=22376 
GO
INSERT INTO HtmlLabelIndex values(22376,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22376,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22376,'Report Date',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22376,'�������',9) 
GO

delete from HtmlLabelIndex where id=22377 
GO
delete from HtmlLabelInfo where indexid=22377 
GO
INSERT INTO HtmlLabelIndex values(22377,'�ⲿXML����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22377,'�ⲿXML����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22377,'Xml Report Outside',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22377,'�ⲿXML���',9) 
GO

delete from HtmlLabelIndex where id=22378 
GO
delete from HtmlLabelInfo where indexid=22378 
GO
INSERT INTO HtmlLabelIndex values(22378,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22378,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22378,'Season Report',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22378,'����',9) 
GO

delete from HtmlLabelIndex where id=22379 
GO
delete from HtmlLabelInfo where indexid=22379 
GO
INSERT INTO HtmlLabelIndex values(22379,'���걨') 
GO
INSERT INTO HtmlLabelInfo VALUES(22379,'���걨',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22379,'semiyearly',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22379,'�����',9) 
GO

delete from HtmlLabelIndex where id=22383 
GO
delete from HtmlLabelInfo where indexid=22383 
GO
INSERT INTO HtmlLabelIndex values(22383,'�����ļ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22383,'�����ļ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22383,'Setting Error',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22383,'�����ļ��e�`',9) 
GO

delete from HtmlLabelIndex where id=22384 
GO
delete from HtmlLabelInfo where indexid=22384 
GO
INSERT INTO HtmlLabelIndex values(22384,'��ѡ�񱨱�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22384,'��ѡ�񱨱�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22384,'Please select a report name',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22384,'Ո�x�������Q',9) 
GO

delete from HtmlLabelIndex where id=22385 
GO
delete from HtmlLabelInfo where indexid=22385 
GO
INSERT INTO HtmlLabelIndex values(22385,'����ǰ׺') 
GO
INSERT INTO HtmlLabelInfo VALUES(22385,'����ǰ׺',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22385,'File Flag',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22385,'���ǰ�Y',9) 
GO
