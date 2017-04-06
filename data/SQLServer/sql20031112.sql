alter table HrmSchedule add 
validedatefrom char(10),
validedateto char(10)
GO

CREATE TABLE HrmArrangeShift (
	id int IDENTITY (1, 1) NOT NULL ,
	shiftname varchar (60)  NULL ,
    shiftbegintime char (5)  NULL ,
    shiftendtime char (5)  NULL ,	
    validedatefrom char (10)  NULL ,
    validedateto   char (10)  NULL,
    ishistory  char(1) default '0'
)
GO


CREATE TABLE HrmArrangeShiftInfo (                  
	id int IDENTITY (1, 1) NOT NULL ,
	resourceid int ,
    shiftdate char (10) ,
    shiftid int	
)
GO

CREATE TABLE HrmArrangeShifttype (
	resourceid int IDENTITY (1, 1) NOT NULL ,
	currentdate char (10)  NULL ,
    shifttypeid int null
)
GO


create table HrmTimecardUser ( 
resourceid int primary key ,
usercode varchar(60),
)
GO

/* ����Ϣ��*/
create table HrmTimecardInfo ( 
resourceid int ,
timecarddate char(10) ,
intime char(5) ,
outtime char(5)
)
GO


/*�������ڱ�*/
create table HrmSalarySchedule(
id	int IDENTITY (1, 1) NOT NULL  primary key,
itemid  int ,                           /*������Ŀid*/
diffid  int                            /*��������id*/
)
GO



/*����ʱ��ƫ������*/
create table HrmWorkTimeWarp(
 id int identity(1,1) not null primary key,
 diffid int ,               /*��ؿ���*/
 resourceid int ,
 diffdate char(10) ,        /*��������*/
 difftype  char(1) ,        /*�������� 0������ 1������*/
 intime char(5) ,           /*�빫˾ʱ��*/
 outtime char(5) ,          /*����˾ʱ��*/
 theintime  char(5) ,           /*Ӧ���빫˾ʱ��*/
 theouttime char(5) ,           /*Ӧ�ó���˾ʱ��*/
 counttime int default 0,    /*ʵ�ʼ���ʱ��(����)*/
 diffcounttime int default 0)    /*���ڼ���ʱ��(����)*/
GO

/* �Կ��ڼ�¼������ʵ�ʼ���ʱ��Ϳ��������ֶ� */
alter table HrmScheduleMaintance add realdifftime int default 0, realcarddifftime int default 0, difftype char(1)
GO

update HrmScheduleMaintance set realdifftime = 0 , realcarddifftime = 0
GO

/* Ա������ͳ�Ʊ� */
create table HrmWorkTimeCount (
id int identity(1,1) not null primary key,
resourceid int ,                /* ������Դ */
workdate char(7) ,              /* ͳ���·� �� 2003-07 */
shiftid int,                    /* ����ʱ������ , 0: һ�㹤��ʱ�� ,���� : �Ű�����id */
workcount int                   /* ���ڴ��� ����ֻҪ��һ�δ�,Ҳ��Ϊһ�γ���*/
)
GO


/* ������Դ������Ŀ�������ڽ�����Ϣ�� */
create table HrmSalaryShiftPay(
id	int IDENTITY (1, 1) NOT NULL  primary key,
itemid  int ,                           /*������Ŀid*/
shiftid  int ,                          /*��������id 0:һ�㹤��ʱ�� ����:�Ű�����id*/
shiftpay  decimal(10,2)                 /*��������id 0:һ�㹤��ʱ�� ����:�Ű�����id*/
)
GO


/* ������Դ������Ŀ�������ڼ�����Ϣ��ϸ */
create table HrmSalaryDiffDetail (
itemid  int ,                               /* ����������Ŀ */
resourceid  int ,                           /* ����������Դ */
payid  int ,                                /* �������ʵ� id */
diffid int ,                                /* �����Ŀ��� id */
difftypeid  int ,                           /* ������������id */ 
startdate  char(10) ,                        /* �������ڿ�ʼ���� */ 
enddate  char(10) ,                        /* �������ڿ�ʼ���� */ 
realcounttime int  ,                        /* ʵ�ʼ���ʱ�� */
realcountpay decimal(10,2)                  /* ʵ�ʼ��㹤�� */
)
GO


create NONCLUSTERED INDEX HrmSalaryDiffDetail_in on HrmSalaryDiffDetail(payid , resourceid , itemid)
GO



update HtmlLabelInfo set labelname = 'ע�⣺ ����ֻ��ΪӢ����ĸ�Ͱ�������ֵ��������ĸ��ͷ��Ӣ����ĸ��Сд���У�' where indexid = 15830 and languageid = 7   
GO




/*�򿨻���Ϣ��*/
/*Create by Wangxiaoyi 2003-10-30*/
CREATE TABLE HrmCardInfo (
	id int identity(1,1) not null primary key ,
    stationid char(2) null, /*���ӵ�̨��*/
    carddate char(10) null , /*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
    cardtime char(5) null ,  /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
    workshift  char(1) null , /*����,��������16�����飬��0~9,A~F*/
    Cardid   char(10) null  /*����*/
    /*islegal char(1) default '1', �Ƿ��ǺϷ��Ŀ���Ĭ��Ϊ1(�Ϸ�����������������֮�ã�*/
)
GO


/*��Ч�򿨻���Ϣ��*/
CREATE TABLE HrmValidateCardInfo (
	id int identity(1,1) not null primary key ,
    stationid char(2) null, /*���ӵ�̨��*/
    carddate char(10) null , /*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
    cardtime char(5) null ,  /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
    workshift  char(1) null , /*����,��������16�����飬��0~9,A~F*/
    Cardid   char(10) null  /*����*/
    /*islegal char(1) default '1', �Ƿ��ǺϷ��Ŀ���Ĭ��Ϊ1(�Ϸ�����������������֮�ã�*/
)
GO


alter PROCEDURE HrmSchedule_Select_Default 
 (@id_1 int ,
 @flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select * from HrmSchedule where id = @id_1
GO


create PROCEDURE HrmSchedule_SelectAll
(@flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select id , validedatefrom ,validedateto from HrmSchedule order by validedatefrom desc 
GO


alter PROCEDURE HrmSchedule_Update 
 (@id_1 	int, 
  @monstarttime1_3 	char(5), 
  @monendtime1_4 	char(5), 
  @monstarttime2_5 	char(5), 
  @monendtime2_6 	char(5), 
  @tuestarttime1_7 	char(5), 
  @tueendtime1_8 	char(5), 
  @tuestarttime2_9 	char(5), 
  @tueendtime2_10 	char(5), 
  @wedstarttime1_11 	char(5), 
  @wedendtime1_12 	char(5), 
  @wedstarttime2_13 	char(5), 
  @wedendtime2_14 	char(5), 
  @thustarttime1_15 	char(5), 
  @thuendtime1_16 	char(5), 
  @thustarttime2_17 	char(5), 
  @thuendtime2_18 	char(5), 
  @fristarttime1_19 	char(5), 
  @friendtime1_20 	char(5), 
  @fristarttime2_21 	char(5), 
  @friendtime2_22 	char(5), 
  @satstarttime1_23 	char(5), 
  @satendtime1_24 	char(5), 
  @satstarttime2_25 	char(5), 
  @satendtime2_26 	char(5), 
  @sunstarttime1_27 	char(5), 
  @sunendtime1_28 	char(5), 
  @sunstarttime2_29 	char(5), 
  @sunendtime2_30 	char(5), 
  @totaltime_31    char(5), 
  @validedatefrom_32 	char(10), 
  @validedateto_33 	char(10), 
  @flag        integer output, 
  @msg         varchar(80) output) 
AS 
UPDATE HrmSchedule  
SET  
monstarttime1= @monstarttime1_3, 
monendtime1	 = @monendtime1_4, 
monstarttime2= @monstarttime2_5, 
monendtime2	 = @monendtime2_6, 
tuestarttime1= @tuestarttime1_7, 
tueendtime1	 = @tueendtime1_8, 
tuestarttime2= @tuestarttime2_9, 
tueendtime2	 = @tueendtime2_10,
wedstarttime1= @wedstarttime1_11, 
wedendtime1	 = @wedendtime1_12, 
wedstarttime2= @wedstarttime2_13, 
wedendtime2	 = @wedendtime2_14, 
thustarttime1= @thustarttime1_15, 
thuendtime1	 = @thuendtime1_16, 
thustarttime2= @thustarttime2_17, 
thuendtime2	 = @thuendtime2_18,
fristarttime1= @fristarttime1_19, 
friendtime1	 = @friendtime1_20, 
fristarttime2= @fristarttime2_21, 
friendtime2	 = @friendtime2_22, 
satstarttime1= @satstarttime1_23, 
satendtime1	 = @satendtime1_24, 
satstarttime2= @satstarttime2_25, 
satendtime2	 = @satendtime2_26, 
sunstarttime1= @sunstarttime1_27, 
sunendtime1	 = @sunendtime1_28, 
sunstarttime2= @sunstarttime2_29, 
sunendtime2	 = @sunendtime2_30, 
totaltime    = @totaltime_31, 
validedatefrom= @validedatefrom_32,  
validedateto= @validedateto_33  
WHERE ( id	 = @id_1)   
GO

alter PROCEDURE HrmSchedule_Insert 
 (@monstarttime1_2 	char(5), 
 @monendtime1_3 	char(5), 
 @monstarttime2_4 	char(5), 
 @monendtime2_5 	char(5), 
 @tuestarttime1_6 	char(5), 
 @tueendtime1_7 	char(5), 
 @tuestarttime2_8 	char(5), 
 @tueendtime2_9 	char(5), 
 @wedstarttime1_10 	char(5), 
 @wedendtime1_11 	char(5), 
 @wedstarttime2_12 	char(5), 
 @wedendtime2_13 	char(5), 
 @thustarttime1_14 	char(5), 
 @thuendtime1_15 	char(5), 
 @thustarttime2_16 	char(5),
 @thuendtime2_17 	char(5), 
 @fristarttime1_18 	char(5), 
 @friendtime1_19 	char(5), 
 @fristarttime2_20 	char(5), 
 @friendtime2_21 	char(5), 
 @satstarttime1_22 	char(5), 
 @satendtime1_23 	char(5), 
 @satstarttime2_24 	char(5), 
 @satendtime2_25 	char(5), 
 @sunstarttime1_26 	char(5), 
 @sunendtime1_27 	char(5), 
 @sunstarttime2_28 	char(5), 
 @sunendtime2_29 	char(5), 
 @totaltime_30    char(5), 
 @validedatefrom_31 	char(10), 
 @validedateto_32 	char(10),
 @flag    integer output, 
 @msg    varchar(80) output)  
AS 
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
            @monstarttime1_2, 
            @monendtime1_3, 
            @monstarttime2_4, 
            @monendtime2_5, 
            @tuestarttime1_6, 
            @tueendtime1_7, 
            @tuestarttime2_8, 
            @tueendtime2_9, 
            @wedstarttime1_10, 
            @wedendtime1_11, 
            @wedstarttime2_12, 
            @wedendtime2_13, 
            @thustarttime1_14, 
            @thuendtime1_15, 
            @thustarttime2_16, 
            @thuendtime2_17, 
            @fristarttime1_18, 
            @friendtime1_19, 
            @fristarttime2_20, 
            @friendtime2_21, 
            @satstarttime1_22, 
            @satendtime1_23, 
            @satstarttime2_24, 
            @satendtime2_25, 
            @sunstarttime1_26, 
            @sunendtime1_27,
            @sunstarttime2_28, 
            @sunendtime2_29, 
            @totaltime_30, 
            @validedatefrom_31,
            @validedateto_32)  
select max(id) from HrmSchedule 
GO

create PROCEDURE HrmArrangeShift_SelectAll
(@ishistory_1 char(1),
 @flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select id , shiftname , shiftbegintime, shiftendtime from HrmArrangeShift where ishistory = @ishistory_1 order by id
GO

create PROCEDURE HrmArrangeShift_UHistory (
 @id_1 	int,
 @validedatefrom_5 char(10),
 @flag        integer output,
 @msg         varchar(80) output) 
 AS 
 UPDATE HrmArrangeShift
 SET  validedateto = @validedatefrom_5,
      ishistory = '1' 
     WHERE ( id	 = @id_1)   
go

CREATE PROCEDURE HrmArrangeShift_Insert (
 @shiftname_2 	 varchar(60),
 @shiftbegintime_3 char(5),
 @shiftendtime_4 char(5),
 @validedatefrom_5  char(10),
 @validedateto_6 char(10),
 @flag        integer output,
 @msg         varchar(80) output)  
  AS 
  INSERT INTO HrmArrangeShift (
 shiftname ,	
 shiftbegintime,
 shiftendtime,
 validedatefrom,
 validedateto)
VALUES (
 @shiftname_2,
 @shiftbegintime_3,
 @shiftendtime_4,
 @validedatefrom_5,
 @validedateto_6)
 select max(id) from HrmArrangeShift  
GO

create PROCEDURE HrmArrangeShift_Update (
 @id_1 	int,
 @shiftname_2 	 varchar(60),
 @shiftbegintime_3 char(5),
 @shiftendtime_4   char(5),
 @validedatefrom_5  char(10),
 @flag        integer output,
 @msg         varchar(80) output) 
 AS 
 UPDATE HrmArrangeShift
 SET  shiftname = @shiftname_2,
      shiftbegintime = @shiftbegintime_3,
      shiftendtime = @shiftendtime_4 ,
      validedatefrom = @validedatefrom_5 
     WHERE ( id	 = @id_1)   
go

 
CREATE PROCEDURE HrmArrangeShift_Delete 
 (@id_1 	int,
 @flag        integer output,
 @msg         varchar(80) output)
 AS DELETE HrmArrangeShift 
 WHERE ( id	 = @id_1)   
GO

create PROCEDURE HrmArrangeShift_Select_Default 
 (@id_1 int ,
 @flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select * from HrmArrangeShift where id = @id_1
GO

create PROCEDURE HrmArrangeShift_SelectById
(@flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select id , shiftname , shiftbegintime, shiftendtime,validedatefrom,validedateto 
 from HrmArrangeShift where ishistory='0' order by id desc 
GO

create PROCEDURE HrmArrangeShift_Updatehistory (
 @id_1 	int,
 @shiftname_2 	 varchar(60),
 @shiftbegintime_3 char(5),
 @shiftendtime_4   char(5),
 @validedatefrom_5 char(10),
 @validedateto_6   char(10),
 @flag        integer output,
 @msg         varchar(80) output) 
 AS 
 UPDATE HrmArrangeShift
 SET  shiftname = @shiftname_2,
      shiftbegintime = @shiftbegintime_3,
      shiftendtime = @shiftendtime_4,
      validedatefrom = @validedatefrom_5 ,
      validedateto = '9999-12-31' 
     WHERE ( id	 = @id_1)   
    go


 CREATE PROCEDURE HrmSalaryScheduleDec_Insert(
 @diffid_1 int ,	
 @itemid_2 char (1) ,
 @flag	int	output, 
 @msg	varchar(80)	output) 
 AS INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 @diffid_1 , @itemid_2)
 set @flag = 1 set @msg = 'OK!' 

GO

CREATE PROCEDURE HrmSalaryScheduleAdd_Insert(
 @diffid_1 int ,	
 @itemid_2 char (1) ,
 @flag	int	output, 
 @msg	varchar(80)	output) 
 AS INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 @diffid_1 , @itemid_2)
 set @flag = 1 set @msg = 'OK!' 

GO

CREATE PROCEDURE HrmArrangeShiftInfo_Insert(
 @resourceid_1 int ,
 @shiftdate_2 char (10) ,
 @shiftid_3 int	,
 @flag        integer output ,
 @msg         varchar(80) output)  
  AS 
  INSERT INTO HrmArrangeShiftInfo (
 resourceid ,	
 shiftdate,
 shiftid)
VALUES (
 @resourceid_1,
 @shiftdate_2,
 @shiftid_3)
 select max(id) from HrmArrangeShiftInfo
 GO

create PROCEDURE HrmArrangeShiftInfo_Save (
 @resourceid_2 int ,
 @shiftdate_3 char (10) ,
 @shiftid_4 int	,
 @flag        integer output,
 @msg         varchar(80) output)  
 AS 
 declare @count int
 select @count = count(shiftid) from HrmArrangeShiftInfo 
 where  resourceid=@resourceid_2 and shiftdate = @shiftdate_3
 if @count is null or @count = 0
    INSERT INTO HrmArrangeShiftInfo(resourceid,shiftdate,shiftid) 
    VALUES(@resourceid_2,@shiftdate_3, @shiftid_4)
 else
    UPDATE HrmArrangeShiftInfo 
    SET  shiftid = @shiftid_4 
    where  resourceid=@resourceid_2 and shiftdate = @shiftdate_3 
go


create PROCEDURE HrmArrangeShiftProcess_Save (
 @resourceid_2 int ,
 @shiftdate_3 char (10) ,
 @shiftid_4 int	,
 @flag        integer output,
 @msg         varchar(80) output)  
 AS 
 declare @count int
 select @count = count(shiftid) from HrmArrangeShiftInfo 
 where  resourceid=@resourceid_2 and shiftdate = @shiftdate_3
 if @count is null or @count = 0
    INSERT INTO HrmArrangeShiftInfo(resourceid,shiftdate,shiftid) 
    VALUES(@resourceid_2,@shiftdate_3, @shiftid_4)
 else
    UPDATE HrmArrangeShiftInfo 
    SET  shiftid = @shiftid_4 
    where  resourceid=@resourceid_2 and shiftdate = @shiftdate_3 
go


/*���ӿ��ڿۿ�Ϳۿ��н֮��༭�����Ĵ洢����*/
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
create NONCLUSTERED INDEX HrmTimecardInfo_in on HrmTimecardInfo(resourceid , timecarddate)
GO

CREATE PROCEDURE HrmTimecardUser_Update
	(@resourceid_1 	int,
	 @usercode_2 	varchar(60),
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @count int

select @count= count(usercode) from HrmTimecardUser 
where resourceid != @resourceid_1 and usercode = @usercode_2
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

CREATE PROCEDURE HrmTimecardInfo_Update
	(@resourceid_1 	int,
	 @timecarddate_3 	char(10),
	 @intime_4 	char(5),
	 @outtime_5 	char(5),
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @count int
select @count= count(resourceid) from HrmTimecardInfo 
where resourceid = @resourceid_1 and timecarddate = @timecarddate_3

if @count is not null and @count > 0 
    UPDATE HrmTimecardInfo 
    SET  intime	 = @intime_4,
         outtime	 = @outtime_5 
    WHERE 
        ( resourceid	 = @resourceid_1 and
         timecarddate	 = @timecarddate_3)
else
    insert into HrmTimecardinfo(resourceid,timecarddate,intime,outtime) 
    values(@resourceid_1,@timecarddate_3,@intime_4,@outtime_5 )
GO


create PROCEDURE HrmSchedule_Select_Current 
 (@currentdate_1 varchar(10) ,
 @flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select * from HrmSchedule where validedatefrom <= @currentdate_1 and validedateto >= @currentdate_1
GO


create PROCEDURE HrmArrangeShift_Select
(@flag integer output, 
 @msg varchar(80) output ) 
 AS 
 select id , shiftbegintime, shiftendtime from HrmArrangeShift order by id
GO



CREATE PROCEDURE HrmWorkTimeWarp_Insert
	(@diffid_1 	int,
	 @resourceid_2 	int,
	 @diffdate_3 	char(10),
	 @difftype_4 	char(1),
	 @intime_5 	char(5),
	 @outtime_6 	char(5),
	 @theintime_7 	char(5),
	 @theouttime_8 	char(5),
	 @counttime_9 	int,
     @diffcounttime_10 	int,
     @flag integer output, 
     @msg varchar(80) output ) 

AS INSERT INTO HrmWorkTimeWarp 
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
	( @diffid_1,
	 @resourceid_2,
	 @diffdate_3,
	 @difftype_4,
	 @intime_5,
	 @outtime_6,
	 @theintime_7,
	 @theouttime_8,
	 @counttime_9,
     @diffcounttime_10)
GO


create PROCEDURE HrmScheduleMaintance_UStype
as
declare @diffid_1 int , @difftype_2 char(1) 
update HrmScheduleMaintance set difftype = 'A' 

declare diffid_cursor cursor for 
select id , difftype from HrmScheduleDiff 
open diffid_cursor 
fetch next from diffid_cursor into @diffid_1 , @difftype_2
while @@fetch_status=0 
begin 
    update HrmScheduleMaintance set difftype = @difftype_2 where diffid = @diffid_1  
    fetch next from diffid_cursor into @diffid_1 , @difftype_2
end 
close diffid_cursor 
deallocate diffid_cursor
GO

exec HrmScheduleMaintance_UStype
GO

drop PROCEDURE HrmScheduleMaintance_UStype
GO






alter PROCEDURE HrmScheduleMain_Insert
	(@diffid_1 	int,
	 @resourceid_2 	int,
	 @startdate_3 	char(10),
	 @starttime_4 	char(8),
	 @enddate_5 	char(10),
	 @endtime_6 	char(8),
	 @memo_7 	text,
	 @createtype_8 	int,
	 @createrid_9 	int,
	 @createdate_10 	char(10),
     @realdifftime_11  int ,
     @difftype_12 char(1),
	 @flag int output, @msg varchar(60) output)

AS INSERT INTO HrmScheduleMaintance 
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
	( @diffid_1,
	 @resourceid_2,
	 @startdate_3,
	 @starttime_4,
	 @enddate_5,
	 @endtime_6,
	 @memo_7,
	 @createtype_8,
	 @createrid_9,
	 @createdate_10,
     @realdifftime_11,
     @difftype_12)
select max(id) from HrmScheduleMaintance
GO


alter PROCEDURE HrmScheduleMain_Update
	(@id_1 	int,
	 @diffid_2 	int,
	 @resourceid_3 	int,
	 @startdate_4 	char(10),
	 @starttime_5 	char(8),
	 @enddate_6 	char(10),
	 @endtime_7 	char(8),
	 @memo_8 	text,
     @realdifftime_11  int ,
     @difftype_12 char(1),
	 @flag int output, @msg varchar(60) output)
AS UPDATE HrmScheduleMaintance SET  
         diffid	 = @diffid_2,
	 resourceid	 = @resourceid_3,
	 startdate	 = @startdate_4,
	 starttime	 = @starttime_5,
	 enddate	 = @enddate_6,
	 endtime	 = @endtime_7,
	 memo        = @memo_8 ,
     realdifftime = @realdifftime_11 ,
     difftype    = @difftype_12 
WHERE 
	( id	 = @id_1)
go





alter PROCEDURE HrmSalaryScheduleDec_Insert(
 @itemid_2 int ,
 @diffid_1 int ,	
 @flag	int	output, 
 @msg	varchar(80)	output) 
 AS INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 @diffid_1 , @itemid_2)
 set @flag = 1 set @msg = 'OK!' 

GO

alter PROCEDURE HrmSalaryScheduleAdd_Insert(
 @itemid_2 int ,
 @diffid_1 int ,	
 @flag	int	output, 
 @msg	varchar(80)	output) 
 AS INSERT INTO HrmSalarySchedule(
 diffid , itemid)  
 VALUES(
 @diffid_1 , @itemid_2)
 set @flag = 1 set @msg = 'OK!' 

GO


CREATE PROCEDURE HrmWorkTimeCount_Insert
	(@resourceid_1 	int,
	 @workdate_2 	char(7),
	 @shiftid_3 	int,
	 @workcount_4 	int,	
     @flag	int	output, 
     @msg	varchar(80)	output) 

AS INSERT INTO HrmWorkTimeCount 
	 ( resourceid,
	 workdate,
	 shiftid,
	 workcount) 
 
VALUES 
	( @resourceid_1,
	 @workdate_2,
	 @shiftid_3,
	 @workcount_4)
GO

CREATE PROCEDURE HrmSalaryShiftPay_SByItemid
	(@itemid_1 	int,
     @flag	int	output, 
     @msg	varchar(80)	output)

AS 
Select * from HrmSalaryShiftPay where itemid = @itemid_1 
GO

CREATE PROCEDURE HrmSalaryShiftPay_Insert
	(@itemid_1 	int,
	 @shiftid_2 	int,
	 @shiftpay_3 	decimal,	
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


CREATE PROCEDURE HrmSalaryShiftPay_Delete
	(@itemid_1 	int,	
     @flag	int	output, 
     @msg	varchar(80)	output)

AS DELETE HrmSalaryShiftPay 
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



CREATE PROCEDURE HrmSalaryDiffDetail_Insert
	(@itemid_1 	int,
	 @resourceid_2 	int,
	 @payid_3 	int,
	 @diffid_4 	int,
	 @difftypeid_5 	int,
	 @startdate_6 	char(10),
	 @enddate_7 	char(10),
	 @realcounttime_8 	int,
	 @realcountpay_9 	decimal(10,2) ,
     @flag          integer output, 
     @msg           varchar(80) output)

AS INSERT INTO HrmSalaryDiffDetail 
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
	( @itemid_1,
	 @resourceid_2,
	 @payid_3,
	 @diffid_4,
	 @difftypeid_5,
	 @startdate_6,
	 @enddate_7,
	 @realcounttime_8,
	 @realcountpay_9)
GO

/*��ѯ�򿨻����� 
 create by Wangxiaoyi 2003-10-30
 */

CREATE PROCEDURE HrmCardInfo_SelectCount (
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@workshift_5  char(1) ,/*����,��������16�����飬��0~9,A~F*/
@Cardid_6  char(10) , /*card id*/
@flag        integer output ,
@msg         varchar(80) output)  

 AS 

 select count(id) from HrmCardInfo where carddate = @carddate_3 and workshift = @workshift_5 and Cardid = @Cardid_6 
 
GO


/*���򿨻����ݴ��浽���ݿ���� 
 create by Wangxiaoyi 2003-10-30
 */


CREATE PROCEDURE HrmCardInfo_Insert (
@stationid_2 char(2) , /*���ӵ�̨��*/
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@cardtime_4 char(5) , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
@workshift_5  char(1) ,/*����,��������16�����飬��0~9,A~F*/
@Cardid_6  char(10) , /*card id*/
@flag        integer output ,
@msg         varchar(80) output)  

 AS 
 INSERT INTO HrmCardInfo (
 stationid , 
 carddate , 
 cardtime , 
 workshift , 
 Cardid ) 
 
 VALUES (
 @stationid_2 , 
 @carddate_3 , 
 @cardtime_4 , 
 @workshift_5 , 
 @Cardid_6 
) 
GO





CREATE PROCEDURE HrmValidateCardInfo_Insert (
@stationid_2 char(2) , /*���ӵ�̨��*/
@carddate_3 char(10),/*�����ڣ���ʽ��yyyy-mm-dd(1900-00-00)*/
@cardtime_4 char(5) , /*��ʱ�䣬��ʽ��hh:nn(08:12)*/
@workshift_5  char(1) ,/*����,��������16�����飬��0~9,A~F*/
@Cardid_6  char(10) , /*card id*/
@flag        integer output ,
@msg         varchar(80) output)  

 AS 
 INSERT INTO HrmValidateCardInfo (
 stationid , 
 carddate , 
 cardtime , 
 workshift , 
 Cardid ) 
 
 VALUES (
 @stationid_2 , 
 @carddate_3 , 
 @cardtime_4 , 
 @workshift_5 , 
 @Cardid_6 
) 
GO



alter PROCEDURE HrmTimecardInfo_Update
	(@resourceid_1 	int,
	 @timecarddate_3 	char(10),
	 @intime_4 	char(5),
	 @outtime_5 	char(5),
	 @flag		int	output, 
	 @msg		varchar(80) output)

AS 
declare @count int
select @count= count(resourceid) from HrmTimecardInfo 
where resourceid = @resourceid_1 and timecarddate = @timecarddate_3

if @count is not null and @count > 0 
    UPDATE HrmTimecardInfo 
    SET  outtime = @outtime_5 
    WHERE 
        ( resourceid	 = @resourceid_1 and
         timecarddate	 = @timecarddate_3)
else
    insert into HrmTimecardinfo(resourceid,timecarddate,intime) 
    values(@resourceid_1,@timecarddate_3,@intime_4 )
GO


/*����ϵͳ����*/
CREATE TABLE HrmkqSystemSet (
tosomeone varchar (60)  NULL , /*�ռ��˵�ַ*/
timeinterval int /*�ɼ�����ʱ����*/
)
GO


CREATE PROCEDURE HrmkqSystemSet_Select(
@flag int output, 
@msg varchar(80) output
) 
AS select * from HrmkqSystemSet 
GO

 CREATE PROCEDURE HrmkqSystem_Insert(
 @tosomeone_1 varchar(60) ,	
 @timeinterval_2 int ,
 @flag	int	output, 
 @msg	varchar(80)	output) 
 AS INSERT INTO HrmkqSystemSet(tosomeone , timeinterval)  
 VALUES(@tosomeone_1 , @timeinterval_2)
GO

CREATE PROCEDURE HrmkqSystemSet_Update(
@tosomeone_1  varchar(60) ,
@timeinterval_2  int , 
@flag int output, 
@msg varchar(80) output) 
AS 
update HrmkqSystemSet 
set 
tosomeone = @tosomeone_1 , 
timeinterval = @timeinterval_2 
GO



insert into 
SystemRightDetail (id,rightdetailname,rightdetail,rightid) 
values (3070,'Ĭ��ʱ����½�','HrmDefaultScheduleAdd:Add',35)
GO



INSERT INTO HtmlLabelIndex values(16689,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16689,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16689,'morning',8) 
GO

INSERT INTO HtmlLabelIndex values(16690,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16690,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16690,'afternoon',8) 
GO

INSERT INTO HtmlLabelIndex values(16691,'��ʷ�б�') 
GO
INSERT INTO HtmlLabelInfo VALUES(16691,'��ʷ�б�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16691,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16692,'�Ű����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16692,'�Ű����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16692,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16693,'�Ű�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16693,'�Ű�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16693,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16694,'�Ű�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16694,'�Ű�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16694,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16695,'�Ű�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16695,'�Ű�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16695,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16696,'��ʼʱ��ͽ���ʱ��û�гɶԳ��֣�') 
GO
INSERT INTO HtmlLabelInfo VALUES(16696,'��ʼʱ��ͽ���ʱ��û�гɶԳ��֣�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16696,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16697,'һ�㹤��ʱ����ʷ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16697,'һ�㹤��ʱ����ʷ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16697,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16698,'������Excel��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16698,'������Excel��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16698,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16699,'Excel�ļ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(16699,'Excel�ļ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16699,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16700,'�����ݵ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16700,'�����ݵ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16700,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16701,'�����޶�Ӧ�û�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16701,'�����޶�Ӧ�û�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16701,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16702,'�ⲿ���û����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16702,'�ⲿ���û����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16702,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16703,'������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16703,'������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16703,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16704,'�빫˾ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16704,'�빫˾ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16704,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16705,'����˾ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16705,'����˾ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16705,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16706,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16706,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16706,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16707,'������ʼ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16707,'������ʼ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16707,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16708,'������������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16708,'������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16708,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16709,'�Ƿ����н��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16709,'�Ƿ����н��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16709,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16710,'н�ʼ��㷽ʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16710,'н�ʼ��㷽ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16710,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16711,'����ֵ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16711,'����ֵ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16711,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16712,'��׼������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16712,'��׼������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16712,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16713,'��С����ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16713,'��С����ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16713,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16714,'ʱ����㷽ʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16714,'ʱ����㷽ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16714,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16715,'�Կ���ʱ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16715,'�Կ���ʱ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16715,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16716,'�Դ�ʱ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16716,'�Դ�ʱ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16716,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16717,'�Խϴ�ʱ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16717,'�Խϴ�ʱ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16717,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16718,'�Խ�Сʱ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16718,'�Խ�Сʱ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16718,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16719,'���ڼ���ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16719,'���ڼ���ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16719,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16720,'�򿨼���ʱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16720,'�򿨼���ʱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16720,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16721,'��ʼ���ڲ��ܴ��ڽ������ڣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(16721,'��ʼ���ڲ��ܴ��ڽ������ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16721,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16722,'��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡') 
GO
INSERT INTO HtmlLabelInfo VALUES(16722,'��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16722,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16723,'�������ļ����أ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(16723,'�������ļ����أ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16723,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16724,'���û��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16724,'���û��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16724,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16725,'��ϵͳID') 
GO
INSERT INTO HtmlLabelInfo VALUES(16725,'��ϵͳID',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16725,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16726,'���û������ͻ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16726,'���û������ͻ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16726,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16727,'�û�������Ϣ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16727,'�û�������Ϣ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16727,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16728,'��ϵͳ�û�ID') 
GO
INSERT INTO HtmlLabelInfo VALUES(16728,'��ϵͳ�û�ID',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16728,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16729,'���ɳ���ͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16729,'���ɳ���ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16729,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16730,'������������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16730,'������������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16730,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16731,'Ա�����ڹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(16731,'Ա�����ڹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16731,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16732,'����ͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16732,'����ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16732,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16733,'�༭����ͳ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16733,'�༭����ͳ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16733,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16734,'����ƫ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16734,'����ƫ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16734,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16735,'ƫ����������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16735,'ƫ����������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16735,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16736,'���ڹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(16736,'���ڹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16736,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16737,'��ȡ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16737,'��ȡ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16737,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16738,'����ϵͳ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16738,'����ϵͳ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16738,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16739,'ʵ�ʼ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16739,'ʵ�ʼ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16739,'',8) 
GO

 INSERT INTO HtmlLabelIndex values(16740,'���ڽ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(16740,'���ڽ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16740,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16741,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(16741,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16741,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16742,'���ڴ��������ڲɼ����뿪��ҳ��ᵼ�����ݲɼ�ֹͣ�����Ҫ�뿪��') 
GO
INSERT INTO HtmlLabelInfo VALUES(16742,'���ڴ��������ڲɼ����뿪��ҳ��ᵼ�����ݲɼ�ֹͣ�����Ҫ�뿪��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16742,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16743,'����ϵͳ����Ա�ʼ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16743,'����ϵͳ����Ա�ʼ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16743,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16744,'���ݲɼ�ʱ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(16744,'���ݲɼ�ʱ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16744,'',8) 
GO
 
INSERT INTO HtmlLabelIndex values(16745,'�ռ��˵�ַ') 
GO
INSERT INTO HtmlLabelInfo VALUES(16745,'�ռ��˵�ַ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16745,'',8) 
GO

INSERT INTO HtmlLabelIndex values(16746,'���óɹ�!') 
GO
INSERT INTO HtmlLabelInfo VALUES(16746,'���óɹ�!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(16746,'',8) 
GO
 
