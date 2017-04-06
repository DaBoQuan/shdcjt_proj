INSERT INTO HtmlLabelIndex values(19427,'н��ָ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19427,'н��ָ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19427,'compensation target setting',8) 
GO
INSERT INTO HtmlLabelIndex values(19430,'н��ָ������ά��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19430,'н��ָ������ά��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19430,'compensation target data maintenance',8) 
GO
INSERT INTO HtmlLabelIndex values(19436,'���ֲ����¼��ֲ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19436,'���ֲ����¼��ֲ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19436,'the subcompany and lower subcompany',8) 
GO
INSERT INTO HtmlLabelIndex values(19437,'ָ���ֲ�') 
GO
INSERT INTO HtmlLabelIndex values(19438,'ָ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19437,'ָ���ֲ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19437,'appointe subcompany',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19438,'ָ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19438,'appointe department',8) 
GO
INSERT INTO HtmlLabelIndex values(19454,'н��ָ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19454,'н��ָ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19454,'compensation target',8) 
GO
INSERT INTO HtmlLabelIndex values(19464,'���ݶ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19464,'���ݶ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19464,'data object',8) 
GO
INSERT INTO HtmlLabelIndex values(19465,'н��ָ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19465,'н��ָ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19465,'compensation target monthly',8) 
GO
INSERT INTO HtmlLabelIndex values(19470,'���������ڴ���н��ָ�����ݵ��룬���Ժ�...') 
GO
INSERT INTO HtmlLabelInfo VALUES(19470,'���������ڴ���н��ָ�����ݵ��룬���Ժ�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19470,'loading compensation target data,please wait...',8) 
GO
INSERT INTO HtmlLabelIndex values(19481,'����ǰ�÷ֲ�/�����µĸ���н��ָ�����ݽ�ȫ��ɾ������ȷ��Ҫ����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19481,'����ǰ�÷ֲ�/�����µĸ���н��ָ�����ݽ�ȫ��ɾ������ȷ��Ҫ����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19481,'the compensation target data will be deleted,are you sure continue load?',8) 
GO
INSERT INTO HtmlLabelIndex values(19488,'н��ָ�����ݵ���ɹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19488,'н��ָ�����ݵ���ɹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19488,'compensation target data loaded success!',8) 
GO
INSERT INTO HtmlLabelIndex values(19489,'����Excelģ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19489,'����Excelģ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19489,'export Excel template',8) 
GO

insert into SystemRights (id,rightdesc,righttype,detachable) values (660,'н��ָ������','3',1) 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (660,7,'н��ָ������','н��ָ������') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (660,8,'compensation target setting','compensation target setting') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4160,'н��ָ������Ȩ��','Compensation:Setting',660) 
GO
insert into SystemRights (id,rightdesc,righttype,detachable) values (661,'н��ָ������ά��','3',1) 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (661,7,'н��ָ������ά��','н��ָ������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (661,8,'compensation target data maintenance','compensation target data maintenance') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4161,'н��ָ������ά��Ȩ��','Compensation:Maintenance',661) 
GO

EXECUTE MMConfig_U_ByInfoInsert 50,2
GO
EXECUTE MMInfo_Insert 517,19427,'','/hrm/finance/compensation/CompensationTargetSet_frm.jsp','mainFrame',50,2,2,0,'',0,'Compensation:Setting',0,'','',0,'','',2
GO
EXECUTE MMConfig_U_ByInfoInsert 50,3
GO
EXECUTE MMInfo_Insert 518,19430,'','/hrm/finance/compensation/CompensationTargetMaint_frm.jsp','mainFrame',50,2,3,0,'',0,'Compensation:Maintenance',0,'','',0,'','',2
GO


CREATE TABLE HRM_CompensationTargetSet(
    id  int NOT NULL IDENTITY (1, 1),
    subcompanyid    int,/*�ֲ�id*/
    TargetName    varchar(50),/*���*/
    Explain   varchar(100),/*˵��*/
    AreaType int,/*Ӧ�÷�Χ����*/
    memo varchar(500)/*��ע*/
)
GO

CREATE TABLE HRM_ComTargetSetDetail(
    Targetid    int,/*ָ��id*/
    companyordeptid    int/*����/�ֲ�id*/
)
GO
CREATE TABLE HRM_CompensationTargetInfo(
    id  int NOT NULL IDENTITY (1, 1),
    subcompanyid    int,/*�ֲ�id*/
    departmentid    int,/*����id*/
    CompensationYear   int,/*��*/
    CompensationMonth  int,/*��*/
    Userid   int,/*Ա��id*/
    memo varchar(500)/*��ע*/
)
GO

CREATE TABLE HRM_CompensationTargetDetail(
    CompensationTargetid    int,/*ָ������id*/
    Targetid    int,/*ָ��id*/
    Target decimal(15,2)/*ָ��ֵ*/
)
GO


