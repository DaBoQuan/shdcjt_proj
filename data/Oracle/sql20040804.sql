
/*
BUG 87 ѧ��ά����Ȩ��bug-������
*/

delete from SystemRightToGroup where rightid=382
/
insert into SystemRightToGroup (groupid,rightid) values (3,382) 
/
update SystemRightRoles set rolelevel='2' where rightid=382
/ 
delete from SystemRightToGroup where rightid=127
/
insert into SystemRightToGroup (groupid,rightid) values (3,127) 
/
delete from SystemRightRoles where rightid=127
/ 
insert into SystemRightRoles (rightid,roleid,rolelevel) values (127,4,'2') 
/

/**
*For bug 87,
*ɾ�� ��������ά�����������ά������ͥ���ά�����ɱ�����ά��Ȩ��
*
*/
/*��������*/
DELETE FROM SystemRights WHERE id=128 
/
DELETE FROM SystemRightsLanguage WHERE id=128
/
DELETE FROM SystemRightDetail WHERE rightid=128
/
DELETE FROM systemrighttogroup WHERE Rightid=128
/
DELETE FROM SystemRightRoles WHERE RightID =128  
/

/*�������*/
DELETE FROM SystemRights WHERE id= 129
/
DELETE FROM SystemRightsLanguage WHERE id=129
/
DELETE FROM SystemRightDetail WHERE rightid=129
/
DELETE FROM systemrighttogroup WHERE Rightid=129
/
DELETE FROM SystemRightRoles WHERE RightID = 129 
/

/*��ͥ���*/
DELETE FROM SystemRights WHERE id= 130
/
DELETE FROM SystemRightsLanguage WHERE id= 130
/
DELETE FROM SystemRightDetail WHERE rightid= 130
/ 
DELETE FROM systemrighttogroup WHERE Rightid= 130
/
DELETE FROM SystemRightRoles WHERE RightID =  130
/

/*�ɱ�����*/
DELETE FROM SystemRights WHERE id= 20
/
DELETE FROM SystemRightsLanguage WHERE id=20
/
DELETE FROM SystemRightDetail WHERE rightid=20
/
DELETE FROM systemrighttogroup WHERE Rightid=20
/
DELETE FROM SystemRightRoles WHERE RightID = 20 
/
/*�ɱ��������ά��*/
DELETE FROM SystemRights WHERE id=21
/
DELETE FROM SystemRightsLanguage WHERE id=21
/
DELETE FROM SystemRightDetail WHERE rightid=21
/
DELETE FROM systemrighttogroup WHERE Rightid=21
/
DELETE FROM SystemRightRoles WHERE RightID =21
/

/*
bug:93 ��ʾ��Ŀά��Ȩ��û��Ĭ�ϵĽ�ɫ���� by ������ 
*/
delete from SystemRights where id = 309
/
delete from SystemRightsLanguage where id = 309
/
delete from SystemRightDetail where id=2009
/ 
insert into SystemRights (id,rightdesc,righttype) values (309,'��ʾ��Ŀά��','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (309,7,'��ʾ��Ŀά��','��ʾ��Ŀά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (309,8,'ShowColumn','ShowColumn') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (2009,'��ʾ��Ŀά��','ShowColumn:Operate',309) 
/
delete from SystemRightToGroup where rightid=309
/
insert into SystemRightToGroup (groupid,rightid) values (3,309) 
/
delete from SystemRightRoles where rightid=309
/ 
insert into SystemRightRoles (rightid,roleid,rolelevel) values (309,4,'2') 
/

/**
*For Bug 99 ,ͼ�α༭ά��Ȩ�޵�Ĭ�Ͻ�ɫ����Ϊ�ܲ������������Դ����Ա��
*/
insert into SystemRights (id,rightdesc,righttype) values (417,'��֯�ܹ�ͼ�α༭','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (417,8,'Organization Hiberarchy Chart','Organization Hiberarchy Chart') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (417,7,'��֯�ܹ�ͼ�α༭','��֯�ܹ�ͼ�α༭') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3107,'��֯�ܹ�ͼ�α༭','HrmDepartLayoutEdit:Edit',417) 
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,417)
/
DELETE FROM SystemRightRoles WHERE RightID = 417 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (417,4,2)
/

/*For Bug 119��Modified by Charoes Huang On May 28,2004*/
CREATE or replace PROCEDURE Employee_SByStatus
(
	flag	out		integer,
	msg  out		varchar2,
	thecursor IN OUT cursor_define.weavercursor) 
as
hrmid_1 integer;
id_1 integer;
lastname_1 varchar2(60);
sex_1 char(1);
startdate_1 char(10);
departmentid_1 integer;
joblevel_1 smallint;
managerid_1 integer;

begin  
for employee_cursor  IN (select distinct(hrmid) from HrmInfoStatus t1,HrmResource t2 where t1.status ='0' and t1.hrmid = t2.id) 
loop
hrmid_1 :=employee_cursor.hrmid ;
select id,lastname,sex,startdate,departmentid,joblevel,managerid INTO id_1,
lastname_1,sex_1,startdate_1,departmentid_1,joblevel_1,managerid_1 from HrmResource WHERE id=hrmid_1;
	
	insert INTO temp_Employee_table_01(id,lastname,sex,startdate,departmentid,joblevel,managerid)
	values(id_1,lastname_1,sex_1,startdate_1,departmentid_1,joblevel_1,managerid_1);
end loop;
open thecursor for
	select * from temp_Employee_table_01;
end;
/

/* bug 183 Added BY Huang Yu,������ѵ��Դ����־��Ŀ��������*/
DELETE FROM SystemLogItem WHERE itemid = 68
/
INSERT INTO SystemLogItem (itemid,lableid,itemdesc) VALUES (68,15879,'��ѵ��Դ')
/

/*��ͬ����ά�� Ȩ�� BUG 208*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=383
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,383)
/
DELETE FROM SystemRightRoles WHERE RightID = 383 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (383,4,2)
/

/*Bug 216, ������ͬά����Ȩ�޹��ɵ���������Դ����Ȩ���顱��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=384
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,384)
/
DELETE FROM SystemRightRoles WHERE RightID = 384 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (384,4,2)
/

/* bug��226 Created By Charoes Huang On May 21,2004*/
INSERT INTO HtmlLabelIndex values(17411,'�����ڽ������ڱ����ں�ͬ��ʼ�ͽ�������֮��') 
/
INSERT INTO HtmlLabelInfo VALUES(17411,'�����ڽ������ڱ����ں�ͬ��ʼ�ͽ�������֮��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17411,'The probation end date must be betwee the start date and end date of the contract!',8) 
/

/**
*Create by Charoes Huang
*Date July 16 ,2004
*Description : For bug 229,���� �����ù������ �ύ��Ĭ��Ϊ��ʾ
*/

update workflow_nodeform set isview=1 where nodeid=233 and fieldid=412
/
update workflow_nodeform set isview=1 where nodeid=234 and fieldid=412
/
update workflow_nodeform set isview=1 where nodeid=235 and fieldid=412
/
update workflow_nodeform set isview=1 where nodeid=236 and fieldid=412
/
update workflow_nodeform set isview=1 where nodeid=237 and fieldid=412
/

/*BUG270  hangyu */
DELETE FROM SystemRights WHERE id = 122
/
DELETE FROM SystemRightsLanguage WHERE id = 122
/
DELETE FROM SystemRightDetail WHERE rightid = 122
/
insert into SystemRights (id,rightdesc,righttype) values (122,'��ѵ����ά��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (122,7,'��ѵ����ά��','��ѵ����ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (122,8,'TrainTypeMaintenance','TrainTypeMaintenance') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (410,'��ѵ�������','HrmTrainTypeAdd:Add',122) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (411,'��ѵ����༭','HrmTrainTypeEdit:Edit',122) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (412,'��ѵ����ɾ��','HrmTrainTypeEdit:Delete',122) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (413,'��ѵ������־�鿴','HrmTrainType:Log',122) 
/
/*����Ĭ��Ϊ������Դ�������Ȩ��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=122
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,122)
/
DELETE FROM SystemRightRoles WHERE RightID = 122 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (122,4,2)
/

/*Bug 274, ������ѵ�滮��Ȩ�޹��ɵ���������Դ����Ȩ���顱��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=370
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,370)
/
DELETE FROM SystemRightRoles WHERE RightID = 370 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (370,4,2)
/


/*Bug 283, ������ѵ��Դ��Ȩ�޹��ɵ���������Դ����Ȩ���顱��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=372
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,372)
/
DELETE FROM SystemRightRoles WHERE RightID = 372 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (372,4,2)
/

/*BUG286  by hy ɾ����ѵ���ţ���ѵ���Ȩ�� */
/*��ѵ����*/
DELETE FROM SystemRights WHERE id = 371
/
DELETE FROM SystemRightsLanguage WHERE id = 371
/
DELETE FROM SystemRightDetail WHERE rightid = 371
/
DELETE FROM SystemRightToGroup WHERE rightid=371
/
DELETE FROM SystemRightRoles WHERE RightID = 371 
/
/*��ѵ�*/
DELETE FROM SystemRights WHERE id = 373
/
DELETE FROM SystemRightsLanguage WHERE id = 373
/
DELETE FROM SystemRightDetail WHERE rightid = 373
/
DELETE FROM SystemRightToGroup WHERE rightid=373
/
DELETE FROM SystemRightRoles WHERE RightID = 373 
/

/*����'רҵά��'Ȩ�� Ĭ��Ϊ������Դ�������Ȩ��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=125
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,125)
/
DELETE FROM SystemRightRoles WHERE RightID = 125 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (125,4,2)
/

/*For Bug 290 with Modified By Charoes Huang ,May 31,2004*/
create or replace  procedure HrmTrain_Insert
(name_1 varchar2,
 planid_2 integer,
 organizer_3 varchar2,
 startdate_4 char,
 enddate_5 char,
 content_6 Varchar2,
 aim_7 Varchar2,
 address_8 varchar2,
 resource_n_9 varchar2, 
 createrid_10 integer,
 testdate_11 char,
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
as 
begin
insert into HrmTrain
(name,
 planid,
 organizer,
 startdate,
 enddate,
 content,
 aim,
 address,
 resource_n, 
 createrid,
 testdate)
values
(name_1,
 planid_2,
 organizer_3,
 startdate_4,
 enddate_5,
 content_6,
 aim_7,
 address_8,
 resource_n_9, 
 createrid_10,
 testdate_11);
open thecursor for
 select max(id) from HrmTrain ;
 end;/* Modified From ' select max(id) from HrmTrainDay'*/
/

/*for id=298 by ������*/
update workflow_base set isvalid='1' where id=26 and workflowname='��ѵ����'
/

/*Created By Charoes Huang On May 19,2004 FOR BUG 301
 *��������ά�� ->��������ά��	
*/
DELETE SystemRights WHERE id = 123
/
DELETE SystemRightsLanguage WHERE id = 123
/
DELETE SystemRightDetail WHERE rightid = 123
/
insert into SystemRights (id,rightdesc,righttype) values (123,'��������ά��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (123,7,'��������ά��','��������ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (123,8,'Awards-Punishments Type Maintenance','Awards-Punishments Type Maintenance') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (414,'�����������','HrmRewardsTypeAdd:Add',123) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (415,'��������༭','HrmRewardsTypeEdit:Edit',123) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (416,'��������ɾ��','HrmRewardsTypeEdit:Delete',123) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (417,'����������־�鿴','HrmRewardsType:Log',123) 
/
/*����Ĭ��Ϊ������Դ�������Ȩ��*/
DELETE systemrighttogroup WHERE GroupID = 3 and rightid=123
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,123)
/
DELETE SystemRightRoles WHERE RightID = 123 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (123,4,1)
/


/*
* For Bug 304
* Created By Charoes Huang ,June 1,2004
*/
create or replace  PROCEDURE HrmTrainTest_Update
(trainid_1 integer,
 resourceid_2 integer,
 testdate_3 char,
 result_4 integer,
 explain_5 Varchar2,
 testerid_6 integer,
 id_7 integer,
 flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
as 
begin
   UPDATE HrmTrainTest
      SET resourceid = resourceid_2,
	  testdate = testdate_3,
	  result = result_4,
          explain = explain_5
      WHERE ID = id_7;
end;
/

/*
*Created by Charoes Huang
*FOR bug 312
*/

CREATE OR REPLACE PROCEDURE HrmCheckItem_SByid 
(id_1 integer,
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor )
AS
begin 
open thecursor for 
SELECT * FROM HrmCheckItem WHERE id = id_1;
end;
/

/*
Created By Charoes Huang On May 30,2004
FOR BUG 313, ɾ��Ȩ��û�в������ݿ�*/

DELETE FROM SystemRights WHERE id = 387
/
DELETE FROM SystemRightsLanguage WHERE id = 387
/
DELETE FROM SystemRightDetail WHERE rightid = 387
/
insert into SystemRights (id,rightdesc,righttype) values (387,'������Դ������Ŀά��','3') 
/

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,7,'������Դ������Ŀά��','������Դ������Ŀ�½����༭��ɾ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,8,'HRMTestItemMaintenance','New,Edit and Delete HRMTestItem') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,7,'������Դ������Ŀά��','������Դ������Ŀ�½����༭��ɾ��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (387,8,'HRMTestItemMaintenance','New,Edit and Delete HRMTestItem') 
/

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3054,'������Դ������Ŀ�½�','HrmCheckItemAdd:Add',387) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3055,'������Դ������Ŀ�༭','HrmCheckItemEdit:Edit',387) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3128,'������Դ������Ŀɾ��','HrmCheckItemEdit:Delete',387) 
/
/*����Ĭ��Ϊ������Դ�������Ȩ��*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=387
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,387)
/
DELETE FROM SystemRightRoles WHERE RightID = 387 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (387,4,1) /*�ֲ������Ȩ��*/
/

/*
Created By Charoes Huang On May 19,2004
FOR BUG 414*/
INSERT INTO HtmlLabelIndex values(17408,'�����ڱ��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17408,'�����ڱ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17409,'The test period must be larger than zero!',8) 
/

/**
 *For Bug 426
 *Created by Charoes Huang, June 2,2004
 *
*/
INSERT INTO HtmlLabelIndex values(17425,'�����˸�λ') 
/
INSERT INTO HtmlLabelInfo VALUES(17425,'�����˸�λ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17425,'Post Examined',8) 
/
/*
 * Script Created ON : May 13,2004
 * Author : Charoes lu peng
*/
/*FOR BUG 436 �޸��˴洢����FnaYearsPeriodsList_SByFnayear�����Ӷ�Periodsid����*/
CREATE OR REPLACE PROCEDURE FnaYearsPeriodsList_SByFnayear (id_1 	integer, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor ) 
as 
begin 
open thecursor for select * from FnaYearsPeriodsList where fnayearid =id_1 order by Periodsid;
end;
/
CREATE OR REPLACE PROCEDURE FnaYearsPeriodsList_Update
(id_1 	integer,
startdate_2 	char,
enddate_3 	char,
fnayearid_4    integer,
isactive_5 	char,
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
minfromdate_1 char(10);
maxenddate_1 char(10); 
begin 
UPDATE FnaYearsPeriodsList SET  startdate=startdate_2, enddate=enddate_3 , isactive=isactive_5 WHERE ( id=id_1); 
select min(startdate) into minfromdate_1 from FnaYearsPeriodsList where fnayearid=fnayearid_4 and (startdate is not null); 
select  max(enddate) into maxenddate_1 from FnaYearsPeriodsList where fnayearid=fnayearid_4 and (enddate is not null) ; 
update FnaYearsPeriods set startdate=minfromdate_1 , enddate = maxenddate_1 where id = fnayearid_4; 
end;
/

/*FOR BUG 437 ��ORACLE�ϵĴ洢����FnaYearsPeriodsList_Update��ʹ�ô���Ŀ�ֵ�ж�enddate <> ''�����޸�Ϊenddate <> IS NOT NULL*/
CREATE OR REPLACE PROCEDURE FnaYearsPeriodsList_SByFnayear
(id_1 	integer,
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor ) 
as 
begin 
open thecursor for select * from FnaYearsPeriodsList where fnayearid =  id_1 order by Periodsid;
end;
/
CREATE OR REPLACE PROCEDURE FnaYearsPeriodsList_Update
(id_1 	integer,
startdate_2 	char,
enddate_3 	char,
fnayearid_4    integer,
isactive_5 	char,
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
minfromdate_1 char(10);
maxenddate_1 char(10); 
begin 
UPDATE FnaYearsPeriodsList SET  startdate=startdate_2, enddate=enddate_3 , isactive=isactive_5 WHERE ( id=id_1); 
select min(startdate) into minfromdate_1 from FnaYearsPeriodsList where fnayearid=fnayearid_4 and (startdate is not null); 
select  max(enddate) into maxenddate_1 from FnaYearsPeriodsList where fnayearid=fnayearid_4 and (enddate is not null) ; 
update FnaYearsPeriods set startdate=minfromdate_1 , enddate = maxenddate_1 where id = fnayearid_4;
end;
/

/*FOR BUG 449 �޸���FnaLoanLog���description�ֶγ���Ϊ4000*/
ALTER TABLE FnaLoanLog MODIFY description varchar2(4000)
/

/*FOR BUG 522,by ·��*/
DELETE SystemRightRoles WHERE rightid = 137 AND roleid = 2
/

/*FOR BUG 528 and 540,by ·��*/
insert into HtmlNoteIndex (id,indexdesc) values (56,'���ʲ������������ʲ����������½��ʲ��顣') 
/
insert into HtmlNoteInfo (indexid,notename,languageid) values (56, '���ʲ������������ʲ����������½��ʲ��顣', 7) 
/
insert into HtmlNoteInfo (indexid,notename,languageid) values (56, 'Can''t create a capital group under this group.', 8) 
/

/*FOR BUG 538,by ·��*/
UPDATE SystemLogItem SET lableid=831, itemdesc='�ʲ���' WHERE itemid=43
/


/*FOR BUG 541,by ·�� ���˽ű�û�ж�Ӧ��sql�ű���*/
CREATE OR REPLACE PROCEDURE CptCapitalAssortment_Delete (id_1 	int, flag out integer, msg out varchar2, thecursor IN OUT cursor_define.weavercursor ) 
AS 
count_1 integer ; 
supassortmentid_1 integer; 
begin 
select  capitalcount into count_1  from CptCapitalAssortment where id =  id_1 ; 
if  count_1 <> 0  then open thecursor for select -1 from dual ; 
return ; 
end  if;  
select  subassortmentcount into count_1 from CptCapitalAssortment where id =  id_1 ; 
if  count_1 <> 0 then open thecursor for select -1 from dual; 
return ; 
end  if;  
select  supassortmentid into supassortmentid_1 from CptCapitalAssortment where id=  id_1;  
update CptCapitalAssortment set subassortmentcount = subassortmentcount-1 where id=  supassortmentid_1; 
DELETE CptCapitalAssortment WHERE id =  id_1; 
end;
/

/*FOR BUG 544,by ·��(��oracle)*/
CREATE OR REPLACE PROCEDURE CptCapital_Delete 
(id_1 	integer,
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor) 
AS begin 
update CptCapitalAssortment set 
capitalcount = capitalcount-1 where id in (select capitalgroupid from CptCapital where id = id_1 );  
DELETE CptCapital WHERE ( id=id_1);
open thecursor for select max(id) from CptCapital;
end;
/
/* td :546 by lp */
UPDATE SysMaintenanceLog SET operateitem = 44 WHERE operatedesc LIKE 'CptCapitalType%'
/

/*FOR BUG 547 �����õ��ʲ����ͣ�ȴ�ܱ�ɾ��,by ·��*/
CREATE or REPLACE PROCEDURE CptCapitalType_Delete (
id_1 integer,
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
as
count_1 integer;
begin
SELECT count(id) into count_1 FROM CptCapital WHERE capitaltypeid = id_1;
    if (count_1>0) then
        open thecursor for
        select -1 from dual;
        return;
    end if;
    DELETE CptCapitalType WHERE id = id_1;
end;
/

/*FOR BUG 553 ���½�ʱ�Զ������ݿ��¼ID��������ʶ���ֶΡ�by ·��*/
CREATE or REPLACE PROCEDURE LgcAssetUnit_Insert (
unitmark_1 	varchar2, 
unitname_2 	varchar2, 
unitdesc_3 	varchar2, 
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)  
AS 
unitId_1 integer;
begin
INSERT INTO LgcAssetUnit 
( unitmark, unitname, unitdesc)  
VALUES ( unitmark_1, unitname_2, unitdesc_3);
select max(id) into unitId_1 from LgcAssetUnit;
UPDATE LgcAssetUnit SET unitmark = to_char(unitId_1) WHERE id = unitId_1;
end;
/
/* Create the set marks stored procedure */
CREATE or REPLACE PROCEDURE LgcAssetUnit_SetAllMarks 
AS
m_id integer;
m_mark varchar2(60);
begin
for all_cursor in
(SELECT id, unitmark FROM LgcAssetUnit)
loop
    m_id:=all_cursor.id;
    m_mark:=all_cursor.unitmark;
    if (m_mark IS NULL OR m_mark = '') then
         UPDATE LgcAssetUnit SET unitmark = to_char(m_id) WHERE id = m_id;
    end if;
end loop;
end;
/
/* end */


/* Invoke the above stored procedure */
call LgcAssetUnit_SetAllMarks()
/
DROP PROCEDURE LgcAssetUnit_SetAllMarks
/
/* end */

/*FOR BUG 554 �ڼ�����λɾ���Ĵ洢�����������˶��ʲ��������õ��ж� by ·��*/
CREATE or REPLACE PROCEDURE LgcAssetUnit_Delete (
id_1 integer, 
flag out integer,
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
AS
count_1 integer;
begin
select count(id) into count_1 from LgcAsset where assetunitid = id_1 ;
if count_1 <> 0 then
open thecursor for
select -1 from dual;
return;
end if;
SELECT count(id) into count_1 FROM CptCapital WHERE unitid = id_1 ;
if count_1 <> 0 then
open thecursor for
select -1 from dual;
return;
end if;
DELETE LgcAssetUnit WHERE ( id= id_1);
end;
/

/*td:555 */
UPDATE SystemRights SET rightdesc = '�ʲ��Զ������Ϣά��' WHERE id = 119
/
UPDATE SystemRightsLanguage SET rightname = '�ʲ��Զ�����Ϣά��', rightdesc='�ʲ��Զ�����Ϣά��' WHERE id = 119 AND languageid=7
/
UPDATE SystemRightDetail SET rightdetailname = '�ʲ��Զ�����Ϣά��' WHERE rightid = 119
/

/*FOR BUG 556 �ʲ�'�Զ�����Ϣ'�б�ͱ༭ҳ���ҳͷ���� by ·��*/
INSERT INTO HtmlLabelIndex values(17476,'�ʲ��Զ����ֶ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17476,'�ʲ��Զ����ֶ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17476,'User Definition Field',8) 
/
/*td:558 by lp */
insert into SystemRights (id,rightdesc,righttype) values (439,'�ʲ�����ά��','0') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (439,7,'�ʲ�����ά��','�ʲ�����ά��') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (439,8,'Capital Maintenance','Capital Maintenance') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3130,'�ʲ�����ά��','Capital:Maintenance',439) 
/
insert into SystemRightToGroup (groupid, rightid) values (9, 439)
/
insert into SystemRightRoles (rightid, roleid, rolelevel) values (439, 7, '2')
/
CREATE or REPLACE PROCEDURE CptCapital_ForcedDelete (
id_1 integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
AS
begin
UPDATE CptCapitalAssortment SET capitalcount = capitalcount-1 
WHERE id IN (SELECT capitalgroupid FROM CptCapital WHERE id = id_1) ; 
DELETE CptCapital WHERE id = id_1 ;
end;
/
/*td:562 �ʲ�����ɾ��ͼƬ������500���󣨽�oracle�ű���*/
CREATE OR REPLACE PROCEDURE CptCapital_UpdatePic (
id_1 integer, capitalimageid_2 integer, flag out integer , msg out varchar2, thecursor IN OUT cursor_define.weavercursor)
AS 
BEGIN
UPDATE CptCapital SET capitalimageid = 0 WHERE id = id_1;
DELETE ImageFile WHERE imagefileid = capitalimageid_2;
END;
/

/*FOR BUG620 (3) ,רҵ���õ���־*/
DELETE FROM SystemLogItem WHERE ItemID = '63'
/
INSERT INTO SystemLogItem(itemid,lableid,itemdesc) Values ('63',16463,'רҵ����')
/