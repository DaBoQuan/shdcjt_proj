
/*�����ǳ�Ӣ�ܡ�Ecology����Ʒ����������Դ�����ύ���Ա��� ���Ľű�*/
 
 CREATE OR REPLACE PROCEDURE HrmBank_Insert 
          ( bankname_1	varchar2, 
            bankdesc_2	varchar2, 
            flag out integer,
            msg out varchar2,
            thecursor IN OUT cursor_define.weavercursor
             )
  AS 
  begin
  INSERT INTO hrmbank(bankname, bankdesc) values(bankname_1, bankdesc_2);
  open thecursor for
  select max(id) from hrmbank ; 
  end;
/

  
CREATE OR REPLACE PROCEDURE HrmBank_Update 
  (id_1	integer, 
  bankname_1 varchar2, 
  bankdesc_1 varchar2,
  flag out integer ,
	 msg out varchar2,
	thecursor IN OUT cursor_define.weavercursor)  
  AS 
  begin
  update HrmBank set 
  bankname = bankname_1,
  bankdesc = bankdesc_1
  where  id = id_1 ;  
  end;
/

/* ���������ϡ� Ecology��Ʒ���� �ʲ����ܸĽ� �ύ���Ա���.doc ���Ľű�*/

CREATE or REPLACE PROCEDURE CptAssortmentShareInfo_Insert 
(relateditemid_1 integer,
sharetype_2 smallint,
seclevel_3 smallint,
rolelevel_4 smallint,
sharelevel_5 smallint,
userid_6 integer,
departmentid_7 integer,
roleid_8 integer,
foralluser_9 smallint,
sharefrom_10 integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO CptCapitalShareInfo
(relateditemid,
sharetype,
seclevel,
rolelevel,
sharelevel,
userid,
departmentid,
roleid,
foralluser,
sharefrom)
VALUES
(relateditemid_1,
sharetype_2,
seclevel_3,
rolelevel_4,
sharelevel_5,
userid_6,
departmentid_7,
roleid_8,
foralluser_9,
sharefrom_10);
end;
/




/*�����ǳ�Ӣ�ܵ�Ecology����Ʒ����ӦƸ��Ա¼���޸��ύ���Ա���Ľű�*/

CREATE OR REPLACE procedure HrmCareerApplyHire
(resourceid_1 	integer, 
 flag out integer,
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor
             )

as 
begin
delete HrmCareerApply 
where
 id = resourceid_1;

delete HrmInterview
where 
 resourceid = resourceid_1;

delete HrmInterviewAssess
where
 resourceid = resourceid_1;

delete HrmInterviewResult
where
 resourceid = resourceid_1;

delete HrmCareerApplyOtherInfo
where 
  applyid = resourceid_1;
end;
/


/*�����ǳ�Ӣ���ύ�ġ�Ecology����Ʒ����������Դ�Զ����ֶα༭�ύ���Ա��桷�Ľű�*/
create or replace procedure HrmResourceDefine_Update
 (id_1 integer,
  datefield1_2 varchar2,
  numberfield1_3 float,
  textfield1_4 varchar2,
  smallintfield1_5 smallint,
  datefield2_6 varchar2,
  numberfield2_7 float,
  textfield2_8 varchar2,
  smallintfield2_9 smallint,
  datefield3_10 varchar2,
  numberfield3_11 float,
  textfield3_12 varchar2,
  smallintfield3_13 smallint,
  datefield4_14 varchar2,
  numberfield4_15 float,
  textfield4_16 varchar2,
  smallintfield4_17 smallint,
  datefield5_18 varchar2,
  numberfield5_19 float,
  textfield5_20 varchar2,
  smallintfield5_21 smallint,
  flag out integer,
  msg out varchar2,
  thecursor IN OUT cursor_define.weavercursor)
 as 
 begin
 update HrmResource 
 set
  datefield1 = datefield1_2,
  numberfield1 = numberfield1_3,
  textfield1 = textfield1_4,
  tinyintfield1 = smallintfield1_5,
  datefield2 = datefield2_6,
  numberfield2 = numberfield2_7,
  textfield2 = textfield2_8,
  tinyintfield2 = smallintfield2_9,
  datefield3 = datefield3_10,
  numberfield3 = numberfield3_11,
  textfield3 = textfield3_12,
  tinyintfield3 = smallintfield3_13,
  datefield4 = datefield4_14,
  numberfield4 = numberfield4_15,
  textfield4 = textfield4_16,
  tinyintfield4 = smallintfield4_17,
  datefield5 = datefield5_18,
  numberfield5 = numberfield5_19,
  textfield5 = textfield5_20,
  tinyintfield5 = smallintfield5_21
 where
  (id = id_1);
 end;
/
 

/*��������������ύ���Ա��桶ecology��Ʒ����ְ���ְ�����͹�������ȷ�ύ���Ա����Ľű�*/

drop table HrmJobActivities
/

drop sequence HrmJobActivities_id
/

drop table HrmJobGroups
/


drop sequence HrmJobGroups_id
/

CREATE TABLE HrmJobGroups (
	id int  NOT NULL ,
	jobgroupname varchar2(200)  NULL ,
	jobgroupremark varchar2(4000)  NULL 
)
/

create sequence HrmJobGroups_id
start with 1
increment by 1
nomaxvalue
nocycle
/


create or replace trigger HrmJobGroups_Trigger
before insert on HrmJobGroups
for each row
begin
select HrmJobGroups_id.nextval into :new.id from dual;
end;
/


CREATE TABLE HrmJobActivities (
	id int  NOT NULL ,
	jobactivitymark varchar2(60) NULL ,
	jobactivityname varchar2(200) NULL ,
	jobgroupid integer NULL ,
	joblevelfrom integer NULL ,
	joblevelto integer NULL 
) 
/

create sequence HrmJobActivities_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmJobActivities_Trigger
before insert on HrmJobActivities
for each row
begin
select HrmJobActivities_id.nextval into :new.id from dual;
end;
/

insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('��������','��������',1)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('��������','��������',1)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('��˾Ӫ��','��˾Ӫ��',2)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('Ͷ�ʹ���','Ͷ�ʹ���',3)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('��������','��������',8)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('����ҵ��','����ҵ��',3)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('Ͷ��ҵ��','Ͷ��ҵ��',3)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('���¹���','���¹���',7)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('��Ŀ����','��Ŀ����',3)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('�������','�������',5)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('�������','�������',4)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('����','����',6)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('����','����',6)
/
insert into HrmJobActivities (jobactivitymark,jobactivityname,jobgroupid) values ('����','����',11)
/

insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('������','������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('������','������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('��Ŀ��','��Ŀ��')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('�����','�����')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('��������','��������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('������','������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('������','������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('������','������')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('�ܲ�','�ܲ�')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('֧����','֧����')
/
insert into HrmJobGroups (jobgroupname,jobgroupremark) values ('����','����')
/

update workflow_browserurl set 
browserurl = '/systeminfo/BrowserMain.jsp?url=/fna/maintenance/BudgetfeeTypeBrowser.jsp?sqlwhere=where feetype=to_char(1)' where tablename = 'FnaBudgetfeeType' 
/


/*���������ϡ�Ecology��Ʒ����- Oracle�ű�BUG�޸�V1.0�ύ���Ա���2003-07-25���Ľű�*/
CREATE OR replace trigger DocDetailLog_Trigger
before INSERT ON DocDetailLog
for each row
begin
SELECT DocDetailLog_id.nextval INTO:new.id from DocDetailLog;
end;
/