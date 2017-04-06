INSERT INTO HtmlLabelIndex values(19427,'н��ָ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19427,'н��ָ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19427,'compensation target setting',8) 
/
INSERT INTO HtmlLabelIndex values(19430,'н��ָ������ά��') 
/
INSERT INTO HtmlLabelInfo VALUES(19430,'н��ָ������ά��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19430,'compensation target data maintenance',8) 
/
INSERT INTO HtmlLabelIndex values(19436,'���ֲ����¼��ֲ�') 
/
INSERT INTO HtmlLabelInfo VALUES(19436,'���ֲ����¼��ֲ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19436,'the subcompany and lower subcompany',8) 
/
INSERT INTO HtmlLabelIndex values(19437,'ָ���ֲ�') 
/
INSERT INTO HtmlLabelIndex values(19438,'ָ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19437,'ָ���ֲ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19437,'appointe subcompany',8) 
/
INSERT INTO HtmlLabelInfo VALUES(19438,'ָ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19438,'appointe department',8) 
/
INSERT INTO HtmlLabelIndex values(19454,'н��ָ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19454,'н��ָ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19454,'compensation target',8) 
/
INSERT INTO HtmlLabelIndex values(19464,'���ݶ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19464,'���ݶ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19464,'data object',8) 
/
INSERT INTO HtmlLabelIndex values(19465,'н��ָ������') 
/
INSERT INTO HtmlLabelInfo VALUES(19465,'н��ָ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19465,'compensation target monthly',8) 
/
INSERT INTO HtmlLabelIndex values(19470,'���������ڴ���н��ָ�����ݵ��룬���Ժ�...') 
/
INSERT INTO HtmlLabelInfo VALUES(19470,'���������ڴ���н��ָ�����ݵ��룬���Ժ�...',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19470,'loading compensation target data,please wait...',8) 
/
INSERT INTO HtmlLabelIndex values(19481,'����ǰ�÷ֲ�/�����µĸ���н��ָ�����ݽ�ȫ��ɾ������ȷ��Ҫ����������') 
/
INSERT INTO HtmlLabelInfo VALUES(19481,'����ǰ�÷ֲ�/�����µĸ���н��ָ�����ݽ�ȫ��ɾ������ȷ��Ҫ����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19481,'the compensation target data will be deleted,are you sure continue load?',8) 
/
INSERT INTO HtmlLabelIndex values(19488,'н��ָ�����ݵ���ɹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(19488,'н��ָ�����ݵ���ɹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19488,'compensation target data loaded success!',8) 
/
INSERT INTO HtmlLabelIndex values(19489,'����Excelģ��') 
/
INSERT INTO HtmlLabelInfo VALUES(19489,'����Excelģ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(19489,'export Excel template',8) 
/

insert into SystemRights (id,rightdesc,righttype,detachable) values (660,'н��ָ������','3',1) 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (660,7,'н��ָ������','н��ָ������') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (660,8,'compensation target setting','compensation target setting') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4160,'н��ָ������Ȩ��','Compensation:Setting',660) 
/
insert into SystemRights (id,rightdesc,righttype,detachable) values (661,'н��ָ������ά��','3',1) 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (661,7,'н��ָ������ά��','н��ָ������ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (661,8,'compensation target data maintenance','compensation target data maintenance') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4161,'н��ָ������ά��Ȩ��','Compensation:Maintenance',661) 
/

call MMConfig_U_ByInfoInsert (50,2)
/
call MMInfo_Insert( 517,19427,'','/hrm/finance/compensation/CompensationTargetSet_frm.jsp','mainFrame',50,2,2,0,'',0,'Compensation:Setting',0,'','',0,'','',2)
/
call MMConfig_U_ByInfoInsert (50,3)
/
call MMInfo_Insert (518,19430,'','/hrm/finance/compensation/CompensationTargetMaint_frm.jsp','mainFrame',50,2,3,0,'',0,'Compensation:Maintenance',0,'','',0,'','',2)
/


CREATE TABLE HRM_CompensationTargetSet(
    id  integer NOT NULL ,
    subcompanyid    integer,/*�ֲ�id*/
    TargetName    varchar2(50),/*���*/
    Explain   varchar2(100),/*˵��*/
    AreaType integer,/*Ӧ�÷�Χ����*/
    memo varchar2(500)/*��ע*/
)
/
create sequence Prj_HRM_CptTSet_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Prj_HRM_CptTSet_Trigger
before insert on HRM_CompensationTargetSet
for each row
begin
select Prj_HRM_CptTSet_id.nextval into :new.id from dual;
end;
/



CREATE TABLE HRM_ComTargetSetDetail(
    Targetid    integer,/*ָ��id*/
    companyordeptid    integer/*����/�ֲ�id*/
)
/


CREATE TABLE HRM_CompensationTargetInfo(
    id  integer NOT NULL ,
    subcompanyid    integer,/*�ֲ�id*/
    departmentid    integer,/*����id*/
    CompensationYear   integer,/*��*/
    CompensationMonth  integer,/*��*/
    Userid   integer,/*Ա��id*/
    memo varchar2(500)/*��ע*/
)
/
create sequence HRM_CpTargetInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HRM_CpTargetInfo_Trigger
before insert on HRM_CompensationTargetInfo
for each row
begin
select HRM_CpTargetInfo_id.nextval into :new.id from dual;
end;
/


CREATE TABLE HRM_CompensationTargetDetail(
    CompensationTargetid    integer,/*ָ������id*/
    Targetid    integer,/*ָ��id*/
    Target number(15,2)/*ָ��ֵ*/
)
/
