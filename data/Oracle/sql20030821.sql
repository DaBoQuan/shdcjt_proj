
/*������������ġ�ecology��Ʒ�����������Ľ��ύ���Ա��桷�Ľű�*/


/* ɾ�� �ʲ����üƻ� */

delete from workflow_bill where id = 1
/
delete from workflow_billfield where billid = 1
/
drop table bill_CptPlanMain
/
drop table bill_CptPlanDetail
/

/* ɾ�� ��ⵥ */

delete from workflow_bill where id = 2
/
delete from workflow_billfield where billid = 2
/

/* ɾ�� ���ⵥ */

delete from workflow_bill where id = 3
/
delete from workflow_billfield where billid = 3
/

/* ɾ�� ��ͬ */

delete from workflow_bill where id = 4
/
delete from workflow_billfield where billid = 4
/
drop table bill_contract
/
drop table bill_contractdetail
/

/* ɾ�� ��������ϵ�� */

delete from workflow_bill where id = 5
/
delete from workflow_billfield where billid = 5
/
drop table Bill_Meetingroom
/

/* ɾ�� ��Ŀ�ƻ� */

delete from workflow_bill where id = 9
/
delete from workflow_billfield where billid = 9
/

/* ɾ�� �������� */

delete from workflow_bill where id = 12
/
delete from workflow_billfield where billid = 12
/

/* ɾ�� �¹����ƻ��� */

delete from workflow_bill where id = 20
/
delete from workflow_billfield where billid = 20
/

/* �¹����ܽ���ƻ� */

insert into HtmlLabelIndex (id,indexdesc) values (6167	,'�¹����ܽ���ƻ�')
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6167,'�¹����ܽ���ƻ�',7)
/
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6167,'',8)
/
update workflow_bill set namelabel = 6167 where id = 21
/

/* ¼��֪ͨ�� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    viewpage = '' , 
    operationpage = 'BillHireResourceOperation.jsp' 
where id = 22
/
/* ��ְ֪ͨ�� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    viewpage = '' , 
    operationpage = 'BillLeaveJobOperation.jsp' 
where id = 23
/

/* ɾ�� �ܲ�Ԥ�㶨�Ƶ� */

delete from workflow_bill where id = 24
/
delete from workflow_billfield where billid = 24
/
drop table bill_TotalBudget
/
drop table bill_BudgetDetail
/

/* ɾ�� ������� */

delete from workflow_bill where id = 25
/
delete from workflow_billfield where billid = 25
/
drop table bill_CptStockInMain
/
drop table bill_CptStockInDetail
/

/* ɾ�� �ʲ��̵� */

delete from workflow_bill where id = 27
/
delete from workflow_billfield where billid = 27
/
drop table bill_CptCheckMain
/
drop table bill_CptCheckDetail
/

/* ɾ�� ��Ƭӡ�� */

delete from workflow_bill where id = 30
/
delete from workflow_billfield where billid = 30
/
drop table bill_NameCard
/

/* ɾ�� ����Ԥ�� */

delete from workflow_bill where id = 31
/
delete from workflow_billfield where billid = 31
/
drop table bill_HotelBook
/

/* ɾ�� ������¼ */

delete from workflow_bill where id = 32
/
delete from workflow_billfield where billid = 32
/
drop table bill_CptCarOut
/

/* ɾ�� �������ñ��� */

delete from workflow_bill where id = 33
/
delete from workflow_billfield where billid = 33
/
drop table bill_CptCarFee
/

/* ɾ�� �������� */

delete from workflow_bill where id = 34
/
delete from workflow_billfield where billid = 34
/
drop table bill_CptCarMantant
/

/* ɾ�� ����ά�� */

delete from workflow_bill where id = 35
/
delete from workflow_billfield where billid = 35
/
drop table bill_CptCarFix
/

/* ɾ�� �칫��Ʒ���� */

delete from workflow_bill where id = 36
/
delete from workflow_billfield where billid = 36
/


/* ɾ�� ҵ���д��ѱ��� */

delete from workflow_bill where id = 37
/
delete from workflow_billfield where billid = 37
/

/* ���۽��� */

Update workflow_bill 
set createpage = '' , 
    viewpage = '' , 
    operationpage = 'BillDiscussOperation.jsp' 
where id = 38
/
delete from workflow_billfield where id = 365
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, 
fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'alldoc',857,'varchar(255)',3,37,4,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel,
fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'projectid',782,'integer',3,8,5,0)
/ 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel,
fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'crmid',783,'integer',3,7,6,0)
/
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel,
fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'relatedrequestid',
1044,'int',3,16,7,0) 
/

/* �������� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmAwardInfoOperation.jsp' 
where id = 39
/

/* ְλ���� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmRedeployOperation.jsp' 
where id = 40
/

/* ��ְ���� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmDismissOperation.jsp' 
where id = 41
/

/* ת������ */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmHireOperation.jsp' 
where id = 42
/

/* �Ӱ� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmScheduleOvertimeOperation.jsp' 
where id = 45
/

/*  ���  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmScheduleHolidayOperation.jsp' 
where id = 46
/

/*  �ù�����  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmDemandOperation.jsp' 
where id = 47
/

/*  ��ѵ����  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmTrainplanOperation.jsp' 
where id = 48
/

/*  �ͻ���ͬ  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillCrmContractOperation.jsp' 
where id = 49
/


Update workflow_billfield set dsporder = 12 where id = 162
/
Update workflow_billfield set dsporder = 13 where id = 326
/
Update workflow_billfield set dsporder = 14 where id = 327
/
Update workflow_billfield set dsporder = 15 where id = 328
/
Update workflow_billfield set dsporder = 16 where id = 329
/
Update workflow_billfield set dsporder = 17 where id = 160
/
Update workflow_billfield set dsporder = 18 where id = 161
/


CREATE or replace  PROCEDURE bill_CptApplyDetail_Insert
(cptapplyid 	integer,
cpttype 	integer,
cptid_1 	integer,
number_2 	number ,
unitprice_3 	number,
amount_4 	number,
needdate_5 	Varchar2, 
purpose_6 	Varchar2 , 
cptdesc_7 	Varchar2 ,
capitalid_8 	integer,
 flag	out integer,
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO bill_CptApplyDetail ( cptapplyid, cpttype, cptid, number_n, unitprice,
amount, needdate, purpose, cptdesc,capitalid)  
VALUES ( cptapplyid, cpttype, cptid_1, number_2, unitprice_3,
amount_4, needdate_5, purpose_6, cptdesc_7 , capitalid_8);
end;
/

Update workflow_billfield set fieldlabel = 535 where billid = 15 and fieldname = 'cptid' 
/

delete from workflow_billfield where billid = 18 and fieldname = 'groupid' 
/
delete from workflow_billfield where billid = 18 and fieldname = 'cptstatus' 
/

Update workflow_billfield set dsporder = 11 where billid = 18 and fieldname = 'capitalid' 
/
Update workflow_billfield set dsporder = 12 where billid = 18 and fieldname = 'number' 
/
Update workflow_billfield set dsporder = 13 where billid = 18 and fieldname = 'unitprice' 
/
Update workflow_billfield set dsporder = 14 where billid = 18 and fieldname = 'amount' 
/


CREATE or replace  PROCEDURE bill_CptAdjustDetail_Insert
(cptadjustid 	integer, 
cptid_1 	integer, 
capitalid_2 	integer, 
number_3 	number,
unitprice_4 	number, 
amount_5 	number, 
needdate_6 	varchar2, 
purpose_7 	varchar2, 
cptdesc_8 	varchar2, 
flag	out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO bill_CptAdjustDetail 
( cptadjustid, 
cptid, 
capitalid,
number_n, 
unitprice, 
amount, 
needdate, 
purpose, 
cptdesc) 
VALUES 
(cptadjustid, 
cptid_1, 
capitalid_2,
number_3, 
unitprice_4,
amount_5,
needdate_6,
purpose_7,
cptdesc_8);
end;
/



Update workflow_billfield set dsporder = 9 where billid = 19 and fieldname = 'capitalid' 
/
Update workflow_billfield set dsporder = 10 where billid = 19 and fieldname = 'number' 
/
Update workflow_billfield set dsporder = 11 where billid = 19 and fieldname = 'unitprice' 
/
Update workflow_billfield set dsporder = 12 where billid = 19 and fieldname = 'amount' 
/
Update workflow_billfield set dsporder = 13 where billid = 19 and fieldname = 'needdate' 
/
Update workflow_billfield set dsporder = 14 where billid = 19 and fieldname = 'purpose' 
/
Update workflow_billfield set dsporder = 15 where billid = 19 and fieldname = 'cptdesc' 
/


CREATE or replace PROCEDURE bill_CptFetchDetail_Insert 
(cptfetchid 	integer, 
cptid_1 	integer,
capitalid_2 	integer,
number_3        number , 
unitprice_4 	number, 
amount_5 	number, 
needdate_6 	varchar2, 
purpose_7 	varchar2,
cptdesc_8 	varchar2, 
flag	out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS 
begin
INSERT INTO bill_CptFetchDetail 
( cptfetchid, 
cptid, 
capitalid,
number_n, 
unitprice, 
amount, 
needdate, 
purpose, 
cptdesc)  
VALUES 
( cptfetchid,
cptid_1, 
capitalid_2,
number_3, 
unitprice_4, 
amount_5, 
needdate_6, 
purpose_7,
cptdesc_8);
end;
/



/*���������ϵġ�Ecology��Ʒ����-������Դsystem�û��Ľ�V1.0�ύ���Ա���2003-08-19���Ľű�*/
delete HrmResource where loginid in ( 'sysadmin' , 'weaveradmin' , 'gmanager' ) or id = 1 or status = 10
/

create table HrmResourceManager
( 
id integer,
loginid varchar2(60),
password varchar2(100),
firstname varchar2(20),
lastname varchar2(20),
systemlanguage integer,
seclevel integer,
status integer
)
/

insert into HrmResourceManager(id,loginid,password,firstname,lastname,systemlanguage,seclevel,status) 
values (1,'sysadmin','C4CA4238A0B923820DCC509A6F75849B','','ϵͳ����Ա',7,30,1)
/

CREATE or replace PROCEDURE HrmResource_SByLoginIDPass 
 ( loginid_1   varchar2, 
   password_1  varchar2, 
   flag	out integer,
   msg out varchar2,
   thecursor IN OUT cursor_define.weavercursor)
AS
count_1 integer; 
begin
if loginid_1 != 'sysadmin'
then
    select count(id)  into count_1 from HrmResource where loginid= loginid_1;
    if count_1 <> 0 
    then
        select count(id)  into count_1 from HrmResource where loginid= loginid_1 and password = password_1 ;
        if count_1 <> 0 
        then
            open thecursor for
            select * from HrmResource where loginid= loginid_1 ;
        else 
            open thecursor for
            select 0 from dual ;
        end if;
    end if;
else 
    select count(id)  into count_1 from HrmResourceManager where loginid = loginid_1 and password = password_1;
    if count_1 <> 0
    then
        open thecursor for
        select * from HrmResourceManager where loginid= loginid_1 ;
    else 
        open thecursor for
        select 0 from dual;
    end if;
end if;
end;
/





CREATE or replace PROCEDURE HrmResource_UpdatePassword 
 (id_1 	integer, 
  passwordold_2     varchar2, 
  passwordnew_3     varchar2, 
  flag	out integer,
   msg out varchar2,
   thecursor IN OUT cursor_define.weavercursor)
AS 
count_1 integer ;
begin

if id_1 != 1 then
    select count(password) into count_1 from HrmResource where id=id_1 and password = passwordold_2;
    update HrmResource set password = passwordnew_3 where id=id_1 and password = passwordold_2;  
else 
    select count(password) into count_1 from HrmResourceManager where id=id_1 and password = passwordold_2;
    update HrmResourceManager set password = passwordnew_3 where id=id_1 and password = passwordold_2;
end if;
if count_1 > 0 
then
    open thecursor for
    select 1 from dual;
    return ;
else 
    open thecursor for
    select 2 from dual;
    return ;
end if;
end;
/





CREATE or replace PROCEDURE HrmResourceSystemInfo_Insert
(id_1 integer,
 loginid_2 varchar2,
 password_3 varchar2,
 systemlanguage_4 integer,
 seclevel_5 integer,
 email_6 varchar2,
 flag	out integer,
   msg out varchar2,
   thecursor IN OUT cursor_define.weavercursor)
AS 
    count_1 integer;
begin
if loginid_2 is not null and loginid_2 != '' and loginid_2 != 'sysadmin'
then
    select count(id)  into count_1 from HrmResource where id != id_1 and loginid = loginid_2;
end if;
if ( count_1 is not null and count_1 > 0 ) or loginid_2 = 'sysadmin'
then
open thecursor for
    select 0 from dual;
else 
    if password_3 = '0' 
    then
        UPDATE HrmResource SET
        loginid = loginid_2,
        systemlanguage = systemlanguage_4,
        seclevel = seclevel_5,
        email = email_6
        WHERE id = id_1;
    else 
        UPDATE HrmResource SET
        loginid = loginid_2,
        password = password_3,
        systemlanguage = systemlanguage_4,
        seclevel = seclevel_5,
        email = email_6
        WHERE id = id_1;
    end if;
end if;
end;
/




