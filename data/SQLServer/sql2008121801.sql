delete from SystemRights where id = 809
go
delete from SystemRightsLanguage where id = 809
go
delete from SystemRightDetail where rightid = 809
go

insert into SystemRights (id,rightdesc,righttype) values (809,'���̱���Ϊ�ĵ�','5') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (809,7,'���̱���Ϊ�ĵ�','���̱���Ϊ�ĵ�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (809,8,'Workflow to generate documents','Workflow to generate documents') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (809,9,'���̱�����ęn','���̱�����ęn') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4320,'���̱���Ϊ�ĵ�','workflowtodocument:all',809) 
GO

delete from HtmlLabelIndex where id=22220 
GO
delete from HtmlLabelInfo where indexid=22220 
GO
INSERT INTO HtmlLabelIndex values(22220,'���̱���Ϊ�ĵ��Ĵ��·��') 
GO
INSERT INTO HtmlLabelInfo VALUES(22220,'���̱���Ϊ�ĵ��Ĵ��·��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22220,'workflow saved as the document store path',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22220,'���̱�����ęn�Ĵ�ŷ�·��',9) 
GO

delete from HtmlLabelIndex where id=22231 
GO
delete from HtmlLabelInfo where indexid=22231 
GO
INSERT INTO HtmlLabelIndex values(22231,'���̴�Ϊ�ĵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(22231,'���̴�Ϊ�ĵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22231,'workflow saved as document',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22231,'���̴���ęn',9) 
GO

delete from HtmlLabelIndex where id=22232 
GO
delete from HtmlLabelInfo where indexid=22232 
GO
INSERT INTO HtmlLabelIndex values(22232,'��ȷ��Ҫ����Щ���̱���Ϊ�ĵ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(22232,'��ȷ��Ҫ����Щ���̱���Ϊ�ĵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22232,'Are you sure to save these workflow as documents?',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22232,'���_��Ҫ���@Щ���̱�����ęn�᣿',9) 
GO