Delete HtmlLabelIndex where id in(19410,20482,19490)
Go
Delete HtmlLabelInfo where indexid in(19410,20482,19490)
Go
INSERT INTO HtmlLabelIndex values(19410,'����Ŀ¼����') 
GO
INSERT INTO HtmlLabelIndex values(20482,'����Ŀ¼') 
GO
INSERT INTO HtmlLabelIndex values(19490,'����Ŀ¼��ʾ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19410,'����Ŀ¼����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19410,'dummy catalog Setting',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19490,'����Ŀ¼��ʾ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19490,'View by dummy catalog',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20482,'����Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20482,'dummy catalog',8) 
GO

Delete HtmlLabelIndex where id=20484
Go
Delete HtmlLabelInfo where indexid=20484
Go

INSERT INTO HtmlLabelIndex values(20484,'�����ĵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(20484,'�����ĵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20484,'Input Docs',8) 
GO


Delete HtmlLabelIndex where id=20485
Go
Delete HtmlLabelInfo where indexid=20485
Go
Delete HtmlLabelIndex where id=20486
Go
Delete HtmlLabelInfo where indexid=20486
Go

INSERT INTO HtmlLabelIndex values(20485,'����ѡ�н��������Ŀ¼') 
GO
INSERT INTO HtmlLabelIndex values(20486,'����ȫ�����������Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(20485,'����ѡ�н��������Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20485,'Import Seleted To Dummy Catelog',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20486,'����ȫ�����������Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20486,'Import All To Dummy Catelog',8) 
GO


Delete HtmlLabelIndex where id=20487
Go
Delete HtmlLabelInfo where indexid=20487
Go

INSERT INTO HtmlLabelIndex values(20487,'���뵽����Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(20487,'���뵽����Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20487,'Import To Dummy Catelog',8) 
GO


Delete HtmlLabelIndex where id=19485
Go
Delete HtmlLabelInfo where indexid=19485
Go
INSERT INTO HtmlLabelIndex values(19485,'����Ŀ¼�ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19485,'����Ŀ¼�ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19485,'Dummy Catelog Field',8) 
GO

Delete HtmlLabelIndex where id=19414
Go
Delete HtmlLabelInfo where indexid=19414
Go
INSERT INTO HtmlLabelIndex values(19414,'ϵͳ��֧��10�����ϵ�����Ŀ¼��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19414,'ϵͳ��֧��10�����ϵ�����Ŀ¼��',7) 
GO

Delete HtmlLabelIndex where id=20497
Go
Delete HtmlLabelInfo where indexid=20497
Go
Delete HtmlLabelIndex where id=20498
Go
Delete HtmlLabelInfo where indexid=20498
Go
INSERT INTO HtmlLabelIndex values(20497,'����ʹ������Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(20497,'����ʹ������Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20497,'Allow To Use Dummy Catalog',8) 
GO
INSERT INTO HtmlLabelIndex values(20498,'Ĭ������Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(20498,'Ĭ������Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20498,'Defualt Dummy Catalog',8) 
GO

Delete HtmlLabelIndex where id=19133
Go
Delete HtmlLabelInfo where indexid=19133
Go
INSERT INTO HtmlLabelIndex values(19133,'�Ƴ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19133,'�Ƴ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19133,'Remove',8) 
GO

Delete HtmlLabelIndex where id=20515
Go
Delete HtmlLabelInfo where indexid=20515
Go
INSERT INTO HtmlLabelIndex values(20515,'����ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20515,'����ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20515,'Import Date',8) 

GO
Delete HtmlLabelIndex where id=20516
Go
Delete HtmlLabelInfo where indexid=20516
Go
Delete HtmlLabelIndex where id=20517
Go
Delete HtmlLabelInfo where indexid=20517
Go
INSERT INTO HtmlLabelIndex values(20517,'�ѷ���') 
GO
INSERT INTO HtmlLabelIndex values(20516,'δ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20516,'δ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20516,'No Public',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20517,'�ѷ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20517,'Publiced',8) 
GO
delete HtmlLabelIndex where id=20551
GO
delete HtmlLabelInfo where indexid=20551
GO
INSERT INTO HtmlLabelIndex values(20551,'û��ѡ���κ�����!') 
GO
INSERT INTO HtmlLabelInfo VALUES(20551,'û��ѡ���κ�����!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20551,'None has been selected!',8) 
GO

delete HtmlLabelIndex where id=20552
GO
delete HtmlLabelInfo where indexid=20552
GO
INSERT INTO HtmlLabelIndex values(20552,'������Ŀ¼�Ѿ�������,���ܽ���ɾ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20552,'������Ŀ¼�Ѿ�������,���ܽ���ɾ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20552,'This dummy catagory is been used,Can not delete!',8) 
GO

insert into SystemRights (id,rightdesc,righttype) values (716,'����Ŀ¼','1') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (716,8,'Dummy Category','Dummy Category') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (716,7,'����Ŀ¼','����Ŀ¼') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4224,'����Ŀ¼ά��','DummyCata:Maint',716) 
GO