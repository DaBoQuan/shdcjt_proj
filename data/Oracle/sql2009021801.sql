delete from SystemRights where id = 709
/
delete from SystemRightsLanguage where id = 709
/
delete from SystemRightDetail where rightid = 709
/
insert into SystemRights (id,rightdesc,righttype) values (709,'�ʲ���������','7') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (709,7,'�ʲ���������','�ʲ���������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (709,8,'Capital Coding Setting','Capital Coding Setting') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4217,'�ʲ���������','CapitalCodingSet:All',709) 
/

delete from HtmlLabelIndex where id=22289 
/
delete from HtmlLabelInfo where indexid=22289 
/
INSERT INTO HtmlLabelIndex values(22289,'�ֲ����') 
/
delete from HtmlLabelIndex where id=22290 
/
delete from HtmlLabelInfo where indexid=22290 
/
INSERT INTO HtmlLabelIndex values(22290,'���ű��') 
/
delete from HtmlLabelIndex where id=22291 
/
delete from HtmlLabelInfo where indexid=22291 
/
INSERT INTO HtmlLabelIndex values(22291,'�ʲ����ͱ��') 
/
delete from HtmlLabelIndex where id=22293 
/
delete from HtmlLabelInfo where indexid=22293 
/
INSERT INTO HtmlLabelIndex values(22293,'�£��������ڣ�') 
/
delete from HtmlLabelIndex where id=22296 
/
delete from HtmlLabelInfo where indexid=22296 
/
INSERT INTO HtmlLabelIndex values(22296,'�£�������ڣ�') 
/
delete from HtmlLabelIndex where id=22299 
/
delete from HtmlLabelInfo where indexid=22299 
/
INSERT INTO HtmlLabelIndex values(22299,'���ŵ�����ˮ') 
/
delete from HtmlLabelIndex where id=22301 
/
delete from HtmlLabelInfo where indexid=22301 
/
INSERT INTO HtmlLabelIndex values(22301,'�ʲ����͵�����ˮ') 
/
delete from HtmlLabelIndex where id=22302 
/
delete from HtmlLabelInfo where indexid=22302 
/
INSERT INTO HtmlLabelIndex values(22302,'�������ڵ�����ˮ') 
/
delete from HtmlLabelIndex where id=22294 
/
delete from HtmlLabelInfo where indexid=22294 
/
INSERT INTO HtmlLabelIndex values(22294,'�գ��������ڣ�') 
/
delete from HtmlLabelIndex where id=22295 
/
delete from HtmlLabelInfo where indexid=22295 
/
INSERT INTO HtmlLabelIndex values(22295,'�꣨������ڣ�') 
/
delete from HtmlLabelIndex where id=22297 
/
delete from HtmlLabelInfo where indexid=22297 
/
INSERT INTO HtmlLabelIndex values(22297,'�գ�������ڣ�') 
/
delete from HtmlLabelIndex where id=22298 
/
delete from HtmlLabelInfo where indexid=22298 
/
INSERT INTO HtmlLabelIndex values(22298,'�ֲ�������ˮ') 
/
delete from HtmlLabelIndex where id=22292 
/
delete from HtmlLabelInfo where indexid=22292 
/
INSERT INTO HtmlLabelIndex values(22292,'�꣨�������ڣ�') 
/
delete from HtmlLabelIndex where id=22300 
/
delete from HtmlLabelInfo where indexid=22300 
/
INSERT INTO HtmlLabelIndex values(22300,'�ʲ��鵥����ˮ') 
/
delete from HtmlLabelIndex where id=22303 
/
delete from HtmlLabelInfo where indexid=22303 
/
INSERT INTO HtmlLabelIndex values(22303,'������ڵ�����ˮ') 
/
INSERT INTO HtmlLabelInfo VALUES(22289,'�ֲ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22289,'subcompany code',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22289,'�ֲ���̖',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22290,'���ű��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22290,'department code',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22290,'���T��̖',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22291,'�ʲ����ͱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22291,'capital type code',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22291,'�Y�a��;�̖',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22292,'�꣨�������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22292,'year (buy date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22292,'�ُ꣨�����ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22293,'�£��������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22293,'month (buy date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22293,'�£�ُ�����ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22294,'�գ��������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22294,'day(buy date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22294,'�գ�ُ�����ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22295,'�꣨������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22295,'year(Warehousing date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22295,'�꣨������ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22296,'�£�������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22296,'month(Warehousing date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22296,'�£�������ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22297,'�գ�������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22297,'day(Warehousing date)',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22297,'�գ�������ڣ�',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22298,'�ֲ�������ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22298,'subcompany Separate flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22298,'�ֲ��Ϊ���ˮ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22299,'���ŵ�����ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22299,'department independently flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22299,'���T�Ϊ���ˮ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22300,'�ʲ��鵥����ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22300,'capital group independently flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22300,'�Y�a�M�Ϊ���ˮ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22301,'�ʲ����͵�����ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22301,'capital type independently flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22301,'�Y�a��͆Ϊ���ˮ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22302,'�������ڵ�����ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22302,'buy date independently flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22302,'ُ�����چΪ���ˮ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22303,'������ڵ�����ˮ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22303,'Warehousing date independently flow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22303,'������چΪ���ˮ',9) 
/
delete from HtmlLabelIndex where id=22336 
/
delete from HtmlLabelInfo where indexid=22336 
/
INSERT INTO HtmlLabelIndex values(22336,'������') 
/
delete from HtmlLabelIndex where id=22337 
/
delete from HtmlLabelInfo where indexid=22337 
/
INSERT INTO HtmlLabelIndex values(22337,'�������') 
/
delete from HtmlLabelIndex where id=22335 
/
delete from HtmlLabelInfo where indexid=22335 
/
INSERT INTO HtmlLabelIndex values(22335,'��ͬǩ��') 
/
delete from HtmlLabelIndex where id=22334 
/
delete from HtmlLabelInfo where indexid=22334 
/
INSERT INTO HtmlLabelIndex values(22334,'�빺��') 
/
delete from HtmlLabelIndex where id=22333 
/
delete from HtmlLabelInfo where indexid=22333 
/
INSERT INTO HtmlLabelIndex values(22333,'�ɹ�״̬') 
/
INSERT INTO HtmlLabelInfo VALUES(22333,'�ɹ�״̬',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22333,'purchase state',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22333,'��ُ��B',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22334,'�빺��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22334,'Please purchase in',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22334,'Ոُ��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22335,'��ͬǩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22335,'Contract',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22335,'��ͬ��ӆ',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22336,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22336,'Payment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22336,'������',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22337,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22337,'Payment finished',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22337,'�����ꮅ',9) 
/
delete from HtmlLabelIndex where id=22338 
/
delete from HtmlLabelInfo where indexid=22338 
/
INSERT INTO HtmlLabelIndex values(22338,'�Ѹ����') 
/
INSERT INTO HtmlLabelInfo VALUES(22338,'�Ѹ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22338,'The amount paid',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22338,'�Ѹ����~',9) 
/
delete from HtmlLabelIndex where id=22339 
/
delete from HtmlLabelInfo where indexid=22339 
/
INSERT INTO HtmlLabelIndex values(22339,'�Ƿ񺣹ؼ��') 
/
delete from HtmlLabelIndex where id=22340 
/
delete from HtmlLabelInfo where indexid=22340 
/
INSERT INTO HtmlLabelIndex values(22340,'�豸����') 
/
delete from HtmlLabelIndex where id=22341 
/
delete from HtmlLabelInfo where indexid=22341 
/
INSERT INTO HtmlLabelIndex values(22341,'�����豸') 
/
INSERT INTO HtmlLabelInfo VALUES(22339,'�Ƿ񺣹ؼ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22339,'Whether the customs supervision',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22339,'�Ƿ��P�O��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22340,'�豸����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22340,'Power equipment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22340,'�O�书��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22341,'�����豸',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22341,'Ancillary equipment',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22341,'�����O��',9) 
/
delete from HtmlLabelIndex where id=22343 
/
delete from HtmlLabelInfo where indexid=22343 
/
INSERT INTO HtmlLabelIndex values(22343,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(22343,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22343,'Technical information',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22343,'���g�Y��',9) 
/
delete from HtmlLabelIndex where id=22342 
/
delete from HtmlLabelInfo where indexid=22342 
/
INSERT INTO HtmlLabelIndex values(22342,'��Ʒ���') 
/
INSERT INTO HtmlLabelInfo VALUES(22342,'��Ʒ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22342,'Spare parts',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22342,'��Ʒ���',9) 
/
delete from HtmlLabelIndex where id=22349 
/
delete from HtmlLabelInfo where indexid=22349 
/
INSERT INTO HtmlLabelIndex values(22349,'����') 
/
delete from HtmlLabelIndex where id=22350 
/
delete from HtmlLabelInfo where indexid=22350 
/
INSERT INTO HtmlLabelIndex values(22350,'��ѹ') 
/
INSERT INTO HtmlLabelInfo VALUES(22349,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22349,'Power',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22349,'����',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22350,'��ѹ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22350,'Voltage',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22350,'늉�',9) 
/
delete from HtmlLabelIndex where id=22351 
/
delete from HtmlLabelInfo where indexid=22351 
/
INSERT INTO HtmlLabelIndex values(22351,'������') 
/
delete from HtmlLabelIndex where id=22352 
/
delete from HtmlLabelInfo where indexid=22352 
/
INSERT INTO HtmlLabelIndex values(22352,'�ߴ�') 
/
INSERT INTO HtmlLabelInfo VALUES(22351,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22351,'Total weight',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22351,'������',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22352,'�ߴ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22352,'Size',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22352,'�ߴ�',9) 
/
delete from HtmlLabelIndex where id=21282 
/
delete from HtmlLabelInfo where indexid=21282 
/
INSERT INTO HtmlLabelIndex values(21282,'��ͬ��') 
/
INSERT INTO HtmlLabelInfo VALUES(21282,'��ͬ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21282,'Contract No.',8) 
/

delete from SystemRights where id = 817
/
delete from SystemRightsLanguage where id = 817
/
delete from SystemRightDetail where rightid = 817
/
insert into SystemRights (id,rightdesc,righttype) values (817,'�ʲ���ѯ����','2') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,9,'�Y�a��ԃ���x','�Y�a��ԃ���x') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,7,'�ʲ���ѯ����','�ʲ���ѯ����') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (817,8,'The definition of assets inquiry','The definition of assets inquiry') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4328,'�ʲ���ѯ����','cptdefinition:all',817) 
/

delete from HtmlLabelIndex where id=22366 
/
delete from HtmlLabelInfo where indexid=22366 
/
INSERT INTO HtmlLabelIndex values(22366,'�ʲ���ѯ����') 
/
INSERT INTO HtmlLabelInfo VALUES(22366,'�ʲ���ѯ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22366,'The definition of assets inquiry',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22366,'�Y�a��ԃ���x',9) 
/
delete from HtmlLabelIndex where id=22390 
/
delete from HtmlLabelInfo where indexid=22390 
/
INSERT INTO HtmlLabelIndex values(22390,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����') 
/
delete from HtmlLabelIndex where id=22393 
/
delete from HtmlLabelInfo where indexid=22393 
/
INSERT INTO HtmlLabelIndex values(22393,'�Ƿ���Ϊ�߼���ѯ����') 
/
delete from HtmlLabelIndex where id=22394 
/
delete from HtmlLabelInfo where indexid=22394 
/
INSERT INTO HtmlLabelIndex values(22394,'������ʾ˳��') 
/
delete from HtmlLabelIndex where id=22392 
/
delete from HtmlLabelInfo where indexid=22392 
/
INSERT INTO HtmlLabelIndex values(22392,'�Ƿ���Ϊ��������') 
/
delete from HtmlLabelIndex where id=22391 
/
delete from HtmlLabelInfo where indexid=22391 
/
INSERT INTO HtmlLabelIndex values(22391,'�Ƿ��б����') 
/
INSERT INTO HtmlLabelInfo VALUES(22390,'�Ƿ�ʹ�ø��ֶ���Ϊ��ѯ�������б����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22390,'Whether or not to use the field as a query or a list of headings',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22390,'�Ƿ�ʹ��ԓ�ֶ������ԃ�l�����б���}',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22391,'�Ƿ��б����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22391,'Whether the list of title',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22391,'�Ƿ��б���}',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22392,'�Ƿ���Ϊ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22392,'Whether as a search criteria',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22392,'�Ƿ����������l��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22393,'�Ƿ���Ϊ�߼���ѯ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22393,'Whether as a senior query',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22393,'�Ƿ�����߼���ԃ�l��',9) 
/
INSERT INTO HtmlLabelInfo VALUES(22394,'������ʾ˳��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22394,'The title of the display order',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22394,'���}�@ʾ���',9) 
/
delete from HtmlLabelIndex where id=22396 
/
delete from HtmlLabelInfo where indexid=22396 
/
INSERT INTO HtmlLabelIndex values(22396,'�Ƿ�ϵͳ�����ʲ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22396,'�Ƿ�ϵͳ�����ʲ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22396,'Whether the system-generated asset coding',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22396,'�Ƿ�ϵ�y�����Y�a���a',9) 
/

delete from HtmlLabelIndex where id=22315 
/
delete from HtmlLabelInfo where indexid=22315 
/
INSERT INTO HtmlLabelIndex values(22315,'�ʲ�����ά��') 
/
INSERT INTO HtmlLabelInfo VALUES(22315,'�ʲ�����ά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22315,'Maintenance of asset information',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22315,'�Y�a�Y�ϾS�o',9) 
/


delete from SystemRights where id =818
/
delete from SystemRightsLanguage where id =818
/
delete from SystemRightDetail where id =4329
/
insert into SystemRights (id,rightdesc,righttype) values (818,'�ʲ����ά��','0') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,8,'Changes in the maintenance of assets','Changes in the maintenance of assets') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,9,'�Y�a׃���S�o','�Y�a׃���S�o') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (818,7,'�ʲ����ά��','�ʲ����ά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4329,'�ʲ����','CptCapital:modify',818) 
/

delete from HtmlLabelIndex where id=21922 
/
delete from HtmlLabelInfo where indexid=21922 
/
INSERT INTO HtmlLabelIndex values(21922,'�����߷ֲ��Ը÷ֲ����в���') 
/
INSERT INTO HtmlLabelInfo VALUES(21922,'�����߷ֲ��Ը÷ֲ����в���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21922,'Click on the left branch of the Division for operations',8) 
/
INSERT INTO HtmlLabelInfo VALUES(21922,'�c����߅�ֲ���ԓ�ֲ��M�в���',9) 
/

delete from HtmlLabelIndex where id=22357 
/
delete from HtmlLabelInfo where indexid=22357 
/
INSERT INTO HtmlLabelIndex values(22357,'�½��ʲ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22357,'�½��ʲ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22357,'New assets',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22357,'�½��Y�a�Y��',9) 
/

delete from HtmlLabelIndex where id=22457 
/
delete from HtmlLabelInfo where indexid=22457 
/
INSERT INTO HtmlLabelIndex values(22457,'ά������') 
/
INSERT INTO HtmlLabelInfo VALUES(22457,'ά������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22457,'Repair period',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22457,'�S������',9) 
/
delete from HtmlLabelIndex where id=22459 
/
delete from HtmlLabelInfo where indexid=22459 
/
INSERT INTO HtmlLabelIndex values(22459,'�ʲ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22459,'�ʲ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22459,'Asset repair',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22459,'�Y�a����',9) 
/
