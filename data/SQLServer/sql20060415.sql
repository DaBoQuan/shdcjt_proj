ALTER TABLE FnaYearsPeriods ADD status int NULL
GO


alter table FnaBudgetfeeType add feelevel int
GO

alter table FnaBudgetfeeType add supsubject int
GO

alter table FnaBudgetfeeType add alertvalue int
GO

declare 
	@os11id int,	@os12id int,	@os13id int,	@os14id int,
	@os21id int,	@os22id int,	@os23id int,	@os24id int
	insert FnaBudgetfeeType (name,description,feeperiod,feelevel,supsubject)
	values('�����¶ȿ�Ŀ','ÿ�½�������һ����Ŀ',1,1,0)
	select @os11id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feeperiod,feelevel,supsubject)
	values('�������ȿ�Ŀ','ÿ���Ƚ�������һ����Ŀ',2,1,0)
	select @os12id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feeperiod,feelevel,supsubject)
	values('���������Ŀ','ÿ�����������һ����Ŀ',3,1,0)
	select @os13id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feeperiod,feelevel,supsubject)
	values('������ȿ�Ŀ','ÿ���������һ����Ŀ',4,1,0)
	select @os14id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feelevel,supsubject)
	values('�����¶ȿ�Ŀ','ÿ�½�������������Ŀ',2,@os11id)
	select @os21id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feelevel,supsubject)
	values('�������ȿ�Ŀ','ÿ���Ƚ�������������Ŀ',2,@os12id)
	select @os22id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feelevel,supsubject)
	values('���������Ŀ','ÿ�����������������Ŀ',2,@os13id)
	select @os23id = @@IDENTITY
	insert FnaBudgetfeeType (name,description,feelevel,supsubject)
	values('������ȿ�Ŀ','ÿ���������������Ŀ',2,@os14id)
	select @os24id = @@IDENTITY
	update FnaBudgetfeeType set feelevel = 3,supsubject = @os21id,alertvalue = 100
	where supsubject is null and feeperiod = 1
	update FnaBudgetfeeType set feelevel = 3,supsubject = @os22id,alertvalue = 100
	where supsubject is null and feeperiod = 2
	update FnaBudgetfeeType set feelevel = 3,supsubject = @os23id,alertvalue = 100
	where supsubject is null and feeperiod = 3
	update FnaBudgetfeeType set feelevel = 3,supsubject = @os24id,alertvalue = 100
	where supsubject is null and feeperiod = 4
GO



ALTER TABLE FnaBudgetInfo ADD budgetorganizationid int NULL
GO

ALTER TABLE FnaBudgetInfo ADD organizationtype int NULL
GO

ALTER TABLE FnaBudgetInfo ADD budgetperiods int NULL
GO

ALTER TABLE FnaBudgetInfo ADD revision int NULL
GO

ALTER TABLE FnaBudgetInfo ADD status int NULL
GO

ALTER TABLE FnaBudgetInfo ADD remark varchar(250) NULL
GO

ALTER TABLE FnaBudgetInfo DROP COLUMN budgetyears
GO

UPDATE FnaBudgetInfo SET budgetorganizationid = budgetdepartmentid,organizationtype = 2
GO

UPDATE FnaBudgetInfo SET status = 0
GO

ALTER TABLE FnaBudgetInfo DROP COLUMN budgetdepartmentid
GO



ALTER TABLE FnaBudgetInfoDetail ADD budgetperiodslist int NULL
GO

ALTER TABLE FnaBudgetInfoDetail DROP COLUMN budgetstartdate, budgetenddate
GO


INSERT INTO HtmlLabelIndex values(18430,'δ��Ч') 
GO
INSERT INTO HtmlLabelInfo VALUES(18430,'δ��Ч',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18430,'unefficient',8) 
GO

delete from  HtmlLabelIndex where id=18431
GO
delete from  HtmlLabelInfo where indexId=18431
GO


INSERT INTO HtmlLabelIndex values(18431,'��Ч') 
GO
INSERT INTO HtmlLabelInfo VALUES(18431,'��Ч',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18431,'efficient',8) 
GO


INSERT INTO ErrorMsgIndex values(53,'���ȹرյ�ǰԤ���ڼ�')
GO
INSERT INTO ErrorMsgInfo VALUES(53,'���ȹرյ�ǰԤ���ڼ�!',7)
GO
INSERT INTO ErrorMsgInfo VALUES(53,'pls close current budget period before this operation!',8)
GO


INSERT INTO HtmlNoteIndex values(75,'�رպ󽫲�����ʹ�õ�ǰ�ڼ��Ԥ��')
GO
INSERT INTO HtmlNoteInfo VALUES(75,'�رպ󽫲�����ʹ�õ�ǰ�ڼ��Ԥ��,ȷ���ر���?',7)
GO
INSERT INTO HtmlNoteInfo VALUES(75,'Are you sure to close current budget period',8)
GO


UPDATE HtmlLabelIndex SET indexdesc = 'Ԥ���Ŀ' WHERE id = 1462
GO
UPDATE HtmlLabelInfo SET labelname = 'Ԥ���Ŀ' WHERE indexid = 1462 AND languageid = 7
GO
UPDATE HtmlLabelInfo SET labelname = 'Budget Classification' WHERE indexid = 1462 AND languageid = 8
GO


UPDATE HtmlLabelIndex SET indexdesc = 'Ԥ���Ŀά��' WHERE id = 1011
GO
UPDATE HtmlLabelInfo SET labelname = 'Ԥ���Ŀά��' WHERE indexid = 1011 AND languageid = 7
GO
UPDATE HtmlLabelInfo SET labelname = 'Budget Classification Maintenance' WHERE indexid = 1011 AND languageid = 8
GO


INSERT INTO HtmlLabelIndex values(18424,'һ����Ŀ')
GO
INSERT INTO HtmlLabelInfo VALUES(18424,'һ����Ŀ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18424,'1st subject',8)
GO


INSERT INTO HtmlLabelIndex values(18425,'������Ŀ')
GO
INSERT INTO HtmlLabelInfo VALUES(18425,'������Ŀ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18425,'2nd subject',8)
GO


INSERT INTO HtmlLabelIndex values(18426,'������Ŀ')
GO
INSERT INTO HtmlLabelInfo VALUES(18426,'������Ŀ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18426,'3rd subject',8)
GO


INSERT INTO HtmlLabelIndex values(18427,'��Ŀ����')
GO
INSERT INTO HtmlLabelInfo VALUES(18427,'��Ŀ����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18427,'subject level',8)
GO


INSERT INTO HtmlLabelIndex values(18428,'�ϼ���Ŀ')
GO
INSERT INTO HtmlLabelInfo VALUES(18428,'�ϼ���Ŀ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18428,'sup subject',8)
GO


INSERT INTO HtmlLabelIndex values(18429,'��ĿԤ��ֵ')
GO
INSERT INTO HtmlLabelInfo VALUES(18429,'��ĿԤ��ֵ',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18429,'alert value',8)
GO


insert into SystemRights (id,rightdesc,righttype,detachable) values (639,'�ܲ�Ԥ��ά��','2',0)
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (639,7,'�ܲ�Ԥ��ά��','�ܲ�Ԥ��ά��')
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (639,8,'headquarter budget maintain','headquarter budget maintain')
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4139,'�ܲ�Ԥ��ά��','HeadBudget:Maint',639)
GO


insert into SystemRights (id,rightdesc,righttype,detachable) values (640,'�ֲ�Ԥ��ά��','2',1)
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (640,8,'subcompany budget maintain','subcompany budget maintain')
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (640,7,'�ֲ�Ԥ��ά��','�ֲ�Ԥ��ά��')
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (4140,'�ֲ�Ԥ��ά��','SubBudget:Maint',640)
GO


insert into SystemRightToGroup (groupid,rightid) values (4,639);
GO
insert into SystemRightToGroup (groupid,rightid) values (4,640);
GO


INSERT INTO HtmlLabelIndex values(18496,'��Ч�汾') 
GO
INSERT INTO HtmlLabelInfo VALUES(18496,'��Ч�汾',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18496,'Efficient version',8) 
GO


INSERT INTO HtmlLabelIndex values(18500,'��ʷ�汾') 
GO
INSERT INTO HtmlLabelInfo VALUES(18500,'��ʷ�汾',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18500,'History version',8) 
GO


INSERT INTO HtmlLabelIndex values(18501,'Ԥ���ܶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18501,'Ԥ���ܶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18501,'budget amount',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18502,'�ѷ���Ԥ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18502,'�ѷ���Ԥ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18502,'allotted budget',8) 
GO


INSERT INTO HtmlLabelIndex values(18503,'�ѷ�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(18503,'�ѷ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18503,'used fee',8) 
GO


INSERT INTO HtmlLabelIndex values(18552,'�汾��ʷ') 
GO
INSERT INTO HtmlLabelInfo VALUES(18552,'�汾��ʷ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18552,'versions history',8) 
GO


INSERT INTO HtmlLabelIndex values(18553,'�汾�Ա�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18553,'�汾�Ա�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18553,'version contrast',8) 
GO


INSERT INTO HtmlLabelIndex values(18554,'��ԱԤ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18554,'��ԱԤ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18554,'person budget',8) 
GO


INSERT INTO HtmlLabelIndex values(18568,'�ѷ����¼�Ԥ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18568,'�ѷ����¼�Ԥ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18568,'under allotted budget',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18569,'ԭԤ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18569,'ԭԤ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18569,'original budget',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18570,'��Ԥ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18570,'��Ԥ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18570,'new budget',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18571,'Ԥ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(18571,'Ԥ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18571,'added budget',8) 
GO


INSERT INTO HtmlLabelIndex values(18577,'Excel�ļ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18577,'Excel�ļ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18577,'import Excel file',8) 
GO
 


INSERT INTO HtmlLabelIndex values(18579,'��Ԥ���ھ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18579,'��Ԥ���ھ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18579,'average by period',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18604,'�ϼ�����Ԥ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18604,'�ϼ�����Ԥ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18604,'upper useable budget',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18687,'��ѡ��2��Ҫ�ԱȰ汾��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18687,'��ѡ��2��Ҫ�ԱȰ汾��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18687,'pls select 2 versions to compare',8) 
GO


INSERT INTO HtmlLabelIndex values(18752,'��ǰ����Ϊ��Ч״̬���ò����Ὣ���з���������Ч�汾���Ϊ�ݸ壬�Ѵ��ڵĲݸ彫�ᱻ�滻����ȷ����?') 
GO
INSERT INTO HtmlLabelInfo VALUES(18752,'��ǰ����Ϊ��Ч״̬���ò����Ὣ���з���������Ч�汾���Ϊ�ݸ壬�Ѵ��ڵĲݸ彫�ᱻ�滻����ȷ����?',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18752,'are you sure ?',8) 
GO



INSERT INTO HtmlLabelIndex values(18755,'ȫ��Ԥ��������Ԥ���֮�Ͳ����!') 
GO
INSERT INTO HtmlLabelInfo VALUES(18755,'ȫ��Ԥ��������Ԥ���֮�Ͳ����!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18755,'calculation is error',8) 
GO
 
 

INSERT INTO HtmlLabelIndex values(18756,'��Ԥ����������ѷ���Ԥ��!') 
GO
INSERT INTO HtmlLabelInfo VALUES(18756,'��Ԥ����������ѷ���Ԥ��!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18756,'calculation is error',8) 
GO
 

INSERT INTO HtmlLabelIndex values(18757,'Ԥ���������С���ϼ�����Ԥ��!') 
GO
INSERT INTO HtmlLabelInfo VALUES(18757,'Ԥ���������С���ϼ�����Ԥ��!',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18757,'calculation is error',8) 
GO
 
INSERT INTO HtmlLabelIndex values(18764,'�¼�����Ԥ��֮�Ͳ��ܴ���Ԥ���ܶ�!')
GO
INSERT INTO HtmlLabelInfo VALUES(18764,'�¼�����Ԥ��֮�Ͳ��ܴ���Ԥ���ܶ�!',7)
GO
INSERT INTO HtmlLabelInfo VALUES(18764,'calculation is error',8)
GO

ALTER PROCEDURE FnaBudgetfeeType_Delete
	@id int,
	@flag int output,
	@msg varchar(80) output
AS
	IF EXISTS (SELECT feetypeid FROM bill_expensedetail WHERE feetypeid = @id)
	OR EXISTS (SELECT id FROM FnaBudgetInfoDetail WHERE budgettypeid = @id)
	OR EXISTS (SELECT id FROM FnaBudgetCheckDetail WHERE budgettypeid = @id)
	BEGIN
		SELECT -1
		RETURN
	END
	DELETE fnaBudgetfeetype WHERE id = @id
GO
alter PROCEDURE FnaBudgetfeeType_Insert
	@name_1	varchar(50),
    @feeperiod_1	int,
    @feetype_1	int,
    @agreegap_1	int,
	@description_1	varchar(255),
	@feelevel_1	int,
	@alertvalue_1 int,
	@supsubject_1 int,
	@flag	int	output,
	@msg	varchar(80) output
as
	insert into fnaBudgetfeetype (name,feeperiod,feetype,agreegap,description,feelevel,alertvalue,supsubject)
    values (@name_1,@feeperiod_1,@feetype_1,@agreegap_1,@description_1,@feelevel_1,@alertvalue_1,@supsubject_1)
GO

alter PROCEDURE FnaBudgetfeeType_Update
	@id_1		int,
	@name_1	varchar(50),
    @feeperiod_1	int,
    @feetype_1	int,
    @agreegap_1	int,
	@description_1	varchar(250),
	@feelevel_1	int,
	@alertvalue_1 int,
	@supsubject_1 int,
	@flag	int	output,
	@msg	varchar(80) output
as
	update fnaBudgetfeetype set name=@name_1,feeperiod=@feeperiod_1,feetype=@feetype_1
    ,agreegap=@agreegap_1,description=@description_1,feelevel=@feelevel_1,alertvalue=@alertvalue_1,supsubject=@supsubject_1 where id=@id_1
GO

alter PROCEDURE FnaBudgetInfo_Insert
	@budgetperiods_1 int,
	@budgetorganizationid_2 int,
	@organizationtype_3 int,
	@budgetstatus_4 int,
	@createrid_5 int,
	@createdate_6 char(10),
	@revision_7 int,
	@status_8 int,
	@flag int output,
	@msg varchar(80) output
AS
	IF EXISTS (
		SELECT id FROM FnaBudgetInfo WHERE budgetorganizationid = @budgetorganizationid_2
		AND organizationtype = @organizationtype_3
		AND budgetperiods = @budgetperiods_1
		AND status = @status_8
		AND revision = @revision_7
		)
	BEGIN
		SELECT -1
		RETURN
	END
	ELSE
	BEGIN
		INSERT INTO FnaBudgetInfo
			(budgetperiods,
			 budgetorganizationid,
			 organizationtype,
			 budgetstatus,
			 createrid,
			 createdate,
			 revision,
			 status) 
		VALUES 
			(@budgetperiods_1,
			 @budgetorganizationid_2,
			 @organizationtype_3,
			 @budgetstatus_4,
			 @createrid_5,
			 @createdate_6,
			 @revision_7,
			 @status_8)
		select @@IDENTITY
	END
GO

CREATE PROCEDURE FnaBudgetInfo_UpdateStatus
   (@id_1 	int,
	@status_2 	int,
	@revision_3 	int,
	@budgetstatus_4		int,
	@flag	int	output, 
	@msg	varchar(80) output)

AS
	UPDATE FnaBudgetInfo
	SET budgetstatus = @budgetstatus_4,
		status	 = @status_2,
		revision	 = @revision_3
	WHERE (id = @id_1)
GO




alter PROCEDURE FnaBudgetInfoDetail_Insert
	(@budgetinfoid_1 	int,
	 @budgetperiods_2 	int,
	 @budgetperiodslist_3 	int,
	 @budgettypeid_4 	int,
	 @budgetresourceid_5 	int,
	 @budgetcrmid_6 	int,
	 @budgetprojectid_7 	int,
	 @budgetaccount_8 	decimal(18,2),
	 @budgetremark_9 	varchar(250),
	 @flag	int	output, 
	 @msg	varchar(80) output)
AS
	IF EXISTS (
	select id from FnaBudgetInfoDetail where budgetinfoid = @budgetinfoid_1
	and budgetperiods = @budgetperiods_2
	and budgetperiodslist = @budgetperiodslist_3
	and budgettypeid = @budgettypeid_4)
	BEGIN
		UPDATE FnaBudgetInfoDetail SET budgetaccount = @budgetaccount_8
		 WHERE budgetinfoid = @budgetinfoid_1
		   AND budgetperiods = @budgetperiods_2
		   AND budgetperiodslist = @budgetperiodslist_3
		   AND budgettypeid = @budgettypeid_4
	END
	ELSE
	BEGIN
		INSERT INTO FnaBudgetInfoDetail 
			(budgetinfoid,
			 budgetperiods,
			 budgetperiodslist,
			 budgettypeid,
			 budgetresourceid,
			 budgetcrmid,
			 budgetprojectid,
			 budgetaccount,
			 budgetremark) 
		VALUES 
			(@budgetinfoid_1,
			 @budgetperiods_2,
			 @budgetperiodslist_3,
			 @budgettypeid_4,
			 @budgetresourceid_5,
			 @budgetcrmid_6,
			 @budgetprojectid_7,
			 @budgetaccount_8,
			 @budgetremark_9)
	END
GO
CREATE PROCEDURE FnaYearsPeriods_Close
	@id_1 int,
	@flag integer output,
	@msg varchar(80) output
AS 
	DECLARE @count integer
	UPDATE FnaYearsPeriods SET status = -1 WHERE  id = @id_1
GO

alter PROCEDURE FnaYearsPeriods_Delete
	@id_1 int,
	@flag integer output,
	@msg varchar(80) output
AS
	DECLARE @count integer
	SELECT @count = count(id) FROM FnaYearsPeriodsList WHERE fnayearid = @id_1 AND isclose ='1'
	IF (@count <> 0) OR EXISTS (SELECT id from FnaBudgetInfo WHERE budgetperiods = @id_1)
	OR EXISTS (SELECT id from FnaBudgetInfoDetail WHERE budgetperiods = @id_1)
	BEGIN
	SELECT '20'
	RETURN
	END
	DELETE FnaYearsPeriods WHERE id = @id_1
	DELETE FnaYearsPeriodsList WHERE fnayearid = @id_1
GO
alter PROCEDURE FnaYearsPeriods_Insert
	@fnayear_1 char(4),
	@startdate_2 char(10),
	@enddate_3 char(10),
	@status int,
	@flag integer output,
	@msg varchar(80) output
AS
	declare @count integer
	select @count = count(id) from FnaYearsPeriods where fnayear = @fnayear_1
	if @count <> 0
	begin
	select -1
	return
	end
	INSERT INTO FnaYearsPeriods (fnayear,startdate,enddate,status)
	VALUES (@fnayear_1,@startdate_2,@enddate_3,@status)
	select @@IDENTITY from FnaYearsPeriods
GO

alter PROCEDURE FnaYearsPeriods_SelectMaxYear
	@flag integer output ,
	@msg varchar(80) output
AS
	declare @fnayear char(4)
	select @fnayear = max(fnayear) from FnaYearsPeriods where status > -1
	select * from FnaYearsPeriods where fnayear = @fnayear
GO

CREATE PROCEDURE FnaYearsPeriods_TakeEffect
	@id_1 int,
	@flag integer output,
	@msg varchar(80) output
AS 
	DECLARE @count integer
	SELECT @count = count(id) FROM FnaYearsPeriods WHERE status = 1
	IF (@count <> 0) BEGIN SELECT '-1' RETURN END
	UPDATE FnaYearsPeriods SET status = 1 WHERE  id = @id_1
GO
update FnaYearsPeriods set status = 0 where status is null
go