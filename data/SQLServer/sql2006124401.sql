
delete from  HtmlLabelIndex  where id=20100
GO

delete from  HtmlLabelIndex  where id=20099
GO

delete from  HtmlLabelInfo  where indexid=20100
GO
delete from  HtmlLabelInfo  where indexid=20099
GO

INSERT INTO HtmlLabelIndex values(20099,'�ƻ�����') 
GO
INSERT INTO HtmlLabelIndex values(20100,'�ƻ�����趨') 
GO
INSERT INTO HtmlLabelInfo VALUES(20099,'�ƻ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20099,'Manager Plan',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20100,'�ƻ�����趨',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20100,'Set Plan Type',8) 
GO

insert into SystemRights (id,rightdesc,righttype) values (699,'�ƻ���������','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (699,7,'�ƻ���������','�ƻ���������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (699,8,'Set Plan Property','Set Plan Property') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4207,'�ƻ���������','PLANPROPERTY:SET',699) 
GO

insert into SystemRights (id,rightdesc,righttype) values (698,'�ƻ��������','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (698,7,'�ƻ��������','�ƻ��������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (698,8,'Set Plan Type','Set Plan Type') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4206,'�ƻ��������','PLANTYPE:SET',698) 
GO
insert into SystemRights (id,rightdesc,righttype) values (697,'��ѯ�¶ȼƻ�','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (697,7,'��ѯ�¶ȼƻ�','��ѯ�¶ȼƻ�') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (697,8,'Query Plan of Month','Query Plan of Month') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4205,'�¶ȼƻ���ѯ','PLAN:QUERY',697) 
GO

insert into SystemRights (id,rightdesc,righttype) values (696,'��֯���������Ȩ��','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (696,8,'View Resource Tree','View Resource Tree') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (696,7,'��֯���������Ȩ��','��֯���������Ȩ��') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4204,'��֯�������Ȩ��','RESOURCETREE:VIEW',696) 
GO

insert into SystemRights (id,rightdesc,righttype) values (695,'����дʵȨ��','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (695,8,'PLAN LOG','PLAN LOG') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (695,7,'����дʵȨ��','����дʵȨ��') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4203,'дʵȨ��','PLANLOG:VIEW',695) 
GO

insert into SystemRights (id,rightdesc,righttype) values (694,'�ƻ�����','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (694,8,'Plan Confirm','Plan Confirm') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (694,7,'�ƻ�����','�ƻ�����') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4202,'�ƻ�����','PLAN:CONFIRM',694) 
GO


insert into SystemRights (id,rightdesc,righttype) values (693,'��ȼƻ�����','7') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (693,8,'create plan of the year','create plan of the year') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (693,7,'��ȼƻ�����','��ȼƻ�����') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4201,'��ȼƻ�����','YEARPLAN:CREATE',693) 
GO


delete from  HtmlLabelIndex  where id=20101
GO

delete from  HtmlLabelIndex  where id=20102
GO
delete from  HtmlLabelIndex  where id=20103
GO

delete from  HtmlLabelIndex  where id=20104
GO
delete from  HtmlLabelIndex  where id=20105
GO

delete from  HtmlLabelIndex  where id=20106
GO
delete from  HtmlLabelIndex  where id=20107
GO

delete from  HtmlLabelIndex  where id=20108
GO


delete from  HtmlLabelInfo  where indexid=20101
GO
delete from  HtmlLabelInfo  where indexid=20102
GO
delete from  HtmlLabelInfo  where indexid=20103
GO
delete from  HtmlLabelInfo  where indexid=20104
GO
delete from  HtmlLabelInfo  where indexid=20105
GO
delete from  HtmlLabelInfo  where indexid=20106
GO
delete from  HtmlLabelInfo  where indexid=20107
GO
delete from  HtmlLabelInfo  where indexid=20108
GO
INSERT INTO HtmlLabelIndex values(20101,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20101,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20101,'Belong Type',8) 
GO

INSERT INTO HtmlLabelIndex values(20102,'��ʱ���㷽ʽ') 
GO
INSERT INTO HtmlLabelIndex values(20103,'��ʱ�����׼') 
GO
INSERT INTO HtmlLabelIndex values(20104,'�Ƿ����ɹ������') 
GO
INSERT INTO HtmlLabelIndex values(20105,'�Ƿ�����') 
GO
INSERT INTO HtmlLabelIndex values(20106,'�ƻ���ʾ��ɫ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20102,'��ʱ���㷽ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20102,'Method of Count WorkTime',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20103,'��ʱ�����׼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20103,'STD of Count WorkTime',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20104,'�Ƿ����ɹ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20104,'get code',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20105,'�Ƿ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20105,'if confirm',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20106,'�ƻ���ʾ��ɫ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20106,'color of plan',8) 
GO

INSERT INTO HtmlLabelIndex values(20107,'����ƽ������') 
GO
INSERT INTO HtmlLabelIndex values(20108,'��׼ֵ*�¹�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20107,'����ƽ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20107,'share alike by month',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20108,'��׼ֵ*�¹�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20108,'STD value*month''s days',8) 
GO

delete from SystemRights where id=595
go

delete from SystemRightDetail where id=4096
go

delete from SystemRightsLanguage where id=595
go

insert into SystemRights (id,rightdesc,righttype) values (595,'���ž���','3') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (595,7,'���ž���','���ž���') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (595,8,'manager','department manager') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4096,'���ž���','Manager',595) 
GO

delete from  HtmlLabelIndex  where id=20119
GO

delete from  HtmlLabelIndex  where id=20120
GO


delete from  HtmlLabelInfo  where indexid=20119
GO
delete from  HtmlLabelInfo  where indexid=20120
GO

INSERT INTO HtmlLabelIndex values(20119,'���Ϊ�¶ȼƻ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(20119,'���Ϊ�¶ȼƻ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20119,'add to monthplan',8) 
GO
INSERT INTO HtmlLabelIndex values(20120,'�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(20120,'�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20120,'work code',8) 
GO