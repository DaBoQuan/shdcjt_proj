delete from HtmlLabelIndex where id=21384 
/
delete from HtmlLabelInfo where indexid=21384 
/
INSERT INTO HtmlLabelIndex values(21384,'���β���') 
/
INSERT INTO HtmlLabelInfo VALUES(21384,'���β���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21384,'NetworkSegmentStrategy',8) 
/

delete from HtmlLabelIndex where id=21385 
/
delete from HtmlLabelInfo where indexid=21385 
/
INSERT INTO HtmlLabelIndex values(21385,'IP����') 
/
INSERT INTO HtmlLabelInfo VALUES(21385,'IP����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21385,'IPSegment',8) 
/

delete from HtmlLabelIndex where id=21386 
/
delete from HtmlLabelInfo where indexid=21386 
/
INSERT INTO HtmlLabelIndex values(21386,'����˵��') 
/
INSERT INTO HtmlLabelInfo VALUES(21386,'����˵��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21386,'SegmentDesc',8) 
/

delete from HtmlLabelIndex where id=21387 
/
delete from HtmlLabelInfo where indexid=21387 
/
INSERT INTO HtmlLabelIndex values(21387,'��ʼIP��ַ') 
/
INSERT INTO HtmlLabelInfo VALUES(21387,'��ʼIP��ַ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21387,'InceptIPAddress',8) 
/

delete from HtmlLabelIndex where id=21388 
/
delete from HtmlLabelInfo where indexid=21388 
/
INSERT INTO HtmlLabelIndex values(21388,'��ֹIP��ַ') 
/
INSERT INTO HtmlLabelInfo VALUES(21388,'��ֹIP��ַ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21388,'EndIPAddress',8) 
/

delete from HtmlLabelIndex where id=21389 
/
delete from HtmlLabelInfo where indexid=21389 
/
INSERT INTO HtmlLabelIndex values(21389,'��ָ��һ������1��223֮�����ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(21389,'��ָ��һ������1��223֮�����ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21389,'Please specify a range between 1 and 223 Numerical',8) 
/

delete from HtmlLabelIndex where id=21390 
/
delete from HtmlLabelInfo where indexid=21390 
/
INSERT INTO HtmlLabelIndex values(21390,'����һ����Ч��Ŀ') 
/
INSERT INTO HtmlLabelInfo VALUES(21390,'����һ����Ч��Ŀ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21390,'Is not a valid project',8) 
/

delete from HtmlLabelIndex where id=21392 
/
delete from HtmlLabelInfo where indexid=21392 
/
INSERT INTO HtmlLabelIndex values(21392,'��ָ��һ������0��255֮�����ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(21392,'��ָ��һ������0��255֮�����ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(21392,'Please specify a range between 0 and 255 Numerical',8) 
/

delete from HtmlLabelIndex where id=17581 
/
delete from HtmlLabelInfo where indexid=17581 
/
INSERT INTO HtmlLabelIndex values(17581,'ֹͣ') 
/
INSERT INTO HtmlLabelInfo VALUES(17581,'ֹͣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17581,'stop',8) 
/

delete from SystemRights where id = 773
/
delete from SystemRightsLanguage where id = 773
/
delete from SystemRightDetail where id = 4283
/
insert into SystemRights (id,rightdesc,righttype) values (773,'���β���ά��','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (773,8,'NetworkSegmentStrategy','NetworkSegmentStrategy') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (773,7,'���β���ά��','���β���ά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4283,'���β���ά��','NetworkSegmentStrategy:All',773) 
/
