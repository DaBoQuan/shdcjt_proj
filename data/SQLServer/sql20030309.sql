CREATE TABLE [CptCapitalModify] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[cptid] [int] NULL ,
	[field] [int] NULL ,
	[oldvalue] [varchar] (200)  NULL ,
	[currentvalue] [varchar] (200)  NULL ,
	[resourceid] [int] NULL ,
	[modifydate] [char](10) NULL 
)
GO

CREATE TABLE [CptCapitalModifyField] (
	[field] [int] NULL ,
	[name] [varchar] (100)  NULL
)
GO

/*�ʲ���������:�ʲ����*/
 ALTER PROCEDURE CptUseLogLend_Insert 
	(@capitalid_1 	[int],
	 @usedate_2 	[char](10),
	 @usedeptid_3 	[int],
	 @useresourceid_4 	[int],
	 @usecount_5 	[int],
	 @useaddress_6 	[varchar](200),
	 @userequest_7 	[int],
	 @maintaincompany_8 	[varchar](100),
	 @fee_9 	[decimal](18,3),
	 @usestatus_10 	[varchar](2),
	 @remark_11 	[text],
	 @costcenterid   [int],
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO [CptUseLog] 
	 ( [capitalid],
	 [usedate],
	 [usedeptid],
	 [useresourceid],
	 [usecount],
	 [useaddress],
	 [userequest],
	 [maintaincompany],
	 [fee],
	 [usestatus],
	 [remark]) 
 
VALUES 
	( @capitalid_1,
	 @usedate_2,
	 @usedeptid_3,
	 @useresourceid_4,
	 @usecount_5,
	 @useaddress_6,
	 @userequest_7,
	 @maintaincompany_8,
	 @fee_9,
	 '3',
	 @remark_11)

Update CptCapital
Set 
departmentid = @usedeptid_3,
resourceid   = @useresourceid_4,
location	     =  @useaddress_6,
stateid = @usestatus_10
where id = @capitalid_1

GO



/*�ʲ���������:�ʲ���ʧ*/
 ALTER PROCEDURE CptUseLogLoss_Insert 
	(@capitalid_1 	[int],
	 @usedate_2 	[char](10),
	 @usedeptid_3 	[int],
	 @useresourceid_4 	[int],
	 @usecount_5 	[int],
	 @useaddress_6 	[varchar](200),
	 @userequest_7 	[int],
	 @maintaincompany_8 	[varchar](100),
	 @fee_9 	[decimal](18,3),
	 @usestatus_10 	[varchar](2),
	 @remark_11 	[text],
	 @costcenterid   [int],
	 @sptcount	[char](1),
	 @flag integer output,
	 @msg varchar(80) output)

AS 
declare @num int
/*�ж������Ƿ��㹻(���ڷǵ���������ʲ�*/
if @sptcount<>'1'
begin
   select @num=capitalnum  from CptCapital where id = @capitalid_1
   if @num<@usecount_5
   begin
	select -1
	return
   end
   else
   begin
	select @num = @num-@usecount_5
   end
end

INSERT INTO [CptUseLog] 
	 ( [capitalid],
	 [usedate],
	 [usedeptid],
	 [useresourceid],
	 [usecount],
	 [useaddress],
	 [userequest],
	 [maintaincompany],
	 [fee],
	 [usestatus],
	 [remark]) 
 
VALUES 
	( @capitalid_1,
	 @usedate_2,
	 @usedeptid_3,
	 @useresourceid_4,
	 @usecount_5,
	 @useaddress_6,
	 @userequest_7,
	 @maintaincompany_8,
	 @fee_9,
	 '-7',
	 @remark_11)
/*����������ʲ�*/
if @sptcount='1'
begin
	Update CptCapital
	Set 
	departmentid=null,
	costcenterid=null,
	resourceid=null,
	stateid = @usestatus_10
	where id = @capitalid_1
end
/*�ǵ���������ʲ�*/
else 
begin
	Update CptCapital
	Set
	capitalnum = @num
	where id = @capitalid_1
end

select 1

GO


/*�ʲ���������:�ʲ��黹*/
 CREATE PROCEDURE CptUseLogBack_Insert 
	(@capitalid_1 	[int],
	 @usedate_2 	[char](10),
	 @usedeptid_3 	[int],
	 @useresourceid_4 	[int],
	 @usecount_5 	[int],
	 @useaddress_6 	[varchar](200),
	 @userequest_7 	[int],
	 @maintaincompany_8 	[varchar](100),
	 @fee_9 	[decimal](18,3),
	 @usestatus_10 	[varchar](2),
	 @remark_11 	[text],
	 @costcenterid   [int],
	 @sptcount	[char](1),
	 @flag integer output,
	 @msg varchar(80) output)

AS 
declare @num int
/*�ж������Ƿ��㹻(���ڷǵ���������ʲ�*/
if @sptcount<>'1'
begin
   select @num=capitalnum  from CptCapital where id = @capitalid_1
end

INSERT INTO [CptUseLog] 
	 ( [capitalid],
	 [usedate],
	 [usedeptid],
	 [useresourceid],
	 [usecount],
	 [useaddress],
	 [userequest],
	 [maintaincompany],
	 [fee],
	 [usestatus],
	 [remark]) 
 
VALUES 
	( @capitalid_1,
	 @usedate_2,
	 @usedeptid_3,
	 @useresourceid_4,
	 @usecount_5,
	 @useaddress_6,
	 @userequest_7,
	 @maintaincompany_8,
	 @fee_9,
	 '0',
	 @remark_11)
/*����������ʲ�*/
if @sptcount='1'
begin
	Update CptCapital
	Set 
	departmentid=null,
	costcenterid=null,
	resourceid=null,
	stateid = @usestatus_10
	where id = @capitalid_1
end
/*�ǵ���������ʲ�*/
else 
begin
	Update CptCapital
	Set
	capitalnum = @num+@usecount_5
	where id = @capitalid_1
end

select 1

GO

/*�ʲ���������:�ʲ�����*/
ALTER PROCEDURE CptUseLogDiscard_Insert 
	(@capitalid_1 	[int],
	 @usedate_2 	[char](10),
	 @usedeptid_3 	[int],
	 @useresourceid_4 	[int],
	 @usecount_5 	[int],
	 @useaddress_6 	[varchar](200),
	 @userequest_7 	[int],
	 @maintaincompany_8 	[varchar](100),
	 @fee_9 	[decimal](18,3),
	 @usestatus_10 	varchar(2),
	 @remark_11 	[text],
	 @sptcount_12	[char](1),
	 @flag integer output,
	 @msg varchar(80) output)

AS
declare @num int
/*�ж������Ƿ��㹻(���ڷǵ���������ʲ�*/
if @sptcount_12<>'1'
begin
   select @num=capitalnum  from CptCapital where id = @capitalid_1
   if @num<@usecount_5
   begin
	select -1
	return
   end
   else
   begin
	select @num = @num-@usecount_5
   end
end
INSERT INTO [CptUseLog] 
	 ( [capitalid],
	 [usedate],
	 [usedeptid],
	 [useresourceid],
	 [usecount],
	 [useaddress],
	 [userequest],
	 [maintaincompany],
	 [fee],
	 [usestatus],
	 [remark]) 
 
VALUES 
	( @capitalid_1,
	 @usedate_2,
	 @usedeptid_3,
	 @useresourceid_4,
	 @usecount_5,
	 @useaddress_6,
	 @userequest_7,
	 @maintaincompany_8,
	 @fee_9,
	 '5',
	 @remark_11)
/*����������ʲ�*/
if @sptcount_12 ='1'
begin
	Update CptCapital
	Set 
	departmentid = null,
	costcenterid = null,
	resourceid   = null,
	location	     =  null,
	stateid = @usestatus_10
	where id = @capitalid_1
end
/*�ǵ���������ʲ�*/
else 
begin
	Update CptCapital
	Set
	capitalnum = @num
	where id = @capitalid_1
end

select 1
GO


/*�ʲ������¼*/
CREATE PROCEDURE CptCapitalModify_Insert 
	(@capitalid_1 	[int],
	 @field_1	[int],
	 @oldvalue_1 	[varchar](200),
	 @currentvalue_1 	[varchar](200),
	 @resourceid_1 [int],
	 @modifydate_1 [char](10),
	 @flag integer output,
	 @msg varchar(80) output)

AS

INSERT INTO CptCapitalModify
	(cptid ,
	field  ,
	oldvalue  ,
	currentvalue  ,
	resourceid ,
	modifydate )
VALUES 
	( @capitalid_1,
	 @field_1,
	 @oldvalue_1,
	 @currentvalue_1,
	 @resourceid_1,
	 @modifydate_1)

GO




CREATE PROCEDURE CptCapitalModifyField_SAll 
	(
	 @flag integer output,
	 @msg varchar(80) output)

AS
select * from CptCapitalModifyField order by field 
GO

insert into CptCapitalModifyField (field,name) values ('1','����')
GO
insert into CptCapitalModifyField (field,name) values ('2','������')
GO
insert into CptCapitalModifyField (field,name) values ('3','��Ч��')
GO
insert into CptCapitalModifyField (field,name) values ('4','��Ч��')
GO
insert into CptCapitalModifyField (field,name) values ('5','��ȫ����')
GO
insert into CptCapitalModifyField (field,name) values ('6','ʹ����')
GO
insert into CptCapitalModifyField (field,name) values ('7','����')
GO
insert into CptCapitalModifyField (field,name) values ('8','�ɱ�')
GO
insert into CptCapitalModifyField (field,name) values ('9','��ʼ�۸�')
GO
insert into CptCapitalModifyField (field,name) values ('10','�۾ɵ׼�')
GO
insert into CptCapitalModifyField (field,name) values ('11','����ͺ�')
GO
insert into CptCapitalModifyField (field,name) values ('12','�ȼ�')
GO
insert into CptCapitalModifyField (field,name) values ('13','���쳧��')
GO
insert into CptCapitalModifyField (field,name) values ('14','��������')
GO
insert into CptCapitalModifyField (field,name) values ('15','�ʲ�����')
GO
insert into CptCapitalModifyField (field,name) values ('16','�ʲ���')
GO
insert into CptCapitalModifyField (field,name) values ('17','������λ')
GO
insert into CptCapitalModifyField (field,name) values ('18','���')
GO
insert into CptCapitalModifyField (field,name) values ('19','�汾')
GO
insert into CptCapitalModifyField (field,name) values ('20','��ŵص�')
GO
insert into CptCapitalModifyField (field,name) values ('21','��ע')
GO
insert into CptCapitalModifyField (field,name) values ('22','�۾ɷ���һ')
GO
insert into CptCapitalModifyField (field,name) values ('23','�۾ɷ�����')
GO
insert into CptCapitalModifyField (field,name) values ('24','�۾ɿ�ʼ����')
GO
insert into CptCapitalModifyField (field,name) values ('25','�۾ɽ�������')
GO
insert into CptCapitalModifyField (field,name) values ('26','��Ӧ��')
GO
insert into CptCapitalModifyField (field,name) values ('27','����')
GO

insert into CptCapitalModifyField (field,name) values ('28','date1')
GO
insert into CptCapitalModifyField (field,name) values ('29','date2')
GO
insert into CptCapitalModifyField (field,name) values ('30','date3')
GO
insert into CptCapitalModifyField (field,name) values ('31','date4')
GO
insert into CptCapitalModifyField (field,name) values ('32','date5')
GO
insert into CptCapitalModifyField (field,name) values ('33','float1')
GO
insert into CptCapitalModifyField (field,name) values ('34','float2')
GO
insert into CptCapitalModifyField (field,name) values ('35','float3')
GO
insert into CptCapitalModifyField (field,name) values ('36','float4')
GO
insert into CptCapitalModifyField (field,name) values ('37','float5')
GO
insert into CptCapitalModifyField (field,name) values ('38','text1')
GO
insert into CptCapitalModifyField (field,name) values ('39','text2')
GO
insert into CptCapitalModifyField (field,name) values ('40','text3')
GO
insert into CptCapitalModifyField (field,name) values ('41','text4')
GO
insert into CptCapitalModifyField (field,name) values ('42','text5')
GO
insert into CptCapitalModifyField (field,name) values ('43','boolean1')
GO
insert into CptCapitalModifyField (field,name) values ('44','boolean2')
GO
insert into CptCapitalModifyField (field,name) values ('45','boolean3')
GO
insert into CptCapitalModifyField (field,name) values ('46','boolean4')
GO
insert into CptCapitalModifyField (field,name) values ('47','boolean5')
GO

insert into CptCapitalModifyField (field,name) values ('48','������')
GO
insert into CptCapitalModifyField (field,name) values ('49','��������')
GO


insert into HtmlLabelIndex (id,indexdesc) values (6055,'�ʲ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6055,'�ʲ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6055,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6056,'ԭֵ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6056,'ԭֵ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6056,'',8)
GO

