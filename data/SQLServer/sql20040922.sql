/*�����ߣ����� ���ܣ�������Դ�Ĺ����뿼�ڹ���*/
alter PROCEDURE HrmArrangeShift_SelectAll
(@ishistory_1 char(1),
 @flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select * from HrmArrangeShift where ishistory = @ishistory_1 order by id
GO

/* ������Դ�Ű���Ա�� ��¼�����Ű����*/

create table HrmArrangeShiftSet (
id int IDENTITY (1, 1) NOT NULL ,
resourceid int
)
GO

CREATE PROCEDURE HrmArrangeShiftSet_Insert 
(
 @resourceid_2 	 varchar(60),
 @flag        integer output,
 @msg         varchar(80) output
)  
AS 
 INSERT INTO HrmArrangeShiftSet (resourceid) VALUES (@resourceid_2)
GO

CREATE PROCEDURE HrmArrangeShiftSet_Delete 
(
 @flag        integer output,
 @msg         varchar(80) output
)  
AS 
 delete HrmArrangeShiftSet 
GO


/* ���ڼ��գ���Ϊ����ʱ����� */

alter table HrmPubHoliday add 
changetype int,   /* �������� �� 1������Ϊ�������� 2�� ����Ϊ������ 3�� ����Ϊ��Ϣ�� */
relateweekday int  /* ����Ϊ�����յ�ʱ���Ӧ������ 1: ������ 2:����һ .... 7:������ */
GO

update HrmPubHoliday set changetype = 1
GO

alter PROCEDURE HrmPubHoliday_Insert 
(@countryid_1 	int, 
 @holidaydate_2 	char(10), 
 @holidayname_3 	varchar(200), 
 @changetype_4  int ,
 @relateweekday_5 int ,
 @flag integer output, 
 @msg varchar(80) output)  
AS 
 if  not exists( select * from hrmpubholiday where countryid=@countryid_1 and holidaydate=@holidaydate_2) 
 begin 
     INSERT INTO HrmPubHoliday ( countryid, holidaydate, holidayname,changetype,relateweekday)  
     VALUES ( @countryid_1, @holidaydate_2, @holidayname_3,@changetype_4,@relateweekday_5) 
 end 
 select max(id) from hrmpubholiday 
GO


alter PROCEDURE HrmPubHoliday_Update 
 (@id_1 int, 
  @holidayname_2 	varchar(200), 
  @changetype_4  int ,
  @relateweekday_5 int ,
  @flag integer output, 
  @msg varchar(80) output)  
  AS 
  update HrmPubHoliday set 
  holidayname=@holidayname_2 ,
  changetype=@changetype_4 ,
  relateweekday=@relateweekday_5 
  where id=@id_1 
GO


alter table HrmkqSystemSet add 
getdatatype int,   /* ���ݲɼ���ʽ */
getdatavalue varchar(200) ,  /* ������ʽ��ֵ */
avgworkhour int  /* ƽ��ÿ�¹���ʱ��(Сʱ) */
GO

delete HrmkqSystemSet
GO

insert into HrmkqSystemSet values('',60,1,'1',172)
GO

alter PROCEDURE HrmkqSystemSet_Update(
@tosomeone_1  varchar(60) ,
@timeinterval_2  int , 
@getdatatype_3  int , 
@getdatavalue_4  varchar(200) , 
@avgworkhour_5  int , 
@flag int output, 
@msg varchar(80) output) 
AS 
update HrmkqSystemSet 
set 
tosomeone = @tosomeone_1 , 
timeinterval = @timeinterval_2 ,
getdatatype = @getdatatype_3 , 
getdatavalue = @getdatavalue_4 , 
avgworkhour = @avgworkhour_5  
GO



/* �Դ򿨼�¼����һ����Ч�ļ�¼�б�, �Ա����ͳ�� */

CREATE TABLE HrmRightCardInfo (
	id int identity(1,1) not null primary key ,
    resourceid int, /*������Դid*/
    carddate char(10) null , /*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
    cardtime char(5) null ,  /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
    inorout  int ,           /*����˾�����빫˾ 0:�� 1:�� ������ʱ���� */
    islegal int default 1 /* ���ڵĺϷ���, �Ϸ� 1, ���Ϸ� 2 */
)
GO


CREATE PROCEDURE HrmRightCardInfo_Insert (
@resourceid_2 int , /*���ӵ�̨��*/
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@cardtime_4 char(5) , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
@inorout_5  int ,           /*����˾�����빫˾ 0:�� 1:�� ������ʱ���� */
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 INSERT INTO HrmRightCardInfo (
 resourceid , 
 carddate , 
 cardtime , 
 inorout            
 ) 
 VALUES (
 @resourceid_2 , 
 @carddate_3 , 
 @cardtime_4 , 
 @inorout_5 
 ) 
 
 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 

 if @cardcount > 2  /* һ��򿨳���3�� */
 begin
    select @reccount = count(id) from HrmArrangeShiftSet where resourceid = @resourceid_2
    if @reccount = 0   /* �ǰ���һ�㹤��ʱ�����, ��Ϊ������ */
    begin
        update HrmRightCardInfo set islegal = 2 where carddate = @carddate_3 and resourceid = @resourceid_2 
    end
    else /* �����Ű����, ���㵱����Ű����� */
    begin
        select @reccount = count(id) from HrmArrangeShiftInfo where resourceid = @resourceid_2 and shiftdate = @carddate_3
        if @reccount * 2 < @cardcount   /* �򿨴��������Ű����*2 , ��Ϊ������ */
        begin
            update HrmRightCardInfo set islegal = 2 where carddate = @carddate_3 and resourceid = @resourceid_2 
        end
    end
 end
GO


alter PROCEDURE HrmArrangeShiftInfo_Save (
 @resourceid_2 int ,
 @shiftdate_3 char (10) ,
 @shiftid_4 int	,
 @flag        integer output,
 @msg         varchar(80) output)  
 AS 
 declare @count int
 select @count = count(shiftid) from HrmArrangeShiftInfo 
 where  resourceid=@resourceid_2 and shiftdate = @shiftdate_3 and shiftid=@shiftid_4
 if @count is null or @count = 0
    INSERT INTO HrmArrangeShiftInfo(resourceid,shiftdate,shiftid) 
    VALUES(@resourceid_2,@shiftdate_3, @shiftid_4)
go

drop PROCEDURE HrmArrangeShiftProcess_Save
GO


CREATE PROCEDURE HrmRightCardInfo_Delete (
@id_1 int ,
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 declare @resourceid_2 int , @carddate_3 char(10) 

 select @resourceid_2 = resourceid , @carddate_3 = carddate from HrmRightCardInfo where id = @id_1

 delete HrmRightCardInfo where id = @id_1

 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 

 if @cardcount <= 2  /* һ��򿨲�����2�� ��Ϊ����*/
 begin
    update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
 end
 else 
 begin
    select @reccount = count(id) from HrmArrangeShiftSet where resourceid = @resourceid_2
    if @reccount > 0   /* �����Ű����, ���㵱����Ű����� */
    begin
        select @reccount = count(id) from HrmArrangeShiftInfo where resourceid = @resourceid_2 and shiftdate = @carddate_3
        if @reccount * 2 >= @cardcount   /* �򿨴����������Ű����*2 , ��Ϊ���� */
        begin
            update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
        end
     end
 end
GO


alter table HrmTimecardInfo add relateshiftid int 
GO

alter PROCEDURE HrmTimecardInfo_Update
	(@resourceid_1 	int,
	 @timecarddate_3 	char(10),
	 @intime_4 	char(5),
	 @outtime_5 	char(5),
     @relateshiftid_6  int ,
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
GO

alter PROCEDURE HrmArrangeShift_Select
(@flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select id , shiftbegintime, shiftendtime from HrmArrangeShift order by shiftbegintime
GO

alter table HrmRightCardInfo add workout int default 0  /* �Ƿ�Ϊ�Ӱ� (����Чҳ��ת��Ӱ�) 0 : �� 1 : �� */
GO

update HrmRightCardInfo set workout = 0 
GO

/* �޸Ĵ򿨼���¼��, ����ת��Ӱ���ж� */

alter PROCEDURE HrmRightCardInfo_Insert (   
@resourceid_2 int , /*���ӵ�̨��*/
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@cardtime_4 char(5) , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
@inorout_5  int ,           /*����˾�����빫˾ 0:�� 1:�� ������ʱ���� */
@flag        integer output ,
@msg         varchar(80) output)  

 AS
 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 and cardtime = @cardtime_4 
 if @cardcount = 0
 begin      /* ֻ�в���ͬ�Ĵ򿨲�¼�� ��ʼ*/
 
     INSERT INTO HrmRightCardInfo (
     resourceid , 
     carddate , 
     cardtime , 
     inorout            
     ) 
     VALUES (
     @resourceid_2 , 
     @carddate_3 , 
     @cardtime_4 , 
     @inorout_5 
     ) 
     
     
     select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 and workout = 0 

     if @cardcount > 2  /* һ��ǼӰ�򿨳���3�� */
     begin
        select @reccount = count(id) from HrmArrangeShiftSet where resourceid = @resourceid_2
        if @reccount = 0   /* �ǰ���һ�㹤��ʱ�����, ��Ϊ������ */
        begin
            update HrmRightCardInfo set islegal = 2 where carddate = @carddate_3 and resourceid = @resourceid_2 
        end
        else /* �����Ű����, ���㵱����Ű����� */
        begin
            select @reccount = count(id) from HrmArrangeShiftInfo where resourceid = @resourceid_2 and shiftdate = @carddate_3
            if @reccount * 2 < @cardcount   /* �򿨴��������Ű����*2 , ��Ϊ������ */
            begin
                update HrmRightCardInfo set islegal = 2 where carddate = @carddate_3 and resourceid = @resourceid_2 
            end
        end
     end

 end   /* ֻ�в���ͬ�Ĵ򿨲�¼�� ����*/
GO

/* �޸�ɾ����Ч�򿨼���, ����ת��Ӱ���ж� */
alter PROCEDURE HrmRightCardInfo_Delete (
@id_1 int ,
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 declare @resourceid_2 int , @carddate_3 char(10) 

 select @resourceid_2 = resourceid , @carddate_3 = carddate from HrmRightCardInfo where id = @id_1

 delete HrmRightCardInfo where id = @id_1

 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 and workout = 0 

 if @cardcount <= 2  /* һ��ǼӰ�򿨲�����2�� ��Ϊ����*/
 begin
    update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
 end
 else 
 begin
    select @reccount = count(id) from HrmArrangeShiftSet where resourceid = @resourceid_2
    if @reccount > 0   /* �����Ű����, ���㵱����Ű����� */
    begin
        select @reccount = count(id) from HrmArrangeShiftInfo where resourceid = @resourceid_2 and shiftdate = @carddate_3
        if @reccount * 2 >= @cardcount   /* �򿨴����������Ű����*2 , ��Ϊ���� */
        begin
            update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
        end
     end
 end
GO

/* ת��Ӱ����Ч�򿨼���, ����ת��Ӱ���ж� */
CREATE PROCEDURE HrmRightCardInfo_AddWork (
@id_1 int ,
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 declare @resourceid_2 int , @carddate_3 char(10) 

 select @resourceid_2 = resourceid , @carddate_3 = carddate from HrmRightCardInfo where id = @id_1

 update HrmRightCardInfo set workout = 2 where id = @id_1

 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 and workout = 0 

 if @cardcount <= 2  /* һ��ǼӰ�򿨲�����2�� ��Ϊ����*/
 begin
    update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
 end
 else 
 begin
    select @reccount = count(id) from HrmArrangeShiftSet where resourceid = @resourceid_2
    if @reccount > 0   /* �����Ű����, ���㵱����Ű����� */
    begin
        select @reccount = count(id) from HrmArrangeShiftInfo where resourceid = @resourceid_2 and shiftdate = @carddate_3
        if @reccount * 2 >= @cardcount   /* �򿨴����������Ű����*2 , ��Ϊ���� */
        begin
            update HrmRightCardInfo set islegal = 1 where carddate = @carddate_3 and resourceid = @resourceid_2 
        end
     end
 end
GO

alter PROCEDURE HrmTimecardUser_Update
	(@resourceid_1 	int,
	 @usercode_2 	varchar(60),
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @count int

select @count= count(usercode) from HrmTimecardUser 
where resourceid != @resourceid_1 and usercode = @usercode_2 and usercode is not null and usercode != '' 
if @count is not null and @count > 0 
begin
    select -1 
    return 
end

select @count= count(resourceid) from HrmTimecardUser where resourceid = @resourceid_1
if @count is not null and @count > 0 
    update HrmTimecardUser set usercode = @usercode_2 where resourceid = @resourceid_1
else
    insert into HrmTimecardUser(resourceid,usercode) values(@resourceid_1,@usercode_2 )

select 1

GO


/* ������Դ������Ŀ���������ӷ���Ϣ�� */
create table HrmSalaryResourcePay(
id	int IDENTITY (1, 1) NOT NULL  primary key,
itemid  int ,                           /*������Ŀid*/
resourceid  int ,                          /*������Դid*/
resourcepay  decimal(10,2)                 /*���*/
)
GO


CREATE PROCEDURE HrmSalaryResourcePay_SByItemid
	(@itemid_1 	int,
     @flag	int	output, 
     @msg	varchar(80)	output)

AS 
Select * from HrmSalaryResourcePay where itemid = @itemid_1 
GO

CREATE PROCEDURE HrmSalaryResourcePay_Insert
	(@itemid_1 	int,
	 @resourceid_2 	int,
	 @resourcepay_3 	decimal(10,2),	
     @flag	int	output, 
     @msg	varchar(80)	output)

AS INSERT INTO HrmSalaryResourcePay 
	 ( itemid,
	 resourceid,
	 resourcepay) 
 
VALUES 
	( @itemid_1,
	 @resourceid_2,
	 @resourcepay_3)
GO


CREATE PROCEDURE HrmSalaryResourcePay_Delete
	(@itemid_1 	int,	
     @flag	int	output, 
     @msg	varchar(80)	output)

AS DELETE HrmSalaryResourcePay 
WHERE ( itemid	 = @itemid_1)

GO


alter PROCEDURE HrmSalaryItem_Update
	(@id_1 	int,
	 @itemname_2 	varchar(50),
	 @itemcode_3 	varchar(50),
	 @itemtype_4 	char(1),
	 @personwelfarerate_5 	int,
	 @companywelfarerate_6 	int,
	 @taxrelateitem_7 	int,
	 @amountecp_8 	varchar(200),
	 @feetype_9 	int,
	 @isshow_10 	char(1),
	 @showorder_11 	int,
	 @ishistory_12 	char(1) ,
     @flag          integer output, 
     @msg           varchar(80) output)

AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int

select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 
UPDATE HrmSalaryItem 
SET  itemname	 = @itemname_2,
	 itemcode	 = @itemcode_3,
	 itemtype	 = @itemtype_4,
	 personwelfarerate	 = @personwelfarerate_5,
	 companywelfarerate	 = @companywelfarerate_6,
	 taxrelateitem	 = @taxrelateitem_7,
	 amountecp	 = @amountecp_8,
	 feetype	 = @feetype_9,
	 isshow	 = @isshow_10,
	 showorder	 = @showorder_11,
	 ishistory	 = @ishistory_12 

WHERE 
	( id	 = @id_1)

if @olditemtype_1 = '1' or @olditemtype_1 = '2'
    delete from HrmSalaryRank where itemid = @id_1
else if @olditemtype_1 = '5' or @olditemtype_1 = '6'
    delete from HrmSalarySchedule where itemid = @id_1
else if @olditemtype_1 = '7'
    delete from HrmSalaryShiftPay where itemid = @id_1
else if @olditemtype_1 = '8'
    delete from HrmSalaryResourcePay where itemid = @id_1
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO


alter PROCEDURE HrmSalaryItem_Delete
	(@id_1 	int ,
     @flag          integer output, 
     @msg           varchar(80) output)
AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int
select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 

DELETE HrmSalaryItem 
WHERE ( id	 = @id_1)

if @olditemtype_1 = '1'
    delete from HrmSalaryRank where itemid = @id_1 
else if @olditemtype_1 = '5' or @olditemtype_1 = '6'
    delete from HrmSalarySchedule where itemid = @id_1
else if @olditemtype_1 = '7'
    delete from HrmSalaryShiftPay where itemid = @id_1
else if @olditemtype_1 = '8'
    delete from HrmSalaryResourcePay where itemid = @id_1
else if @olditemtype_1 = '2'
begin
    delete from HrmSalaryRank where itemid = @id_1 
    delete from HrmSalaryWelfarerate where itemid = @id_1 
end
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO

alter PROCEDURE HrmSalaryShiftPay_Insert
	(@itemid_1 	int,
	 @shiftid_2 	int,
	 @shiftpay_3 	decimal(10,2),	
     @flag	int	output, 
     @msg	varchar(80)	output)

AS INSERT INTO HrmSalaryShiftPay 
	 ( itemid,
	 shiftid,
	 shiftpay) 
 
VALUES 
	( @itemid_1,
	 @shiftid_2,
	 @shiftpay_3)
GO

/* δִ�� */

alter table HrmScheduleDiff alter column countnum decimal(10, 2) 
GO

alter PROCEDURE HrmScheduleDiff_Insert 
 (@diffname_1 	varchar(60), 
  @diffdesc_2 	varchar(200), 
  @difftype_3 	char(1), 
  @difftime_4 	char(1), 
  @mindifftime_5 	smallint, 
  @workflowid_6 	int, 
  @salaryable_7 	char(1), 
  @counttype_8 	char(1), 
  @countnum_9 	varchar(10),  
  @salaryitem_11 	int, 
  @diffremark_12 	text,
  @color_13 varchar(30),
  @flag integer output,   @msg  varchar(80) output)  
AS 
declare  @countnum_10 decimal(10,2) if @countnum_9 <>'' set @countnum_10 = convert(decimal(10,2),@countnum_9) 
  else set  @countnum_10 = 0  

INSERT INTO HrmScheduleDiff 
( diffname, 
  diffdesc, 
  difftype, 
  difftime, 
  mindifftime, 
  workflowid, 
  salaryable, 
  counttype, 
  countnum,  
  salaryitem, 
  diffremark,
  color)  
VALUES 
( @diffname_1, 
  @diffdesc_2, 
  @difftype_3, 
  @difftime_4, 
  @mindifftime_5, 
  @workflowid_6, 
  @salaryable_7, 
  @counttype_8, 
  @countnum_10,   /* ע�⣬ ������ countnum_9 ����� countnum_10 */
  @salaryitem_11, 
  @diffremark_12,
  @color_13) 
select max(id) from HrmScheduleDiff 
GO

alter PROCEDURE HrmScheduleDiff_Update 
 (@id_1 	int, 
  @diffname_2 	varchar(60), 
  @diffdesc_3 	varchar(200), 
  @difftype_4 	char(1), 
  @difftime_5 	char(1), 
  @mindifftime_6 	smallint, 
  @workflowid_7 	int, 
  @salaryable_8 	char(1), 
  @counttype_9 	char(1), 
  @countnum_11      varchar(10), 
  @salaryitem_12 	int, 
  @diffremark_13 	text, 
  @color_14 varchar(30),
  @flag integer output, @msg varchar(80) output) 
AS declare  @countnum_10 decimal(10,2) if @countnum_11 <>'' set @countnum_10 = convert(decimal(10,2),@countnum_11) 
  else set  @countnum_10 = 0  
UPDATE HrmScheduleDiff  SET  
  diffname	 = @diffname_2, 
  diffdesc	 = @diffdesc_3, 
  difftype	 = @difftype_4, 
  difftime	 = @difftime_5, 
  mindifftime	 = @mindifftime_6, 
  workflowid	 = @workflowid_7, 
  salaryable	 = @salaryable_8, 
  counttype	 = @counttype_9, 
  countnum	 = @countnum_10, 
  salaryitem	 = @salaryitem_12, 
  diffremark	 = @diffremark_13,
  color = @color_14
WHERE 
( id	 = @id_1)  
GO



insert into SystemRights (id,rightdesc,righttype) values (399,'�Ű�ά��','3') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3088,'�Ű�ά��','HrmArrangeShiftMaintance:Maintance',399) 
GO

insert into SystemRightToGroup (groupid,rightid) values (3,399)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (399,4,'1')
GO


insert into SystemRights (id,rightdesc,righttype) values (400,'�Ű�����ά��','3') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3089,'�Ű�����ά��','HrmArrangeShift:Maintance',400) 
GO

insert into SystemRightToGroup (groupid,rightid) values (3,400)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (400,4,'1')
GO


insert into SystemRights (id,rightdesc,righttype) values (401,'����ϵͳ����','3') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3090,'����ϵͳ����','HrmkqSystemSetEdit:Edit',401) 
GO

insert into SystemRightToGroup (groupid,rightid) values (3,401)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (401,4,'1')
GO

insert into SystemRights (id,rightdesc,righttype) values (402,'���û��ӿ�ά��','3') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3091,'���û��ӿ�ά��','HrmTimecardUser:Maintenance',402) 
GO
insert into SystemRightToGroup (groupid,rightid) values (3,402)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (402,4,'1')
GO

insert into SystemRights (id,rightdesc,righttype) values (403,'������ƫ��ά��','3') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3092,'������ƫ��ά��','HrmWorktimeWarp:Maintenance',403) 
GO

insert into SystemRightToGroup (groupid,rightid) values (3,403)
GO

insert into SystemRightRoles (rightid,roleid,rolelevel) values (403,4,'1')
GO

alter PROCEDURE HrmSalaryItem_Update
	(@id_1 	int,
	 @itemname_2 	varchar(50),
	 @itemcode_3 	varchar(50),
	 @itemtype_4 	char(1),
	 @personwelfarerate_5 	int,
	 @companywelfarerate_6 	int,
	 @taxrelateitem_7 	int,
	 @amountecp_8 	varchar(200),
	 @feetype_9 	int,
	 @isshow_10 	char(1),
	 @showorder_11 	int,
	 @ishistory_12 	char(1) ,
     @flag          integer output, 
     @msg           varchar(80) output)

AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int

select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 
UPDATE HrmSalaryItem 
SET  itemname	 = @itemname_2,
	 itemcode	 = @itemcode_3,
	 itemtype	 = @itemtype_4,
	 personwelfarerate	 = @personwelfarerate_5,
	 companywelfarerate	 = @companywelfarerate_6,
	 taxrelateitem	 = @taxrelateitem_7,
	 amountecp	 = @amountecp_8,
	 feetype	 = @feetype_9,
	 isshow	 = @isshow_10,
	 showorder	 = @showorder_11,
	 ishistory	 = @ishistory_12 

WHERE 
	( id	 = @id_1)

if @olditemtype_1 = '1' 
begin
    delete from HrmSalaryRank where itemid = @id_1 
    delete from HrmSalaryResourcePay where itemid = @id_1 
end
else if @olditemtype_1 = '2'
begin
    delete from HrmSalaryRank where itemid = @id_1
    delete from HrmSalaryWelfarerate where itemid = @id_1
    delete from HrmSalaryResourcePay where itemid = @id_1
end
else if @olditemtype_1 = '5' or @olditemtype_1 = '6'
    delete from HrmSalarySchedule where itemid = @id_1
else if @olditemtype_1 = '7'
    delete from HrmSalaryShiftPay where itemid = @id_1
else if @olditemtype_1 = '8'
    delete from HrmSalaryResourcePay where itemid = @id_1
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO

alter PROCEDURE HrmSalaryItem_Delete
	(@id_1 	int ,
     @flag          integer output, 
     @msg           varchar(80) output)
AS 
declare @olditemtype_1 char(1) 
declare @benchid_1 int
select @olditemtype_1 = itemtype from HrmSalaryItem where id = @id_1 

DELETE HrmSalaryItem 
WHERE ( id	 = @id_1)

if @olditemtype_1 = '1'
begin
    delete from HrmSalaryRank where itemid = @id_1 
    delete from HrmSalaryResourcePay where itemid = @id_1 
end
else if @olditemtype_1 = '5' or @olditemtype_1 = '6'
    delete from HrmSalarySchedule where itemid = @id_1
else if @olditemtype_1 = '7'
    delete from HrmSalaryShiftPay where itemid = @id_1
else if @olditemtype_1 = '8'
    delete from HrmSalaryResourcePay where itemid = @id_1
else if @olditemtype_1 = '2'
begin
    delete from HrmSalaryRank where itemid = @id_1 
    delete from HrmSalaryWelfarerate where itemid = @id_1 
    delete from HrmSalaryResourcePay where itemid = @id_1
end
else if @olditemtype_1 = '3'
begin
    declare benchid_cursor cursor for
    select id from HrmSalaryTaxbench where itemid = @id_1 
    open benchid_cursor 
    fetch next from benchid_cursor into @benchid_1
    while @@fetch_status=0
    begin 
        delete from HrmSalaryTaxrate where benchid = @benchid_1
        delete from HrmSalaryTaxbench where id = @benchid_1
        fetch next from benchid_cursor into @benchid_1
    end
    close benchid_cursor deallocate benchid_cursor
end
GO


alter table  HrmSalaryWelfarerate alter column personwelfarerate   decimal(10,2) 
GO

alter table  HrmSalaryWelfarerate alter column companywelfarerate  decimal(10,2) 
GO


alter PROCEDURE HrmSalaryWelfarerate_Insert
    (@itemid_1 	int,
     @cityid_2 	int,
     @personwelfarerate_3 	decimal(10,2),
     @companywelfarerate_4 	decimal(10,2),
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryWelfarerate 
	 ( itemid,
	 cityid,
	 personwelfarerate,
	 companywelfarerate) 
 
VALUES 
	( @itemid_1,
	 @cityid_2,
	 @personwelfarerate_3,
	 @companywelfarerate_4)
GO

alter table HrmkqSystemSet add 
salaryenddate int   /* н�ʼ���������ڣ��������죩 */
GO

update HrmkqSystemSet set salaryenddate=31 
GO

alter PROCEDURE HrmkqSystemSet_Update(
@tosomeone_1  varchar(60) ,
@timeinterval_2  int , 
@getdatatype_3  int , 
@getdatavalue_4  varchar(200) , 
@avgworkhour_5  int , 
@salaryenddate_6  int , 
@flag int output, 
@msg varchar(80) output) 
AS 
update HrmkqSystemSet 
set 
tosomeone = @tosomeone_1 , 
timeinterval = @timeinterval_2 ,
getdatatype = @getdatatype_3 , 
getdatavalue = @getdatavalue_4 , 
avgworkhour = @avgworkhour_5 , 
salaryenddate = @salaryenddate_6  
GO

alter table HrmSalaryRank add jobactivityid int /*���ʺ͸�����Ŀѡ�����ְ��ѡ��*/
GO 

alter PROCEDURE HrmSalaryRank_Insert
	(@itemid_1 	int,
	 @jobid_2 	int,
	 @joblevelfrom_3 	int,
	 @joblevelto_4 	int,
	 @amount_5 	decimal(10,2),
     @jobactivityid_6 	int,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryRank 
	 ( itemid,
	 jobid,
	 joblevelfrom,
	 joblevelto,
	 amount,
     jobactivityid) 
 
VALUES 
	( @itemid_1,
	 @jobid_2,
	 @joblevelfrom_3,
	 @joblevelto_4,
	 @amount_5,
     @jobactivityid_6)
GO

alter PROCEDURE HrmTimecardInfo_Update
	(@resourceid_1 	int,
	 @timecarddate_3 	char(10),
	 @intime_4 	char(5),
	 @outtime_5 	char(5),
     @relateshiftid_6  int ,
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @reccount int
select @reccount = count(resourceid) from HrmTimecardinfo where resourceid = @resourceid_1 and timecarddate = @timecarddate_3

if @reccount = 0 
    insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
    values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
else if @intime_4 = '' 
    update HrmTimecardinfo set outtime = @outtime_5 where resourceid = @resourceid_1 and timecarddate = @timecarddate_3
else if @outtime_5 = ''
    update HrmTimecardinfo set intime = @intime_4 where resourceid = @resourceid_1 and timecarddate = @timecarddate_3
else 
    update HrmTimecardinfo set intime = @intime_4 , outtime = @outtime_5 where resourceid = @resourceid_1 and timecarddate = @timecarddate_3
GO


alter PROCEDURE HrmRightCardInfo_Insert (   
@resourceid_2 int , /*���ӵ�̨��*/
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@cardtime_4 char(5) , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
@inorout_5  int ,           /*����˾�����빫˾ 0:�� 1:�� ������ʱ���� */
@flag        integer output ,
@msg         varchar(80) output)  

 AS
 declare @cardcount int , @reccount int 
 select @cardcount = count(id) from HrmRightCardInfo where carddate = @carddate_3 and resourceid = @resourceid_2 and cardtime = @cardtime_4 
 if @cardcount = 0
 begin      /* ֻ�в���ͬ�Ĵ򿨲�¼�� ��ʼ*/
 
     INSERT INTO HrmRightCardInfo (
         resourceid , 
         carddate , 
         cardtime , 
         inorout ,
         islegal ,
         workout 
     ) 
     VALUES (
         @resourceid_2 , 
         @carddate_3 , 
         @cardtime_4 , 
         @inorout_5 ,
         0 ,
         0
     ) 
 end   /* ֻ�в���ͬ�Ĵ򿨲�¼�� ����*/
GO

/* �޸�ɾ����Ч�򿨼���, ����ת��Ӱ���ж� */
alter PROCEDURE HrmRightCardInfo_Delete (
@id_1 int ,
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 declare @resourceid_2 int , @carddate_3 char(10) 
 select @resourceid_2 = resourceid , @carddate_3 = carddate from HrmRightCardInfo where id = @id_1
 delete HrmRightCardInfo where id = @id_1
 update HrmRightCardInfo set islegal = 0 where carddate = @carddate_3 and resourceid = @resourceid_2 
 select @resourceid_2, @carddate_3
GO

/* ת��Ӱ����Ч�򿨼���, ����ת��Ӱ���ж� */
alter PROCEDURE HrmRightCardInfo_AddWork (
@id_1 int ,
@flag        integer output ,
@msg         varchar(80) output)  

 AS

 declare @resourceid_2 int , @carddate_3 char(10) 
 select @resourceid_2 = resourceid , @carddate_3 = carddate from HrmRightCardInfo where id = @id_1
 update HrmRightCardInfo set workout = 2 where id = @id_1
 update HrmRightCardInfo set islegal = 0 where carddate = @carddate_3 and resourceid = @resourceid_2 
 select @resourceid_2, @carddate_3
GO



update HrmRightCardInfo set islegal = 0 
GO

delete HrmTimecardinfo 
GO

INSERT INTO HtmlLabelIndex values(17091,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17091,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17091,'Now',8) 
GO


create table HrmSalaryCreateInfo (
id int identity(1,1) primary key not null,
currentdate char(7),            /* ��Ҫ�������ʵ��·� */
salarybegindate char(10) ,      /* ���¿�ʼ������ */
salaryenddate char(10) ,      /* ���½��������� */
payid varchar(6) ,              /* ���ʵ�id ,�����һ������, payid Ϊ 0 ,����Ϊԭ���� payid */
plandate char(10) ,             /* �ƻ��������� */
hasdone  char(1) default '0'    /* �Ƿ��Ѿ����� */
)
GO

CREATE PROCEDURE HrmSalaryCreateInfo_Insert
	(@currentdate_1 	char(7),
	 @salarybegindate_2 	char(10),
	 @salaryenddate_3 	char(10),
	 @payid_4 	varchar(6),
	 @plandate_5 	char(10),
	 @flag int output, 
     @msg varchar(60) output)

AS INSERT INTO HrmSalaryCreateInfo 
	 ( currentdate,
	 salarybegindate,
	 salaryenddate,
	 payid,
	 plandate) 
 
VALUES 
	( @currentdate_1,
	 @salarybegindate_2,
	 @salaryenddate_3,
	 @payid_4,
	 @plandate_5)
GO



CREATE PROCEDURE HrmSalaryCreateInfo_Delete
	(@id_1 	int,
	 @flag int output, 
     @msg varchar(60) output)

AS DELETE HrmSalaryCreateInfo 

WHERE 
	( id	 = @id_1)
GO


CREATE PROCEDURE HrmSalaryCreateInfo_Select
	(@hasdone_1 	char(1),
	 @flag int output, 
     @msg varchar(60) output)

AS 

select * from HrmSalaryCreateInfo where hasdone = @hasdone_1
GO

alter PROCEDURE HrmTimecardInfo_Update
	(@resourceid_1 	int,
	 @timecarddate_3 	char(10),
	 @intime_4 	char(5),
	 @outtime_5 	char(5),
     @relateshiftid_6  int ,
     @cardtimetype int ,  /* 1: �������� 2: �������� 0: ���� */
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @reccount int 

select @reccount = count(resourceid) from HrmTimecardinfo 
where resourceid = @resourceid_1 and timecarddate = @timecarddate_3 and relateshiftid = @relateshiftid_6

if @cardtimetype = 0 
begin
    if @reccount = 0 
        insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
        values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
    else if @relateshiftid_6 = -1  
    begin
        select @reccount = count(resourceid) from HrmTimecardinfo 
        where resourceid = @resourceid_1 and timecarddate = @timecarddate_3 and intime = @intime_4 and outtime = @outtime_5
        if @reccount = 0 
            insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
            values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
    end 
end
else if @cardtimetype = 1  
begin
    if @reccount = 0 
        insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
        values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
    else 
        update HrmTimecardinfo set outtime = @outtime_5 where resourceid = @resourceid_1 and timecarddate = @timecarddate_3 and relateshiftid = @relateshiftid_6 
end
else if @cardtimetype = 2  
begin
    if @reccount = 0 
        insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime,relateshiftid) 
        values(@resourceid_1,@timecarddate_3,@intime_4 , @outtime_5 ,@relateshiftid_6)
    else 
        update HrmTimecardinfo set intime = @intime_4 where resourceid = @resourceid_1 and timecarddate = @timecarddate_3 and relateshiftid = @relateshiftid_6 
end
GO

INSERT INTO HtmlLabelIndex values(17092,'�ƻ�ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(17092,'�ƻ�ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17092,'Plan time',8) 
GO