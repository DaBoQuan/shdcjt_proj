Delete HtmlLabelIndex where id in(19410,20482,19490)
/
Delete HtmlLabelInfo where indexid in(19410,20482,19490)
/
INSERT INTO HtmlLabelIndex values(19410,'����Ŀ¼����') 
/
INSERT INTO HtmlLabelIndex values(20482,'����Ŀ¼') 
/
INSERT INTO HtmlLabelIndex values(19490,'����Ŀ¼��ʾ') 
/
INSERT INTO HtmlLabelInfo VALUES(19410,'����Ŀ¼����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19410,'dummy catalog Setting',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19490,'����Ŀ¼��ʾ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19490,'View by dummy catalog',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20482,'����Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20482,'dummy catalog',8) 
/


Delete HtmlLabelIndex where id=20484
/
Delete HtmlLabelInfo where indexid=20484
/

INSERT INTO HtmlLabelIndex values(20484,'�����ĵ�') 
/
INSERT INTO HtmlLabelInfo VALUES(20484,'�����ĵ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20484,'Input Docs',8) 
/


Delete HtmlLabelIndex where id=20485
/
Delete HtmlLabelInfo where indexid=20485
/
Delete HtmlLabelIndex where id=20486
/
Delete HtmlLabelInfo where indexid=20486
/

INSERT INTO HtmlLabelIndex values(20485,'����ѡ�н��������Ŀ¼') 
/
INSERT INTO HtmlLabelIndex values(20486,'����ȫ�����������Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(20485,'����ѡ�н��������Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20485,'Import Seleted To Dummy Catelog',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20486,'����ȫ�����������Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20486,'Import All To Dummy Catelog',8) 
/


Delete HtmlLabelIndex where id=20487
/
Delete HtmlLabelInfo where indexid=20487
/

INSERT INTO HtmlLabelIndex values(20487,'���뵽����Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(20487,'���뵽����Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20487,'Import To Dummy Catelog',8) 
/


Delete HtmlLabelIndex where id=19485
/
Delete HtmlLabelInfo where indexid=19485
/
INSERT INTO HtmlLabelIndex values(19485,'����Ŀ¼�ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19485,'����Ŀ¼�ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19485,'Dummy Catelog Field',8) 
/

Delete HtmlLabelIndex where id=19414
/
Delete HtmlLabelInfo where indexid=19414
/
INSERT INTO HtmlLabelIndex values(19414,'ϵͳ��֧��10�����ϵ�����Ŀ¼��') 
/
INSERT INTO HtmlLabelInfo VALUES(19414,'ϵͳ��֧��10�����ϵ�����Ŀ¼��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19414,'The system doesn''t support 10 level of dummy catelog field!',8) 
/


Delete HtmlLabelIndex where id=20497
/
Delete HtmlLabelInfo where indexid=20497
/
Delete HtmlLabelIndex where id=20498
/
Delete HtmlLabelInfo where indexid=20498
/
INSERT INTO HtmlLabelIndex values(20497,'����ʹ������Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(20497,'����ʹ������Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20497,'Allow To Use Dummy Catalog',8) 
/
INSERT INTO HtmlLabelIndex values(20498,'Ĭ������Ŀ¼') 
/
INSERT INTO HtmlLabelInfo VALUES(20498,'Ĭ������Ŀ¼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20498,'Defualt Dummy Catalog',8) 
/

Delete HtmlLabelIndex where id=19133
/
Delete HtmlLabelInfo where indexid=19133
/
INSERT INTO HtmlLabelIndex values(19133,'�Ƴ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19133,'�Ƴ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19133,'Remove',8) 
/

Delete HtmlLabelIndex where id=20515
/
Delete HtmlLabelInfo where indexid=20515
/
INSERT INTO HtmlLabelIndex values(20515,'����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(20515,'����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20515,'Import Date',8) 
/
Delete HtmlLabelIndex where id=20516
/
Delete HtmlLabelInfo where indexid=20516
/
Delete HtmlLabelIndex where id=20517
/
Delete HtmlLabelInfo where indexid=20517
/
INSERT INTO HtmlLabelIndex values(20517,'�ѷ���') 
/
INSERT INTO HtmlLabelIndex values(20516,'δ����') 
/
INSERT INTO HtmlLabelInfo VALUES(20516,'δ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20516,'No Public',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20517,'�ѷ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20517,'Publiced',8) 
/


delete HtmlLabelIndex where id=20551
/
delete HtmlLabelInfo where indexid=20551
/
INSERT INTO HtmlLabelIndex values(20551,'û��ѡ���κ�����!') 
/
INSERT INTO HtmlLabelInfo VALUES(20551,'û��ѡ���κ�����!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20551,'None has been selected!',8) 
/

delete HtmlLabelIndex where id=20552
/
delete HtmlLabelInfo where indexid=20552
/
INSERT INTO HtmlLabelIndex values(20552,'������Ŀ¼�Ѿ�������,���ܽ���ɾ��') 
/
INSERT INTO HtmlLabelInfo VALUES(20552,'������Ŀ¼�Ѿ�������,���ܽ���ɾ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20552,'This dummy catagory is been used,Can not delete!',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (716,'����Ŀ¼','1') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (716,8,'Dummy Category','Dummy Category') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (716,7,'����Ŀ¼','����Ŀ¼') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4224,'����Ŀ¼ά��','DummyCata:Maint',716) 
/