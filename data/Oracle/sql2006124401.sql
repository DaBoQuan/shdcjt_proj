
delete from  HtmlLabelIndex  where id=20100
/

delete from  HtmlLabelIndex  where id=20099
/

delete from  HtmlLabelInfo  where indexid=20100
/
delete from  HtmlLabelInfo  where indexid=20099
/

INSERT INTO HtmlLabelIndex values(20099,'�ƻ�����') 
/
INSERT INTO HtmlLabelIndex values(20100,'�ƻ�����趨') 
/
INSERT INTO HtmlLabelInfo VALUES(20099,'�ƻ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20099,'Manager Plan',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20100,'�ƻ�����趨',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20100,'Set Plan Type',8) 
/

insert into SystemRights (id,rightdesc,righttype) values (699,'�ƻ���������','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (699,7,'�ƻ���������','�ƻ���������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (699,8,'Set Plan Property','Set Plan Property') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4207,'�ƻ���������','PLANPROPERTY:SET',699) 
/

insert into SystemRights (id,rightdesc,righttype) values (698,'�ƻ��������','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (698,7,'�ƻ��������','�ƻ��������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (698,8,'Set Plan Type','Set Plan Type') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4206,'�ƻ��������','PLANTYPE:SET',698) 
/
insert into SystemRights (id,rightdesc,righttype) values (697,'��ѯ�¶ȼƻ�','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (697,7,'��ѯ�¶ȼƻ�','��ѯ�¶ȼƻ�') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (697,8,'Query Plan of Month','Query Plan of Month') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4205,'�¶ȼƻ���ѯ','PLAN:QUERY',697) 
/

insert into SystemRights (id,rightdesc,righttype) values (696,'��֯���������Ȩ��','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (696,8,'View Resource Tree','View Resource Tree') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (696,7,'��֯���������Ȩ��','��֯���������Ȩ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4204,'��֯�������Ȩ��','RESOURCETREE:VIEW',696) 
/

insert into SystemRights (id,rightdesc,righttype) values (695,'����дʵȨ��','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (695,8,'PLAN LOG','PLAN LOG') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (695,7,'����дʵȨ��','����дʵȨ��') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4203,'дʵȨ��','PLANLOG:VIEW',695) 
/

insert into SystemRights (id,rightdesc,righttype) values (694,'�ƻ�����','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (694,8,'Plan Confirm','Plan Confirm') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (694,7,'�ƻ�����','�ƻ�����') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4202,'�ƻ�����','PLAN:CONFIRM',694) 
/


insert into SystemRights (id,rightdesc,righttype) values (693,'��ȼƻ�����','7') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (693,8,'create plan of the year','create plan of the year') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (693,7,'��ȼƻ�����','��ȼƻ�����') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4201,'��ȼƻ�����','YEARPLAN:CREATE',693) 
/


delete from  HtmlLabelIndex  where id=20101
/

delete from  HtmlLabelIndex  where id=20102
/
delete from  HtmlLabelIndex  where id=20103
/

delete from  HtmlLabelIndex  where id=20104
/
delete from  HtmlLabelIndex  where id=20105
/

delete from  HtmlLabelIndex  where id=20106
/
delete from  HtmlLabelIndex  where id=20107
/

delete from  HtmlLabelIndex  where id=20108
/


delete from  HtmlLabelInfo  where indexid=20101
/
delete from  HtmlLabelInfo  where indexid=20102
/
delete from  HtmlLabelInfo  where indexid=20103
/
delete from  HtmlLabelInfo  where indexid=20104
/
delete from  HtmlLabelInfo  where indexid=20105
/
delete from  HtmlLabelInfo  where indexid=20106
/
delete from  HtmlLabelInfo  where indexid=20107
/
delete from  HtmlLabelInfo  where indexid=20108
/
INSERT INTO HtmlLabelIndex values(20101,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(20101,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20101,'Belong Type',8) 
/

INSERT INTO HtmlLabelIndex values(20102,'��ʱ���㷽ʽ') 
/
INSERT INTO HtmlLabelIndex values(20103,'��ʱ�����׼') 
/
INSERT INTO HtmlLabelIndex values(20104,'�Ƿ����ɹ������') 
/
INSERT INTO HtmlLabelIndex values(20105,'�Ƿ�����') 
/
INSERT INTO HtmlLabelIndex values(20106,'�ƻ���ʾ��ɫ') 
/
INSERT INTO HtmlLabelInfo VALUES(20102,'��ʱ���㷽ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20102,'Method of Count WorkTime',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20103,'��ʱ�����׼',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20103,'STD of Count WorkTime',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20104,'�Ƿ����ɹ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20104,'get code',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20105,'�Ƿ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20105,'if confirm',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20106,'�ƻ���ʾ��ɫ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20106,'color of plan',8) 
/

INSERT INTO HtmlLabelIndex values(20107,'����ƽ������') 
/
INSERT INTO HtmlLabelIndex values(20108,'��׼ֵ*�¹�������') 
/
INSERT INTO HtmlLabelInfo VALUES(20107,'����ƽ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20107,'share alike by month',8) 
/
INSERT INTO HtmlLabelInfo VALUES(20108,'��׼ֵ*�¹�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20108,'STD value*month''s days',8) 
/

delete from SystemRights where id=595
/

delete from SystemRightDetail where id=4096
/

delete from SystemRightsLanguage where id=595
/

insert into SystemRights (id,rightdesc,righttype) values (595,'���ž���','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (595,7,'���ž���','���ž���') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (595,8,'manager','department manager') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4096,'���ž���','Manager',595) 
/

delete from  HtmlLabelIndex  where id=20119
/

delete from  HtmlLabelIndex  where id=20120
/


delete from  HtmlLabelInfo  where indexid=20119
/
delete from  HtmlLabelInfo  where indexid=20120
/

INSERT INTO HtmlLabelIndex values(20119,'���Ϊ�¶ȼƻ�') 
/
INSERT INTO HtmlLabelInfo VALUES(20119,'���Ϊ�¶ȼƻ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20119,'add to monthplan',8) 
/
INSERT INTO HtmlLabelIndex values(20120,'�������') 
/
INSERT INTO HtmlLabelInfo VALUES(20120,'�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(20120,'work code',8) 
/