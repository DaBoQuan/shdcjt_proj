delete from HtmlLabelIndex where id=22482 
/
delete from HtmlLabelInfo where indexid=22482 
/
INSERT INTO HtmlLabelIndex values(22482,'�ֻ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(22482,'�ֻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22482,'Mobile',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22482,'�֙C̖�a',9) 
/

delete from HtmlLabelIndex where id=22483 
/
delete from HtmlLabelInfo where indexid=22483 
/
INSERT INTO HtmlLabelIndex values(22483,'��Ա���������б�') 
/
INSERT INTO HtmlLabelInfo VALUES(22483,'��Ա���������б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22483,'Birthday reminder list of staff',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22483,'�ˆT���������б�',9) 
/

delete from HtmlLabelIndex where id=22484 
/
delete from HtmlLabelInfo where indexid=22484 
/
INSERT INTO HtmlLabelIndex values(22484,'�ͻ����������б�') 
/
INSERT INTO HtmlLabelInfo VALUES(22484,'�ͻ����������б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22484,'Customer birthday reminder list',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22484,'�͑����������б�',9) 
/

delete from HtmlLabelIndex where id=22488 
/
delete from HtmlLabelInfo where indexid=22488 
/
INSERT INTO HtmlLabelIndex values(22488,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(22488,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22488,'Tomorrow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22488,'����',9) 
/

delete from HtmlLabelIndex where id=22492 
/
delete from HtmlLabelInfo where indexid=22492 
/
INSERT INTO HtmlLabelIndex values(22492,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(22492,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(22492,'The day after tomorrow',8) 
/
INSERT INTO HtmlLabelInfo VALUES(22492,'����',9) 
/


delete from SystemRights where id=821 
/
insert into SystemRights (id,rightdesc,righttype) values (821,'��Ա��������Ȩ��','3') 
/
delete from SystemRightsLanguage where id=821 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (821,8,'Birthday to remind staff competence','Birthday to remind staff competence') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (821,7,'��Ա��������Ȩ��','��Ա��������Ȩ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (821,9,'�ˆT�������љ���','�ˆT�������љ���') 
/
delete from SystemRightDetail where id=4332 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4332,'��Ա��������Ȩ��','HRM:BirthdayReminder',821) 
/