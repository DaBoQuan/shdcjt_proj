delete from SystemRights where id = 816
/
delete from SystemRightsLanguage where id = 816
/
delete from SystemRightDetail where id = 4327
/
insert into SystemRights (id,rightdesc,righttype) values (816,'�ⲿXML����Ȩ��','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,8,'Xml Report Role','Xml Report Role') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,7,'�ⲿXML����Ȩ��','�ⲿXML����Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (816,9,'�ⲿXML������','�ⲿXML������') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4327,'XML����������','XmlReportSetting:Edit',816) 
/

delete from HtmlLabelIndex where id=22375 
/
delete from HtmlLabelInfo where indexid=22375 
/
INSERT INTO HtmlLabelIndex values(22375,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(22375,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22375,'Report Type',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22375,'������',9) 
/

delete from HtmlLabelIndex where id=22376 
/
delete from HtmlLabelInfo where indexid=22376 
/
INSERT INTO HtmlLabelIndex values(22376,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(22376,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22376,'Report Date',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22376,'�������',9) 
/

delete from HtmlLabelIndex where id=22377 
/
delete from HtmlLabelInfo where indexid=22377 
/
INSERT INTO HtmlLabelIndex values(22377,'�ⲿXML����') 
/
INSERT INTO HtmlLabelInfo VALUES(22377,'�ⲿXML����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22377,'Xml Report Outside',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22377,'�ⲿXML���',9) 
/

delete from HtmlLabelIndex where id=22378 
/
delete from HtmlLabelInfo where indexid=22378 
/
INSERT INTO HtmlLabelIndex values(22378,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(22378,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22378,'Season Report',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22378,'����',9) 
/

delete from HtmlLabelIndex where id=22379 
/
delete from HtmlLabelInfo where indexid=22379 
/
INSERT INTO HtmlLabelIndex values(22379,'���걨') 
/
INSERT INTO HtmlLabelInfo VALUES(22379,'���걨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22379,'semiyearly',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22379,'�����',9) 
/

delete from HtmlLabelIndex where id=22383 
/
delete from HtmlLabelInfo where indexid=22383 
/
INSERT INTO HtmlLabelIndex values(22383,'�����ļ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22383,'�����ļ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22383,'Setting Error',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22383,'�����ļ��e�`',9) 
/

delete from HtmlLabelIndex where id=22384 
/
delete from HtmlLabelInfo where indexid=22384 
/
INSERT INTO HtmlLabelIndex values(22384,'��ѡ�񱨱�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22384,'��ѡ�񱨱�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22384,'Please select a report name',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22384,'Ո�x�������Q',9) 
/

delete from HtmlLabelIndex where id=22385 
/
delete from HtmlLabelInfo where indexid=22385 
/
INSERT INTO HtmlLabelIndex values(22385,'����ǰ׺') 
/
INSERT INTO HtmlLabelInfo VALUES(22385,'����ǰ׺',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22385,'File Flag',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22385,'���ǰ�Y',9) 
/
