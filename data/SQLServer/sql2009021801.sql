delete from SystemRights where id = 709
go
delete from SystemRightsLanguage where id = 709
go
delete from SystemRightDetail where rightid = 709
go
insert into SystemRights (id,rightdesc,righttype) values (709,'�ʲ���������','7') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (709,7,'�ʲ���������','�ʲ���������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (709,8,'Capital Coding Setting','Capital Coding Setting') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4217,'�ʲ���������','CapitalCodingSet:All',709) 
GO

delete from HtmlLabelIndex where id=22289 
GO
delete from HtmlLabelInfo where indexid=22289 
GO
INSERT INTO HtmlLabelIndex values(22289,'�ֲ����') 
GO
delete from HtmlLabelIndex where id=22290 
GO
delete from HtmlLabelInfo where indexid=22290 
GO
INSERT INTO HtmlLabelIndex values(22290,'���ű��') 
GO
delete from HtmlLabelIndex where id=22291 
GO
delete from HtmlLabelInfo where indexid=22291 
GO
INSERT INTO HtmlLabelIndex values(22291,'�ʲ����ͱ��') 
GO
delete from HtmlLabelIndex where id=22293 
GO
delete from HtmlLabelInfo where indexid=22293 
GO
INSERT INTO HtmlLabelIndex values(22293,'�£��������ڣ�') 
GO
delete from HtmlLabelIndex where id=22296 
GO
delete from HtmlLabelInfo where indexid=22296 
GO
INSERT INTO HtmlLabelIndex values(22296,'�£�������ڣ�') 
GO
delete from HtmlLabelIndex where id=22299 
GO
delete from HtmlLabelInfo where indexid=22299 
GO
INSERT INTO HtmlLabelIndex values(22299,'���ŵ�����ˮ') 
GO
delete from HtmlLabelIndex where id=22301 
GO
delete from HtmlLabelInfo where indexid=22301 
GO
INSERT INTO HtmlLabelIndex values(22301,'�ʲ����͵�����ˮ') 
GO
delete from HtmlLabelIndex where id=22302 
GO
delete from HtmlLabelInfo where indexid=22302 
GO
INSERT INTO HtmlLabelIndex values(22302,'�������ڵ�����ˮ') 
GO
delete from HtmlLabelIndex where id=22294 
GO
delete from HtmlLabelInfo where indexid=22294 
GO
INSERT INTO HtmlLabelIndex values(22294,'�գ��������ڣ�') 
GO
delete from HtmlLabelIndex where id=22295 
GO
delete from HtmlLabelInfo where indexid=22295 
GO
INSERT INTO HtmlLabelIndex values(22295,'�꣨������ڣ�') 
GO
delete from HtmlLabelIndex where id=22297 
GO
delete from HtmlLabelInfo where indexid=22297 
GO
INSERT INTO HtmlLabelIndex values(22297,'�գ�������ڣ�') 
GO
delete from HtmlLabelIndex where id=22298 
GO
delete from HtmlLabelInfo where indexid=22298 
GO
INSERT INTO HtmlLabelIndex values(22298,'�ֲ�������ˮ') 
GO
delete from HtmlLabelIndex where id=22292 
GO
delete from HtmlLabelInfo where indexid=22292 
GO
INSERT INTO HtmlLabelIndex values(22292,'�꣨�������ڣ�') 
GO
delete from HtmlLabelIndex where id=22300 
GO
delete from HtmlLabelInfo where indexid=22300 
GO
INSERT INTO HtmlLabelIndex values(22300,'�ʲ��鵥����ˮ') 
GO
delete from HtmlLabelIndex where id=22303 
GO
delete from HtmlLabelInfo where indexid=22303 
GO
INSERT INTO HtmlLabelIndex values(22303,'������ڵ�����ˮ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22289,'�ֲ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22289,'subcompany code',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22289,'�ֲ���̖',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22290,'���ű��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22290,'department code',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22290,'���T��̖',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22291,'�ʲ����ͱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22291,'capital type code',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22291,'�Y�a��;�̖',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22292,'�꣨�������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22292,'year (buy date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22292,'�ُ꣨�����ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22293,'�£��������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22293,'month (buy date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22293,'�£�ُ�����ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22294,'�գ��������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22294,'day(buy date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22294,'�գ�ُ�����ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22295,'�꣨������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22295,'year(Warehousing date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22295,'�꣨������ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22296,'�£�������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22296,'month(Warehousing date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22296,'�£�������ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22297,'�գ�������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22297,'day(Warehousing date)',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22297,'�գ�������ڣ�',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22298,'�ֲ�������ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22298,'subcompany Separate flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22298,'�ֲ��Ϊ���ˮ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22299,'���ŵ�����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22299,'department independently flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22299,'���T�Ϊ���ˮ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22300,'�ʲ��鵥����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22300,'capital group independently flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22300,'�Y�a�M�Ϊ���ˮ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22301,'�ʲ����͵�����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22301,'capital type independently flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22301,'�Y�a��͆Ϊ���ˮ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22302,'�������ڵ�����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22302,'buy date independently flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22302,'ُ�����چΪ���ˮ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22303,'������ڵ�����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22303,'Warehousing date independently flow',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22303,'������چΪ���ˮ',9) 
GO
delete from HtmlLabelIndex where id=22336 
GO
delete from HtmlLabelInfo where indexid=22336 
GO
INSERT INTO HtmlLabelIndex values(22336,'������') 
GO
delete from HtmlLabelIndex where id=22337 
GO
delete from HtmlLabelInfo where indexid=22337 
GO
INSERT INTO HtmlLabelIndex values(22337,'�������') 
GO
delete from HtmlLabelIndex where id=22335 
GO
delete from HtmlLabelInfo where indexid=22335 
GO
INSERT INTO HtmlLabelIndex values(22335,'��ͬǩ��') 
GO
delete from HtmlLabelIndex where id=22334 
GO
delete from HtmlLabelInfo where indexid=22334 
GO
INSERT INTO HtmlLabelIndex values(22334,'�빺��') 
GO
delete from HtmlLabelIndex where id=22333 
GO
delete from HtmlLabelInfo where indexid=22333 
GO
INSERT INTO HtmlLabelIndex values(22333,'�ɹ�״̬') 
GO
INSERT INTO HtmlLabelInfo VALUES(22333,'�ɹ�״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22333,'purchase state',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22333,'��ُ��B',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22334,'�빺��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22334,'Please purchase in',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22334,'Ոُ��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22335,'��ͬǩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22335,'Contract',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22335,'��ͬ��ӆ',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22336,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22336,'Payment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22336,'������',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22337,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22337,'Payment finished',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22337,'�����ꮅ',9) 
GO
delete from HtmlLabelIndex where id=22338 
GO
delete from HtmlLabelInfo where indexid=22338 
GO
INSERT INTO HtmlLabelIndex values(22338,'�Ѹ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22338,'�Ѹ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22338,'The amount paid',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22338,'�Ѹ����~',9) 
GO
delete from HtmlLabelIndex where id=22339 
GO
delete from HtmlLabelInfo where indexid=22339 
GO
INSERT INTO HtmlLabelIndex values(22339,'�Ƿ񺣹ؼ��') 
GO
delete from HtmlLabelIndex where id=22340 
GO
delete from HtmlLabelInfo where indexid=22340 
GO
INSERT INTO HtmlLabelIndex values(22340,'�豸����') 
GO
delete from HtmlLabelIndex where id=22341 
GO
delete from HtmlLabelInfo where indexid=22341 
GO
INSERT INTO HtmlLabelIndex values(22341,'�����豸') 
GO
INSERT INTO HtmlLabelInfo VALUES(22339,'�Ƿ񺣹ؼ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22339,'Whether the customs supervision',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22339,'�Ƿ��P�O��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22340,'�豸����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22340,'Power equipment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22340,'�O�书��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22341,'�����豸',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22341,'Ancillary equipment',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22341,'�����O��',9) 
GO
delete from HtmlLabelIndex where id=22343 
GO
delete from HtmlLabelInfo where indexid=22343 
GO
INSERT INTO HtmlLabelIndex values(22343,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22343,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22343,'Technical information',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22343,'���g�Y��',9) 
GO
delete from HtmlLabelIndex where id=22342 
GO
delete from HtmlLabelInfo where indexid=22342 
GO
INSERT INTO HtmlLabelIndex values(22342,'��Ʒ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(22342,'��Ʒ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22342,'Spare parts',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22342,'��Ʒ���',9) 
GO
delete from HtmlLabelIndex where id=22349 
GO
delete from HtmlLabelInfo where indexid=22349 
GO
INSERT INTO HtmlLabelIndex values(22349,'����') 
GO
delete from HtmlLabelIndex where id=22350 
GO
delete from HtmlLabelInfo where indexid=22350 
GO
INSERT INTO HtmlLabelIndex values(22350,'��ѹ') 
GO
INSERT INTO HtmlLabelInfo VALUES(22349,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22349,'Power',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22349,'����',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22350,'��ѹ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22350,'Voltage',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22350,'늉�',9) 
GO
delete from HtmlLabelIndex where id=22351 
GO
delete from HtmlLabelInfo where indexid=22351 
GO
INSERT INTO HtmlLabelIndex values(22351,'������') 
GO
delete from HtmlLabelIndex where id=22352 
GO
delete from HtmlLabelInfo where indexid=22352 
GO
INSERT INTO HtmlLabelIndex values(22352,'�ߴ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(22351,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22351,'Total weight',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22351,'������',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22352,'�ߴ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22352,'Size',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22352,'�ߴ�',9) 
GO
delete from HtmlLabelIndex where id=21282 
GO
delete from HtmlLabelInfo where indexid=21282 
GO
INSERT INTO HtmlLabelIndex values(21282,'��ͬ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(21282,'��ͬ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21282,'Contract No.',8) 
GO

delete from SystemRights where id = 817
go
delete from SystemRightsLanguage where id = 817
go
delete from SystemRightDetail where rightid = 817
go
insert into SystemRights (id,rightdesc,righttype) values (817,'�ʲ���ѯ����','2') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,9,'�Y�a��ԃ���x','�Y�a��ԃ���x') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,7,'�ʲ���ѯ����','�ʲ���ѯ����') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,8,'The definition of assets inquiry','The definition of assets inquiry') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4328,'�ʲ���ѯ����','cptdefinition:all',817) 
GO

delete from HtmlLabelIndex where id=22366 
GO
delete from HtmlLabelInfo where indexid=22366 
GO
INSERT INTO HtmlLabelIndex values(22366,'�ʲ���ѯ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22366,'�ʲ���ѯ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22366,'The definition of assets inquiry',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22366,'�Y�a��ԃ���x',9) 
GO
delete from HtmlLabelIndex where id=22390 
GO
delete from HtmlLabelInfo where indexid=22390 
GO
INSERT INTO HtmlLabelIndex values(22390,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����') 
GO
delete from HtmlLabelIndex where id=22393 
GO
delete from HtmlLabelInfo where indexid=22393 
GO
INSERT INTO HtmlLabelIndex values(22393,'�Ƿ���Ϊ�߼���ѯ����') 
GO
delete from HtmlLabelIndex where id=22394 
GO
delete from HtmlLabelInfo where indexid=22394 
GO
INSERT INTO HtmlLabelIndex values(22394,'������ʾ˳��') 
GO
delete from HtmlLabelIndex where id=22392 
GO
delete from HtmlLabelInfo where indexid=22392 
GO
INSERT INTO HtmlLabelIndex values(22392,'�Ƿ���Ϊ��������') 
GO
delete from HtmlLabelIndex where id=22391 
GO
delete from HtmlLabelInfo where indexid=22391 
GO
INSERT INTO HtmlLabelIndex values(22391,'�Ƿ��б����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22390,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22390,'Whether or not to use the field as a query or a list of headings',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22390,'�Ƿ�ʹ��ԓ�ֶ������ԃ�l�����б���}',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22391,'�Ƿ��б����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22391,'Whether the list of title',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22391,'�Ƿ��б���}',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22392,'�Ƿ���Ϊ��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22392,'Whether as a search criteria',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22392,'�Ƿ����������l��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22393,'�Ƿ���Ϊ�߼���ѯ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22393,'Whether as a senior query',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22393,'�Ƿ�����߼���ԃ�l��',9) 
GO
INSERT INTO HtmlLabelInfo VALUES(22394,'������ʾ˳��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22394,'The title of the display order',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22394,'���}�@ʾ���',9) 
GO
delete from HtmlLabelIndex where id=22396 
GO
delete from HtmlLabelInfo where indexid=22396 
GO
INSERT INTO HtmlLabelIndex values(22396,'�Ƿ�ϵͳ�����ʲ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22396,'�Ƿ�ϵͳ�����ʲ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22396,'Whether the system-generated asset coding',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22396,'�Ƿ�ϵ�y�����Y�a���a',9) 
GO

delete from HtmlLabelIndex where id=22315 
GO
delete from HtmlLabelInfo where indexid=22315 
GO
INSERT INTO HtmlLabelIndex values(22315,'�ʲ�����ά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(22315,'�ʲ�����ά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22315,'Maintenance of asset information',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22315,'�Y�a�Y�ϾS�o',9) 
GO


delete from SystemRights where id =818
GO
delete from SystemRightsLanguage where id =818
GO
delete from SystemRightDetail where id =4329
GO
insert into SystemRights (id,rightdesc,righttype) values (818,'�ʲ����ά��','0') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,8,'Changes in the maintenance of assets','Changes in the maintenance of assets') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,9,'�Y�a׃���S�o','�Y�a׃���S�o') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,7,'�ʲ����ά��','�ʲ����ά��') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4329,'�ʲ����','CptCapital:modify',818) 
GO

delete from HtmlLabelIndex where id=21922 
GO
delete from HtmlLabelInfo where indexid=21922 
GO
INSERT INTO HtmlLabelIndex values(21922,'�����߷ֲ��Ը÷ֲ����в���') 
GO
INSERT INTO HtmlLabelInfo VALUES(21922,'�����߷ֲ��Ը÷ֲ����в���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(21922,'Click on the left branch of the Division for operations',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(21922,'�c����߅�ֲ���ԓ�ֲ��M�в���',9) 
GO

delete from HtmlLabelIndex where id=22357 
GO
delete from HtmlLabelInfo where indexid=22357 
GO
INSERT INTO HtmlLabelIndex values(22357,'�½��ʲ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22357,'�½��ʲ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22357,'New assets',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22357,'�½��Y�a�Y��',9) 
GO

delete from HtmlLabelIndex where id=22457 
GO
delete from HtmlLabelInfo where indexid=22457 
GO
INSERT INTO HtmlLabelIndex values(22457,'ά������') 
GO
INSERT INTO HtmlLabelInfo VALUES(22457,'ά������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22457,'Repair period',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22457,'�S������',9) 
GO
delete from HtmlLabelIndex where id=22459 
GO
delete from HtmlLabelInfo where indexid=22459 
GO
INSERT INTO HtmlLabelIndex values(22459,'�ʲ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(22459,'�ʲ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(22459,'Asset repair',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(22459,'�Y�a����',9) 
GO