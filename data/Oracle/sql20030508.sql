create table HrmEducationLevel
(id integer  not null,
 name varchar2(60) null,
 description varchar2(200) null)
/
create sequence HrmEducationLevel_id                      
start with 1                                               
increment by 1                                             
nomaxvalue                                                 
nocycle
/
create or replace trigger HrmEducationLevel_Trigger     
before insert on HrmEducationLevel                        
for each row                                               
begin                                                      
select HrmEducationLevel_id.nextval INTO :new.id from dual;
end;                                                       
/ 

insert into SystemRights (id, rightdesc,righttype) 
  values (381,'����ά��ά��',3) 
/
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(381,4,1)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3028,'����ά�����','HrmScheduleMaintanceAdd:Add',381)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3029,'����ά���༭','HrmScheduleMaintanceEdit:Edit',381)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3030,'����ά��ɾ��','HrmScheduleMaintanceDelete:Delete',381)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3031,'����ά����־','HrmScheduleMaintance:Log',381)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3032,'����ά���鿴','HrmScheduleMaintanceView:View',381)
/

insert into HrmEducationLevel (name,description)values('����','����')
/
insert into HrmEducationLevel (name,description)values('����','����')
/
insert into HrmEducationLevel (name,description)values('����','����')
/
insert into HrmEducationLevel (name,description)values('�м�','�м�')
/
insert into HrmEducationLevel (name,description)values('��ר','��ר')
/
insert into HrmEducationLevel (name,description)values('��ר','��ר')
/
insert into HrmEducationLevel (name,description)values('����','����')
/
insert into HrmEducationLevel (name,description)values('˶ʿ�о���','˶ʿ�о���')
/
insert into HrmEducationLevel (name,description)values('��ʿ�о���','��ʿ�о���')
/
insert into HrmEducationLevel (name,description)values('MBA','MBA')
/
insert into HrmEducationLevel (name,description)values('EMBA','EMBA')
/
insert into HrmEducationLevel (name,description)values('��ʿ��','��ʿ��')
/

CREATE OR REPLACE PROCEDURE HrmEducationLevel_Delete 
 (
	id_1 	integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
)
 AS
 begin
 DELETE HrmEducationLevel  WHERE ( id	 = id_1) ;
end;
/

 CREATE OR REPLACE PROCEDURE HrmEducationLevel_Insert 
	(
	name_1 	varchar2,
	description_2 	varchar2,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	)  
AS
begin
INSERT INTO HrmEducationLevel ( name, description)  VALUES ( name_1, description_2) ;
end;
/


 CREATE OR REPLACE PROCEDURE HrmEducationLevel_Select 
 (
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
open thecursor for
select * from HrmEducationLevel;
end;
/


 CREATE OR REPLACE PROCEDURE HrmEducationLevel_SelectByID 
 (
	id_1 varchar2 , 
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	)
AS
begin
open thecursor for
select * from HrmEducationLevel where id = to_number(id_1);
end;
/


 CREATE OR REPLACE PROCEDURE HrmEducationLevel_Update 
 (id_1 	integer,
	name_2 	varchar2,
	description_3 	varchar2,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS 
begin
UPDATE HrmEducationLevel  SET  name	 = name_2, description	 = description_3  WHERE ( id	 = id_1) ;
end;
/


insert into SystemLogItem (itemid,lableid,itemdesc) values(80,818,'ѧ��')
/

insert into SystemRights (id, rightdesc,righttype) 
  values (382,'ѧ��ά��',3) 
/
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(382,4,1)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3033,'ѧ�����','HrmEducationLevelAdd:Add',382)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3034,'ѧ���༭','HrmEducationLevelEdit:Edit',382)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3035,'ѧ��ɾ��','HrmEducationLevelDelete:Delete',382)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3036,'ѧ����־','HrmEducationLevel:Log',382)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3037,'ѧ���鿴','HrmEducationLevelView:View',382)
/

 CREATE OR REPLACE PROCEDURE HrmResourceDateCheck
 (today_1 char,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 as 
 begin
 update HrmResource set
   status = 7
 where
    (status = 0 or status = 1 or status = 2 or status = 3) and enddate < today_1 and enddate <>'';
 update HrmResource set
   status = 3
 where
   status = 0 and probationenddate < today_1 ;
end;
/


 CREATE OR REPLACE PROCEDURE HrmResource_DepUpdate
(
	id_1 integer,
	departmentid_2 integer,
	joblevel_3 integer,
	costcenterid_4 integer,
	jobtitle_5 integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
as
begin
update HrmResource set
  departmentid = departmentid_2,
  joblevel = joblevel_3,
  costcenterid = costcenterid_4,
  jobtitle = jobtitle_5
where
  id = id_1;
end;
/


 CREATE OR REPLACE PROCEDURE HrmDepartment_Select 
 (
  	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
open thecursor for
select * from HrmDepartment order by showorder;
end;
/


delete from HrmListValidate
/
insert into HrmListValidate (id,name,validate_n) values(1,'��֯�ṹ','1')
/
insert into HrmListValidate (id,name,validate_n) values(2,'���¹���','1')
/
insert into HrmListValidate (id,name,validate_n) values(3,'��������','1')
/
insert into HrmListValidate (id,name,validate_n) values(4,'��ͬ����','1')
/
insert into HrmListValidate (id,name,validate_n) values(5,'���ڹ���','1')
/
insert into HrmListValidate (id,name,validate_n) values(6,'�������','1')
/
insert into HrmListValidate (id,name,validate_n) values(7,'���Ϳ���','1')
/
insert into HrmListValidate (id,name,validate_n) values(8,'��ѵ����','1')
/
insert into HrmListValidate (id,name,validate_n) values(9,'��Ƹ����','1')
/
insert into HrmListValidate (id,name,validate_n) values(10,'����','1')
/
insert into HrmListValidate (id,name,validate_n) values(11,'������Ϣ','1')
/
insert into HrmListValidate (id,name,validate_n) values(12,'������Ϣ','1')
/
insert into HrmListValidate (id,name,validate_n) values(13,'������Ϣ','1')
/
insert into HrmListValidate (id,name,validate_n) values(14,'�ʲ���Ϣ','1')
/
insert into HrmListValidate (id,name,validate_n) values(15,'ϵͳ��Ϣ','1')
/
insert into HrmListValidate (id,name,validate_n) values(16,'����','1')
/
insert into HrmListValidate (id,name,validate_n) values(17,'������','1')
/
insert into HrmListValidate (id,name,validate_n) values(18,'�ƻ�','1')
/
insert into HrmListValidate (id,name,validate_n) values(19,'�ʼ�����','1')
/
insert into HrmListValidate (id,name,validate_n) values(20,'����','1')
/
insert into HrmListValidate (id,name,validate_n) values(21,'��ѵ��¼','1')
/
insert into HrmListValidate (id,name,validate_n) values(22,'���ͼ�¼','1')
/
insert into HrmListValidate (id,name,validate_n) values(23,'��־','1')
/
insert into HrmListValidate (id,name,validate_n) values(24,'ͳ��','1')
/
insert into HrmListValidate (id,name,validate_n) values(25,'ͼƬ','1')
/
insert into HrmListValidate (id,name,validate_n) values(26,'��ɫ������','1')
/
insert into HrmListValidate (id,name,validate_n) values(27,'���ڲμӵ���ѵ�','1')
/
insert into HrmListValidate (id,name,validate_n) values(28,'���Բμӵ���ѵ����','1')
/

insert into HrmScheduleDiff (diffname, diffdesc,difftype,difftime, mindifftime, workflowid,salaryable,counttype,countnum,salaryitem,diffremark,color)
values('�Ӱ�','�Ӱ�',0,0,0,1,'',0,0,1,'','ff0033')
/

insert into HrmScheduleDiff (diffname, diffdesc,difftype,difftime, mindifftime, workflowid,salaryable,counttype,countnum,salaryitem,diffremark,color)
values('���','���',1,0,0,1,'',0,0,1,'','00ffff')
/

insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3038,'ӦƸ�����','HrmCareerApplyAdd:Add',111)
/

insert into SystemRights (id, rightdesc,righttype) 
  values (383,'��ͬ����ά��',3) 
/
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(383,4,1)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3039,'��ͬ�������','HrmContractTypeAdd:Add',383)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3040,'��ͬ����༭','HrmContractTypeEdit:Edit',383)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3041,'��ͬ����ɾ��','HrmContractTypeDelete:Delete',383)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3042,'��ͬ������־','HrmContractType:Log',383)
/

insert into HtmlLabelIndex (id,indexdesc) values (6158,'��ͬ����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6158,'��ͬ����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6158,'HrmContractType',8)
/

insert into SystemLogItem (itemid,lableid,itemdesc) values(81,6158,'��ͬ����')
/

insert into SystemRights (id, rightdesc,righttype) 
  values (384,'��ͬά��',3) 
/
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(384,4,1)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3045,'��ͬ���','HrmContractAdd:Add',384)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3043,'��ͬ�༭','HrmContractEdit:Edit',384)
/
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3044,'��ͬɾ��','HrmContractDelete:Delete',384)
/

insert into SystemLogItem (itemid,lableid,itemdesc) values(82,6156,'��ѵ����')
/

insert into SystemLogItem (itemid,lableid,itemdesc) values(83,6136,'��ѵ�')
/

alter table SystemSet add pop3server varchar2(60)
/

 CREATE OR REPLACE PROCEDURE SystemSet_Update 
 (
	emailserver_1  varchar2 , 
	debugmode_2   char , 
	logleaveday_3  smallint ,
	defmailuser_4  varchar2 ,
	defmailpassword_5  varchar2,
	pop3server_6  varchar2, 
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	)  
AS 
begin
 update SystemSet set 
        emailserver=emailserver_1 , 
        debugmode=debugmode_2,
        logleaveday=logleaveday_3 ,
        defmailuser=defmailuser_4 , 
        defmailpassword=defmailpassword_5 , 
        pop3server=pop3server_6 ;
end;
/


alter table HrmCheckKind modify( checkstartdate char(10))
/

alter table HrmCheckKind drop column checkenddate 
/
/* 2003-05-6 ������������� */
DROP TABLE HrmCheckKind
/
drop sequence HrmCheckKind_id
/
CREATE TABLE HrmCheckKind (
	id integer  NOT NULL  ,
	kindname varchar2(60)  NULL ,
	checkcycle char (1)   NULL ,
        checkexpecd integer NULL,
	checkstartdate char(10)  NULL 
) 
/
create sequence HrmCheckKind_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckKind_Tr
before insert on HrmCheckKind
for each row
begin
select HrmCheckKind_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckKind  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/

/* 2003-5-6 ��������������Ŀ�� */
DROP TABLE HrmCheckKindItem
/
drop sequence HrmCheckKindItem_id
/
CREATE TABLE HrmCheckKindItem (
	id integer  NOT NULL   ,
	checktypeid integer  NULL ,
	checkitemid integer   NULL ,
	checkitemproportion integer NULL 
) 
/
create sequence HrmCheckKindItem_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckKindItem_Tr
before insert on HrmCheckKindItem
for each row
begin
select HrmCheckKindItem_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckKindItem  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/


/* 2003-5-6 �������˸�λ�� */
DROP TABLE HrmCheckPost
/
drop sequence HrmCheckPost_id
/
CREATE TABLE HrmCheckPost 
(
	id integer  NOT NULL  ,
	checktypeid integer  NULL ,
	jobid integer   NULL	
) 
/
create sequence HrmCheckPost_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckPost_Tr
before insert on HrmCheckPost
for each row
begin
select HrmCheckPost_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckPost  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/


/* 2003-5-6 �������˲����˱� */
DROP TABLE HrmCheckActor
/
DROP sequence HrmCheckActor_id
/
CREATE TABLE HrmCheckActor (
	id integer  NOT NULL  ,
	checktypeid integer  NULL ,
	typeid integer   NULL ,
	resourceid integer NULL,
	checkproportion integer NULL	
) 
/
create sequence HrmCheckActor_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckActor_Tr
before insert on HrmCheckActor
for each row
begin
select HrmCheckActor_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckActor  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/

/* 2003-5-6 �������˱� */
DROP TABLE HrmCheckList
/
drop sequence HrmCheckList_id
/
CREATE TABLE HrmCheckList (
	id integer  NOT NULL  ,
	checkname varchar2 (60) NULL,
	checktypeid integer  NULL ,
	startdate char(10) NULL,/*��ʼ����*/
	enddate char(10) NULL, /*��������*/
	status integer NULL/*״̬*/	
) 
/
create sequence HrmCheckList_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckList_Tr
before insert on HrmCheckList
for each row
begin
select HrmCheckList_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckList  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/
/* 2003-5-6 �����������˱� */
DROP TABLE HrmByCheckPeople
/
drop sequence HrmByCheckPeople_id
/
CREATE TABLE HrmByCheckPeople (
	id integer NOT NULL  ,
	checkid integer  NULL ,/*����id*/
	resourceid integer NULL,/*��������ID*/
	checkercount integer NULL,/*������ID*/
	proportion integer  NULL ,/*Ȩ��*/
        checkresourcetype integer NULL,/*����*/
	result number (10,2) NULL,/*�ɼ�*/
	lastmodifydate char(10) NULL/*����޸ĵ�ʱ��*/	
) 
/
create sequence HrmByCheckPeople_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmByCheckPeople_Tr
before insert on HrmByCheckPeople
for each row
begin
select HrmByCheckPeople_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmByCheckPeople  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/

/* 2003-5-6 �������˳ɼ��� */
DROP TABLE HrmCheckGrade
/
drop sequence HrmCheckGrade_id
/
CREATE TABLE HrmCheckGrade (
	id integer   NOT NULL   ,
	checkpeopleid integer  NULL ,/*����id*/
	checkitemid integer NULL,/*��ĿID*/
	result integer  NULL, /*�ɼ�*/
	checkitemproportion integer NULL/*Ȩ��*/			
) 
/
create sequence HrmCheckGrade_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger HrmCheckGrade_Tr
before insert on HrmCheckGrade
for each row
begin
select HrmCheckGrade_id.nextval into :new.id from dual;
end;
/
ALTER TABLE HrmCheckGrade  ADD 
	 PRIMARY KEY 
	(
		id
	) 
/

/*2003-4-28�޸Ŀ��˸�λ�洢����*/
CREATE OR REPLACE PROCEDURE HrmCheckPost_Update
(id_1 integer,
 checktypeid_2 integer,
 jobid_3 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
UPDATE HrmCheckPost set
checktypeid = checktypeid_2,
jobid = jobid_3
WHERE
 id = id_1;
end;
/


/*2003-4-28�޸Ŀ���������Ŀ�洢����*/
CREATE OR REPLACE PROCEDURE HrmCheckKindItem_Update
(
	id_1 integer,
	checktypeid_2 integer,
	checkitemid_3 integer,
	checkitemproportion_4 integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
UPDATE HrmCheckKindItem set
checktypeid = checktypeid_2,
checkitemid = checkitemid_3,
checkitemproportion = checkitemproportion_4
WHERE
 id = id_1;
end;
/


/*2003-4-28�޸Ŀ��˲����˴洢����*/
CREATE OR REPLACE PROCEDURE HrmCheckActor_Update
(
	id_1 integer,
	checktypeid_2 integer,
	typeid_3 integer,
	resourceid_4 integer,
	checkproportion_5 integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
UPDATE HrmCheckActor set
checktypeid = checktypeid_2,
typeid = typeid_3,
resourceid = resourceid_4,
checkproportion = checkproportion_5
WHERE
 id = id_1;
end;
/


 
 /* 2003-4-25���������˳ɼ������� */

CREATE OR REPLACE PROCEDURE HrmCheckGrade_Insert
(checkpeopleid_2 integer,
 checkitemid_3 integer,
 result_4 integer,
 checkitemproportion_5 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 AS
 begin
   insert into HrmCheckGrade (checkpeopleid,checkitemid,result,checkitemproportion) values (checkpeopleid_2,checkitemid_3,
   result_4,checkitemproportion_5);
 end;
/

 /*2003-4-28�޸Ŀ����˳ɼ��洢����*/

CREATE OR REPLACE PROCEDURE HrmCheckGrade_Update
(id_1 integer,
 checkpeopleid_2 integer,
 checkitemid_3 integer,
 result_4 integer,
 checkitemproportion_5 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS
begin
UPDATE HrmCheckGrade set
checkpeopleid = checkpeopleid_2,
checkitemid = checkitemid_3,
result = result_4,
checkitemproportion = checkitemproportion_5
WHERE
 id = id_1;
end;
/


 /* 2003-5-6�������˱����� */
CREATE OR REPLACE PROCEDURE HrmCheckList_Insert
(
	checkname_2 varchar2,
	checktypeid_3 integer,
	startdate_4 char,
	enddate_5 char,
	status_6 integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 AS
 begin
   insert into HrmCheckList (checkname,checktypeid,startdate,enddate,status) values (checkname_2,checktypeid_3,
   startdate_4,enddate_5,status_6);
open thecursor for
   select max(id) from HrmCheckList ;
end;
/

/* 2003-5-6������������洢���� */

CREATE OR REPLACE PROCEDURE HrmCheckKind_Insert
(
	kindname_2 varchar2,
	checkcycle_3 char,
	checkexpecd_4 integer,
	checkstartdate_5 char,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 AS
 begin
   insert into HrmCheckKind (kindname,checkcycle,checkexpecd,checkstartdate) values (kindname_2,checkcycle_3,
   checkexpecd_4, checkstartdate_5);
 end;
/

  
  /*2003-5-6�޸Ŀ�������洢����*/

CREATE OR REPLACE PROCEDURE HrmCheckKind_Update
(
	id_1 integer,
	kindname_2 varchar2,
	checkcycle_3 char,
	checkexpecd_4 integer,
	checkstartdate_5 char,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS 
begin
UPDATE HrmCheckKind set
kindname = kindname_2,
checkcycle = checkcycle_3,
checkexpecd = checkexpecd_4,
checkstartdate= checkstartdate_5
WHERE
 id = id_1;
end;
/


/*2003-05-9�����������˱�洢����*/

CREATE OR REPLACE PROCEDURE HrmByCheckPeople_Insert
(
	checkid_2 integer,
	resourceid_3 integer,
	checkercount_4 integer,
	proportion_5 integer,
	checkresourcetype_6 integer,
	result_7 number,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 AS
 begin
   insert into HrmByCheckPeople (checkid,resourceid,checkercount,proportion,checkresourcetype
   ,result) values (checkid_2,resourceid_3,checkercount_4, proportion_5,checkresourcetype_6,
   result_7);
open thecursor for
   select max(id) from HrmByCheckPeople;
end;
/


 /* 2003-5-9�������˲����˱�Ĵ洢���� */
 CREATE OR REPLACE PROCEDURE HrmCheckActor_Insert
(
	checktypeid_2 integer,
	typeid_3 integer,
	resourceid_4 integer,
	checkproportion_5 integer,
	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
 AS
 begin
   insert into HrmCheckActor (checktypeid,typeid,resourceid,checkproportion) values (checktypeid_2,
   typeid_3,resourceid_4,checkproportion_5);
 end;
/

 /*2003-5-10�޸ı������˱�Ĵ洢����*/
CREATE OR REPLACE PROCEDURE HrmByCheckPeople_Update
(id_1 integer,
 result_2 number,
 lastmodifydate_3 char,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
AS 
begin
UPDATE HrmByCheckPeople set
result = result_2,
lastmodifydate= lastmodifydate_3
WHERE
 id = id_1;
end;
/



insert into HtmlLabelInfo (indexid,labelname,languageid) values (7014,'����ʵʩ',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7014,'',8)
/



insert into HtmlLabelInfo (indexid,labelname,languageid) values (7015,'���Ϳ���',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7015,'',8)
/


CREATE TABLE CRM_PayInfo
(
id integer not null ,
payid integer null,
factprice number(10,2) null,
factdate char(10) null,
creater integer null
)
/
create sequence CRM_PayInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger CRM_PayInfo_Trigger
before insert on CRM_PayInfo
for each row
begin
select CRM_PayInfo_id.nextval INTO :new.id from dual;
end;
/

CREATE OR REPLACE PROCEDURE CRM_PayInfo_Insert
(
	id_1		integer,
	factprice_1	number,
	factdate_1 char,
	creater_1 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
as
begin
	insert into CRM_PayInfo
	(payid,factprice,factdate,creater)
	values
	(	id_1,factprice_1,	factdate_1 ,creater_1);
end;
/


CREATE OR REPLACE PROCEDURE CRM_PayInfo_SelectAll
(
	id_1		integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
as
begin
open thecursor for
	select * from CRM_PayInfo WHERE payid=id_1 order by factdate desc;
	end;
/


CREATE OR REPLACE PROCEDURE CRM_PayInfo_update
(
	id_1		integer,
	factprice_1	number,
	factdate_1 char,
	creater_1 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
as
begin
	update  CRM_PayInfo set
	factprice=factprice_1,
	factdate=factdate_1,
	creater=creater_1
	WHERE id=id_1;
end;
/


CREATE OR REPLACE PROCEDURE CRM_PayInfo_del
(
	id_1		integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 
as
begin
	delete from CRM_PayInfo WHERE id =id_1;
end;
/




/*crm-proj-fna����*/
 alter table CRM_Contract add projid integer null
/



  CREATE OR REPLACE PROCEDURE CRM_Contract_Insert 
	(name_1  varchar2   ,
	 typeId_1  integer  ,	
	 docId_1  varchar2   ,
	 price_1  number  ,
	 crmId_1  integer  ,
	 contacterId_1  integer  ,
	 startDate_1  char    ,
	 endDate_1  char  ,
	 manager_1  integer  ,
	 status_1  integer  ,
	 isRemind_1  integer  ,
	 remindDay_1  integer  ,
	 creater_1  integer  ,
	 createDate_1  char   ,
	 createTime_1  char  ,
	 prjid_1 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 

AS 
begin
INSERT INTO CRM_Contract 
	 (name , 
	 typeId , 
	 docId , price , crmId , contacterId , startDate , endDate , manager , status , isRemind , remindDay , creater , createDate , createTime,projid) 
 
VALUES 
	( name_1,
	 typeId_1,
	 docId_1, price_1 , crmId_1 , contacterId_1 , startDate_1 , endDate_1 , manager_1 , status_1 , isRemind_1 , remindDay_1 , creater_1 , createDate_1 , createTime_1,prjid_1);
open thecursor for
select * from (select  * from CRM_Contract order by id desc ) WHERE rownum =1;
end;
/



 CREATE OR REPLACE PROCEDURE CRM_Contract_Update 
	(id_1 	integer ,
	 name_1  varchar2   ,
	 typeId_1  integer  ,	
	 docId_1  varchar2   ,
	 price_1  number  ,
	 crmId_1  integer  ,
	 contacterId_1  integer  ,
	 startDate_1  char   ,
	 endDate_1  char   ,
	 manager_1  integer  ,
	 status_1  integer  ,
	 isRemind_1  integer  ,
	 remindDay_1  integer  ,
	 prjid_1 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 

AS
begin
UPDATE CRM_Contract
SET name = name_1, typeId = typeId_1 , docId = docId_1 , price = price_1 , crmId = crmId_1 , 
contacterId = contacterId_1 , startDate = startDate_1 , endDate = endDate_1 , manager = manager_1 , 
status = status_1 , isRemind = isRemind_1 , remindDay = remindDay_1 ,projid=prjid_1  where id = id_1;
end;
/



alter table CRM_ContractPayMethod add feetypeid integer null
/


 CREATE OR REPLACE PROCEDURE CRM_ContractPayMethod_Insert 
	(
	 contractId_1  integer  ,	
	 prjName_1  varchar2   ,
	 typeId_1  integer  ,
	 payPrice_1  number  ,
	 payDate_1  char    ,
	 factPrice_1  number ,
	 factDate_1  char  ,
	 qualification_1 varchar2 ,
	 isFinish_1  integer  ,
	 isRemind_1  integer  ,
	 feetypeid_1 integer,
 	flag out integer  , 
	msg  out varchar2,
	thecursor IN OUT cursor_define.weavercursor
	) 

AS
begin
INSERT INTO CRM_ContractPayMethod 
	 (contractId , 
	 prjName , 
	 typeId , payPrice , payDate , factPrice , factDate , qualification , isFinish , isRemind,feetypeid ) 
 
VALUES 
	(contractId_1,
	 prjName_1,
	 typeId_1, payPrice_1 , payDate_1 , factPrice_1 , factDate_1 , qualification_1 , isFinish_1 , isRemind_1,feetypeid_1);
end;
/



alter table FnaAccountLog add iscontractid char(1) default 0
/


 CREATE OR REPLACE PROCEDURE FnaAccountLog_Insert
(
feetypeid_1 integer,
resourceid_2 integer,
departmentid_3 integer,
crmid_4 integer,
projectid_5 integer,
amount_6 number,
description_7 varchar2,
occurdate_8 char,
releatedid_9 char,
releatedname_10 varchar2,
iscontractid_1 char,
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
	) 

AS
begin 
INSERT INTO FnaAccountLog
( feetypeid,
resourceid,
departmentid,
crmid,
projectid,
amount,
description,
occurdate,
releatedid,
releatedname,
iscontractid
)

VALUES
(
feetypeid_1,
resourceid_2,
departmentid_3,
crmid_4,
projectid_5,
amount_6,
description_7,
occurdate_8,
releatedid_9,
releatedname_10,
iscontractid_1
);
open thecursor for
select max(id) from FnaAccountLog;
end;
/

alter table CRM_ContractPayMethod add fnalogid integer null
/



CREATE OR REPLACE PROCEDURE FnaAccountLog_Update
(
fnalogid_1 integer,
amount_6 number,
projectid_5 integer,
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
	) 
AS 
begin
Update FnaAccountLog set 
amount=amount_6,
projectid = projectid_5
WHERE id = fnalogid_1;
end;
/


create table HrmResource_Trigger
(id integer not null,
 managerid integer null,
 departmentid integer null,
 subcompanyid1 integer null,
 seclevel smallint null,
 managerstr varchar2(200) null)
/







CREATE OR REPLACE PROCEDURE HrmResource_Trigger_Insert
(
id_1 integer,
managerid_2 integer,
departmentid_3 integer,
subcompanyid1_4 integer,
seclevel_5 smallint,
managerstr_6 varchar2,
flag out integer  , 
msg  out varchar2,
thecursor IN OUT cursor_define.weavercursor
) 
AS 
numcount integer;
begin
select count(*) into numcount from HrmResource_Trigger where id=id_1;
if numcount =0 then
INSERT INTO HrmResource_Trigger 
( id,
managerid,
departmentid,
subcompanyid1,
seclevel,
managerstr) 
 
VALUES 
( id_1,
managerid_2,
departmentid_3,
subcompanyid1_4,
seclevel_5,
managerstr_6);
end if;
end;
/


insert into HrmResource_Trigger(id,managerid,departmentid,subcompanyid1,seclevel,managerstr)values(1,1,1,1,30,'1,')
/
insert into HrmResource_Trigger(id,managerid,departmentid,subcompanyid1,seclevel,managerstr)values(2,1,1,1,30,'1,')
/






/* ����������Դ��ĸ��� */
CREATE or REPLACE  TRIGGER Tri_Update_HrmresourceShare 
after  update  ON Hrmresource 
FOR each row

Declare resourceid_1 integer;
		subresourceid_1 integer;
		supresourceid_1 integer;
		olddepartmentid_1 integer;
		departmentid_1 integer;
		subcompanyid_1 integer;
		oldseclevel_1	 integer;
		seclevel_1	 integer;
		docid_1	 integer;
		crmid_1	 integer;
		prjid_1	 integer;
		cptid_1	 integer;
		sharelevel_1  integer;
		countrec      integer;
		countdelete   integer;
		oldmanagerstr_1    varchar2(200);
		managerstr_1    varchar2(200);
		managerstr_11 varchar2(200) ;
		mainid_1	integer;
		subid_1	integer;
		secid_1	integer;
		members_1 varchar2(200);

begin
        
/* �Ӹ��޸ĵ����в����޸ĵ�resourceid �� */

 olddepartmentid_1 := :old.departmentid;
 oldseclevel_1 := :old.seclevel ; 
 oldmanagerstr_1 := :old.managerstr;
 resourceid_1 := :new.id ;
 departmentid_1 := :new.departmentid;
 subcompanyid_1 := :new.subcompanyid1;
 seclevel_1 := :new.seclevel ; 
 managerstr_1 := :new.managerstr;

if seclevel_1 is not null then
update HrmResource_Trigger set
seclevel =seclevel_1 
where id =resourceid_1;
end if;


if ( departmentid_1 is not null ) then
update HrmResource_Trigger set 
departmentid =departmentid_1
where id =resourceid_1;
end if;

if (  managerstr_1 is not null) then
update HrmResource_Trigger set
managerstr =managerstr_1
where id =resourceid_1;
end if;

if subcompanyid_1 is not null then
update HrmResource_Trigger set
subcompanyid1 =subcompanyid_1 
where id =resourceid_1;
end if;

if oldseclevel_1 is null then
oldseclevel_1 := 0;
end if;


/* ������źͰ�ȫ������Ϣ���޸�(���½���ʱ����������Ϣ�϶����޸�) */
  
if ( departmentid_1 <>olddepartmentid_1 or  seclevel_1 <> oldseclevel_1 or oldseclevel_1 is null )  then   
 
    if departmentid_1 is null   then
	departmentid_1 := 0;
	end if;
    if subcompanyid_1 is null   then
	subcompanyid_1 := 0;
	end if;

    /* �����½��ĵ�Ŀ¼���б� */
    


	delete from DocUserCategory where userid= resourceid_1 and usertype= '0';

	for all_cursor in(
	select distinct t1.id t1id from docseccategory t1,HrmResource_Trigger t2,hrmrolemembers t5
	where t1.cusertype='0' and t2.id= resourceid_1 
	and(( t2.seclevel>= t1.cuserseclevel) 
	or( t2.seclevel >= t1.cdepseclevel1 and t2.departmentid=t1.cdepartmentid1) 
	or( t2.seclevel >= t1.cdepseclevel2 and t2.departmentid=t1.cdepartmentid2) 
	or( t5.roleid=t1.croleid1 and t5.rolelevel=t1.crolelevel1 and t2.id=t5.resourceid )
	or( t5.roleid=t1.croleid2 and t5.rolelevel=t1.crolelevel2 and t2.id=t5.resourceid )
	or( t5.roleid=t1.croleid3 and t5.rolelevel=t1.crolelevel3 and t2.id=t5.resourceid ))
	)
	loop
		secid_1 := all_cursor.t1id;
		select  subcategoryid INTO subid_1 from docseccategory where id=secid_1;
		select  maincategoryid INTO mainid_1 from docsubcategory where id=subid_1;
		insert into  docusercategory (secid,mainid,subid,userid,usertype)
		values (secid_1,mainid_1,subid_1,resourceid_1,'0');
	end loop;

    /* DOC ����*/
	
    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = resourceid_1 and usertype = 1;



    /*  �����е���Ϣ�ַŵ� temptablevalue �� */
    /*  �Լ������Ļ����� owner �����¿��Ա༭ */
    for docid_cursor IN (select distinct id from DocDetail where ( doccreaterid = resourceid_1 or ownerid = resourceid_1 ) and usertype= '1')
	loop
	docid_1 := docid_cursor.id;
	insert into temptablevalue values(docid_1, 2);
	end loop;




    /* �Լ��¼����ĵ� */
    /* �����¼� */
 
     managerstr_11 := concat( concat('%,' , to_char(resourceid_1)) , ',%'); 

    for subdocid_cursor IN ( select distinct id from DocDetail where ( doccreaterid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) or ownerid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ) and usertype= '1')
	loop
	docid_1 :=subdocid_cursor.id;
	     select  count(docid) INTO countrec  from temptablevalue where docid = docid_1;
        if countrec = 0 then
		insert into temptablevalue values(docid_1, 1);
		end if;
	end loop;
         


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    for  sharedocid_cursor IN (select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= seclevel_1 )  or ( userid= resourceid_1 ) or (departmentid= departmentid_1 and seclevel<= seclevel_1 ))
	loop 
	docid_1:=sharedocid_cursor.docid;
	sharelevel_1 :=sharedocid_cursor.sharelevel;
        select  count(docid) INTO countrec  from temptablevalue where docid = docid_1  ;
        if countrec = 0  then        
            insert into temptablevalue values(docid_1, sharelevel_1);        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */ end if;  
        end if;
	end loop;
    


    for sharedocid_cursor IN (select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.docid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ))
    loop
	docid_1 :=sharedocid_cursor.docid;
	sharelevel_1 :=sharedocid_cursor.sharelevel;
	select  count(docid) INTO countrec  from temptablevalue where docid = docid_1  ;
        if countrec = 0  then
        
            insert into temptablevalue values(docid_1, sharelevel_1);
        
        else if sharelevel_1 = 2  then        
            update temptablevalue set sharelevel = 2 where docid=docid_1; /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */ end if;  
        end if;
	end loop;


 



    /* ����ʱ���е�����д�빲��� */
    for alldocid_cursor IN (select * from temptablevalue)
	loop
	docid_1 :=alldocid_cursor.docid;
	sharelevel_1 := alldocid_cursor.sharelevel;
	insert into docsharedetail values(docid_1, resourceid_1,1,sharelevel_1);
	end loop;
    



    /* ------- CRM  ���� ------- */


    /* ɾ��ԭ�еĸ��˵����пͻ�������Ϣ */
	delete from CrmShareDetail where userid = resourceid_1 and usertype = 1;



    /*  �����е���Ϣ�ַŵ� temptablevaluecrm �� */
    /*  �Լ��� manager �Ŀͻ� 2 */
    for crmid_cursor IN (select id from CRM_CustomerInfo where manager = resourceid_1 )
	loop
	crmid_1 :=crmid_cursor.id;
	insert into temptablevaluecrm values(crmid_1, 2);
	end loop;
    

    /* �Լ��¼��Ŀͻ� 3 */
    /* �����¼� */
     
     managerstr_11 := concat( concat('%,' , to_char(resourceid_1)) , ',%' );

    for subcrmid_cursor IN (select id from CRM_CustomerInfo where ( manager in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	crmid_1 :=subcrmid_cursor.id;
        select count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0 then
		insert into temptablevaluecrm values(crmid_1, 3);
		end if;
	end loop;
    

 
    /* ��Ϊcrm����Ա�ܿ����Ŀͻ� */
    for rolecrmid_cursor IN (   select distinct t1.id from CRM_CustomerInfo  t1, hrmrolemembers  t2  where t2.roleid=8 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	crmid_1:=rolecrmid_cursor.id;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1;
        if countrec = 0 then
		insert into temptablevaluecrm values(crmid_1, 4);
		end if;
	end loop;




    /* �ɿͻ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecrmid_cursor IN (select distinct t2.relateditemid , t2.sharelevel from CRM_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	crmid_1 := sharecrmid_cursor.relateditemid;
	 sharelevel_1:=sharecrmid_cursor.sharelevel;
        select  count(crmid) INTO countrec  from temptablevaluecrm where crmid = crmid_1 ; 
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;
    




    for sharecrmid_cursor IN (   select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department=departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) 
    )
	loop
	crmid_1 :=sharecrmid_cursor.relateditemid;
	sharelevel_1 :=sharecrmid_cursor.sharelevel;
        select count(crmid) INTO countrec from temptablevaluecrm where crmid = crmid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluecrm values(crmid_1, sharelevel_1);
        end if;
	end loop;



    /* ����ʱ���е�����д�빲��� */
    for allcrmid_cursor IN (select * from temptablevaluecrm)
	loop
	crmid_1 :=allcrmid_cursor.crmid;
	sharelevel_1 := allcrmid_cursor.sharelevel;
	insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(crmid_1, resourceid_1,1,sharelevel_1);
	end loop;





    /* ------- PROJ ���� ------- */



    /*  �����е���Ϣ�ַŵ� temptablevaluePrj �� */
    /*  �Լ�����Ŀ2 */
    for prjid_cursor IN (select id from Prj_ProjectInfo where manager = resourceid_1 )
	loop
	prjid_1:=prjid_cursor.id;
	insert into temptablevaluePrj values(prjid_1, 2);
	end loop;
    



    /* �Լ��¼�����Ŀ3 */
    /* �����¼� */
     
     managerstr_11 :=  concat(concat('%,' , to_char(resourceid_1)) , ',%' );

    for subprjid_cursor IN (select id from Prj_ProjectInfo where ( manager in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	prjid_1 :=subprjid_cursor.id;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 3);
		end if;
	end loop;

    
 
    /* ��Ϊ��Ŀ����Ա�ܿ�������Ŀ4 */
    for roleprjid_cursor IN (   select distinct t1.id from Prj_ProjectInfo  t1, hrmrolemembers  t2  where t2.roleid=9 and t2.resourceid= resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1 )))
	loop
	prjid_1 :=roleprjid_cursor.id;
        select count(prjid) INTO  countrec  from temptablevaluePrj where prjid = prjid_1;
        if countrec = 0 then
		insert into temptablevaluePrj values(prjid_1, 4);
		end if;
	end loop;

	 


    /* ����Ŀ�Ĺ����õ�Ȩ�� 1 2 */
    for shareprjid_cursor IN ( select distinct t2.relateditemid , t2.sharelevel from Prj_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	prjid_1 :=shareprjid_cursor.relateditemid;
	sharelevel_1 :=shareprjid_cursor.sharelevel;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end if;
	end loop;
   



    for shareprjid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and  t3.resourceid=resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=seclevel_1 and ( (t2.rolelevel=0  and t1.department=departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=subcompanyid_1) or (t3.rolelevel=2) ) 
    )
	loop
	 prjid_1 :=shareprjid_cursor.relateditemid;
	 sharelevel_1:=shareprjid_cursor.sharelevel;
        select count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, sharelevel_1);
        end	if;
		end loop;





    /* ��Ŀ��Ա5 (�ڲ��û�) */
	members_1 := concat(concat('%,' , to_char(resourceid_1)), ',%' );
    for inuserprjid_cursor IN (  SELECT  id FROM Prj_ProjectInfo   WHERE  ( concat(concat(',',members),',')  LIKE  members_1)  and isblock='1'  )
	loop
	prjid_1 :=inuserprjid_cursor.id;
        select  count(prjid) INTO countrec  from temptablevaluePrj where prjid = prjid_1  ;
        if countrec = 0  then
        
            insert into temptablevaluePrj values(prjid_1, 5);
        end	if;
	end loop;




    /* ɾ��ԭ�е������Ա��ص�������ĿȨ */
    delete from PrjShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allprjid_cursor IN (select * from temptablevaluePrj)
	loop
	prjid_1 :=allprjid_cursor.prjid;
	sharelevel_1 :=allprjid_cursor.sharelevel;
       insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(prjid_1, resourceid_1,1,sharelevel_1);
	end loop;



    /* ------- CPT ���� ------- */



    /*  �����е���Ϣ�ַŵ� temptablevalueCpt �� */
    /*  �Լ����ʲ�2 */
    for cptid_cursor IN (select id from CptCapital where resourceid = resourceid_1 )
	loop
	cptid_1 :=cptid_cursor.id;
	insert into temptablevalueCpt values(cptid_1, 2);
	end loop;
    

    /* �Լ��¼����ʲ�1 */
    /* �����¼� */
     
     managerstr_11 := concat(concat( '%,' , to_char(resourceid_1)),',%'); 

    for subcptid_cursor IN (
	select id from CptCapital where ( resourceid in (select distinct id from HrmResource_Trigger where concat(',',managerstr) like managerstr_11 ) ))
	loop
	cptid_1 := subcptid_cursor.id;
        select  count(cptid) INTO countrec  from temptablevalueCpt where cptid = cptid_1;
        if countrec = 0  then
		insert into temptablevalueCpt values(cptid_1, 1);
		end if;
	end loop;

    

 
   
    /* ���ʲ��Ĺ����õ�Ȩ�� 1 2 */
    for sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapitalShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=seclevel_1)  or ( t2.userid=resourceid_1 ) or (t2.departmentid=departmentid_1 and t2.seclevel<=seclevel_1)  ))
	loop
	cptid_1 :=sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select  count(cptid) into  countrec from temptablevalueCpt where cptid = cptid_1  ;
        if countrec = 0  then
        
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end if;
	end loop;




    for  sharecptid_cursor IN (    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.relateditemid and t3.resourceid= resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= seclevel_1 and ( (t2.rolelevel=0  and t1.departmentid= departmentid_1 ) or (t2.rolelevel=1 and t1.departmentid=t4.id and t4.subcompanyid1= subcompanyid_1 ) or (t3.rolelevel=2) ))
	loop
	cptid_1:= sharecptid_cursor.relateditemid;
	sharelevel_1 := sharecptid_cursor.sharelevel;
        select count(cptid) INTO countrec  from temptablevalueCpt where cptid = cptid_1;  
        if countrec = 0 then         
            insert into temptablevalueCpt values(cptid_1, sharelevel_1);
        end  if;
	end loop;




    /* ɾ��ԭ�е������Ա��ص������ʲ�Ȩ */
    delete from CptShareDetail where userid = resourceid_1 and usertype = 1;

    /* ����ʱ���е�����д�빲��� */
    for allcptid_cursor IN (select * from temptablevalueCpt)
	loop
	cptid_1 :=allcptid_cursor.cptid;
	sharelevel_1 := allcptid_cursor.sharelevel;
        insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(cptid_1, resourceid_1,1,sharelevel_1);
	end loop;

    




end if;       /* �����޸��˲��źͰ�ȫ�������� */
            

       
/* �����޸��˾����ֶ�,�µ������ϼ����ӶԸ��¼����ĵ�����,������Ϊ�ɶ� */
if ( countdelete > 0 and managerstr_1 <> oldmanagerstr_1 )  then /* �½�������Դʱ��Ծ����ֶεĸı䲻���� */

    if ( managerstr_1 is not null and length(managerstr_1) > 1 ) then /* ���ϼ����� */
     

         managerstr_1 := concat( ',' , managerstr_1);

	/* ------- DOC ���� ------- */
        for supuserid_cursor in(select distinct t1.id id_1 , t2.id id_2 from HrmResource_Trigger t1, DocDetail t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and ( t2.doccreaterid = resourceid_1 or t2.ownerid = resourceid_1 ) and t2.usertype= '1' )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		docid_1 := supuserid_cursor.id_2;
            select  count(docid) INTO countrec  from docsharedetail where docid = docid_1 and userid= supresourceid_1 and usertype= 1 ;
            if countrec = 0  then
            
                insert into docsharedetail values(docid_1,supresourceid_1,1,1);
            end if;
		end loop;

	
	/* ------- CRM ���� ------- */
        for supuserid_cursor IN (select distinct t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, CRM_CustomerInfo t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and  t2.manager = resourceid_1  )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		crmid_1 := supuserid_cursor.id_2;
            select  count(crmid) INTO countrec  from CrmShareDetail where crmid = crmid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0 then
            
                insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(crmid_1,supresourceid_1,1,3);
            end if;
		end loop;



	/* ------- PROJ ���� ------- */
		for supuserid_cursor IN (    select distinct t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, Prj_ProjectInfo t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%')  and  t2.manager = resourceid_1 )
		loop
		supresourceid_1:= supuserid_cursor.id_1;
		prjid_1 :=supuserid_cursor.id_2;
            select  count(prjid) INTO countrec  from PrjShareDetail where prjid = prjid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0  then
            
                insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(prjid_1,supresourceid_1,1,3);
            end if;
		end loop;
		 


	/* ------- CPT ���� ------- */
		for supuserid_cursor IN (      select distinct  t1.id  id_1, t2.id id_2 from HrmResource_Trigger t1, CptCapital t2 where managerstr_1 like concat(concat('%,',to_char(t1.id)),',%') and  t2.resourceid = resourceid_1  )
		loop
		supresourceid_1:=supuserid_cursor.id_1;
		cptid_1 :=supuserid_cursor.id_2;
		    select  count(cptid) INTO countrec  from CptShareDetail where cptid = cptid_1 and userid= supresourceid_1 and usertype= 1;
            if countrec = 0  then
            
                insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(cptid_1,supresourceid_1,1,1);
            end if;
		end loop;

    end  if;           /* ���ϼ������ж����� */
end if;  /* �޸ľ�����ж����� */            
end ;
/



CREATE TABLE Bill_HrmAwardInfo (
	id integer NOT NULL  ,
	rptitle varchar2 (60)  NULL ,
	resource_n integer   NULL ,
	rpdate  char(10) NULL,
	rptypeid integer NULL ,
	rpexplain varchar2 (200) NULL,
	rptransact varchar2 (200) NULL ,
	requestid  integer
) 
/
create sequence Bill_HrmAwardInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmAwardInfo_Trigger
before insert on Bill_HrmAwardInfo
for each row
begin
select Bill_HrmAwardInfo_id.nextval INTO :new.id from dual;
end;
/

CREATE TABLE Bill_HrmRedeploy (
	id integer NOT NULL  ,
	resource_n integer   NULL ,
	redeploydate  char(10) NULL,
	oldjob integer NULL ,
	newjob integer NULL ,
	oldjoblevel integer NULL ,
	newjoblevel integer NULL ,
	redeployreason varchar2 (200) NULL,
	ischangesalary	integer NULL ,
	requestid  integer
) 
/
create sequence Bill_HrmRedeploy_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmRedeploy_Trigger
before insert on Bill_HrmRedeploy
for each row
begin
select Bill_HrmRedeploy_id.nextval INTO :new.id from dual;
end;
/


CREATE TABLE Bill_HrmDismiss (
	id integer  NOT NULL  ,
	resource_n integer   NULL ,
	dismissdate  char(10) NULL,
	docid integer NULL ,
	dismissreason varchar2(200) NULL,
	requestid  integer
) 
/
create sequence Bill_HrmDismiss_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmDismiss_Trigger
before insert on Bill_HrmDismiss
for each row
begin
select Bill_HrmDismiss_id.nextval INTO :new.id from dual;
end;
/


CREATE TABLE Bill_HrmHire (
	id integer NOT NULL  ,
	resource_n integer   NULL ,
	hiredate  char(10) NULL,
	hirereason varchar2(200) NULL,
	requestid  integer
) 
/
create sequence Bill_HrmHire_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmHire_Trigger
before insert on Bill_HrmHire
for each row
begin
select Bill_HrmHire_id.nextval INTO :new.id from dual;
end;
/


CREATE TABLE Bill_HrmScheduleHoliday (
	id integer  NOT NULL  ,
	diffid  integer   NULL ,
	resource_n integer   NULL ,
	startdate  char(10) NULL,
	starttime  char(8) NULL,
	enddate  char(10) NULL,
	endtime  char(8) NULL,
	reason varchar2(255) NULL,
	requestid  integer
) 
/
create sequence Bill_HrmScheduleHoliday_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmScheduleHoliday_Tri
before insert on Bill_HrmScheduleHoliday
for each row
begin
select Bill_HrmScheduleHoliday_id.nextval INTO :new.id from dual;
end;
/

CREATE TABLE Bill_HrmScheduleOvertime (
	id integer  NOT NULL  ,
	diffid  integer   NULL ,
	resource_n integer   NULL ,
	startdate  char(10) NULL,
	starttime  char(8) NULL,
	enddate  char(10) NULL,
	endtime  char(8) NULL,
	reason varchar2(255) NULL,
	requestid  integer
) 
/
create sequence Bill_HrmScheduleOvertime_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmScheduleOvertime_Tri
before insert on Bill_HrmScheduleOvertime
for each row
begin
select Bill_HrmScheduleOvertime_id.nextval INTO :new.id from dual;
end;
/



CREATE TABLE Bill_HrmUseDemand (
	id integer  NOT NULL ,
	resource_n integer   NULL ,
	demandjobtitle integer NULL ,
	demandnum integer NULL ,
	demandkind integer NULL ,
	leastedulevel integer NULL ,
	demandregdate char (10)  NULL ,
	otherrequest varchar2(4000)  NULL ,
	refermandid integer NULL ,
	referdate char (10)  NULL ,
	status integer NULL ,
	createkind integer NULL ,
	demanddep integer NULL ,
	requestid  integer null
)
/
create sequence Bill_HrmUseDemand_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmUseDemand_Tri
before insert on Bill_HrmUseDemand
for each row
begin
select Bill_HrmUseDemand_id.nextval INTO :new.id from dual;
end;
/


CREATE TABLE Bill_HrmTrainplan (
	id integer NOT NULL ,
	resource_n integer   NULL ,
	trainplanid integer NULL ,
	reason varchar2(4000)  NULL ,
	createdate char (10)  NULL ,
	requestid  integer 
)
/
create sequence Bill_HrmTrainplan_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger Bill_HrmTrainplan_Tri
before insert on Bill_HrmTrainplan
for each row
begin
select Bill_HrmTrainplan_id.nextval INTO :new.id from dual;
end;
/

insert into HtmlLabelIndex (id,indexdesc) values (6107	,'��������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6107,'��������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6107,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6109	,'��������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6109,'��������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6109,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6110	,'ְλ����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6110,'ְλ����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6110,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6111	,'��������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6111,'��������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6111,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6112	,'ԭ��λ')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6112,'ԭ��λ',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6112,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6113	,'�¸�λ')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6113,'�¸�λ',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6113,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6114	,'ԭְ��')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6114,'ԭְ��',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6114,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6115	,'��ְ��')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6115,'��ְ��',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6115,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6116	,'����ԭ��')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6116,'����ԭ��',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6116,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6119	,'��ְ����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6119,'��ְ����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6119,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6120	,'��ְ��ͬ')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6120,'��ְ��ͬ',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6120,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6121	,'ת������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6121,'ת������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6121,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6122	,'ת������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6122,'ת������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6122,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6123	,'ת����ע')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6123,'ת����ע',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6123,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6150	,'��������')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6150,'��������',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6150,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6151	,'�Ӱ�')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6151,'�Ӱ�',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6151,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6152	,'����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6152,'����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6152,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6153	,'��λʱ��')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6153,'��λʱ��',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6153,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6155	,'��ѵ����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6155,'��ѵ����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6155,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6156	,'��ѵ����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6156,'��ѵ����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6156,'',8)
/

insert into HtmlLabelIndex (id,indexdesc) values (6157	,'�Ƿ��������û�׼����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6157,'�Ƿ��������û�׼����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6157,'',8)
/

/*�����������*/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6099,'int','/systeminfo/BrowserMain.jsp?url=/hrm/award/AwardTypeBrowser.jsp?awardtype=0','HrmAwardType','name','id','/hrm/award/HrmAwardTypeEdit.jsp?id=')
/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 818,'int','/systeminfo/BrowserMain.jsp?url=/hrm/educationlevel/EduLevelBrowser.jsp','HrmEducationLevel','name','id','/hrm/educationlevel/HrmEduLevelEdit.jsp?id=')
/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 804,'int','/systeminfo/BrowserMain.jsp?url=/hrm/usekind/UseKindBrowser.jsp','HrmUseKind','name','id','/hrm/usekind/HrmUseKindEdit.jsp?id=')
/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6156,'int','/systeminfo/BrowserMain.jsp?url=/hrm/train/trainplan/HrmTrainPlanBroswer.jsp','HrmTrainPlan','planname','id','/hrm/train/trainplan/HrmTrainPlanEdit.jsp?id=')
/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6159,'int','/systeminfo/BrowserMain.jsp?url=/hrm/schedule/HrmScheduleDiffBrowser.jsp?difftype=0','HrmScheduleDiff','diffname','id','/hrm/schedule/HrmScheduleDiffEdit.jsp?id=')
/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 1881,'int','/systeminfo/BrowserMain.jsp?url=/hrm/schedule/HrmScheduleDiffBrowser.jsp?difftype=1','HrmScheduleDiff','diffname','id','/hrm/schedule/HrmScheduleDiffEdit.jsp?id=')
/

/*��������*/
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(39,6150,'Bill_HrmAwardInfo','AddBillHrmAwardInfo.jsp','ManageBillHrmAwardInfo.jsp','','','') 
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptitle',344,'varchar2(60)',1,1,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptypeid',6099,'integer',3,29,4,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rpexplain',791,'varchar2(200)',2,0,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptransact',1008,'varchar2(200)',2,0,6,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rpdate',855,'char(10)',3,2,2,0)
/

/*ְλ����*/
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(40,6110,'Bill_HrmRedeploy','BillHrmRedeployAdd.jsp','BillHrmRedeployManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'redeploydate',6111,'char(10)',3,2,2,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'oldjob',6112,'integer',3,24,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'newjob',6113,'integer',3,24,4,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'oldjoblevel',6114,'integer',1,2,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'newjoblevel',6115,'integer',1,2,6,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'redeployreason',6116,'varchar2(200)',2,0,8,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'ischangesalary',6157,'integer',4,0,7,0) 
/


/* ��ְ���� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(41,6119,'Bill_HrmDismiss','BillHrmDismissAdd.jsp','BillHrmDismissManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'dismissdate',898,'char(10)',3,2,2,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'docid',6120,'integer',3,9,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'dismissreason',1978,'varchar2(200)',2,0,4,0) 
/

/* ת������ */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(42,6121,'Bill_HrmHire','BillHrmHireAdd.jsp','BillHrmHireManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'hiredate',6122,'char(10)',3,2,2,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'hirereason',6123,'varchar2(200)',2,0,3,0) 
/
/* �Ӱ� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(45,6151,'Bill_HrmScheduleOvertime','BillHrmScheduleOvertimeAdd.jsp','BillHrmScheduleOvertimeManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'resource_n',368,'integer',3,1,1,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'startdate',740,'char(10)',3,2,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'starttime',742,'char(8)',3,19,4,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'enddate',741,'char(10)',3,2,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'endtime',743,'char(8)',3,19,6,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'reason',791,'varchar2(255)',2,0,7,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'diffid',6159,'integer',3,33,2,0) 
/

/* ��� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(46,670,'Bill_HrmScheduleHoliday','BillHrmScheduleHolidayAdd.jsp','BillHrmScheduleHolidayManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'startdate',740,'char(10)',3,2,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'starttime',742,'char(8)',3,19,4,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'enddate',741,'char(10)',3,2,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'endtime',743,'char(8)',3,19,6,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'reason',791,'varchar2(255)',2,0,7,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'diffid',1881,'integer',3,34,2,0) 
/

/* �ù����� */

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(47,6131,'Bill_HrmUseDemand','BillHrmDemandAdd.jsp','BillHrmDemandManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandjobtitle',6086,'integer',3,24,2,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandnum',1859,'integer',1,2,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandkind',6152,'integer',3,31,4,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'leastedulevel',1860,'integer',3,30,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandregdate',6153,'char(10)',3,2,6,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'otherrequest',1847,'varchar2(4000)',2,0,7,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'resource_n',368,'integer',3,1,1,0) 
/

/* ��ѵ���� */

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(48,6155,'Bill_HrmTrainplan','BillHrmTrainplanAdd.jsp','BillHrmTrainplanManage.jsp','','','') 
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'resource_n',368,'integer',3,1,1,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'trainplanid',6156,'integer',3,32,2,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'reason',85,'varchar2(4000)',2,0,3,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'createdate',855,'char(10)',3,2,4,0) 
/

insert into HtmlLabelIndex (id,indexdesc) values (6159	,'�Ӱ�����')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6159,'�Ӱ�����',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6159,'',8)
/

