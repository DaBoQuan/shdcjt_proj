
/*������������ġ�ecology��Ʒ�����������Ľ��ύ���Ա��桷�Ľű�*/


/* ɾ�� �ʲ����üƻ� */

delete from workflow_bill where id = 1
go
delete from workflow_billfield where billid = 1
go
drop table bill_CptPlanMain
go
drop table bill_CptPlanDetail
go

/* ɾ�� ��ⵥ */

delete from workflow_bill where id = 2
go
delete from workflow_billfield where billid = 2
go

/* ɾ�� ���ⵥ */

delete from workflow_bill where id = 3
go
delete from workflow_billfield where billid = 3
go

/* ɾ�� ��ͬ */

delete from workflow_bill where id = 4
go
delete from workflow_billfield where billid = 4
go
drop table bill_contract
go
drop table bill_contractdetail
go

/* ɾ�� ��������ϵ�� */

delete from workflow_bill where id = 5
go
delete from workflow_billfield where billid = 5
go
drop table Bill_Meetingroom
go

/* ɾ�� ��Ŀ�ƻ� */

delete from workflow_bill where id = 9
go
delete from workflow_billfield where billid = 9
go

/* ɾ�� �������� */

delete from workflow_bill where id = 12
go
delete from workflow_billfield where billid = 12
go

/* ɾ�� �¹����ƻ��� */

delete from workflow_bill where id = 20
go
delete from workflow_billfield where billid = 20
go

/* �¹����ܽ���ƻ� */

insert into HtmlLabelIndex (id,indexdesc) values (6167	,'�¹����ܽ���ƻ�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6167,'�¹����ܽ���ƻ�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6167,'',8)
GO
update workflow_bill set namelabel = 6167 where id = 21
go

/* ¼��֪ͨ�� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    viewpage = '' , 
    operationpage = 'BillHireResourceOperation.jsp' 
where id = 22
go

/* ��ְ֪ͨ�� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    viewpage = '' , 
    operationpage = 'BillLeaveJobOperation.jsp' 
where id = 23
go

/* ɾ�� �ܲ�Ԥ�㶨�Ƶ� */

delete from workflow_bill where id = 24
go
delete from workflow_billfield where billid = 24
go
drop table bill_TotalBudget
go
drop table bill_BudgetDetail
go

/* ɾ�� ������� */

delete from workflow_bill where id = 25
go
delete from workflow_billfield where billid = 25
go
drop table bill_CptStockInMain
go
drop table bill_CptStockInDetail
go

/* ɾ�� �ʲ��̵� */

delete from workflow_bill where id = 27
go
delete from workflow_billfield where billid = 27
go
drop table bill_CptCheckMain
go
drop table bill_CptCheckDetail
go

/* ɾ�� ��Ƭӡ�� */

delete from workflow_bill where id = 30
go
delete from workflow_billfield where billid = 30
go
drop table bill_NameCard
go

/* ɾ�� ����Ԥ�� */

delete from workflow_bill where id = 31
go
delete from workflow_billfield where billid = 31
go
drop table bill_HotelBook
go

/* ɾ�� ������¼ */

delete from workflow_bill where id = 32
go
delete from workflow_billfield where billid = 32
go
drop table bill_CptCarOut
go

/* ɾ�� �������ñ��� */

delete from workflow_bill where id = 33
go
delete from workflow_billfield where billid = 33
go
drop table bill_CptCarFee
go

/* ɾ�� �������� */

delete from workflow_bill where id = 34
go
delete from workflow_billfield where billid = 34
go
drop table bill_CptCarMantant
go

/* ɾ�� ����ά�� */

delete from workflow_bill where id = 35
go
delete from workflow_billfield where billid = 35
go
drop table bill_CptCarFix
go

/* ɾ�� �칫��Ʒ���� */

delete from workflow_bill where id = 36
go
delete from workflow_billfield where billid = 36
go

/* ɾ�� ҵ���д��ѱ��� */

delete from workflow_bill where id = 37
go
delete from workflow_billfield where billid = 37
go

/* ���۽��� */

Update workflow_bill 
set createpage = '' , 
    viewpage = '' , 
    operationpage = 'BillDiscussOperation.jsp' 
where id = 38
go
delete from workflow_billfield where id = 365
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'alldoc',857,'varchar(255)',3,37,4,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'projectid',782,'int',3,8,5,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'crmid',783,'int',3,7,6,0)
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (38,'relatedrequestid',1044,'int',3,16,7,0) 
GO

/* �������� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmAwardInfoOperation.jsp' 
where id = 39
go

/* ְλ���� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmRedeployOperation.jsp' 
where id = 40
go

/* ��ְ���� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmDismissOperation.jsp' 
where id = 41
go

/* ת������ */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmHireOperation.jsp' 
where id = 42
go

/* �Ӱ� */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmScheduleOvertimeOperation.jsp' 
where id = 45
go

/*  ���  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmScheduleHolidayOperation.jsp' 
where id = 46
go

/*  �ù�����  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmDemandOperation.jsp' 
where id = 47
go

/*  ��ѵ����  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillHrmTrainplanOperation.jsp' 
where id = 48
go

/*  �ͻ���ͬ  */

Update workflow_bill 
set createpage = '' , 
    managepage = '' , 
    operationpage = 'BillCrmContractOperation.jsp' 
where id = 49
go


Update workflow_billfield set dsporder = 12 where id = 162
GO
Update workflow_billfield set dsporder = 13 where id = 326
GO
Update workflow_billfield set dsporder = 14 where id = 327
GO
Update workflow_billfield set dsporder = 15 where id = 328
GO
Update workflow_billfield set dsporder = 16 where id = 329
GO
Update workflow_billfield set dsporder = 17 where id = 160
GO
Update workflow_billfield set dsporder = 18 where id = 161
GO


ALTER  PROCEDURE bill_CptApplyDetail_Insert
(@cptapplyid 	[int],
@cpttype 	[int],
@cptid_1 	[int],
@number_2 	[decimal](10,3),
@unitprice_3 	[decimal](10,3),
@amount_4 	[decimal](10,3),
@needdate_5 	[varchar](10), 
@purpose_6 	[varchar](60), 
@cptdesc_7 	[varchar](60),
@capitalid_8 	[int],
@flag integer output , 
@msg varchar(80) output )  
AS 
INSERT INTO [bill_CptApplyDetail] ( [cptapplyid], [cpttype], [cptid], [number_n], [unitprice], [amount], [needdate], [purpose], [cptdesc],[capitalid])  
VALUES ( @cptapplyid, @cpttype, @cptid_1, @number_2, @unitprice_3, @amount_4, @needdate_5, @purpose_6, @cptdesc_7 , @capitalid_8) 
GO

Update workflow_billfield set fieldlabel = 535 where billid = 15 and fieldname = 'cptid' 
GO

delete from workflow_billfield where billid = 18 and fieldname = 'groupid' 
GO
delete from workflow_billfield where billid = 18 and fieldname = 'cptstatus' 
GO

Update workflow_billfield set dsporder = 11 where billid = 18 and fieldname = 'capitalid' 
GO
Update workflow_billfield set dsporder = 12 where billid = 18 and fieldname = 'number' 
GO
Update workflow_billfield set dsporder = 13 where billid = 18 and fieldname = 'unitprice' 
GO
Update workflow_billfield set dsporder = 14 where billid = 18 and fieldname = 'amount' 
GO


ALTER  PROCEDURE bill_CptAdjustDetail_Insert
(@cptadjustid 	[int], 
@cptid_1 	[int], 
@capitalid_2 	[int], 
@number_3 	[decimal](10,3),
@unitprice_4 	[decimal](10,3), 
@amount_5 	[decimal](10,3), 
@needdate_6 	[varchar](10), 
@purpose_7 	[varchar](60), 
@cptdesc_8 	[varchar](60), 
@flag integer output , 
@msg varchar(80) output )  
AS 
INSERT INTO [bill_CptAdjustDetail] 
( [cptadjustid], 
[cptid], 
[capitalid],
[number_n], 
[unitprice], 
[amount], 
[needdate], 
[purpose], 
[cptdesc]) 
VALUES 
(@cptadjustid, 
@cptid_1, 
@capitalid_2,
@number_3, 
@unitprice_4,
@amount_5,
@needdate_6,
@purpose_7,
@cptdesc_8) 
GO


Update workflow_billfield set dsporder = 9 where billid = 19 and fieldname = 'capitalid' 
GO
Update workflow_billfield set dsporder = 10 where billid = 19 and fieldname = 'number' 
GO
Update workflow_billfield set dsporder = 11 where billid = 19 and fieldname = 'unitprice' 
GO
Update workflow_billfield set dsporder = 12 where billid = 19 and fieldname = 'amount' 
GO
Update workflow_billfield set dsporder = 13 where billid = 19 and fieldname = 'needdate' 
GO
Update workflow_billfield set dsporder = 14 where billid = 19 and fieldname = 'purpose' 
GO
Update workflow_billfield set dsporder = 15 where billid = 19 and fieldname = 'cptdesc' 
GO


ALTER PROCEDURE bill_CptFetchDetail_Insert 
(@cptfetchid 	[int], 
@cptid_1 	[int],
@capitalid_2 	[int],
@number_3 	[decimal](10,3), 
@unitprice_4 	[decimal](10,3), 
@amount_5 	[decimal](10,3), 
@needdate_6 	[varchar](10), 
@purpose_7 	[varchar](60),
@cptdesc_8 	[varchar](60), 
@flag integer output , 
@msg varchar(80) output ) 
AS 
INSERT INTO [bill_CptFetchDetail] 
( [cptfetchid], 
[cptid], 
[capitalid],
[number_n], 
[unitprice], 
[amount], 
[needdate], 
[purpose], 
[cptdesc])  
VALUES 
( @cptfetchid,
@cptid_1, 
@capitalid_2,
@number_3, 
@unitprice_4, 
@amount_5, 
@needdate_6, 
@purpose_7,
@cptdesc_8) 
GO



/*���������ϵġ�Ecology��Ʒ����-������Դsystem�û��Ľ�V1.0�ύ���Ա���2003-08-19���Ľű�*/
delete HrmResource where loginid in ( 'sysadmin' , 'weaveradmin' , 'gmanager' ) or id = 1 or status = 10
GO

create table HrmResourceManager( 
id int,
loginid varchar(60),
password varchar(100),
firstname varchar(20),
lastname varchar(20),
systemlanguage int,
seclevel int,
status int
)
GO

insert into HrmResourceManager(id,loginid,password,firstname,lastname,systemlanguage,seclevel,status) 
values (1,'sysadmin','C4CA4238A0B923820DCC509A6F75849B','','ϵͳ����Ա',7,30,1)
GO



alter PROCEDURE HrmResource_SByLoginIDPass 
 ( @loginid   varchar(60), 
   @password  varchar(100), 
   @flag	int	output, 
   @msg	varchar(80)	output ) 
AS 
declare @count int 
if @loginid != 'sysadmin'
begin
    select @count = count(id) from HrmResource where loginid= @loginid  
    if @count <> 0 
    begin 
        select @count = count(id) from HrmResource where loginid= @loginid and password = @password 
        if @count <> 0 
            select * from HrmResource where loginid= @loginid 
        else 
            select 0 
    end 
end
else 
begin
    select @count = count(id) from HrmResourceManager where loginid = @loginid and password = @password
    if @count <> 0 
        select * from HrmResourceManager where loginid= @loginid 
    else 
        select 0 
end
GO


alter PROCEDURE HrmResource_UpdatePassword 
 (@id_1 	int, 
  @passwordold_2     varchar(100), 
  @passwordnew_3     varchar(100), 
  @flag                             integer output, 
  @msg                             varchar(80) output ) 
AS 
if @id_1 != 1
    update HrmResource set password = @passwordnew_3 where id=@id_1 and password = @passwordold_2  
else 
    update HrmResourceManager set password = @passwordnew_3 where id=@id_1 and password = @passwordold_2  

if @@ROWCOUNT<>0 begin set @flag=1 set @msg='��������ɹ�' select 1 return end else begin set @flag=1 set @msg='��������ʧ��' select 2 return end 
GO



alter PROCEDURE HrmResourceSystemInfo_Insert
(@id_1 int,
 @loginid_2 varchar(20),
 @password_3 varchar(60),
 @systemlanguage_4 int,
 @seclevel_5 int,
 @email_6 varchar(60),
 @flag int output, @msg varchar(60) output)
AS 
declare @count int

if @loginid_2 is not null and @loginid_2 != '' and @loginid_2 != 'sysadmin'
    select @count = count(id) from HrmResource where id != @id_1 and loginid = @loginid_2

if ( @count is not null and @count > 0 ) or @loginid_2 = 'sysadmin'
    select 0
else 
begin
    if @password_3 = '0' 
        UPDATE HrmResource SET
        loginid = @loginid_2,
        systemlanguage = @systemlanguage_4,
        seclevel = @seclevel_5,
        email = @email_6
        WHERE id = @id_1
    else 
        UPDATE HrmResource SET
        loginid = @loginid_2,
        password = @password_3,
        systemlanguage = @systemlanguage_4,
        seclevel = @seclevel_5,
        email = @email_6
        WHERE id = @id_1
end
GO


