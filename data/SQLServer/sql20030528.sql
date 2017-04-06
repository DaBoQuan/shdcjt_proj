alter table license add multilanguage char
GO

update license set multilanguage='n'
GO

alter table license add email char
GO

update license set email='n'
GO

alter table license add meeting char
GO

update license set meeting='n'
GO

alter table license add project char
GO

update license set project='n'
GO

alter table license add crm char
GO

update license set crm='n'
GO

alter table license add cpt char
GO

update license set cpt='n'
GO

alter table license add finance char
GO

update license set finance='n'
GO

alter table license add hrm char
GO

update license set hrm='n'
GO

alter table license add workflow char
GO

update license set workflow='n'
GO

alter table license add document char
GO

update license set document='n'
GO

alter PROCEDURE HrmResource_Trigger_Insert
	(@id_1 	int,
	 @managerid_2 	int,
	 @departmentid_3 	int,
	 @subcompanyid1_4 	int,
	 @seclevel_5 	tinyint,
	 @managerstr_6 	varchar(200),
	 @flag int output, @msg varchar(60) output)
AS 
declare @numcount int
select   @numcount = count(*)  from HrmResource_Trigger where id=@id_1
if @numcount =0 
begin
INSERT INTO HrmResource_Trigger 
	 ( id,
  	   managerid,
 	   departmentid,
	   subcompanyid1,
	   seclevel,
	   managerstr) 
 
VALUES 
	( @id_1,
	 @managerid_2,
	 @departmentid_3,
	 @subcompanyid1_4,
	 0,
	 @managerstr_6)
end
go

 alter PROCEDURE HrmResourceBasicInfo_Insert 
 (@id_1 int, 
  @workcode_2 varchar(60), 
  @lastname_3 varchar(60), 
  @sex_5 char(1), 
  @resoureimageid_6 int, 
  @departmentid_7 int, 
  @costcenterid_8 int, 
  @jobtitle_9 int, 
  @joblevel_10 int, 
  @jobactivitydesc_11 varchar(200), 
  @managerid_12 int, 
  @assistantid_13 int, 
  @status_14 char(1), 
  @locationid_15 int, 
  @workroom_16 varchar(60), 
  @telephone_17 varchar(60), 
  @mobile_18 varchar(60), 
  @mobilecall_19 varchar(30) , 
  @fax_20 varchar(60), 
  @jobcall_21 int, 
  @flag int output, @msg varchar(60) output) 
AS INSERT INTO HrmResource 
(id, 
 workcode, 
 lastname, 
 sex, 
 resourceimageid, 
 departmentid, 
 costcenterid, 
 jobtitle, 
 joblevel, 
 jobactivitydesc, 
 managerid, 
 assistantid, 
 status, 
 locationid, 
 workroom, 
 telephone, 
 mobile, 
 mobilecall, 
 fax, 
 jobcall,
 seclevel) 
VALUES 
(@id_1, 
 @workcode_2, 
 @lastname_3, 
 @sex_5, 
 @resoureimageid_6, 
 @departmentid_7, 
 @costcenterid_8, 
 @jobtitle_9, 
 @joblevel_10, 
 @jobactivitydesc_11, 
 @managerid_12, 
 @assistantid_13, 
 @status_14, 
 @locationid_15, 
 @workroom_16, 
 @telephone_17, 
 @mobile_18, 
 @mobilecall_19, 
 @fax_20, 
 @jobcall_21,
 0)
GO

CREATE procedure HrmCareerApply_CreateInfo
(@id_1 int,
 @createrid_2 int,
 @createdate_3 char(10),
 @lastmodid_4 int,
 @lastmoddate_5 char(10),
 @flag int output, @msg varchar(60) output)
as update HrmCareerApply set
 createrid = @createrid_2,
 createdate = @createdate_3,
 lastmodid = @lastmodid_4,
 lastmoddate = @lastmoddate_5
where
 id = @id_1
GO

create procedure HrmCareerApply_ModInfo
(@id_1 int,
 @lastmodid_2 int,
 @lastmoddate_3 char(10),
 @flag int output, @msg varchar(60) output)
as update HrmCareerApply set
 lastmodid = @lastmodid_2,
 lastmoddate = @lastmoddate_3
where
 id = @id_1

GO

create procedure HrmResourceMaxId_Get
(@flag int output, @msg varchar(60) output)
as 
declare @id_1 integer
select @id_1=currentid from SequenceIndex where indexdesc='resourceid'
update SequenceIndex set currentid = @id_1+1 where indexdesc='resourceid'
select @id_1
go

create procedure SequenceIndexRes_Init
as 
declare @id_1 integer, @resid_2 integer, @curid_3 integer
select @id_1=max(id) from HrmResource
select @resid_2 = max(id) from HrmCareerApply
if( @id_1>@resid_2) set @curid_3= @id_1+1
else  set @curid_3 = @resid_2+1
update SequenceIndex set currentid = @curid_3 where indexdesc='resourceid'
go

exec SequenceIndexRes_Init
go

INSERT INTO HtmlLabelInfo([indexid], [labelname], [languageid])
VALUES (7171, '�������', 7)
go        
INSERT  INTO HtmlLabelInfo([indexid], [labelname], [languageid])
VALUES (7171, 'weaverPlugin_download', 8)
go
INSERT  INTO htmllabelindex([id], [indexdesc])
VALUES (7171, '�������')
GO


CREATE TABLE [docReadTag] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[userType] [int] NULL ,
	[docid] [int] NULL ,
	[userid] [int]   NULL ,
	[readCount] [int] NULL 
)
GO

CREATE PROCEDURE docReadTag_SelectByuserid
	(@docid_1 	[int] ,
	 @userid_2 	[int] ,
	 @userType_3	[int] ,
  	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)

AS
select  userid   from docReadTag where docid = @docid_1 and userid = @userid_2 and userType = @userType_3
GO


CREATE PROCEDURE docDetail_QueryByDocid
	(@docid_1 	[int] ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS
select DocSubject,maincategory,docdepartmentid,doccreaterid  from Docdetail where id = @docid_1 
GO



CREATE PROCEDURE docDetailLog_QueryByDate
	(@fromdate_1 	[char](10) ,
	 @todate_1 	[char](10) ,
	 @flag	[int]	output, 
	 @msg	[varchar](80)	output)
AS
SELECT docid, SUM(readCount) AS COUNT FROM docReadTag where docid in (SELECT docid FROM DocDetailLog WHERE (operatedate >= @fromdate_1) AND (operatedate <= @todate_1))GROUP BY docid ORDER BY COUNT DESC
GO

/*̷����*/

CREATE TABLE DirAccessControlList (
	mainid int IDENTITY (1, 1) NOT NULL ,
	dirid int NOT NULL ,
	dirtype int NOT NULL ,
	seclevel int NULL ,
	departmentid int NULL ,
	roleid int NULL ,
	rolelevel int NULL ,
	usertype int NULL ,
	permissiontype int NOT NULL ,
	operationcode int NOT NULL ,
	userid int NULL 
)
GO

CREATE TABLE DirAccessPermission (
	dirid int NOT NULL ,
	dirtype int NOT NULL ,
	userid int NOT NULL ,
	usertype int NOT NULL ,
	createdoc int NOT NULL ,
	createdir int NOT NULL ,
	movedoc int NOT NULL 
)
GO

ALTER TABLE DirAccessControlList  ADD 
	CONSTRAINT PK_DirAccessControlList PRIMARY KEY  CLUSTERED 
	(
		mainid
	) 
GO

ALTER TABLE DirAccessPermission  ADD 
	CONSTRAINT PK_DirAccessPermission PRIMARY KEY  CLUSTERED 
	(
		dirid,
		dirtype,
		userid,
		usertype
	) 
GO

/*
    2003��6��3������
*/

ALTER TABLE DirAccessPermission  ADD
    copydoc int DEFAULT 0 NOT NULL

GO

/* ����һ���û�-��Դ������ɣ����޴洢���̵��ã� */
CREATE PROCEDURE Doc_DirAccessPermission_Insert(@dirid_1 int, @dirtype_1 int, @userid_1 int, @usertype_1 int, @operationcode_1 int)  AS

declare @count_1 int

if @operationcode_1 = 0 begin
  set @count_1 = (select createdoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
  if @count_1 is null
      insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(@dirid_1, @dirtype_1, @userid_1, @usertype_1, 1, 0, 0, 0)
  else
      update DirAccessPermission set createdoc = (@count_1+1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
end
else if @operationcode_1 = 1 begin
    set @count_1 = (select createdir from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
    if @count_1 is null
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(@dirid_1, @dirtype_1, @userid_1, @usertype_1, 0, 1, 0, 0)
    else
        update DirAccessPermission set createdir = (@count_1+1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
end
else if @operationcode_1 = 2 begin
    set @count_1 = (select movedoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
    if @count_1 is null
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(@dirid_1, @dirtype_1, @userid_1, @usertype_1, 0, 0, 1, 0)
    else
        update DirAccessPermission set movedoc = (@count_1+1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
end
else if @operationcode_1 = 3 begin
    select @count_1 = copydoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
    if @count_1 is null
        insert into DirAccessPermission(dirid, dirtype, userid, usertype, createdoc, createdir, movedoc, copydoc) values(@dirid_1, @dirtype_1, @userid_1, @usertype_1, 0, 0, 0, 1)
    else
        update DirAccessPermission set copydoc = (@count_1+1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
end

GO

/* ɾ��һ���û�-��Դ������ɣ����޴洢���̵��ã� */
CREATE PROCEDURE Doc_DirAccessPermission_Delete(@dirid_1 int, @dirtype_1 int, @userid_1 int, @usertype_1 int, @operationcode_1 int)  AS

declare @count_1 int

if @operationcode_1 = 0 begin
  set @count_1 = (select createdoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
  if not (@count_1 is null) and (@count_1 > 0) begin
    update DirAccessPermission set createdoc = (@count_1-1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
  end
end
else if @operationcode_1 = 1 begin
  set @count_1 = (select createdir from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
  if not (@count_1 is null) and (@count_1 > 0) begin
    update DirAccessPermission set createdir = (@count_1-1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
  end
end
else if @operationcode_1 = 2 begin
  set @count_1 = (select movedoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
  if not (@count_1 is null) and (@count_1 > 0) begin
    update DirAccessPermission set movedoc = (@count_1-1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
  end
end
else if @operationcode_1 = 3 begin
  select @count_1 = copydoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
  if not (@count_1 is null) and (@count_1 > 0) begin
    update DirAccessPermission set copydoc = (@count_1-1) where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
  end
end

GO

/* �Բ��ţ���ȫ����ķ�ʽ����Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_Insert_Type1(@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @departmentid_1 int, @seclevel_1 int, @flag int output, @msg varchar(80) output)  AS

insert into DirAccessControlList(dirid, dirtype, departmentid, seclevel, operationcode, permissiontype) values(@dirid_1, @dirtype_1, @departmentid_1, @seclevel_1, @operationcode_1, 1)

declare @userid_1 int
declare @count int
declare users_cursor cursor for
select distinct id from HrmResource where departmentid = @departmentid_1 and seclevel >= @seclevel_1

open users_cursor
fetch next from users_cursor
into @userid_1
while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  
  fetch next from users_cursor
  into @userid_1
end

close users_cursor
deallocate users_cursor

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ������ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ������ʧ��' 
    return 
end
GO

/* �Խ�ɫ����ɫ����+��ȫ����ķ�ʽ����Ȩ�� */

CREATE PROCEDURE Doc_DirAcl_Insert_Type2(@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @roleid_1 int, @rolelevel_1 int, @seclevel_1 int, @flag int output, @msg varchar(80) output)  AS

insert into DirAccessControlList(dirid, dirtype, roleid, rolelevel, seclevel, operationcode, permissiontype) values(@dirid_1, @dirtype_1, @roleid_1, @rolelevel_1, @seclevel_1, @operationcode_1, 2)

declare @userid_1 int
declare @count int
declare users_cursor cursor for
select distinct HrmResource.id from HrmResource, HrmRoleMembers 
where roleid = @roleid_1 and rolelevel >= @rolelevel_1 and HrmResource.id = HrmRoleMembers.resourceid and seclevel >= @seclevel_1

open users_cursor
fetch next from users_cursor
into @userid_1
while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  
  fetch next from users_cursor
  into @userid_1
end

close users_cursor
deallocate users_cursor

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ������ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ������ʧ��' 
    return 
end
GO

/* �������ˣ���ȫ����ķ�ʽ����Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_Insert_Type3(@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @seclevel_1 int, @flag int output, @msg varchar(80) output)  AS

insert into DirAccessControlList(dirid, dirtype, seclevel, operationcode, permissiontype) values(@dirid_1, @dirtype_1, @seclevel_1, @operationcode_1, 3)

declare @userid_1 int
declare @count int
declare users_cursor cursor for
select distinct id from HrmResource where seclevel >= @seclevel_1

open users_cursor
fetch next from users_cursor
into @userid_1
while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  
  fetch next from users_cursor
  into @userid_1
end

close users_cursor
deallocate users_cursor

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ������ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ������ʧ��' 
    return 
end
GO

/* ���û����ͣ���ȫ����ķ�ʽ����Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_Insert_Type4(@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @usertype_1 int, @seclevel_1 int, @flag int output, @msg varchar(80) output)  AS

insert into DirAccessControlList(dirid, dirtype, usertype, seclevel, operationcode, permissiontype) values(@dirid_1, @dirtype_1, @usertype_1, @seclevel_1, @operationcode_1, 4)

if @usertype_1 = 0 begin
  declare @userid_1 int
  declare @count int
  declare users_cursor cursor for
  select distinct id from HrmResource where seclevel >= @seclevel_1
  
  open users_cursor
  fetch next from users_cursor
  into @userid_1
  while @@fetch_status = 0
  begin
    execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
    
    fetch next from users_cursor
    into @userid_1
  end

  close users_cursor
  deallocate users_cursor
end

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ������ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ������ʧ��' 
    return 
end
GO

/* ��������Դ�ķ�ʽ����Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_Insert_Type5(@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @userid_1 int, @flag int output, @msg varchar(80) output)  AS

insert into DirAccessControlList(dirid, dirtype, userid, operationcode, permissiontype) values(@dirid_1, @dirtype_1, @userid_1, @operationcode_1, 5)
execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ������ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ������ʧ��' 
    return 
end
GO

/* ɾ��Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_Delete(@mainid_1 int, @flag int output, @msg varchar(80) output)  AS

declare @dirid_1 int, @dirtype_1 int, @operationcode_1 int, @departmentid_1 int, @roleid_1 int, @rolelevel_1 int, @seclevel_1 int, @permissiontype_1 int, @usertype_1 int, @mainuserid_1 int
declare permission_cursor cursor for
select dirid, dirtype, seclevel, departmentid, roleid, rolelevel, usertype, permissiontype, operationcode, userid from DirAccessControlList where mainid = @mainid_1

open permission_cursor
fetch next from permission_cursor
into @dirid_1, @dirtype_1, @seclevel_1, @departmentid_1, @roleid_1, @rolelevel_1, @usertype_1, @permissiontype_1, @operationcode_1, @mainuserid_1

close permission_cursor
deallocate permission_cursor

if @@fetch_status = 0 begin
  declare @userid_1 int
  declare @count int
  
  if @permissiontype_1 = 1 begin
    declare users_cursor cursor for
    select distinct id from HrmResource where departmentid = @departmentid_1 and seclevel >= @seclevel_1
    open users_cursor
    fetch next from users_cursor
    into @userid_1
    
    while @@fetch_status = 0
    begin
      execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
      fetch next from users_cursor
      into @userid_1
    end
    close users_cursor
    deallocate users_cursor
  end
  else if @permissiontype_1 = 2 begin
    declare users_cursor cursor for
    select distinct HrmResource.id from HrmResource, HrmRoleMembers where roleid = @roleid_1 and rolelevel >= @rolelevel_1 and HrmResource.id = HrmRoleMembers.resourceid and seclevel >= @seclevel_1
    open users_cursor
    fetch next from users_cursor
    into @userid_1
    
    while @@fetch_status = 0
    begin
      execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
      fetch next from users_cursor
      into @userid_1
    end
    close users_cursor
    deallocate users_cursor
  end
  else if @permissiontype_1 = 3 begin
    declare users_cursor cursor for
    select distinct id from HrmResource where seclevel >= @seclevel_1
    open users_cursor
    fetch next from users_cursor
    into @userid_1
    
    while @@fetch_status = 0
    begin
      execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
      fetch next from users_cursor
      into @userid_1
    end
    close users_cursor
    deallocate users_cursor
  end
  else if @permissiontype_1 = 4 begin
    if @usertype_1 = 0 begin
      declare users_cursor cursor for
      select distinct id from HrmResource where seclevel >= @seclevel_1
      open users_cursor
      fetch next from users_cursor
      into @userid_1
      
      while @@fetch_status = 0
      begin
        execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,@usertype_1,@operationcode_1
        fetch next from users_cursor
        into @userid_1
      end      
      close users_cursor
      deallocate users_cursor
    end
  end
  else if @permissiontype_1 = 5 begin
    execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@mainuserid_1,0,@operationcode_1
  end
  
  delete from DirAccessControlList where mainid = @mainid_1
end

if @@error<>0 begin 
    set @flag=1 
    set @msg='ɾ��Ŀ¼����Ȩ�ޱ�ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='ɾ��Ŀ¼����Ȩ�ޱ�ʧ��' 
    return 
end
GO

/* ɾ����Ŀ¼������Ȩ�� */
create procedure Doc_DirAcl_CPermissionForDir(@dirid_1 int, @dirtype_1 int, @flag int output, @msg varchar(80) output) as 

delete from DirAccessControlList where dirid = @dirid_1 and dirtype = @dirtype_1
delete from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1

if @@error<>0 begin 
    set @flag=1 
    set @msg='���Ŀ¼����Ȩ�ޱ�ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='���Ŀ¼����Ȩ�ޱ�ʧ��' 
    return 
end

GO

/* ɾ�����û�������Ȩ�� */
create procedure Doc_DirAcl_CPermissionForUser(@userid_1 int, @usertype_1 int, @flag int output, @msg varchar(80) output) as 

if @usertype_1 = 0 begin
    delete from DirAccessPermission where userid = @userid_1 and usertype = @usertype_1
end

if @@error<>0 begin 
    set @flag=1 
    set @msg='���Ŀ¼����Ȩ�ޱ�ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='���Ŀ¼����Ȩ�ޱ�ʧ��' 
    return 
end
GO

/* Ϊ�����û��������б�Ȩ�ޱ������Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_GrantUserPermission(@userid_1 int, @flag int output, @msg varchar(80) output)  AS

/*  �����HrmResource����ֶ���ص�Ȩ���жϣ���ʱ�����İ�ȫ����Ҳ���ں���ʹ�� */

declare @departmentid_1 int, @seclevel_1 int
declare user_cursor cursor for
select departmentid, seclevel from HrmResource where id = @userid_1
open user_cursor
fetch next from user_cursor
into @departmentid_1, @seclevel_1
close user_cursor
deallocate user_cursor

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int
declare @isValidUser int

if @@fetch_status = 0 begin
  set @isValidUser = 1
  declare permission_cursor cursor for
  select mainid, dirid, dirtype, operationcode from DirAccessControlList 
  where (permissiontype=1 and departmentid=@departmentid_1 and seclevel<=@seclevel_1) or 
        (permissiontype=3 and seclevel<=@seclevel_1) or
        (permissiontype=4 and usertype=0 and seclevel<=@seclevel_1) or
        (permissiontype=5 and userid=@userid_1)
  
  open permission_cursor
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  
  while @@fetch_status = 0
  begin
    execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
    fetch next from permission_cursor
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  end
  
  close permission_cursor
  deallocate permission_cursor
end
else begin
  set @isValidUser = 0
end

/* �����ɫ��ص�Ȩ���ж� */

if @isValidUser = 1 begin
  declare @roleid_1 int, @rolelevel_1 int
  declare user_role_cursor cursor for
  select roleid, rolelevel from HrmRoleMembers where resourceid = @userid_1
  
  open user_role_cursor
  fetch next from user_role_cursor
  into @roleid_1, @rolelevel_1
  
  while @@fetch_status = 0 begin
    declare permission_cursor cursor for
    select mainid, dirid, dirtype, operationcode from DirAccessControlList 
    where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)
    
    open permission_cursor
    fetch next from permission_cursor
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
    while @@fetch_status = 0
    begin
      execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
      fetch next from permission_cursor
      into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
    end
    close permission_cursor
    deallocate permission_cursor
    
    fetch next from user_role_cursor
    into @roleid_1, @rolelevel_1
  end
  
  close user_role_cursor
  deallocate user_role_cursor
end

if @@error<>0 begin 
    set @flag=1 
    set @msg='����Ŀ¼����Ȩ�޳ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='����Ŀ¼����Ȩ��ʧ��' 
    return 
end
GO

/* Ϊ�����û��������б�Ȩ�ޱ������Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_DUserPermission(@userid_1 int, @flag int output, @msg varchar(80) output)  AS

/*  �����HrmResource����ֶ���ص�Ȩ���жϣ���ʱ�����İ�ȫ����Ҳ���ں���ʹ�� */

declare @departmentid_1 int, @seclevel_1 int
declare user_cursor cursor for
select departmentid, seclevel from HrmResource where id = @userid_1
open user_cursor
fetch next from user_cursor
into @departmentid_1, @seclevel_1
close user_cursor
deallocate user_cursor

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int
declare @isValidUser int

if @@fetch_status = 0 begin
  set @isValidUser = 1
  declare permission_cursor cursor for
  select mainid, dirid, dirtype, operationcode from DirAccessControlList 
  where (permissiontype=1 and departmentid=@departmentid_1 and seclevel<=@seclevel_1) or 
        (permissiontype=3 and seclevel<=@seclevel_1) or
        (permissiontype=4 and usertype=0 and seclevel<=@seclevel_1) or 
        (permissiontype=5 and userid=@userid_1)
  
  open permission_cursor
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  
  while @@fetch_status = 0
  begin
    execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
    fetch next from permission_cursor
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  end
  
  close permission_cursor
  deallocate permission_cursor
end
else begin
  set @isValidUser = 0
end

/* �����ɫ��ص�Ȩ���ж� */

if @isValidUser = 1 begin
  declare @roleid_1 int, @rolelevel_1 int
  declare user_role_cursor cursor for
  select roleid, rolelevel from HrmRoleMembers where resourceid = @userid_1
  
  open user_role_cursor
  fetch next from user_role_cursor
  into @roleid_1, @rolelevel_1
  
  while @@fetch_status = 0 begin
    declare permission_cursor cursor for
    select mainid, dirid, dirtype, operationcode from DirAccessControlList 
    where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)
    
    open permission_cursor
    fetch next from permission_cursor
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
    while @@fetch_status = 0
    begin
      execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
      fetch next from permission_cursor
      into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
    end
    close permission_cursor
    deallocate permission_cursor
    
    fetch next from user_role_cursor
    into @roleid_1, @rolelevel_1
  end
  
  close user_role_cursor
  deallocate user_role_cursor
end

if @@error<>0 begin 
    set @flag=1 
    set @msg='ȡ��Ŀ¼����Ȩ�޳ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='ȡ��Ŀ¼����Ȩ��ʧ��' 
    return 
end
GO

/* ����Ƿ�ӵ��Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_CheckPermission(@dirid_1 int, @dirtype_1 int, @userid_1 int, @usertype_1 int, @seclevel_1 int, @operationcode_1 int, @flag int output, @msg varchar(80) output)  AS

declare @count_1 int
declare @result int

set @result = 0

if @usertype_1 = 0 begin
    if @operationcode_1 = 0 begin
        set @count_1 = (select createdoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
    end
    else if @operationcode_1 = 1 begin
        set @count_1 = (select createdir from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
    end
    else if @operationcode_1 = 2 begin
        set @count_1 = (select movedoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1)
    end
    else if @operationcode_1 = 3 begin
        select @count_1 = copydoc from DirAccessPermission where dirid = @dirid_1 and dirtype = @dirtype_1 and userid = @userid_1 and usertype = @usertype_1
    end
end
else begin
    set @count_1 = (select count(mainid) from DirAccessControlList where dirid=@dirid_1 and dirtype=@dirtype_1 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1)))
end

if (not (@count_1 is null)) and (@count_1 > 0) begin
    set @result = 1
end

select @result result

if @@error<>0 begin 
    set @flag=1 
    set @msg='���Ŀ¼����Ȩ�޳ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='���Ŀ¼����Ȩ��ʧ��' 
    return 
end
GO

/* �����û�ӵ��Ȩ�޵���Ŀ¼ */
CREATE PROCEDURE Doc_MainCategory_FindByUser @userid_1 int, @usertype_1 int, @operationcode_1 int, @flag	int	output, @msg varchar(80) output as 
if @operationcode_1 = 0 begin
    select 'mainid' = id from DocMainCategory where id in (
        select distinct maincategoryid from DocSubCategory where id in (
            select distinct subcategoryid from DocSecCategory where id in (
                select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and createdoc > 0
                )
            )
        )
    order by categoryorder
end
else if @operationcode_1 = 1 begin
    select 'mainid' = id from DocMainCategory where id in (
                select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=0 and createdir > 0
        )
    order by categoryorder
end
else if @operationcode_1 = 2 begin
    select 'mainid' = id from DocMainCategory where id in (
                select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=0 and movedoc > 0
        )
    order by categoryorder
end
else if @operationcode_1 = 3 begin
    select 'mainid' = id from DocMainCategory where id in (
                select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=0 and copydoc > 0
        )
    order by categoryorder
end
GO

/* �����û�ӵ��Ȩ�޵ķ�Ŀ¼ */
CREATE PROCEDURE Doc_SubCategory_FindByUser @userid_1 int, @usertype_1 int, @operationcode_1 int, @flag	int	output, @msg	varchar(80) output as 
if @operationcode_1 = 0 begin
    select distinct subcategoryid mainid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and createdoc>0)
end
else if @operationcode_1 = 1 begin
    select distinct dirid mainid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=1 and createdir>0
end
else if @operationcode_1 = 2 begin
    select distinct dirid mainid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=1 and movedoc>0
end
else if @operationcode_1 = 3 begin
    select distinct dirid mainid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=1 and copydoc>0
end
GO

/* �����û�ӵ��Ȩ�޵���Ŀ¼ */
CREATE PROCEDURE Doc_SecCategory_FindByUser @userid_1 int, @usertype_1 int, @operationcode_1 int, @flag	int	output, @msg	varchar(80) output as 
if @operationcode_1 = 0 begin
    select distinct id mainid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and createdoc>0)
end
else if @operationcode_1 = 1 begin
    select distinct id mainid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and createdir>0)
end
else if @operationcode_1 = 2 begin
    select distinct id mainid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and movedoc>0)
end
else if @operationcode_1 = 3 begin
    select distinct id mainid from DocSecCategory where id in (select distinct dirid from DirAccessPermission where userid=@userid_1 and usertype=@usertype_1 and dirtype=2 and copydoc>0)
end  
GO

/* �����ⲿ�û�ӵ��Ȩ�޵���Ŀ¼ */
CREATE PROCEDURE Doc_MainCategory_FByUser_Out @usertype_1 int, @seclevel_1 int, @operationcode_1 int, @flag	int	output, @msg varchar(80) output as 
if @operationcode_1 = 0 begin
    select 'mainid' = id from DocMainCategory where id in (
        select distinct maincategoryid from DocSubCategory where id in (
            select distinct subcategoryid from DocSecCategory where id in (
                select distinct dirid from DirAccessControlList where dirtype=2 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1))
                )
            )
        )
    order by categoryorder
end
else if (@operationcode_1 = 1) or (@operationcode_1 = 2) or (@operationcode_1 = 3) begin
    select 'mainid' = id from DocMainCategory where id in (
        select distinct dirid from DirAccessControlList where dirtype=0 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1))
        )
    order by categoryorder
end

GO

/* �����ⲿ�û�ӵ��Ȩ�޵ķ�Ŀ¼ */
CREATE PROCEDURE Doc_SubCategory_FindByUser_Out @usertype_1 int, @seclevel_1 int, @operationcode_1 int, @flag	int	output, @msg	varchar(80) output as 
if @operationcode_1 = 0 begin
    select distinct subcategoryid mainid from DocSecCategory where id in (
        select distinct dirid from DirAccessControlList where dirtype=2 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1))
        )
end
else if (@operationcode_1 = 1) or (@operationcode_1 = 2) or (@operationcode_1 = 3) begin
    select distinct id mainid from DocSubCategory where id in (
        select distinct dirid from DirAccessControlList where dirtype=1 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1))
        )
end
GO

/* �����ⲿ�û�ӵ��Ȩ�޵���Ŀ¼ */
CREATE PROCEDURE Doc_SecCategory_FindByUser_Out(@usertype_1 int, @seclevel_1 int, @operationcode_1 int, @flag int output, @msg varchar(80) output)  AS

select distinct dirid mainid from DirAccessControlList where dirtype=2 and operationcode=@operationcode_1 and ((permissiontype=3 and seclevel<=@seclevel_1) or (permissiontype=4 and usertype=@usertype_1 and seclevel<=@seclevel_1))

if @@error<>0 begin 
    set @flag=1 
    set @msg='���Ŀ¼����Ȩ�޳ɹ�' 
    return end 
else begin 
    set @flag=0 
    set @msg='���Ŀ¼����Ȩ��ʧ��' 
    return 
end
GO

/* ����Ŀ¼ѡ��Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_SByDirID (@dirid_1 int, @dirtype_1 int, @operationcode_1 int, @flag	int output, @msg	varchar(80)	output) as 
    select * from DirAccessControlList where dirid=@dirid_1 and dirtype=@dirtype_1 and operationcode=@operationcode_1
GO

/* ���û�������Ϣ�����仯ʱ����ȡ��Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_DUserP_BasicChange(@userid_1 int, @departmentid_1 int, @seclevel_1 int)  AS

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int

/* �����1,3,4,5��Ȩ�޵�Ӱ�� */
declare permission_cursor cursor for
select mainid, dirid, dirtype, operationcode from DirAccessControlList 
where (permissiontype=1 and departmentid=@departmentid_1 and seclevel<=@seclevel_1) or 
      (permissiontype=3 and seclevel<=@seclevel_1) or
      (permissiontype=4 and usertype=0 and seclevel<=@seclevel_1) or 
      (permissiontype=5 and userid=@userid_1)

open permission_cursor
fetch next from permission_cursor
into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1

while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
end

close permission_cursor
deallocate permission_cursor

/* �����2��Ȩ�޵�Ӱ�� */
declare @roleid_1 int, @rolelevel_1 int
declare user_role_cursor cursor for
select roleid, rolelevel from HrmRoleMembers where resourceid = @userid_1

open user_role_cursor
fetch next from user_role_cursor
into @roleid_1, @rolelevel_1

while @@fetch_status = 0 begin
  declare permission_cursor1 cursor for
  select mainid, dirid, dirtype, operationcode from DirAccessControlList 
  where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)
  
  open permission_cursor1
  fetch next from permission_cursor1
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  while @@fetch_status = 0
  begin
    execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
    fetch next from permission_cursor1
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  end
  close permission_cursor1
  deallocate permission_cursor1
  
  fetch next from user_role_cursor
  into @roleid_1, @rolelevel_1
end

close user_role_cursor
deallocate user_role_cursor

GO

/* ���û���ɫ�����仯ʱ����ȡ�����Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_DUserP_RoleChange(@userid_1 int, @roleid_1 int, @rolelevel_1 int, @seclevel_1 int)  AS

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int
declare permission_cursor cursor for
select mainid, dirid, dirtype, operationcode from DirAccessControlList 
where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)

open permission_cursor
fetch next from permission_cursor
into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Delete @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
end
close permission_cursor
deallocate permission_cursor

GO

/* ���û�������Ϣ�����仯ʱ��������Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_GUserP_BasicChange(@userid_1 int, @departmentid_1 int, @seclevel_1 int)  AS

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int
/* �����1,3,4,5��Ȩ�޵�Ӱ�� */
declare permission_cursor cursor for
select mainid, dirid, dirtype, operationcode from DirAccessControlList 
where (permissiontype=1 and departmentid=@departmentid_1 and seclevel<=@seclevel_1) or 
      (permissiontype=3 and seclevel<=@seclevel_1) or
      (permissiontype=4 and usertype=0 and seclevel<=@seclevel_1) or 
      (permissiontype=5 and userid=@userid_1)

open permission_cursor
fetch next from permission_cursor
into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1

while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
end

close permission_cursor
deallocate permission_cursor

/* �����2��Ȩ�޵�Ӱ�� */
declare @roleid_1 int, @rolelevel_1 int
declare user_role_cursor cursor for
select roleid, rolelevel from HrmRoleMembers where resourceid = @userid_1

open user_role_cursor
fetch next from user_role_cursor
into @roleid_1, @rolelevel_1

while @@fetch_status = 0 begin
  declare permission_cursor1 cursor for
  select mainid, dirid, dirtype, operationcode from DirAccessControlList 
  where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)
  
  open permission_cursor1
  fetch next from permission_cursor1
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  while @@fetch_status = 0
  begin
    execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
    fetch next from permission_cursor1
    into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
  end
  close permission_cursor1
  deallocate permission_cursor1
  
  fetch next from user_role_cursor
  into @roleid_1, @rolelevel_1
end

close user_role_cursor
deallocate user_role_cursor
  
GO

/* ���û���ɫ�����仯ʱ����ȡ��Ȩ�� */
CREATE PROCEDURE Doc_DirAcl_GUserP_RoleChange(@userid_1 int, @roleid_1 int, @rolelevel_1 int, @seclevel_1 int)  AS

declare @mainid_1 int, @dirid_1 int, @dirtype_1 int, @operationcode_1 int
declare permission_cursor cursor for
select mainid, dirid, dirtype, operationcode from DirAccessControlList 
where (permissiontype=2 and roleid=@roleid_1 and rolelevel<=@rolelevel_1 and seclevel<=@seclevel_1)

open permission_cursor
fetch next from permission_cursor
into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
while @@fetch_status = 0
begin
  execute Doc_DirAccessPermission_Insert @dirid_1,@dirtype_1,@userid_1,0,@operationcode_1
  fetch next from permission_cursor
  into @mainid_1, @dirid_1, @dirtype_1, @operationcode_1
end
close permission_cursor
deallocate permission_cursor
GO

/* �Ӿɱ�������� */
CREATE PROCEDURE Doc_DirAcl_InsertFromOldTable as 

declare @secid_1 int, @usertype_1 int, @seclevel_1 int
declare @department1_1 int, @dseclevel1_1 int, @department2_1 int, @dseclevel2_1 int
declare @roleid1_1 int, @rolelevel1_1 int, @roleid2_1 int, @rolelevel2_1 int, @roleid3_1 int, @rolelevel3_1 int
declare oldpermission_cursor cursor for
select id,cusertype,cuserseclevel,cdepartmentid1,cdepseclevel1,cdepartmentid2,cdepseclevel2,croleid1,crolelevel1,croleid2,crolelevel2,croleid3,crolelevel3 from DocSecCategory

open oldpermission_cursor
fetch next from oldpermission_cursor
into @secid_1, @usertype_1, @seclevel_1, @department1_1, @dseclevel1_1, @department2_1, @dseclevel2_1, @roleid1_1, @rolelevel1_1, @roleid2_1, @rolelevel2_1, @roleid3_1, @rolelevel3_1

while @@fetch_status=0 begin
  execute Doc_DirAcl_Insert_Type4 @secid_1,2,0,@usertype_1,@seclevel_1,1,1
  if not (@department1_1=0) begin
    execute Doc_DirAcl_Insert_Type1 @secid_1,2,0,@department1_1,@dseclevel1_1,1,1
  end
  if not (@department2_1=0) begin
    execute Doc_DirAcl_Insert_Type1 @secid_1,2,0,@department2_1,@dseclevel2_1,1,1
  end
  if not (@roleid1_1=0) begin
    execute Doc_DirAcl_Insert_Type2 @secid_1,2,0,@roleid1_1,@rolelevel1_1,0,1,1
  end
  if not (@roleid2_1=0) begin
    execute Doc_DirAcl_Insert_Type2 @secid_1,2,0,@roleid2_1,@rolelevel2_1,0,1,1
  end
  if not (@roleid3_1=0) begin
    execute Doc_DirAcl_Insert_Type2 @secid_1,2,0,@roleid3_1,@rolelevel3_1,0,1,1
  end
  
  fetch next from oldpermission_cursor
  into @secid_1, @usertype_1, @seclevel_1, @department1_1, @dseclevel1_1, @department2_1, @dseclevel2_1, @roleid1_1, @rolelevel1_1, @roleid2_1, @rolelevel2_1, @roleid3_1, @rolelevel3_1
end

close oldpermission_cursor
deallocate oldpermission_cursor

GO

exec Doc_DirAcl_InsertFromOldTable
go

insert into htmllabelinfo values(7175, '���ţ���ȫ����', 7)
go
insert into htmllabelinfo values(7175, 'department+security level', 8)
go
insert into htmllabelinfo values(7176, '��ɫ����ȫ���𣫼���', 7)
go
insert into htmllabelinfo values(7176, 'role+security level+role level', 8)
go
insert into htmllabelinfo values(7177, '��ȫ����', 7)
go
insert into htmllabelinfo values(7177, 'security level', 8)
go
insert into htmllabelinfo values(7178, '�û����ͣ���ȫ����', 7)
go
insert into htmllabelinfo values(7178, 'usertype+security level', 8)
go
insert into htmllabelinfo values(7179, '�û�����', 7)
go
insert into htmllabelinfo values(7179, 'usertype', 8)
go

/* �޸�hrmresource��trigger */
alter TRIGGER Tri_Update_HrmresourceShare ON Hrmresource WITH ENCRYPTION
FOR UPDATE
AS
Declare @resourceid_1 int,
        @subresourceid_1 int,
        @supresourceid_1 int,
        @olddepartmentid_1 int,
        @departmentid_1 int,
	    @subcompanyid_1 int,
        @oldseclevel_1	 int,
	    @seclevel_1	 int,
        @docid_1	 int,
        @crmid_1	 int,
	    @prjid_1	 int,
	    @cptid_1	 int,
        @sharelevel_1  int,
        @countrec      int,
        @countdelete   int,
        @oldmanagerstr_1    varchar(200),
        @managerstr_1    varchar(200)
        
/* �Ӹ��޸ĵ����в����޸ĵ�resourceid �� */
select @olddepartmentid_1 = departmentid, @oldseclevel_1 = seclevel , 
       @oldmanagerstr_1 = managerstr from deleted
select @resourceid_1 = id , @departmentid_1 = departmentid, @subcompanyid_1 = subcompanyid1 ,  
       @seclevel_1 = seclevel , @managerstr_1 = managerstr from inserted

/* ������źͰ�ȫ������Ϣ���޸� */
if ( @departmentid_1 <>@olddepartmentid_1 or  @seclevel_1 <> @oldseclevel_1 or @oldseclevel_1 is null )     
begin
    if @departmentid_1 is null   set @departmentid_1 = 0
    if @subcompanyid_1 is null   set @subcompanyid_1 = 0

    /* �޸�Ŀ¼��ɱ� */
    if ((@olddepartmentid_1 is not null) and (@oldseclevel_1 is not null)) begin
        execute Doc_DirAcl_DUserP_BasicChange @resourceid_1, @olddepartmentid_1, @oldseclevel_1
    end
    if ((@departmentid_1 is not null) and (@seclevel_1 is not null)) begin
        execute Doc_DirAcl_GUserP_BasicChange @resourceid_1, @departmentid_1, @seclevel_1
    end

    /* �����½��ĵ�Ŀ¼���б� */
    exec DocUserCategory_InsertByUser @resourceid_1,'0','',''
    
    /* DOC ����*/

    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = @resourceid_1 and usertype = 1

    /* ������ʱ����� */
    Declare @temptablevalue  table(docid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevalue �� */
    /*  �Լ������Ļ����� owner �����¿��Ա༭ */
    declare docid_cursor cursor for
    select distinct id from DocDetail where ( doccreaterid = @resourceid_1 or ownerid = @resourceid_1 ) and usertype= '1'
    open docid_cursor 
    fetch next from docid_cursor into @docid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, 2)
        fetch next from docid_cursor into @docid_1
    end
    close docid_cursor deallocate docid_cursor


    /* �Լ��¼����ĵ� */
    /* �����¼� */
    declare @managerstr_11 varchar(200) 
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subdocid_cursor cursor for
    select distinct id from DocDetail where ( doccreaterid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) or ownerid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) ) and usertype= '1'
    open subdocid_cursor 
    fetch next from subdocid_cursor into @docid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1
        if @countrec = 0  insert into @temptablevalue values(@docid_1, 1)
        fetch next from subdocid_cursor into @docid_1
    end
    close subdocid_cursor deallocate subdocid_cursor
         


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    declare sharedocid_cursor cursor for
    select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= @seclevel_1 )  or ( userid= @resourceid_1 ) or (departmentid= @departmentid_1 and seclevel<= @seclevel_1 )
    open sharedocid_cursor 
    fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalue values(@docid_1, @sharelevel_1)
        end
        else if @sharelevel_1 = 2  
        begin
            update @temptablevalue set sharelevel = 2 where docid=@docid_1 /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
        end
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    end 
    close sharedocid_cursor deallocate sharedocid_cursor

    declare sharedocid_cursor cursor for
    select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.docid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= @departmentid_1 ) or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
    open sharedocid_cursor 
    fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalue values(@docid_1, @sharelevel_1)
        end
        else if @sharelevel_1 = 2  
        begin
            update @temptablevalue set sharelevel = 2 where docid=@docid_1 /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
        end
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    end 
    close sharedocid_cursor deallocate sharedocid_cursor



    /* ����ʱ���е�����д�빲��� */
    declare alldocid_cursor cursor for
    select * from @temptablevalue
    open alldocid_cursor 
    fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into docsharedetail values(@docid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    end
    close alldocid_cursor deallocate alldocid_cursor


    /* ------- CRM  ���� ------- */


    /* ɾ��ԭ�еĸ��˵����пͻ�������Ϣ */
	delete from CrmShareDetail where userid = @resourceid_1 and usertype = 1

    /* ������ʱ����� */
    Declare @temptablevaluecrm  table(crmid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevaluecrm �� */
    /*  �Լ��� manager �Ŀͻ� 2 */
    declare crmid_cursor cursor for
    select id from CRM_CustomerInfo where manager = @resourceid_1 
    open crmid_cursor 
    fetch next from crmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluecrm values(@crmid_1, 2)
        fetch next from crmid_cursor into @crmid_1
    end
    close crmid_cursor deallocate crmid_cursor


    /* �Լ��¼��Ŀͻ� 3 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcrmid_cursor cursor for
    select id from CRM_CustomerInfo where ( manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subcrmid_cursor 
    fetch next from subcrmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1
        if @countrec = 0  insert into @temptablevaluecrm values(@crmid_1, 3)
        fetch next from subcrmid_cursor into @crmid_1
    end
    close subcrmid_cursor deallocate subcrmid_cursor
 
    /* ��Ϊcrm����Ա�ܿ����Ŀͻ� */
    declare rolecrmid_cursor cursor for
   select distinct t1.id from CRM_CustomerInfo  t1, hrmrolemembers  t2  where t2.roleid=8 and t2.resourceid= @resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=@departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1 ))
    open rolecrmid_cursor 
    fetch next from rolecrmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1
        if @countrec = 0  insert into @temptablevaluecrm values(@crmid_1, 4)
        fetch next from rolecrmid_cursor into @crmid_1
    end
    close rolecrmid_cursor deallocate rolecrmid_cursor	 


    /* �ɿͻ��Ĺ����õ�Ȩ�� 1 2 */
    declare sharecrmid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CRM_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open sharecrmid_cursor 
    fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecrm values(@crmid_1, @sharelevel_1)
        end
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    end 
    close sharecrmid_cursor deallocate sharecrmid_cursor



    declare sharecrmid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=@resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=@seclevel_1 and ( (t2.rolelevel=0  and t1.department=@departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1) or (t3.rolelevel=2) ) 
    open sharecrmid_cursor 
    fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecrm values(@crmid_1, @sharelevel_1)
        end
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    end 
    close sharecrmid_cursor deallocate sharecrmid_cursor


    /* ����ʱ���е�����д�빲��� */
    declare allcrmid_cursor cursor for
    select * from @temptablevaluecrm
    open allcrmid_cursor 
    fetch next from allcrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(@crmid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allcrmid_cursor into @crmid_1 , @sharelevel_1
    end
    close allcrmid_cursor deallocate allcrmid_cursor



    /* ------- PROJ ���� ------- */

    /* ������ʱ����� */
    Declare @temptablevaluePrj  table(prjid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevaluePrj �� */
    /*  �Լ�����Ŀ2 */
    declare prjid_cursor cursor for
    select id from Prj_ProjectInfo where manager = @resourceid_1 
    open prjid_cursor 
    fetch next from prjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluePrj values(@prjid_1, 2)
        fetch next from prjid_cursor into @prjid_1
    end
    close prjid_cursor deallocate prjid_cursor


    /* �Լ��¼�����Ŀ3 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subprjid_cursor cursor for
    select id from Prj_ProjectInfo where ( manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subprjid_cursor 
    fetch next from subprjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1
        if @countrec = 0  insert into @temptablevaluePrj values(@prjid_1, 3)
        fetch next from subprjid_cursor into @prjid_1
    end
    close subprjid_cursor deallocate subprjid_cursor
 
    /* ��Ϊ��Ŀ����Ա�ܿ�������Ŀ4 */
    declare roleprjid_cursor cursor for
   select distinct t1.id from Prj_ProjectInfo  t1, hrmrolemembers  t2  where t2.roleid=9 and t2.resourceid= @resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=@departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1 ))
    open roleprjid_cursor 
    fetch next from roleprjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1
        if @countrec = 0  insert into @temptablevaluePrj values(@prjid_1, 4)
        fetch next from roleprjid_cursor into @prjid_1
    end
    close roleprjid_cursor deallocate roleprjid_cursor	 


    /* ����Ŀ�Ĺ����õ�Ȩ�� 1 2 */
    declare shareprjid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from Prj_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open shareprjid_cursor 
    fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, @sharelevel_1)
        end
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    end 
    close shareprjid_cursor deallocate shareprjid_cursor


    declare shareprjid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and  t3.resourceid=@resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=@seclevel_1 and ( (t2.rolelevel=0  and t1.department=@departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1) or (t3.rolelevel=2) ) 
    open shareprjid_cursor 
    fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, @sharelevel_1)
        end
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    end 
    close shareprjid_cursor deallocate shareprjid_cursor



    /* ��Ŀ��Ա5 (�ڲ��û�) */
	declare @members_1 varchar(200)
	set @members_1 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 
    declare inuserprjid_cursor cursor for
    SELECT  id FROM Prj_ProjectInfo   WHERE  (','+members+','  LIKE  @members_1)  and isblock='1' 
    open inuserprjid_cursor 
    fetch next from inuserprjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, 5)
        end
        fetch next from inuserprjid_cursor into @prjid_1
    end 
    close inuserprjid_cursor deallocate inuserprjid_cursor


    /* ɾ��ԭ�е������Ա��ص�������ĿȨ */
    delete from PrjShareDetail where userid = @resourceid_1 and usertype = 1

    /* ����ʱ���е�����д�빲��� */
    declare allprjid_cursor cursor for
    select * from @temptablevaluePrj
    open allprjid_cursor 
    fetch next from allprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(@prjid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allprjid_cursor into @prjid_1 , @sharelevel_1
    end
    close allprjid_cursor deallocate allprjid_cursor


    /* ------- CPT ���� ------- */

    /* ������ʱ����� */
    Declare @temptablevalueCpt  table(cptid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevalueCpt �� */
    /*  �Լ����ʲ�2 */
    declare cptid_cursor cursor for
    select id from CptCapital where resourceid = @resourceid_1 
    open cptid_cursor 
    fetch next from cptid_cursor into @cptid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalueCpt values(@cptid_1, 2)
        fetch next from cptid_cursor into @cptid_1
    end
    close cptid_cursor deallocate cptid_cursor


    /* �Լ��¼����ʲ�1 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcptid_cursor cursor for
    select id from CptCapital where ( resourceid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subcptid_cursor 
    fetch next from subcptid_cursor into @cptid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1
        if @countrec = 0  insert into @temptablevalueCpt values(@cptid_1, 1)
        fetch next from subcptid_cursor into @cptid_1
    end
    close subcptid_cursor deallocate subcptid_cursor
 
   
    /* ���ʲ��Ĺ����õ�Ȩ�� 1 2 */
    declare sharecptid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CptCapitalShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open sharecptid_cursor 
    fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalueCpt values(@cptid_1, @sharelevel_1)
        end
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    end 
    close sharecptid_cursor deallocate sharecptid_cursor


    declare sharecptid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.relateditemid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.departmentid= @departmentid_1 ) or (t2.rolelevel=1 and t1.departmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
    open sharecptid_cursor 
    fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalueCpt values(@cptid_1, @sharelevel_1)
        end       
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    end 
    close sharecptid_cursor deallocate sharecptid_cursor
    


    /* ɾ��ԭ�е������Ա��ص������ʲ�Ȩ */
    delete from CptShareDetail where userid = @resourceid_1 and usertype = 1

    /* ����ʱ���е�����д�빲��� */
    declare allcptid_cursor cursor for
    select * from @temptablevalueCpt
    open allcptid_cursor 
    fetch next from allcptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(@cptid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allcptid_cursor into @cptid_1 , @sharelevel_1
    end
    close allcptid_cursor deallocate allcptid_cursor



end        /* �����޸��˲��źͰ�ȫ�������� */
            

       
/* �����޸��˾����ֶ�,�µ������ϼ����ӶԸ��¼����ĵ�����,������Ϊ�ɶ� */
if ( @countdelete > 0 and @managerstr_1 <> @oldmanagerstr_1 )  /* �½�������Դʱ��Ծ����ֶεĸı䲻���� */
begin
    if ( @managerstr_1 is not null and len(@managerstr_1) > 1 )  /* ���ϼ����� */
    begin

        set @managerstr_1 = ',' + @managerstr_1

	/* ------- DOC ���� ------- */
        declare supuserid_cursor cursor for
        select distinct t1.id , t2.id from HrmResource t1, DocDetail t2 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and ( t2.doccreaterid = @resourceid_1 or t2.ownerid = @resourceid_1 ) and t2.usertype= '1' ;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @docid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from docsharedetail where docid = @docid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into docsharedetail values(@docid_1,@supresourceid_1,1,1)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @docid_1
        end
        close supuserid_cursor deallocate supuserid_cursor
	
	/* ------- CRM ���� ------- */
        declare supuserid_cursor cursor for
        select distinct t1.id , t2.id from HrmResource t1, CRM_CustomerInfo t2 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and  t2.manager = @resourceid_1  ;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @crmid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(crmid) from CrmShareDetail where crmid = @crmid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(@crmid_1,@supresourceid_1,1,3)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @crmid_1
        end
        close supuserid_cursor deallocate supuserid_cursor


	/* ------- PROJ ���� ------- */
	declare supuserid_cursor cursor for
        select distinct t1.id , t2.id from HrmResource t1, Prj_ProjectInfo t2 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and  t2.manager = @resourceid_1  ;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @prjid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(prjid) from PrjShareDetail where prjid = @prjid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(@prjid_1,@supresourceid_1,1,3)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @prjid_1
        end
        close supuserid_cursor deallocate supuserid_cursor


	/* ------- CPT ���� ------- */
	declare supuserid_cursor cursor for
        select distinct t1.id , t2.id from HrmResource t1, CptCapital t2 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and  t2.resourceid = @resourceid_1  ;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @cptid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(cptid) from CptShareDetail where cptid = @cptid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(@cptid_1,@supresourceid_1,1,1)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @cptid_1
        end
        close supuserid_cursor deallocate supuserid_cursor


    end             /* ���ϼ������ж����� */
end   /* �޸ľ�����ж����� */

go

/* �޸�hrmrolemembers��trigger ���ڽ�ɫ��ĸ��� */
ALTER TRIGGER Tri_Update_HrmRoleMembersShare ON HrmRoleMembers WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS
Declare @roleid_1 int,
        @resourceid_1 int,
        @oldrolelevel_1 char(1),
        @oldroleid_1 int,
        @oldresourceid_1 int,
        @rolelevel_1 char(1),
        @docid_1	 int,
	    @crmid_1	 int,
	    @prjid_1	 int,
	    @cptid_1	 int,
        @sharelevel_1  int,
        @departmentid_1 int,
	    @subcompanyid_1 int,
        @seclevel_1	 int,
        @countrec      int,
        @countdelete   int,
        @countinsert   int
        
/* ĳһ���˼���һ����ɫ�����ڽ�ɫ�еļ������߽��д���,������������������˹���ķ�Χ,����Ҫɾ��
ԭ�й�����Ϣ,ֻ��Ҫ�ж����ӵĲ���, �����ڽ�ɫ�м���Ľ��ͻ���ɾ��ĳһ����Ա,ֻ��ɾ��ȫ������ϸ��,����������Դһ��
�˵Ĳ��Ż��߰�ȫ����ı�Ĳ��� */

select @countdelete = count(*) from deleted
select @countinsert = count(*) from inserted

select @oldrolelevel_1 = rolelevel, @oldroleid_1 = roleid, @oldresourceid_1 = resourceid from deleted

if @countinsert > 0 
    select @roleid_1 = roleid , @resourceid_1 = resourceid, @rolelevel_1 = rolelevel from inserted
else 
    select @roleid_1 = roleid , @resourceid_1 = resourceid, @rolelevel_1 = rolelevel from deleted

/* �����ɾ��ԭ�����ݣ�����ɱ��е�Ȩ���������һ */
if (@countdelete > 0) begin
    select @seclevel_1 = seclevel from hrmresource where id = @oldresourceid_1
    if @seclevel_1 is not null begin
        execute Doc_DirAcl_DUserP_RoleChange @oldresourceid_1, @oldroleid_1, @oldrolelevel_1, @seclevel_1
    end
end
/* ��������������ݣ�����ɱ��е�Ȩ���������һ */
if (@countinsert > 0) begin
    select @seclevel_1 = seclevel from hrmresource where id = @resourceid_1
    if @seclevel_1 is not null begin
        execute Doc_DirAcl_GUserP_RoleChange @resourceid_1, @roleid_1, @rolelevel_1, @seclevel_1
    end
end

if ( @countinsert >0 and ( @countdelete = 0 or @rolelevel_1  > @oldrolelevel_1 ) )     
begin
    select @departmentid_1 = departmentid , @subcompanyid_1 = subcompanyid1 , @seclevel_1 = seclevel 
    from hrmresource where id = @resourceid_1 
    if @departmentid_1 is null   set @departmentid_1 = 0
    if @subcompanyid_1 is null   set @subcompanyid_1 = 0

    if @rolelevel_1 = '2'       /* �µĽ�ɫ����Ϊ�ܲ��� */
    begin 

	/* ------- DOC ���� ------- */

        declare sharedocid_cursor cursor for
        select distinct docid , sharelevel from DocShare where roleid = @roleid_1 and rolelevel <= @rolelevel_1 and seclevel <= @seclevel_1 
        open sharedocid_cursor 
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from docsharedetail where docid = @docid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into docsharedetail values(@docid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update docsharedetail set sharelevel = 2 where docid=@docid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        end 
        close sharedocid_cursor deallocate sharedocid_cursor

	/* ------- CRM ���� ------- */

	declare sharecrmid_cursor cursor for
        select distinct relateditemid , sharelevel from CRM_ShareInfo where roleid = @roleid_1 and rolelevel <= @rolelevel_1 and seclevel <= @seclevel_1 
        open sharecrmid_cursor 
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(crmid) from CrmShareDetail where crmid = @crmid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CrmShareDetail values(@crmid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CrmShareDetail set sharelevel = 2 where crmid=@crmid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        end 
        close sharecrmid_cursor deallocate sharecrmid_cursor


	/* ------- PROJ ���� ------- */

	declare shareprjid_cursor cursor for
        select distinct relateditemid , sharelevel from Prj_ShareInfo where roleid = @roleid_1 and rolelevel <= @rolelevel_1 and seclevel <= @seclevel_1 
        open shareprjid_cursor 
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(prjid) from PrjShareDetail where prjid = @prjid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into PrjShareDetail values(@prjid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update PrjShareDetail set sharelevel = 2 where prjid=@prjid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        end 
        close shareprjid_cursor deallocate shareprjid_cursor


	/* ------- CPT ���� ------- */

	declare sharecptid_cursor cursor for
        select distinct relateditemid , sharelevel from CptCapitalShareInfo where roleid = @roleid_1 and rolelevel <= @rolelevel_1 and seclevel <= @seclevel_1 
        open sharecptid_cursor 
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(cptid) from CptShareDetail where cptid = @cptid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CptShareDetail values(@cptid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CptShareDetail set sharelevel = 2 where cptid=@cptid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        end 
        close sharecptid_cursor deallocate sharecptid_cursor


    end
    else if @rolelevel_1 = '1'          /* �µĽ�ɫ����Ϊ�ֲ��� */
    begin

	/* ------- DOC ���� ------- */
        declare sharedocid_cursor cursor for
        select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2 , hrmdepartment  t4 where t1.id=t2.docid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= @subcompanyid_1
        open sharedocid_cursor 
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from docsharedetail where docid = @docid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into docsharedetail values(@docid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update docsharedetail set sharelevel = 2 where docid=@docid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        end 
        close sharedocid_cursor deallocate sharedocid_cursor


	/* ------- CRM ���� ------- */
       declare sharecrmid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.department = t4.id and t4.subcompanyid1= @subcompanyid_1
        open sharecrmid_cursor 
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(crmid) from CrmShareDetail where crmid = @crmid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CrmShareDetail values(@crmid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CrmShareDetail set sharelevel = 2 where crmid = @crmid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        end 
        close sharecrmid_cursor deallocate sharecrmid_cursor

	/* ------- PRJ ���� ------- */

	declare shareprjid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.department=t4.id and t4.subcompanyid1= @subcompanyid_1
        open shareprjid_cursor 
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(prjid) from PrjShareDetail where prjid = @prjid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into PrjShareDetail values(@prjid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update PrjShareDetail set sharelevel = 2 where prjid=@prjid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        end 
        close shareprjid_cursor deallocate shareprjid_cursor

	/* ------- CPT ���� ------- */

	declare sharecptid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2 , hrmdepartment  t4 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.departmentid=t4.id and t4.subcompanyid1= @subcompanyid_1
        open sharecptid_cursor 
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(cptid) from CptShareDetail where cptid = @cptid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CptShareDetail values(@cptid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CptShareDetail set sharelevel = 2 where cptid=@cptid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        end 
        close sharecptid_cursor deallocate sharecptid_cursor


    end
    else if @rolelevel_1 = '0'          /* Ϊ�½�ʱ���趨����Ϊ���ż� */
    begin

        /* ------- DOC ���� ------- */

	declare sharedocid_cursor cursor for
        select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2 where t1.id=t2.docid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.docdepartmentid= @departmentid_1
        open sharedocid_cursor 
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from docsharedetail where docid = @docid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into docsharedetail values(@docid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update docsharedetail set sharelevel = 2 where docid=@docid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
        end 
        close sharedocid_cursor deallocate sharedocid_cursor
	
	/* ------- CRM ���� ------- */

	declare sharecrmid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.department = @departmentid_1
        open sharecrmid_cursor 
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(crmid) from CrmShareDetail where crmid = @crmid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CrmShareDetail values(@crmid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CrmShareDetail set sharelevel = 2 where crmid = @crmid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
        end 
        close sharecrmid_cursor deallocate sharecrmid_cursor

	/* ------- PRJ ���� ------- */

	declare shareprjid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.department= @departmentid_1
        open shareprjid_cursor 
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(prjid) from PrjShareDetail where prjid = @prjid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into PrjShareDetail values(@prjid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update PrjShareDetail set sharelevel = 2 where prjid = @prjid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
        end 
        close shareprjid_cursor deallocate shareprjid_cursor

	/* ------- CPT ���� ------- */

	declare sharecptid_cursor cursor for
        select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2 where t1.id=t2.relateditemid and t2.roleid = @roleid_1 and t2.rolelevel <= @rolelevel_1 and t2.seclevel <= @seclevel_1 and t1.departmentid= @departmentid_1
        open sharecptid_cursor 
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(cptid) from CptShareDetail where cptid = @cptid_1 and userid = @resourceid_1 and usertype = 1  
            if @countrec = 0  
            begin
                insert into CptShareDetail values(@cptid_1, @resourceid_1, 1, @sharelevel_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update CptShareDetail set sharelevel = 2 where cptid = @cptid_1 and userid = @resourceid_1 and usertype = 1  /* �����ǿ��Ա༭, ���޸�ԭ�м�¼ */   
            end
            fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
        end 
        close sharecptid_cursor deallocate sharecptid_cursor

    end
end
else if ( @countdelete > 0 and ( @countinsert = 0 or @rolelevel_1  < @oldrolelevel_1 ) ) /* ��Ϊɾ�����߼��𽵵� */
begin
    select @departmentid_1 = departmentid , @subcompanyid_1 = subcompanyid1 , @seclevel_1 = seclevel 
    from hrmresource where id = @resourceid_1 
    if @departmentid_1 is null   set @departmentid_1 = 0
    if @subcompanyid_1 is null   set @subcompanyid_1 = 0
	
    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
	delete from DocShareDetail where userid = @resourceid_1 and usertype = 1

    /* ������ʱ����� */
    Declare @temptablevalue  table(docid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevalue �� */
    /*  �Լ������Ļ����� owner �����¿��Ա༭ */
    declare docid_cursor cursor for
    select distinct id from DocDetail where ( doccreaterid = @resourceid_1 or ownerid = @resourceid_1 ) and usertype= '1'
    open docid_cursor 
    fetch next from docid_cursor into @docid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, 2)
        fetch next from docid_cursor into @docid_1
    end
    close docid_cursor deallocate docid_cursor


    /* �Լ��¼����ĵ� */
    /* �����¼� */
    declare @managerstr_11 varchar(200) 
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subdocid_cursor cursor for
    select distinct id from DocDetail where ( doccreaterid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) or ownerid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) ) and usertype= '1'
    open subdocid_cursor 
    fetch next from subdocid_cursor into @docid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1
        if @countrec = 0  insert into @temptablevalue values(@docid_1, 1)
        fetch next from subdocid_cursor into @docid_1
    end
    close subdocid_cursor deallocate subdocid_cursor
         


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    declare sharedocid_cursor cursor for
    select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= @seclevel_1 )  or ( userid= @resourceid_1 ) or (departmentid= @departmentid_1 and seclevel<= @seclevel_1 )
    open sharedocid_cursor 
    fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalue values(@docid_1, @sharelevel_1)
        end
        else if @sharelevel_1 = 2  
        begin
            update @temptablevalue set sharelevel = 2 where docid=@docid_1 /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
        end
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    end 
    close sharedocid_cursor deallocate sharedocid_cursor

    declare sharedocid_cursor cursor for
    select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment t4 where t1.id=t2.docid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= @departmentid_1 ) or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
    open sharedocid_cursor 
    fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(docid) from @temptablevalue where docid = @docid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalue values(@docid_1, @sharelevel_1)
        end
        else if @sharelevel_1 = 2  
        begin
            update @temptablevalue set sharelevel = 2 where docid=@docid_1 /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
        end
        fetch next from sharedocid_cursor into @docid_1 , @sharelevel_1
    end 
    close sharedocid_cursor deallocate sharedocid_cursor

    /* ����ʱ���е�����д�빲��� */
    declare alldocid_cursor cursor for
    select * from @temptablevalue
    open alldocid_cursor 
    fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into docsharedetail values(@docid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    end
    close alldocid_cursor deallocate alldocid_cursor

    /* ------- CRM  ���� ------- */


    /* ɾ��ԭ�еĸ��˵����пͻ�������Ϣ */
	delete from CrmShareDetail where userid = @resourceid_1 and usertype = 1

    /* ������ʱ����� */
    Declare @temptablevaluecrm  table(crmid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevaluecrm �� */
    /*  �Լ��� manager �Ŀͻ� 2 */
    declare crmid_cursor cursor for
    select id from CRM_CustomerInfo where manager = @resourceid_1 
    open crmid_cursor 
    fetch next from crmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluecrm values(@crmid_1, 2)
        fetch next from crmid_cursor into @crmid_1
    end
    close crmid_cursor deallocate crmid_cursor


    /* �Լ��¼��Ŀͻ� 3 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcrmid_cursor cursor for
    select id from CRM_CustomerInfo where ( manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subcrmid_cursor 
    fetch next from subcrmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1
        if @countrec = 0  insert into @temptablevaluecrm values(@crmid_1, 3)
        fetch next from subcrmid_cursor into @crmid_1
    end
    close subcrmid_cursor deallocate subcrmid_cursor
 
    /* ��Ϊcrm����Ա�ܿ����Ŀͻ� */
    declare rolecrmid_cursor cursor for
   select distinct t1.id from CRM_CustomerInfo  t1, hrmrolemembers  t2  where t2.roleid=8 and t2.resourceid= @resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=@departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1 ))
    open rolecrmid_cursor 
    fetch next from rolecrmid_cursor into @crmid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1
        if @countrec = 0  insert into @temptablevaluecrm values(@crmid_1, 4)
        fetch next from rolecrmid_cursor into @crmid_1
    end
    close rolecrmid_cursor deallocate rolecrmid_cursor	 


    /* �ɿͻ��Ĺ����õ�Ȩ�� 1 2 */
    declare sharecrmid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CRM_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid = @departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open sharecrmid_cursor 
    fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecrm values(@crmid_1, @sharelevel_1)
        end
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    end 
    close sharecrmid_cursor deallocate sharecrmid_cursor



    declare sharecrmid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CRM_CustomerInfo t1 ,  CRM_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=@resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=@seclevel_1 and ( (t2.rolelevel=0  and t1.department = @departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1) or (t3.rolelevel=2) ) 
    open sharecrmid_cursor 
    fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(crmid) from @temptablevaluecrm where crmid = @crmid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecrm values(@crmid_1, @sharelevel_1)
        end
        fetch next from sharecrmid_cursor into @crmid_1 , @sharelevel_1
    end 
    close sharecrmid_cursor deallocate sharecrmid_cursor


    /* ����ʱ���е�����д�빲��� */
    declare allcrmid_cursor cursor for
    select * from @temptablevaluecrm
    open allcrmid_cursor 
    fetch next from allcrmid_cursor into @crmid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into CrmShareDetail( crmid, userid, usertype, sharelevel) values(@crmid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allcrmid_cursor into @crmid_1 , @sharelevel_1
    end
    close allcrmid_cursor deallocate allcrmid_cursor



    /* ------- PROJ ���� ------- */

    /* ������ʱ����� */
    Declare @temptablevaluePrj  table(prjid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevaluePrj �� */
    /*  �Լ�����Ŀ2 */
    declare prjid_cursor cursor for
    select id from Prj_ProjectInfo where manager = @resourceid_1 
    open prjid_cursor 
    fetch next from prjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluePrj values(@prjid_1, 2)
        fetch next from prjid_cursor into @prjid_1
    end
    close prjid_cursor deallocate prjid_cursor


    /* �Լ��¼�����Ŀ3 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subprjid_cursor cursor for
    select id from Prj_ProjectInfo where ( manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subprjid_cursor 
    fetch next from subprjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1
        if @countrec = 0  insert into @temptablevaluePrj values(@prjid_1, 3)
        fetch next from subprjid_cursor into @prjid_1
    end
    close subprjid_cursor deallocate subprjid_cursor
 
    /* ��Ϊ��Ŀ����Ա�ܿ�������Ŀ4 */
    declare roleprjid_cursor cursor for
   select distinct t1.id from Prj_ProjectInfo  t1, hrmrolemembers  t2  where t2.roleid=9 and t2.resourceid= @resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=@departmentid_1) or  (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1 ))
    open roleprjid_cursor 
    fetch next from roleprjid_cursor into @prjid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1
        if @countrec = 0  insert into @temptablevaluePrj values(@prjid_1, 4)
        fetch next from roleprjid_cursor into @prjid_1
    end
    close roleprjid_cursor deallocate roleprjid_cursor	 


    /* ����Ŀ�Ĺ����õ�Ȩ�� 1 2 */
    declare shareprjid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from Prj_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open shareprjid_cursor 
    fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, @sharelevel_1)
        end
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    end 
    close shareprjid_cursor deallocate shareprjid_cursor


    declare shareprjid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from Prj_ProjectInfo t1 ,  Prj_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and  t3.resourceid=@resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=@seclevel_1 and ( (t2.rolelevel=0  and t1.department=@departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1) or (t3.rolelevel=2) ) 
    open shareprjid_cursor 
    fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, @sharelevel_1)
        end
        fetch next from shareprjid_cursor into @prjid_1 , @sharelevel_1
    end 
    close shareprjid_cursor deallocate shareprjid_cursor



    /* ��Ŀ��Ա5 (�ڲ��û�) */
    declare inuserprjid_cursor cursor for
    SELECT distinct t2.id FROM Prj_TaskProcess  t1,Prj_ProjectInfo  t2 WHERE  t1.hrmid =@resourceid_1 and t2.id=t1.prjid and t1.isdelete<>'1' and t2.isblock='1' 

    
    open inuserprjid_cursor 
    fetch next from inuserprjid_cursor into @prjid_1 
    while @@fetch_status=0
    begin 
        select @countrec = count(prjid) from @temptablevaluePrj where prjid = @prjid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@prjid_1, 5)
        end
        fetch next from inuserprjid_cursor into @prjid_1
    end 
    close inuserprjid_cursor deallocate inuserprjid_cursor


    /* ɾ��ԭ�е������Ա��ص�������ĿȨ */
    delete from PrjShareDetail where userid = @resourceid_1 and usertype = 1

    /* ����ʱ���е�����д�빲��� */
    declare allprjid_cursor cursor for
    select * from @temptablevaluePrj
    open allprjid_cursor 
    fetch next from allprjid_cursor into @prjid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into PrjShareDetail( prjid, userid, usertype, sharelevel) values(@prjid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allprjid_cursor into @prjid_1 , @sharelevel_1
    end
    close allprjid_cursor deallocate allprjid_cursor


    /* ------- CPT ���� ------- */

    /* ������ʱ����� */
    Declare @temptablevalueCpt  table(cptid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevalueCpt �� */
    /*  �Լ����ʲ�2 */
    declare cptid_cursor cursor for
    select id from CptCapital where resourceid = @resourceid_1 
    open cptid_cursor 
    fetch next from cptid_cursor into @cptid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalueCpt values(@cptid_1, 2)
        fetch next from cptid_cursor into @cptid_1
    end
    close cptid_cursor deallocate cptid_cursor


    /* �Լ��¼����ʲ�1 */
    /* �����¼� */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcptid_cursor cursor for
    select id from CptCapital where ( resourceid in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subcptid_cursor 
    fetch next from subcptid_cursor into @cptid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1
        if @countrec = 0  insert into @temptablevalueCpt values(@cptid_1, 1)
        fetch next from subcptid_cursor into @cptid_1
    end
    close subcptid_cursor deallocate subcptid_cursor
 
   
    /* ���ʲ��Ĺ����õ�Ȩ�� 1 2 */
    declare sharecptid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CptCapitalShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open sharecptid_cursor 
    fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluePrj values(@cptid_1, @sharelevel_1)
        end
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    end 
    close sharecptid_cursor deallocate sharecptid_cursor


    declare sharecptid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CptCapital t1 ,  CptCapitalShareInfo  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 where t1.id=t2.relateditemid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.departmentid= @departmentid_1 ) or (t2.rolelevel=1 and t1.departmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
    open sharecptid_cursor 
    fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(cptid) from @temptablevalueCpt where cptid = @cptid_1  
        if @countrec = 0  
        begin
            insert into @temptablevalueCpt values(@cptid_1, @sharelevel_1)
        end       
        fetch next from sharecptid_cursor into @cptid_1 , @sharelevel_1
    end 
    close sharecptid_cursor deallocate sharecptid_cursor
    


    /* ɾ��ԭ�е������Ա��ص������ʲ�Ȩ */
    delete from CptShareDetail where userid = @resourceid_1 and usertype = 1

    /* ����ʱ���е�����д�빲��� */
    declare allcptid_cursor cursor for
    select * from @temptablevalueCpt
    open allcptid_cursor 
    fetch next from allcptid_cursor into @cptid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into CptShareDetail( cptid, userid, usertype, sharelevel) values(@cptid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allcptid_cursor into @cptid_1 , @sharelevel_1
    end
    close allcptid_cursor deallocate allcptid_cursor

end        /* ������ɫɾ�����߼��𽵵͵Ĵ��� */
go

