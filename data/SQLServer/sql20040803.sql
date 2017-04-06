/*  FOR BUG 78 "ְ�����ά��"Ȩ����Ȩ����������ʾ����"��������ά��"*/
delete from SystemRights where id=28
GO
delete from SystemRightsLanguage where id=28
GO
delete from SystemRightDetail where rightid=28
GO
insert into SystemRights (id,rightdesc,righttype) values (28,'ְ�����ά��','3') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,7,'ְ�����ά��','ְ��������ӣ�ɾ�������º���־�鿴') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (28,8,'HrmJobGroups','Add,delete,update and log HrmJobGroups') 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (96,'ְ��������','HrmJobGroupsAdd:Add',28) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (97,'ְ�����༭','HrmJobGroupsEdit:Edit',28) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (98,'ְ�����ɾ��','HrmJobGroupsEdit:Delete',28) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (99,'ְ�������־�鿴','HrmJobGroups:Log',28) 
GO
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (198,'ְ��������','AddWorkType:Add',28) 
GO

/* FOR BUG 84 ְ�Ƶ���־ҳ����Ȼû����־��Ϣ*/
insert SystemLogItem(itemid,lableid,itemdesc) values(65,16462,'ְ������')
GO

/*FOR BUG 197 �޸��¹����ܽ�Ĭ�ϲ���ȷ�ĳ���*/
update WORKFLOW_NODELINK set isreject='1' where id=14
go
update WORKFLOW_NODELINK set isreject=' ' where id=15
go

/*
 * Script Created ON : May 20,2004
 * Author : Charoes Huang Yu
*/
/*FOR BUG 310 �޸�HrmAwardInfo���resourseid�ֶε�����Ϊvarchar(4000)*/
ALTER TABLE HrmAwardInfo 
	ALTER COLUMN resourseid varchar(4000)
GO
/*�޸Ľ��� ���� @resourseid_3 int�ֶ�����Ϊvarchar(4000)*/
/*����*/
ALTER  PROCEDURE HrmAwardInfo_Insert
(@rptitle_2 varchar(60),
 @resourseid_3 varchar(4000),
 @rptypeid_4 int,
 @rpdate_5 char(10),
 @rpexplain_6 varchar(200),
 @rptransact_7 varchar(200),
 @flag int output, @msg varchar(60) output)
 AS
    insert into HrmAwardInfo (rptitle,resourseid,rptypeid,rpdate,rpexplain,rptransact) values (@rptitle_2,@resourseid_3,@rptypeid_4,@rpdate_5,@rpexplain_6,@rptransact_7)
GO
/*����*/
ALTER  PROCEDURE HrmAwardInfo_Update
(@id_1 int,
 @rptitle_2 varchar(60),
 @resourseid_3 varchar(4000),
 @rptypeid_4 int,
 @rpdate_5 char(10),
 @rpexplain_6 varchar(200),
 @rptransact_7 varchar(200),
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmAwardInfo set
rptitle = @rptitle_2,
resourseid = @resourseid_3,
rptypeid = @rptypeid_4,
rpdate = @rpdate_5,
rpexplain = @rpexplain_6,
rptransact = @rptransact_7
WHERE
 id = @id_1
GO
/*td:394 �������ĵġ�����ĵ����ߡ�����������ĵ��ͻظ��ĵ���ͳ����Ŀ����ȷ  */
alter PROCEDURE DocRpSum @optional	varchar(30),
 @userid int,
 @flag	int output,
 @msg 	varchar(80) output AS declare @resultid  int,
 @count  int,
 @replycount  int create table #temp( resultid  int ,
 acount  int,
 replycount int ) if   @optional='doccreater' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
ownerid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by ownerid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and doccreaterid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='crm' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
t1.crmid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by t1.crmid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and t1.crmid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='resource' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
hrmresid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by hrmresid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and hrmresid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='project' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
projectid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by projectid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and projectid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='department' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
docdepartmentid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by docdepartmentid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and docdepartmentid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='language' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
doclangurage resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by doclangurage order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and doclangurage=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  if   @optional='item' begin declare resultid_cursor cursor for select top 20 count(id) resultcount,
itemid resultid from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid group by itemid order by resultcount desc open resultid_cursor fetch next from resultid_cursor into @count,
@resultid while @@fetch_status=0 begin select @replycount=count(id) from docdetail as t1,
DocShareDetail as t2 where t1.id=t2.docid and t1.docstatus in (1,2,5) and t2.usertype=1 and t2.userid=@userid and itemid=@resultid and isreply='1' insert into #temp values(@resultid,
@count,
@replycount) fetch next from resultid_cursor into @count,
@resultid end close resultid_cursor deallocate resultid_cursor select * from #temp order by acount desc end  
GO
/*
 * Script Created ON : May 20,2004
 * Author : Charoes lu peng
*/
/*FOR BUG 430 �޸��˴洢����FnaYearsPeriods_Select�������˶��ڼ��굹�����й���*/
ALTER PROCEDURE FnaYearsPeriods_Select (
@flag integer output , @msg varchar(80) output)
AS 
SELECT * FROM FnaYearsPeriods ORDER BY fnayear DESC 
GO

/*FOR BUG 432 �޸������ڼ䱻���ú󣬲���ɾ���ڼ�*/
ALTER PROCEDURE FnaYearsPeriods_Delete (@id_1 int, @flag integer output , @msg varchar(80) output)  
AS 
DECLARE @fnaYear char(4)
DECLARE @count integer
SELECT @fnaYear = fnayear FROM FnaYearsPeriods WHERE id = @id_1
SELECT @count = count(id) FROM FnaYearsPeriodsList WHERE fnayearid = @id_1 AND isclose ='1'  
IF (@count <> 0) OR EXISTS (SELECT id from FnaBudgetInfo WHERE budgetyears = @fnayear)
BEGIN 
SELECT '20' RETURN 
END  
DELETE FnaYearsPeriods WHERE id = @id_1 
DELETE FnaYearsPeriodsList WHERE  fnayearid = @id_1
GO

/*FOR BUG 440 �������ͱ��������̻���Ԥ���������ã����ܱ�ɾ����*/
ALTER PROCEDURE FnaBudgetfeeType_Delete 
(@id int, @flag int output, 
@msg varchar(80) output)
AS
DECLARE @typeId integer
IF EXISTS (SELECT feetypeid FROM bill_expensedetail WHERE feetypeid = @id) OR
EXISTS (SELECT id FROM FnaBudgetCheckDetail WHERE budgettypeid = @id)
SELECT -1 RETURN DELETE fnaBudgetfeetype WHERE id = @id 
GO

/*FOR BUG 443 �����˲�������ά��Ȩ�ޣ����ø�Ȩ��������������ά����*/
insert into SystemRights (id,rightdesc,righttype) values (437,'��������ά��','2') 
GO

insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (437,7,'��������ά��','��������ά��') 
GO
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (437,8,'Write-Off','Write-Off') 
GO

insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (3127,'��������ά��','FinanceWriteOff:Maintenance',437) 
GO
insert into SystemRightToGroup (groupid, rightid) values (4, 437)
GO
insert into SystemRightRoles (rightid, roleid, rolelevel) values (437, 5, '2')
GO

/*FOR BUG 445 �޸ġ���ϸ'Ϊ'�������ʴ���'*/
INSERT INTO HtmlLabelIndex values(17390,'�������ʴ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(17390,'�������ʴ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17390,'Write-Off',8) 
GO

/*FOR BUG 447 �޸��ڡ����˲������ʡ�ҳ�棬�����˶ԡ�ƾ֤�š��ֶε����ӡ�
�����ˡ��鿴�������༭��ҳ�棬�Լ������ˡ��༭������ɾ�������ܡ�*/

CREATE PROCEDURE FnaLoanLog_Update (
@id_0 int, @loantypeid_1 int, @resourceid_2 int, @departmentid_3 int, @crmid_4 int, @projectid_5 int, @amount_6 decimal, 
@description_7 varchar(250), @credenceno_8 varchar(60), @occurdate_9 char(10), @releatedid_10 int, @releatedname_11 varchar(255),
@returndate_12 char(10), @dealuser_13 int, @flag integer output , @msg varchar(80) output) 
AS 
UPDATE FnaLoanLog SET loantypeid = @loantypeid_1, resourceid = @resourceid_2, departmentid = @departmentid_3,
crmid = @crmid_4, projectid = @projectid_5, amount = @amount_6, description = @description_7, credenceno = @credenceno_8,
occurdate = @occurdate_9, releatedid = @releatedid_10, releatedname = @releatedname_11, returndate = @returndate_12,
dealuser = @dealuser_13 WHERE id = @id_0
GO

CREATE PROCEDURE FnaLoanLog_Delete (
@id_0 int, @flag integer output , @msg varchar(80) output) 
AS 
DELETE FnaLoanLog WHERE id = @id_0
GO

/*FOR BUG 646  ������������ĸ���������ȷ��ʾ*/
alter PROCEDURE bill_HrmFinance_SelectLoan
  @resourceid	int,
  @flag integer output ,
  @msg varchar(80) output
AS
  declare @tmpamount1   decimal(10,3),
          @tmpamount2   decimal(10,3)
  select @tmpamount1=sum(amount) from FnaLoanLog
  where resourceid=@resourceid and loantypeid = 1
  
  select @tmpamount2=sum(amount) from FnaLoanLog
  where resourceid=@resourceid and loantypeid != 1
  
  if    @tmpamount1 is null set @tmpamount1=0
  if    @tmpamount2 is null set @tmpamount2=0
  
  set @tmpamount1=@tmpamount1-@tmpamount2
  
  select @tmpamount1
GO

