alter trigger Tri_I_DirAccessControlList on DirAccessControlList for insert
as
declare  @id_1         integer;
declare  @dirid_1         integer;
declare  @dirtype_1      integer;
declare  @seclevel_1     integer
declare  @departmentid_1      integer;
declare  @subcompanyid_1      integer;
declare  @userid_1            integer;
declare  @usertype_1        integer;
declare  @sharelevel_1       integer;
declare  @roleid_1            integer;
declare  @rolelevel_1         integer;
declare  @permissiontype_1  integer;
declare  @operationcode_1 integer;
declare  @docSecCategoryTemplateId_1 integer;
declare @sourceid_1           integer;
declare  @type_1		    integer;
declare  @content_1		    integer;
declare  @sourcetype_1        integer;
declare  @srcfrom_1        integer;

select @id_1 =mainid, @dirid_1=dirid,@dirtype_1=dirtype,@seclevel_1=seclevel,@userid_1=userid,@subcompanyid_1=subcompanyid,@departmentid_1=departmentid,@usertype_1=usertype,@roleid_1=roleid,@rolelevel_1=rolelevel,@operationcode_1=operationcode,@permissiontype_1=permissiontype,@docSecCategoryTemplateId_1=DocSecCategoryTemplateId FROM inserted

set	@srcfrom_1 = @id_1;
set	@sourceid_1= @dirid_1;
set	@sourcetype_1= @dirtype_1;
set	@type_1= @permissiontype_1;
set	@sharelevel_1 = @operationcode_1;

if @type_1=1         /*部门+安全级别*/
	set @content_1 = @departmentid_1;
else if @type_1=2   /*角色+安全级别+级别*/
	set @content_1 =  convert( integer,( convert(varchar(10),@roleid_1) + convert(varchar(10),@rolelevel_1)));
else if @type_1=3   /*安全级别*/
	begin
		set @seclevel_1 = @seclevel_1;
		set @content_1 = 0;
	end
else if @type_1=4    /*用户类型+安全级别*/
	set  @content_1 = @usertype_1;
else if @type_1=5    /*人力资源*/
	begin
		set  @content_1 = @userid_1;
		set  @seclevel_1 = 0; 
	end
else if @type_1=6    /*分部+安全级别*/
	set @content_1 = @subcompanyid_1;
			
/*插入数据*/
 insert into DirAccessControlDetail
(
	sourceid,
	type,
	content,
	seclevel,
	sharelevel,
	sourcetype,
	srcfrom
 )values(
	@sourceid_1,
	@type_1,
	@content_1,
	@seclevel_1,
	@sharelevel_1,
	@sourcetype_1,
	@srcfrom_1
 )
 /*修正角色共享时，角色级别数据*/
 if @rolelevel_1 = 0 /*部门级别*/
   begin
       /*增加分部级别数据*/
       set @content_1=convert( integer,( convert(varchar(10),@roleid_1) + convert(varchar(10),1)));
        insert into DirAccessControlDetail
		(
			sourceid,
			type,
			content,
			seclevel,
			sharelevel,
			sourcetype,
			srcfrom
		 )values(
			@sourceid_1,
			@type_1,
			@content_1,
			@seclevel_1,
			@sharelevel_1,
			@sourcetype_1,
			@srcfrom_1
		 )
		/*增加总部级别数据*/
		set @content_1=convert( integer,( convert(varchar(10),@roleid_1) + convert(varchar(10),2)));
        insert into DirAccessControlDetail
		(
			sourceid,
			type,
			content,
			seclevel,
			sharelevel,
			sourcetype,
			srcfrom
		 )values(
			@sourceid_1,
			@type_1,
			@content_1,
			@seclevel_1,
			@sharelevel_1,
			@sourcetype_1,
			@srcfrom_1
		 )
   end
else if @rolelevel_1>0  /*分部级别*/
   begin
      /*增加总部级别数据*/
		set @content_1=convert( integer,( convert(varchar(10),@roleid_1) + convert(varchar(10),2)));
        insert into DirAccessControlDetail
		(
			sourceid,
			type,
			content,
			seclevel,
			sharelevel,
			sourcetype,
			srcfrom
		 )values(
			@sourceid_1,
			@type_1,
			@content_1,
			@seclevel_1,
			@sharelevel_1,
			@sourcetype_1,
			@srcfrom_1
		 )
   end
GO