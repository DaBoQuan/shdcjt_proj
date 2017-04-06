alter table HrmSchedule add validedatefrom char(10)
/

alter table HrmSchedule add validedateto char(10)
/

CREATE TABLE HrmArrangeShift (
    id integer NOT NULL ,
    shiftname varchar2 (60)  NULL ,
    shiftbegintime char (5)  NULL ,
    shiftendtime char (5)  NULL ,	
    validedatefrom char (10)  NULL ,
    validedateto   char (10)  NULL,
    ishistory  char(1) default '0'
)
/

create sequence HrmArrangeShift_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmArrangeShift_Trigger
before insert on HrmArrangeShift
for each row
begin
select HrmArrangeShift_id.nextval into :new.id from dual;
end;
/


CREATE TABLE HrmArrangeShiftInfo (                  
	id integer NOT NULL ,
	resourceid integer ,
    shiftdate char (10) ,
    shiftid integer	
)
/

create sequence HrmArrangeShiftInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmArrangeShiftInfo_Trigger
before insert on HrmArrangeShiftInfo
for each row
begin
select HrmArrangeShiftInfo_id.nextval into :new.id from dual;
end;
/

CREATE TABLE HrmArrangeShifttype (
	resourceid integer NOT NULL ,
	currentdate char (10)  NULL ,
    shifttypeid integer null
)
/

create sequence HrmArrangeShifttype_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmArrangeShifttype_Trigger
before insert on HrmArrangeShifttype
for each row
begin
select HrmArrangeShifttype_id.nextval into :new.resourceid from dual;
end;
/


create table HrmTimecardUser ( 
resourceid integer primary key ,
usercode varchar2(60)
)
/

/* ����Ϣ��*/
create table HrmTimecardInfo ( 
resourceid integer ,
timecarddate char(10) ,
intime char(5) ,
outtime char(5)
)
/


/*�������ڱ�*/
create table HrmSalarySchedule(
id	integer NOT NULL  primary key,
itemid  integer ,                           /*������Ŀid*/
diffid  integer                            /*��������id*/
)
/

create sequence HrmSalarySchedule_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmSalarySchedule_Trigger
before insert on HrmSalarySchedule
for each row
begin
select HrmSalarySchedule_id.nextval into :new.id from dual;
end;
/


/*����ʱ��ƫ������*/
create table HrmWorkTimeWarp(
 id integer not null primary key,
 diffid integer ,               /*��ؿ���*/
 resourceid integer ,
 diffdate char(10) ,        /*��������*/
 difftype  char(1) ,        /*�������� 0������ 1������*/
 intime char(5) ,           /*�빫˾ʱ��*/
 outtime char(5) ,          /*����˾ʱ��*/
 theintime  char(5) ,           /*Ӧ���빫˾ʱ��*/
 theouttime char(5) ,           /*Ӧ�ó���˾ʱ��*/
 counttime integer default 0,    /*ʵ�ʼ���ʱ��(����)*/
 diffcounttime integer default 0)    /*���ڼ���ʱ��(����)*/
/


create sequence HrmWorkTimeWarp_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmWorkTimeWarp_Trigger
before insert on HrmWorkTimeWarp
for each row
begin
select HrmWorkTimeWarp_id.nextval into :new.id from dual;
end;
/

/* �Կ��ڼ�¼������ʵ�ʼ���ʱ��Ϳ��������ֶ� */
alter table HrmScheduleMaintance add realdifftime integer default 0
/
alter table HrmScheduleMaintance add realcarddifftime integer default 0
/
alter table HrmScheduleMaintance add difftype char(1)
/

update HrmScheduleMaintance set realdifftime = 0 , realcarddifftime = 0
/

/* Ա������ͳ�Ʊ� */
create table HrmWorkTimeCount (
id integer not null primary key,
resourceid integer ,                /* ������Դ */
workdate char(7) ,              /* ͳ���·� �� 2003-07 */
shiftid integer,                    /* ����ʱ������ , 0: һ�㹤��ʱ�� ,���� : �Ű�����id */
workcount integer                   /* ���ڴ��� ����ֻҪ��һ�δ�,Ҳ��Ϊһ�γ���*/
)
/

create sequence HrmWorkTimeCount_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmWorkTimeCount_Trigger
before insert on HrmWorkTimeCount
for each row
begin
select HrmWorkTimeCount_id.nextval into :new.id from dual;
end;
/



/* ������Դ������Ŀ�������ڽ�����Ϣ�� */
create table HrmSalaryShiftPay(
id	integer  NOT NULL  primary key,
itemid  integer ,                           /*������Ŀid*/
shiftid  integer ,                          /*��������id 0:һ�㹤��ʱ�� ����:�Ű�����id*/
shiftpay  number(10,2)                 /*��������id 0:һ�㹤��ʱ�� ����:�Ű�����id*/
)
/
create sequence HrmSalaryShiftPay_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmSalaryShiftPay_Trigger
before insert on HrmSalaryShiftPay
for each row
begin
select HrmSalaryShiftPay_id.nextval into :new.id from dual;
end;
/


/* ������Դ������Ŀ�������ڼ�����Ϣ��ϸ */
create table HrmSalaryDiffDetail (
itemid  integer ,                               /* ����������Ŀ */
resourceid  integer ,                           /* ����������Դ */
payid  integer ,                                /* �������ʵ� id */
diffid integer ,                                /* �����Ŀ��� id */
difftypeid  integer ,                           /* ������������id */ 
startdate  char(10) ,                        /* �������ڿ�ʼ���� */ 
enddate  char(10) ,                        /* �������ڿ�ʼ���� */ 
realcounttime integer  ,                        /* ʵ�ʼ���ʱ�� */
realcountpay number(10,2)                  /* ʵ�ʼ��㹤�� */
)
/


create INDEX HrmSalaryDiffDetail_in on HrmSalaryDiffDetail(payid , resourceid , itemid)
/



update HtmlLabelInfo set labelname = 'ע�⣺ ����ֻ��ΪӢ����ĸ�Ͱ�������ֵ��������ĸ��ͷ��Ӣ����ĸ��Сд���У�' 
where indexid = 15830 and languageid = 7   
/




/*�򿨻���Ϣ��*/
/*Create by Wangxiaoyi 2003-10-30*/
CREATE TABLE HrmCardInfo (
	id integer  not null primary key ,
    stationid char(2) null, /*���ӵ�̨��*/
    carddate char(10) null , /*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
    cardtime char(5) null ,  /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
    workshift  char(1) null , /*����,��������16�����飬��0~9,A~F*/
    Cardid   char(10) null  /*����*/
)
/
create sequence HrmCardInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmCardInfo_Trigger
before insert on HrmCardInfo
for each row
begin
select HrmCardInfo_id.nextval into :new.id from dual;
end;
/

/*��Ч�򿨻���Ϣ��*/
CREATE TABLE HrmValidateCardInfo (
	id integer not null primary key ,
    stationid char(2) null, /*���ӵ�̨��*/
    carddate char(10) null , /*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
    cardtime char(5) null ,  /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
    workshift  char(1) null , /*����,��������16�����飬��0~9,A~F*/
    Cardid   char(10) null  /*����*/
)
/
create sequence HrmValidateCardInfo_id
start with 1
increment by 1
nomaxvalue
nocycle
/

create or replace trigger HrmValidateCardInfo_Trigger
before insert on HrmValidateCardInfo
for each row
begin
select HrmValidateCardInfo_id.nextval into :new.id from dual;
end;
/

CREATE or REPLACE PROCEDURE HrmSchedule_Select_Default 
 (id_1 integer ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS
 begin
 open thecursor for
 select * from HrmSchedule where id = id_1;
 end;
/


CREATE or REPLACE PROCEDURE HrmSchedule_SelectAll
( flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor ) 
 AS 
 begin
 open thecursor for
 select id , validedatefrom ,validedateto from HrmSchedule order by validedatefrom desc;
 end;
/


create or replace PROCEDURE HrmSchedule_Update 
 (id_1 	integer, 
  monstarttime1_3 	char, 
  monendtime1_4 	char, 
  monstarttime2_5 	char, 
  monendtime2_6 	char, 
  tuestarttime1_7 	char, 
  tueendtime1_8 	char, 
  tuestarttime2_9 	char, 
  tueendtime2_10 	char, 
  wedstarttime1_11 	char, 
  wedendtime1_12 	char, 
  wedstarttime2_13 	char, 
  wedendtime2_14 	char, 
  thustarttime1_15 	char, 
  thuendtime1_16 	char, 
  thustarttime2_17 	char, 
  thuendtime2_18 	char, 
  fristarttime1_19 	char, 
  friendtime1_20 	char, 
  fristarttime2_21 	char, 
  friendtime2_22 	char, 
  satstarttime1_23 	char, 
  satendtime1_24 	char, 
  satstarttime2_25 	char, 
  satendtime2_26 	char, 
  sunstarttime1_27 	char, 
  sunendtime1_28 	char, 
  sunstarttime2_29 	char, 
  sunendtime2_30 	char, 
  totaltime_31    char, 
  validedatefrom_32 	char, 
  validedateto_33 	char, 
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
AS 
begin
UPDATE HrmSchedule  
SET  
monstarttime1= monstarttime1_3, 
monendtime1	 = monendtime1_4, 
monstarttime2= monstarttime2_5, 
monendtime2	 = monendtime2_6, 
tuestarttime1= tuestarttime1_7, 
tueendtime1	 = tueendtime1_8, 
tuestarttime2= tuestarttime2_9, 
tueendtime2	 = tueendtime2_10,
wedstarttime1= wedstarttime1_11, 
wedendtime1	 = wedendtime1_12, 
wedstarttime2= wedstarttime2_13, 
wedendtime2	 = wedendtime2_14, 
thustarttime1= thustarttime1_15, 
thuendtime1	 = thuendtime1_16, 
thustarttime2= thustarttime2_17, 
thuendtime2	 = thuendtime2_18,
fristarttime1= fristarttime1_19, 
friendtime1	 = friendtime1_20, 
fristarttime2= fristarttime2_21, 
friendtime2	 = friendtime2_22, 
satstarttime1= satstarttime1_23, 
satendtime1	 = satendtime1_24, 
satstarttime2= satstarttime2_25, 
satendtime2	 = satendtime2_26, 
sunstarttime1= sunstarttime1_27, 
sunendtime1	 = sunendtime1_28, 
sunstarttime2= sunstarttime2_29, 
sunendtime2	 = sunendtime2_30, 
totaltime    = totaltime_31, 
validedatefrom= validedatefrom_32,  
validedateto= validedateto_33  
WHERE ( id	 = id_1);
end;
/

create or replace PROCEDURE HrmSchedule_Insert 
 (monstarttime1_2 	char, 
 monendtime1_3 	char, 
 monstarttime2_4 	char, 
 monendtime2_5 	char, 
 tuestarttime1_6 	char, 
 tueendtime1_7 	char, 
 tuestarttime2_8 	char, 
 tueendtime2_9 	char, 
 wedstarttime1_10 	char, 
 wedendtime1_11 	char, 
 wedstarttime2_12 	char, 
 wedendtime2_13 	char, 
 thustarttime1_14 	char, 
 thuendtime1_15 	char, 
 thustarttime2_16 	char,
 thuendtime2_17 	char, 
 fristarttime1_18 	char, 
 friendtime1_19 	char, 
 fristarttime2_20 	char, 
 friendtime2_21 	char, 
 satstarttime1_22 	char, 
 satendtime1_23 	char, 
 satstarttime2_24 	char, 
 satendtime2_25 	char, 
 sunstarttime1_26 	char, 
 sunendtime1_27 	char, 
 sunstarttime2_28 	char, 
 sunendtime2_29 	char, 
 totaltime_30    char, 
 validedatefrom_31 	char, 
 validedateto_32 	char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
AS 
begin
INSERT INTO HrmSchedule ( 
            monstarttime1, 
            monendtime1, 
            monstarttime2, 
            monendtime2, 
            tuestarttime1, 
            tueendtime1, 
            tuestarttime2, 
            tueendtime2, 
            wedstarttime1, 
            wedendtime1, 
            wedstarttime2, 
            wedendtime2, 
            thustarttime1, 
            thuendtime1, 
            thustarttime2, 
            thuendtime2, 
            fristarttime1, 
            friendtime1, 
            fristarttime2, 
            friendtime2, 
            satstarttime1, 
            satendtime1, 
            satstarttime2, 
            satendtime2, 
            sunstarttime1, 
            sunendtime1, 
            sunstarttime2, 
            sunendtime2, 
            totaltime, 
            validedatefrom,
            validedateto)  
VALUES ( 
            monstarttime1_2, 
            monendtime1_3, 
            monstarttime2_4, 
            monendtime2_5, 
            tuestarttime1_6, 
            tueendtime1_7, 
            tuestarttime2_8, 
            tueendtime2_9, 
            wedstarttime1_10, 
            wedendtime1_11, 
            wedstarttime2_12, 
            wedendtime2_13, 
            thustarttime1_14, 
            thuendtime1_15, 
            thustarttime2_16, 
            thuendtime2_17, 
            fristarttime1_18, 
            friendtime1_19, 
            fristarttime2_20, 
            friendtime2_21, 
            satstarttime1_22, 
            satendtime1_23, 
            satstarttime2_24, 
            satendtime2_25, 
            sunstarttime1_26, 
            sunendtime1_27,
            sunstarttime2_28, 
            sunendtime2_29, 
            totaltime_30, 
            validedatefrom_31,
            validedateto_32);
open thecursor for
select max(id) from HrmSchedule ;
end;
/

create or replace PROCEDURE HrmArrangeShift_SelectAll
(ishistory_1 char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS
 begin
 open thecursor for
 select id , shiftname , shiftbegintime, shiftendtime from HrmArrangeShift where ishistory = ishistory_1 order by id;
 end;
/

create or replace PROCEDURE HrmArrangeShift_UHistory (
 id_1 	integer,
 validedatefrom_5 char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS 
 begin
 UPDATE HrmArrangeShift
 SET  validedateto = validedatefrom_5,
      ishistory = '1' 
     WHERE ( id	 = id_1);
end;
/

create or replace PROCEDURE HrmArrangeShift_Insert (
 shiftname_2 	 varchar2,
 shiftbegintime_3 char,
 shiftendtime_4 char,
 validedatefrom_5  char,
 validedateto_6 char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
  AS 
  begin
  INSERT INTO HrmArrangeShift (
 shiftname ,	
 shiftbegintime,
 shiftendtime,
 validedatefrom,
 validedateto)
VALUES (
 shiftname_2,
 shiftbegintime_3,
 shiftendtime_4,
 validedatefrom_5,
 validedateto_6);
 open thecursor for
 select max(id) from HrmArrangeShift  ;
 end;
/

create or replace PROCEDURE HrmArrangeShift_Update (
 id_1 	integer,
 shiftname_2 	 varchar2,
 shiftbegintime_3 char,
 shiftendtime_4   char,
 validedatefrom_5  char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS 
 begin
 UPDATE HrmArrangeShift
 SET  shiftname = shiftname_2,
      shiftbegintime = shiftbegintime_3,
      shiftendtime = shiftendtime_4 ,
      validedatefrom = validedatefrom_5 
     WHERE ( id	 = id_1);
 end;
/

 
create or replace PROCEDURE HrmArrangeShift_Delete 
 (id_1 	integer,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
 AS 
 begin
 DELETE HrmArrangeShift 
 WHERE ( id	 = id_1);
 end;
/

create or replace PROCEDURE HrmArrangeShift_Select_Default 
 (id_1 integer ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS 
 begin
  open thecursor for
 select * from HrmArrangeShift where id = id_1;
 end;
/

create or replace PROCEDURE HrmArrangeShift_SelectById
(id_1 integer ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor ) 
 AS 
 begin
 open thecursor for
 select id , shiftname , shiftbegintime, shiftendtime,validedatefrom,validedateto 
 from HrmArrangeShift where ishistory='0' order by id desc ;
 end;
/

create or replace PROCEDURE HrmArrangeShift_Updatehistory (
 id_1 	integer,
 shiftname_2 	 varchar2,
 shiftbegintime_3 char,
 shiftendtime_4   char,
 validedatefrom_5 char,
 validedateto_6   char,
 flag out integer, 
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor) 
 AS
 begin
 UPDATE HrmArrangeShift
 SET  shiftname = shiftname_2,
      shiftbegintime = shiftbegintime_3,
      shiftendtime = shiftendtime_4,
      validedatefrom = validedatefrom_5 ,
      validedateto = '9999-12-31' 
     WHERE ( id	 = id_1);
end;
/

 create or replace PROCEDURE HrmSalaryScheduleDec_Insert(
 diffid_1 integer ,	
 itemid_2 char,
 flag out integer, 
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor) 
 AS 
 begin
 INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 diffid_1 , itemid_2);
 end;
/



create or replace PROCEDURE HrmArrangeShiftInfo_Insert(
 resourceid_1 integer ,
 shiftdate_2 char ,
 shiftid_3 integer	,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
  AS 
  begin
  INSERT INTO HrmArrangeShiftInfo (
 resourceid ,	
 shiftdate,
 shiftid)
VALUES (
 resourceid_1,
 shiftdate_2,
 shiftid_3);
  open thecursor for
 select max(id) from HrmArrangeShiftInfo;
end;
/

create or replace PROCEDURE HrmArrangeShiftInfo_Save (
 resourceid_2 integer ,
 shiftdate_3 char ,
 shiftid_4 integer	,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
 AS 
 count_1 integer;
 begin
 select count(shiftid) into count_1  from HrmArrangeShiftInfo 
 where  resourceid=resourceid_2 and shiftdate = shiftdate_3;
 if count_1 is null or count_1 = 0 then
    INSERT INTO HrmArrangeShiftInfo(resourceid,shiftdate,shiftid) 
    VALUES(resourceid_2,shiftdate_3, shiftid_4);
 else
    UPDATE HrmArrangeShiftInfo 
    SET  shiftid = shiftid_4 
    where  resourceid=resourceid_2 and shiftdate = shiftdate_3;
    end if;
end;
/


create or replace PROCEDURE HrmArrangeShiftProcess_Save (
 resourceid_2 integer ,
 shiftdate_3 char,
 shiftid_4 integer	,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)  
 AS 
 count_1 integer;
 begin
 select count(shiftid) into count_1 from HrmArrangeShiftInfo 
 where  resourceid=resourceid_2 and shiftdate = shiftdate_3;
 if count_1 is null or count_1 = 0 then
    INSERT INTO HrmArrangeShiftInfo(resourceid,shiftdate,shiftid) 
    VALUES(resourceid_2,shiftdate_3, shiftid_4);
 else
    UPDATE HrmArrangeShiftInfo 
    SET  shiftid = shiftid_4 
    where  resourceid=resourceid_2 and shiftdate = shiftdate_3;
end if;    
end;
/


create or replace PROCEDURE HrmSalaryItem_Update
	(id_1 	integer,
	 itemname_2 	varchar2,
	 itemcode_3 	varchar2,
	 itemtype_4 	char,
	 personwelfarerate_5 	integer,
	 companywelfarerate_6 	integer,
	 taxrelateitem_7 	integer,
	 amountecp_8 	varchar2,
	 feetype_9 	integer,
	 isshow_10 	char,
	 showorder_11 	integer,
	 ishistory_12 	char ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)

AS 

olditemtype_1 char(1) ;
benchid_1 integer;
begin
select itemtype into olditemtype_1 from HrmSalaryItem where id = id_1 ;
UPDATE HrmSalaryItem 
SET  itemname	 = itemname_2,
	 itemcode	 = itemcode_3,
	 itemtype	 = itemtype_4,
	 personwelfarerate	 = personwelfarerate_5,
	 companywelfarerate	 = companywelfarerate_6,
	 taxrelateitem	 = taxrelateitem_7,
	 amountecp	 = amountecp_8,
	 feetype	 = feetype_9,
	 isshow	 = isshow_10,
	 showorder	 = showorder_11,
	 ishistory	 = ishistory_12 

WHERE 
	( id	 = id_1);

if olditemtype_1 = '1' or olditemtype_1 = '2' then
    delete from HrmSalaryRank where itemid = id_1;
else 
    if olditemtype_1 = '5' or olditemtype_1 = '6' then
        delete from HrmSalarySchedule where itemid = id_1;

    else 
        if olditemtype_1 = '3' then
        for benchid_cursor in
        (select id from HrmSalaryTaxbench where itemid = id_1)
        loop
            delete from HrmSalaryTaxrate where benchid = benchid_1;
            delete from HrmSalaryTaxbench where id = benchid_1;
        end loop;
        end if;
    end if;
end if;
end;
/




create  INDEX HrmTimecardInfo_in on HrmTimecardInfo(resourceid , timecarddate)
/

create or replace PROCEDURE HrmTimecardUser_Update
	(resourceid_1 	integer,
	 usercode_2 	varchar2,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)

AS 
count_1 integer;
begin
select count(usercode) into count_1 from HrmTimecardUser
where resourceid != resourceid_1 and usercode = usercode_2;
if count_1 is not null and count_1 > 0 then
    open thecursor for
    select -1 from dual;
    return ;
end if;

select count(resourceid) into count_1 from HrmTimecardUser where resourceid = resourceid_1;
if count_1 is not null and count_1 > 0 then
    update HrmTimecardUser set usercode = usercode_2 where resourceid = resourceid_1;
else
    insert into HrmTimecardUser(resourceid,usercode) values(resourceid_1,usercode_2 );
    open thecursor for
    select 1 from dual;
end if;
end;
/

create or replace PROCEDURE HrmTimecardInfo_Update
	(resourceid_1 	integer,
	 timecarddate_3 	char,
	 intime_4 	char,
	 outtime_5 	char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)

AS 
count_1 integer;
begin
select count(resourceid) into count_1 from HrmTimecardInfo 
where resourceid = resourceid_1 and timecarddate = timecarddate_3;
if count_1 is not null and count_1 > 0 then
    UPDATE HrmTimecardInfo 
    SET  intime	 = intime_4,
         outtime	 = outtime_5 
    WHERE 
        ( resourceid	 = resourceid_1 and
         timecarddate	 = timecarddate_3);
else
    insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime) 
    values(resourceid_1,timecarddate_3,intime_4,outtime_5 );
end if;
end;
/


create or replace PROCEDURE HrmSchedule_Select_Current 
 (currentdate_1 varchar2,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor) 
 AS
 begin
 open thecursor for
 select * from HrmSchedule where validedatefrom <= currentdate_1 and validedateto >= currentdate_1;
 end;
/


create or replace PROCEDURE HrmArrangeShift_Select
( flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor ) 
 AS
 begin
  open thecursor for
 select id , shiftbegintime, shiftendtime from HrmArrangeShift order by id;
 end;
/



create or replace PROCEDURE HrmWorkTimeWarp_Insert
	(diffid_1 	integer,
	 resourceid_2 	integer,
	 diffdate_3 	char,
	 difftype_4 	char,
	 intime_5 	char,
	 outtime_6 	char,
	 theintime_7 	char,
	 theouttime_8 	char,
	 counttime_9 	integer,
     diffcounttime_10 	integer,
    flag out integer, 
    msg out varchar2 ,
    thecursor IN OUT cursor_define.weavercursor) 

AS 
begin
INSERT INTO HrmWorkTimeWarp 
	 ( diffid,
	 resourceid,
	 diffdate,
	 difftype,
	 intime,
	 outtime,
	 theintime,
	 theouttime,
	 counttime,
     diffcounttime) 
 
VALUES 
	( diffid_1,
	 resourceid_2,
	 diffdate_3,
	 difftype_4,
	 intime_5,
	 outtime_6,
	 theintime_7,
	 theouttime_8,
	 counttime_9,
     diffcounttime_10);
end;
/


create or replace PROCEDURE HrmScheduleMaintance_UStype
as
diffid_1 integer ;
difftype_2 char(1);
begin
update HrmScheduleMaintance set difftype = 'A' ;

for diffid_cursor in
    (select id , difftype from HrmScheduleDiff)
loop
    update HrmScheduleMaintance set difftype = difftype_2 where diffid = diffid_1 ;
end loop;
end;
/

call HrmScheduleMaintance_UStype()
/

drop PROCEDURE HrmScheduleMaintance_UStype
/






create or replace PROCEDURE HrmScheduleMain_Insert
	(diffid_1 	integer,
	 resourceid_2 	integer,
	 startdate_3 	char,
	 starttime_4 	char,
	 enddate_5 	char,
	 endtime_6 	char,
	 memo_7 	Varchar2,
	 createtype_8 	integer,
	 createrid_9 	integer,
	 createdate_10 	char,
     realdifftime_11  integer ,
     difftype_12 char,
	  flag out integer, 
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)

AS 
begin
INSERT INTO HrmScheduleMaintance 
	 ( diffid,
	 resourceid,
	 startdate,
	 starttime,
	 enddate,
	 endtime,
	 memo,
	 createtype,
	 createrid,
	 createdate,
     realdifftime,
     difftype) 
 
VALUES 
	( diffid_1,
	 resourceid_2,
	 startdate_3,
	 starttime_4,
	 enddate_5,
	 endtime_6,
	 memo_7,
	 createtype_8,
	 createrid_9,
	 createdate_10,
     realdifftime_11,
     difftype_12);
     open thecursor for
select max(id) from HrmScheduleMaintance;
end;
/


create or replace PROCEDURE HrmScheduleMain_Update
	(id_1 	integer,
	 diffid_2 	integer,
	 resourceid_3 	integer,
	 startdate_4 	char,
	 starttime_5 	char,
	 enddate_6 	char,
	 endtime_7 	char,
	 memo_8 	Varchar2,
     realdifftime_11  integer ,
     difftype_12 char,
	  flag out integer, 
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
AS 
begin
UPDATE HrmScheduleMaintance SET  
         diffid	 = diffid_2,
	 resourceid	 = resourceid_3,
	 startdate	 = startdate_4,
	 starttime	 = starttime_5,
	 enddate	 = enddate_6,
	 endtime	 = endtime_7,
	 memo        = memo_8 ,
     realdifftime = realdifftime_11 ,
     difftype    = difftype_12 
WHERE 
	( id	 = id_1);
end;
/





create or replace PROCEDURE HrmSalaryScheduleDec_Insert(
 itemid_2 integer ,
 diffid_1 integer ,	
	  flag out integer, 
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor) 
 AS 
 begin
 INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 diffid_1 , itemid_2);
 end;
/



create or replace PROCEDURE HrmSalaryScheduleAdd_Insert(
 itemid_2 char,
 diffid_1 integer ,
  flag out integer, 
 msg out varchar2,
 thecursor IN OUT cursor_define.weavercursor )
 AS 
 begin
 INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 diffid_1 , itemid_2);
 end;
/

CREATE or REPLACE PROCEDURE HrmWorkTimeCount_Insert
(resourceid_1 	integer,
 workdate_2 	char,
 shiftid_3 	integer,
 workcount_4 	integer,	
 flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )

AS 
begin
INSERT INTO HrmWorkTimeCount 
	 ( resourceid,
	 workdate,
	 shiftid,
	 workcount) 
 
VALUES 
	( resourceid_1,
	 workdate_2,
	 shiftid_3,
	 workcount_4) ;
end ;
/

CREATE or REPLACE PROCEDURE HrmSalaryShiftPay_SByItemid
(itemid_1 	integer,
 flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )
AS 
begin 
open thecursor for
Select * from HrmSalaryShiftPay where itemid = itemid_1 ;
end ;
/

CREATE PROCEDURE HrmSalaryShiftPay_Insert
	(itemid_1 	integer,
	 shiftid_2 	integer,
	 shiftpay_3 	number,	
     flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )

AS 
begin
INSERT INTO HrmSalaryShiftPay 
	 ( itemid,
	 shiftid,
	 shiftpay) 
 
VALUES 
	( itemid_1,
	 shiftid_2,
	 shiftpay_3) ;
end ;
/


CREATE or REPLACE PROCEDURE HrmSalaryShiftPay_Delete
	(itemid_1 	integer,	
     flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )

AS 
begin
DELETE HrmSalaryShiftPay 
WHERE ( itemid	 = itemid_1) ;
end ;
/



create or replace PROCEDURE HrmSalaryItem_Update
	(id_1 	integer,
	 itemname_2 	varchar2,
	 itemcode_3 	varchar2,
	 itemtype_4 	char,
	 personwelfarerate_5 	integer,
	 companywelfarerate_6 	integer,
	 taxrelateitem_7 	integer,
	 amountecp_8 	varchar2,
	 feetype_9 	integer,
	 isshow_10 	char,
	 showorder_11 	integer,
	 ishistory_12 	char ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )

AS 

olditemtype_1 char(1) ;
benchid_1 integer;
begin
select itemtype into olditemtype_1 from HrmSalaryItem where id = id_1 ;
UPDATE HrmSalaryItem 
SET  itemname	 = itemname_2,
	 itemcode	 = itemcode_3,
	 itemtype	 = itemtype_4,
	 personwelfarerate	 = personwelfarerate_5,
	 companywelfarerate	 = companywelfarerate_6,
	 taxrelateitem	 = taxrelateitem_7,
	 amountecp	 = amountecp_8,
	 feetype	 = feetype_9,
	 isshow	 = isshow_10,
	 showorder	 = showorder_11,
	 ishistory	 = ishistory_12 

WHERE 
	( id	 = id_1);

if olditemtype_1 = '1' or olditemtype_1 = '2' then
    delete from HrmSalaryRank where itemid = id_1;
else 
    if olditemtype_1 = '5' or olditemtype_1 = '6' then
        delete from HrmSalarySchedule where itemid = id_1;
    else 
        if olditemtype_1 = '7' then
            delete from HrmSalaryShiftPay where itemid = id_1 ;
        else 
            if olditemtype_1 = '3' then
            for benchid_cursor in
            (select id from HrmSalaryTaxbench where itemid = id_1)
            loop
                delete from HrmSalaryTaxrate where benchid = benchid_1;
                delete from HrmSalaryTaxbench where id = benchid_1;
            end loop;
            end if;
        end if;
    end if;
end if;
end;
/



create or replace PROCEDURE HrmSalaryItem_Delete
	(id_1 	integer ,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )
AS 
olditemtype_1 char(1) ;
benchid_1 integer;
begin
select itemtype into olditemtype_1 from HrmSalaryItem where id = id_1 ;

DELETE HrmSalaryItem 
WHERE ( id	 = id_1);

if olditemtype_1 = '1' then
    delete from HrmSalaryRank where itemid = id_1 ;
else 
    if olditemtype_1 = '5' or olditemtype_1 = '6' then
        delete from HrmSalarySchedule where itemid = id_1;
    else 
        if olditemtype_1 = '7' then
            delete from HrmSalaryShiftPay where itemid = id_1 ;
        else 
            if olditemtype_1 = '2' then
                delete from HrmSalaryRank where itemid = id_1;
                delete from HrmSalaryWelfarerate where itemid = id_1;
            else 
                if olditemtype_1 = '3' then
                    for benchid_cursor in
                    (select id from HrmSalaryTaxbench where itemid = id_1)
                    loop
                        delete from HrmSalaryTaxrate where benchid = benchid_1;
                        delete from HrmSalaryTaxbench where id = benchid_1;
                    end loop;
                end if;
            end if;
        end if;
    end if ;
end if;
end;
/



CREATE or REPLACE PROCEDURE  HrmSalaryDiffDetail_Insert
	(itemid_1 	integer,
	 resourceid_2 	integer,
	 payid_3 	integer,
	 diffid_4 	integer,
	 difftypeid_5 	integer,
	 startdate_6 	char,
	 enddate_7 	char,
	 realcounttime_8 	integer,
	 realcountpay_9 	number ,
         flag	out integer, 
         msg   out	varchar2, 
         thecursor IN OUT cursor_define.weavercursor )

AS 
begin
INSERT INTO HrmSalaryDiffDetail 
	 ( itemid,
	 resourceid,
	 payid,
	 diffid,
	 difftypeid,
	 startdate,
	 enddate,
	 realcounttime,
	 realcountpay) 
 
VALUES 
	( itemid_1,
	 resourceid_2,
	 payid_3,
	 diffid_4,
	 difftypeid_5,
	 startdate_6,
	 enddate_7,
	 realcounttime_8,
	 realcountpay_9) ;
end ;
/


/*��ѯ�򿨻����� 
 create by Wangxiaoyi 2003-10-30
 */

CREATE or REPLACE PROCEDURE HrmCardInfo_SelectCount (
carddate_3 char,/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
workshift_5  char ,/*����,��������16�����飬��0~9,A~F*/
Cardid_6  char , /*card id*/
flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor ) 
 AS
 begin
 open thecursor for
 select count(id) from HrmCardInfo where carddate = carddate_3 and workshift = workshift_5 and Cardid = Cardid_6 ;
 end ;
/




CREATE or REPLACE PROCEDURE HrmCardInfo_Insert (
stationid_2 char , /*���ӵ�̨��*/
carddate_3 char,/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
cardtime_4 char , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
workshift_5  char ,/*����,��������16�����飬��0~9,A~F*/
Cardid_6  char , /*card id*/
flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )

 AS 
 begin
 INSERT INTO HrmCardInfo (
 stationid , 
 carddate , 
 cardtime , 
 workshift , 
 Cardid ) 
 
 VALUES (
 stationid_2 , 
 carddate_3 , 
 cardtime_4 , 
 workshift_5 , 
 Cardid_6 
) ;
end;
/





CREATE or REPLACE PROCEDURE HrmValidateCardInfo_Insert (
 stationid_2 char , /*���ӵ�̨��*/
 carddate_3 char,/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
 cardtime_4 char , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
 workshift_5  char ,/*����,��������16�����飬��0~9,A~F*/
 Cardid_6  char , /*card id*/
 flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )

 AS 
 begin
 INSERT INTO HrmValidateCardInfo (
 stationid , 
 carddate , 
 cardtime , 
 workshift , 
 Cardid ) 
 
 VALUES (
 stationid_2 , 
 carddate_3 , 
 cardtime_4 , 
 workshift_5 , 
 Cardid_6 
) ;
end ;
/



create or replace PROCEDURE HrmTimecardInfo_Update
	(resourceid_1 	integer,
	 timecarddate_3 	char,
	 intime_4 	char,
	 outtime_5 	char,
 flag out integer, 
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)

AS 
count_1 integer;
begin
select count(resourceid) into count_1 from HrmTimecardInfo 
where resourceid = resourceid_1 and timecarddate = timecarddate_3;
if count_1 is not null and count_1 > 0 then
    UPDATE HrmTimecardInfo 
    SET  outtime	 = outtime_5 
    WHERE 
        ( resourceid	 = resourceid_1 and
         timecarddate	 = timecarddate_3);
else
    insert into HrmTimecardinfo(resourceid,timecarddate,intime) 
    values(resourceid_1,timecarddate_3,intime_4 );
end if;
end;
/


/*����ϵͳ����*/
CREATE TABLE HrmkqSystemSet (
tosomeone varchar2 (60)  NULL , /*�ռ��˵�ַ*/
timeinterval integer /*�ɼ�����ʱ����*/
)
/


CREATE PROCEDURE HrmkqSystemSet_Select(
 flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )
AS 
begin
open thecursor for
select * from HrmkqSystemSet ;
end ;
/


CREATE or REPLACE PROCEDURE HrmkqSystem_Insert(
 tosomeone_1 varchar2 ,	
 timeinterval_2 integer ,
 flag	out integer, 
 msg   out	varchar2, 
 thecursor IN OUT cursor_define.weavercursor )
 AS 
 begin
 INSERT INTO HrmkqSystemSet(tosomeone , timeinterval)  
 VALUES(tosomeone_1 , timeinterval_2) ;
 end ;
/


CREATE or REPLACE PROCEDURE  HrmkqSystemSet_Update(
tosomeone_1  varchar2 ,
timeinterval_2  integer , 
flag	out integer, 
msg   out	varchar2, 
thecursor IN OUT cursor_define.weavercursor ) 
AS 
begin
update HrmkqSystemSet set tosomeone = tosomeone_1 , timeinterval = timeinterval_2 ;
end ;
/

insert into 
SystemRightDetail (id,rightdetailname,rightdetail,rightid) 
values (3070,'Ĭ��ʱ����½�','HrmDefaultScheduleAdd:Add',35)
/

INSERT INTO HtmlLabelIndex values(16689,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(16689,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16689,'morning',8) 
/

INSERT INTO HtmlLabelIndex values(16690,'����') 
/
INSERT INTO HtmlLabelInfo VALUES(16690,'����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16690,'afternoon',8) 
/

INSERT INTO HtmlLabelIndex values(16691,'��ʷ�б�') 
/
INSERT INTO HtmlLabelInfo VALUES(16691,'��ʷ�б�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16691,'',8) 
/

INSERT INTO HtmlLabelIndex values(16692,'�Ű����') 
/
INSERT INTO HtmlLabelInfo VALUES(16692,'�Ű����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16692,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16693,'�Ű�������') 
/
INSERT INTO HtmlLabelInfo VALUES(16693,'�Ű�������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16693,'',8) 
/

INSERT INTO HtmlLabelIndex values(16694,'�Ű�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16694,'�Ű�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16694,'',8) 
/

INSERT INTO HtmlLabelIndex values(16695,'�Ű�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16695,'�Ű�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16695,'',8) 
/

INSERT INTO HtmlLabelIndex values(16696,'��ʼʱ��ͽ���ʱ��û�гɶԳ��֣�') 
/
INSERT INTO HtmlLabelInfo VALUES(16696,'��ʼʱ��ͽ���ʱ��û�гɶԳ��֣�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16696,'',8) 
/

INSERT INTO HtmlLabelIndex values(16697,'һ�㹤��ʱ����ʷ') 
/
INSERT INTO HtmlLabelInfo VALUES(16697,'һ�㹤��ʱ����ʷ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16697,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16698,'������Excel��') 
/
INSERT INTO HtmlLabelInfo VALUES(16698,'������Excel��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16698,'',8) 
/

INSERT INTO HtmlLabelIndex values(16699,'Excel�ļ�') 
/
INSERT INTO HtmlLabelInfo VALUES(16699,'Excel�ļ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16699,'',8) 
/

INSERT INTO HtmlLabelIndex values(16700,'�����ݵ������') 
/
INSERT INTO HtmlLabelInfo VALUES(16700,'�����ݵ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16700,'',8) 
/

INSERT INTO HtmlLabelIndex values(16701,'�����޶�Ӧ�û�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16701,'�����޶�Ӧ�û�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16701,'',8) 
/

INSERT INTO HtmlLabelIndex values(16702,'�ⲿ���û����') 
/
INSERT INTO HtmlLabelInfo VALUES(16702,'�ⲿ���û����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16702,'',8) 
/

INSERT INTO HtmlLabelIndex values(16703,'������') 
/
INSERT INTO HtmlLabelInfo VALUES(16703,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16703,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16704,'�빫˾ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16704,'�빫˾ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16704,'',8) 
/

INSERT INTO HtmlLabelIndex values(16705,'����˾ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16705,'����˾ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16705,'',8) 
/

INSERT INTO HtmlLabelIndex values(16706,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(16706,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16706,'',8) 
/

INSERT INTO HtmlLabelIndex values(16707,'������ʼ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16707,'������ʼ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16707,'',8) 
/

INSERT INTO HtmlLabelIndex values(16708,'������������') 
/
INSERT INTO HtmlLabelInfo VALUES(16708,'������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16708,'',8) 
/

INSERT INTO HtmlLabelIndex values(16709,'�Ƿ����н��') 
/
INSERT INTO HtmlLabelInfo VALUES(16709,'�Ƿ����н��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16709,'',8) 
/

INSERT INTO HtmlLabelIndex values(16710,'н�ʼ��㷽ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(16710,'н�ʼ��㷽ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16710,'',8) 
/

INSERT INTO HtmlLabelIndex values(16711,'����ֵ') 
/
INSERT INTO HtmlLabelInfo VALUES(16711,'����ֵ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16711,'',8) 
/

INSERT INTO HtmlLabelIndex values(16712,'��׼������') 
/
INSERT INTO HtmlLabelInfo VALUES(16712,'��׼������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16712,'',8) 
/

INSERT INTO HtmlLabelIndex values(16713,'��С����ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16713,'��С����ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16713,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16714,'ʱ����㷽ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(16714,'ʱ����㷽ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16714,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16715,'�Կ���ʱ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16715,'�Կ���ʱ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16715,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16716,'�Դ�ʱ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16716,'�Դ�ʱ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16716,'',8) 
/

INSERT INTO HtmlLabelIndex values(16717,'�Խϴ�ʱ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16717,'�Խϴ�ʱ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16717,'',8) 
/

INSERT INTO HtmlLabelIndex values(16718,'�Խ�Сʱ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16718,'�Խ�Сʱ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16718,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16719,'���ڼ���ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16719,'���ڼ���ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16719,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16720,'�򿨼���ʱ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16720,'�򿨼���ʱ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16720,'',8) 
/

INSERT INTO HtmlLabelIndex values(16721,'��ʼ���ڲ��ܴ��ڽ������ڣ�') 
/
INSERT INTO HtmlLabelInfo VALUES(16721,'��ʼ���ڲ��ܴ��ڽ������ڣ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16721,'',8) 
/

INSERT INTO HtmlLabelIndex values(16722,'��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡') 
/
INSERT INTO HtmlLabelInfo VALUES(16722,'��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16722,'',8) 
/

INSERT INTO HtmlLabelIndex values(16723,'�������ļ����أ�') 
/
INSERT INTO HtmlLabelInfo VALUES(16723,'�������ļ����أ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16723,'',8) 
/

INSERT INTO HtmlLabelIndex values(16724,'���û��������') 
/
INSERT INTO HtmlLabelInfo VALUES(16724,'���û��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16724,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16725,'��ϵͳID') 
/
INSERT INTO HtmlLabelInfo VALUES(16725,'��ϵͳID',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16725,'',8) 
/

INSERT INTO HtmlLabelIndex values(16726,'���û������ͻ������') 
/
INSERT INTO HtmlLabelInfo VALUES(16726,'���û������ͻ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16726,'',8) 
/

INSERT INTO HtmlLabelIndex values(16727,'�û�������Ϣ') 
/
INSERT INTO HtmlLabelInfo VALUES(16727,'�û�������Ϣ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16727,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16728,'��ϵͳ�û�ID') 
/
INSERT INTO HtmlLabelInfo VALUES(16728,'��ϵͳ�û�ID',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16728,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16729,'���ɳ���ͳ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16729,'���ɳ���ͳ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16729,'',8) 
/

INSERT INTO HtmlLabelIndex values(16730,'������������') 
/
INSERT INTO HtmlLabelInfo VALUES(16730,'������������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16730,'',8) 
/

INSERT INTO HtmlLabelIndex values(16731,'Ա�����ڹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(16731,'Ա�����ڹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16731,'',8) 
/

INSERT INTO HtmlLabelIndex values(16732,'����ͳ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16732,'����ͳ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16732,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16733,'�༭����ͳ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16733,'�༭����ͳ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16733,'',8) 
/

INSERT INTO HtmlLabelIndex values(16734,'����ƫ��') 
/
INSERT INTO HtmlLabelInfo VALUES(16734,'����ƫ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16734,'',8) 
/

INSERT INTO HtmlLabelIndex values(16735,'ƫ����������') 
/
INSERT INTO HtmlLabelInfo VALUES(16735,'ƫ����������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16735,'',8) 
/

INSERT INTO HtmlLabelIndex values(16736,'���ڹ���') 
/
INSERT INTO HtmlLabelInfo VALUES(16736,'���ڹ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16736,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16737,'��ȡ������') 
/
INSERT INTO HtmlLabelInfo VALUES(16737,'��ȡ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16737,'',8) 
/

INSERT INTO HtmlLabelIndex values(16738,'����ϵͳ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16738,'����ϵͳ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16738,'',8) 
/

INSERT INTO HtmlLabelIndex values(16739,'ʵ�ʼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16739,'ʵ�ʼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16739,'',8) 
/

 INSERT INTO HtmlLabelIndex values(16740,'���ڽ���') 
/
INSERT INTO HtmlLabelInfo VALUES(16740,'���ڽ���',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16740,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16741,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(16741,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16741,'',8) 
/

INSERT INTO HtmlLabelIndex values(16742,'���ڴ��������ڲɼ����뿪��ҳ��ᵼ�����ݲɼ�ֹͣ�����Ҫ�뿪��') 
/
INSERT INTO HtmlLabelInfo VALUES(16742,'���ڴ��������ڲɼ����뿪��ҳ��ᵼ�����ݲɼ�ֹͣ�����Ҫ�뿪��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16742,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16743,'����ϵͳ����Ա�ʼ�����') 
/
INSERT INTO HtmlLabelInfo VALUES(16743,'����ϵͳ����Ա�ʼ�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16743,'',8) 
/

INSERT INTO HtmlLabelIndex values(16744,'���ݲɼ�ʱ����') 
/
INSERT INTO HtmlLabelInfo VALUES(16744,'���ݲɼ�ʱ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16744,'',8) 
/
 
INSERT INTO HtmlLabelIndex values(16745,'�ռ��˵�ַ') 
/
INSERT INTO HtmlLabelInfo VALUES(16745,'�ռ��˵�ַ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16745,'',8) 
/

INSERT INTO HtmlLabelIndex values(16746,'���óɹ�!') 
/
INSERT INTO HtmlLabelInfo VALUES(16746,'���óɹ�!',7) 
/
INSERT INTO HtmlLabelInfo VALUES(16746,'',8) 
/
 

