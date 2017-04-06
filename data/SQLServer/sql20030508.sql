create table HrmEducationLevel
(id int identity(1,1) not null,
 name varchar(60) null,
 description varchar(200) null)
go

insert into SystemRights (id, rightdesc,righttype) 
  values (381,'����ά��ά��',3) 
go
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(381,4,1)
 go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3028,'����ά�����','HrmScheduleMaintanceAdd:Add',381)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3029,'����ά���༭','HrmScheduleMaintanceEdit:Edit',381)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3030,'����ά��ɾ��','HrmScheduleMaintanceDelete:Delete',381)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3031,'����ά����־','HrmScheduleMaintance:Log',381)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3032,'����ά���鿴','HrmScheduleMaintanceView:View',381)
go

insert into HrmEducationLevel (name,description)values('����','����')
go
insert into HrmEducationLevel (name,description)values('����','����')
go
insert into HrmEducationLevel (name,description)values('����','����')
go
insert into HrmEducationLevel (name,description)values('�м�','�м�')
go
insert into HrmEducationLevel (name,description)values('��ר','��ר')
go
insert into HrmEducationLevel (name,description)values('��ר','��ר')
go
insert into HrmEducationLevel (name,description)values('����','����')
go
insert into HrmEducationLevel (name,description)values('˶ʿ�о���','˶ʿ�о���')
go
insert into HrmEducationLevel (name,description)values('��ʿ�о���','��ʿ�о���')
go
insert into HrmEducationLevel (name,description)values('MBA','MBA')
go
insert into HrmEducationLevel (name,description)values('EMBA','EMBA')
go
insert into HrmEducationLevel (name,description)values('��ʿ��','��ʿ��')
go

CREATE PROCEDURE HrmEducationLevel_Delete 
 (@id_1 	[int], @flag integer output, @msg varchar(80) output)  AS DELETE [HrmEducationLevel]  WHERE ( [id]	 = @id_1) 
GO

 CREATE PROCEDURE HrmEducationLevel_Insert 
 (@name_1 	[varchar](60), @description_2 	[varchar](60), @flag integer output, @msg varchar(80) output)  AS INSERT INTO [HrmEducationLevel] ( [name], [description])  VALUES ( @name_1, @description_2) 
GO

 CREATE PROCEDURE HrmEducationLevel_Select 
 @flag integer output , @msg varchar(80) output  AS select * from HrmEducationLevel set  @flag = 0 set  @msg = '�����ɹ����' 
GO

 CREATE PROCEDURE HrmEducationLevel_SelectByID 
 @id varchar(100) , @flag integer output , @msg varchar(80) output AS select * from HrmEducationLevel where id =convert(int, @id) set  @flag = 0 set  @msg = '��ѯ�洢���̳ɹ�' 
GO

 CREATE PROCEDURE HrmEducationLevel_Update 
 (@id_1 	[int], @name_2 	[varchar](60), @description_3 	[varchar](60), @flag integer output, @msg varchar(80) output)  AS UPDATE [HrmEducationLevel]  SET  [name]	 = @name_2, [description]	 = @description_3  WHERE ( [id]	 = @id_1) 
GO

insert into SystemLogItem (itemid,lableid,itemdesc) values(80,818,'ѧ��')
go

insert into SystemRights (id, rightdesc,righttype) 
  values (382,'ѧ��ά��',3) 
go
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(382,4,1)
 go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3033,'ѧ�����','HrmEducationLevelAdd:Add',382)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3034,'ѧ���༭','HrmEducationLevelEdit:Edit',382)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3035,'ѧ��ɾ��','HrmEducationLevelDelete:Delete',382)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3036,'ѧ����־','HrmEducationLevel:Log',382)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3037,'ѧ���鿴','HrmEducationLevelView:View',382)
go

alter procedure HrmResourceDateCheck
 (@today_1 char(10),
  @flag int output, @msg varchar(60) output)
 as update HrmResource set
   status = 7
 where
    (status = 0 or status = 1 or status = 2 or status = 3) and enddate < @today_1 and enddate <>''
 update HrmResource set
   status = 3
 where
   status = 0 and probationenddate < @today_1 
GO

alter procedure HrmResource_DepUpdate
(@id_1 int,
 @departmentid_2 int,
 @joblevel_3 int,
 @costcenterid_4 int,
 @jobtitle_5 int,
 @flag int output,@msg varchar(60) output)
as update HrmResource set
  departmentid = @departmentid_2,
  joblevel = @joblevel_3,
  costcenterid = @costcenterid_4,
  jobtitle = @jobtitle_5
where
  id = @id_1
go

alter PROCEDURE HrmDepartment_Select 
 @flag integer output , @msg varchar(80) output AS select * from HrmDepartment order by showorder set  @flag = 0 set  @msg = '�����ɹ����' 

GO

delete from HrmListValidate
go
insert into HrmListValidate (id,name,validate_n) values(1,'��֯�ṹ','1')
go
insert into HrmListValidate (id,name,validate_n) values(2,'���¹���','1')
go
insert into HrmListValidate (id,name,validate_n) values(3,'��������','1')
go
insert into HrmListValidate (id,name,validate_n) values(4,'��ͬ����','1')
go
insert into HrmListValidate (id,name,validate_n) values(5,'���ڹ���','1')
go
insert into HrmListValidate (id,name,validate_n) values(6,'�������','1')
go
insert into HrmListValidate (id,name,validate_n) values(7,'���Ϳ���','1')
go
insert into HrmListValidate (id,name,validate_n) values(8,'��ѵ����','1')
go
insert into HrmListValidate (id,name,validate_n) values(9,'��Ƹ����','1')
go
insert into HrmListValidate (id,name,validate_n) values(10,'����','1')
go
insert into HrmListValidate (id,name,validate_n) values(11,'������Ϣ','1')
go
insert into HrmListValidate (id,name,validate_n) values(12,'������Ϣ','1')
go
insert into HrmListValidate (id,name,validate_n) values(13,'������Ϣ','1')
go
insert into HrmListValidate (id,name,validate_n) values(14,'�ʲ���Ϣ','1')
go
insert into HrmListValidate (id,name,validate_n) values(15,'ϵͳ��Ϣ','1')
go
insert into HrmListValidate (id,name,validate_n) values(16,'����','1')
go
insert into HrmListValidate (id,name,validate_n) values(17,'������','1')
go
insert into HrmListValidate (id,name,validate_n) values(18,'�ƻ�','1')
go
insert into HrmListValidate (id,name,validate_n) values(19,'�ʼ�����','1')
go
insert into HrmListValidate (id,name,validate_n) values(20,'����','1')
go
insert into HrmListValidate (id,name,validate_n) values(21,'��ѵ��¼','1')
go
insert into HrmListValidate (id,name,validate_n) values(22,'���ͼ�¼','1')
go
insert into HrmListValidate (id,name,validate_n) values(23,'��־','1')
go
insert into HrmListValidate (id,name,validate_n) values(24,'ͳ��','1')
go
insert into HrmListValidate (id,name,validate_n) values(25,'ͼƬ','1')
go
insert into HrmListValidate (id,name,validate_n) values(26,'��ɫ������','1')
go
insert into HrmListValidate (id,name,validate_n) values(27,'���ڲμӵ���ѵ�','1')
go
insert into HrmListValidate (id,name,validate_n) values(28,'���Բμӵ���ѵ����','1')
go

insert into HrmScheduleDiff (diffname, diffdesc,difftype,difftime, mindifftime, workflowid,salaryable,counttype,countnum,salaryitem,diffremark,color)
values('�Ӱ�','�Ӱ�',0,0,0,1,'',0,0,1,'','ff0033')
go

insert into HrmScheduleDiff (diffname, diffdesc,difftype,difftime, mindifftime, workflowid,salaryable,counttype,countnum,salaryitem,diffremark,color)
values('���','���',1,0,0,1,'',0,0,1,'','00ffff')
go

insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3038,'ӦƸ�����','HrmCareerApplyAdd:Add',111)
go

insert into SystemRights (id, rightdesc,righttype) 
  values (383,'��ͬ����ά��',3) 
go
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(383,4,1)
 go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3039,'��ͬ�������','HrmContractTypeAdd:Add',383)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3040,'��ͬ����༭','HrmContractTypeEdit:Edit',383)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3041,'��ͬ����ɾ��','HrmContractTypeDelete:Delete',383)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3042,'��ͬ������־','HrmContractType:Log',383)
go

insert into HtmlLabelIndex (id,indexdesc) values (6158,'��ͬ����')
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6158,'��ͬ����',7)
go
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6158,'HrmContractType',8)
go

insert into SystemLogItem (itemid,lableid,itemdesc) values(81,6158,'��ͬ����')
go

insert into SystemRights (id, rightdesc,righttype) 
  values (384,'��ͬά��',3) 
go
insert into SystemRightRoles(rightid,roleid,rolelevel)
  values(384,4,1)
 go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3045,'��ͬ���','HrmContractAdd:Add',384)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3043,'��ͬ�༭','HrmContractEdit:Edit',384)
go
insert into SystemRightDetail(id,rightdetailname,rightdetail,rightid)
  values(3044,'��ͬɾ��','HrmContractDelete:Delete',384)
go

insert into SystemLogItem (itemid,lableid,itemdesc) values(82,6156,'��ѵ����')
go

insert into SystemLogItem (itemid,lableid,itemdesc) values(83,6136,'��ѵ�')
go

alter table SystemSet add pop3server varchar(60)
GO

alter PROCEDURE SystemSet_Update 
 (@emailserver_1  varchar(60) , 
  @debugmode_2   char(1) , 
  @logleaveday_3  tinyint ,
  @defmailuser_4  varchar(60) ,
  @defmailpassword_5  varchar(60) ,
  @pop3server_6  varchar(60), 
  @flag int output, 
  @msg varchar(80) output) 
AS 
 update SystemSet set 
        emailserver=@emailserver_1 , 
        debugmode=@debugmode_2,
        logleaveday=@logleaveday_3 ,
        defmailuser=@defmailuser_4 , 
        defmailpassword=@defmailpassword_5 , 
        pop3server=@pop3server_6 
GO

alter table HrmCheckKind alter column checkstartdate char(10)
GO

alter table HrmCheckKind drop column checkenddate 
GO
/* 2003-05-6 ������������� */
DROP TABLE HrmCheckKind
GO
CREATE TABLE HrmCheckKind (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	kindname varchar (60)  NULL ,
	checkcycle char (1)   NULL ,
        checkexpecd int NULL,
	checkstartdate char(10)  NULL 
) 
GO  

/* 2003-5-6 ��������������Ŀ�� */
DROP TABLE HrmCheckKindItem
GO
CREATE TABLE HrmCheckKindItem (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY  ,
	checktypeid int  NULL ,
	checkitemid int   NULL ,
	checkitemproportion int NULL 
) 
GO

/* 2003-5-6 �������˸�λ�� */
DROP TABLE HrmCheckPost
GO
CREATE TABLE HrmCheckPost (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	checktypeid int  NULL ,
	jobid int   NULL 
	
) 
GO

/* 2003-5-6 �������˲����˱� */
DROP TABLE HrmCheckActor
GO
CREATE TABLE HrmCheckActor (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	checktypeid int  NULL ,
	typeid int   NULL ,
	resourceid int NULL,
	checkproportion int NULL
	
) 
GO
/* 2003-5-6 �������˱� */
DROP TABLE HrmCheckList
GO
CREATE TABLE HrmCheckList (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	checkname varchar (60) NULL,
	checktypeid int  NULL ,
	startdate char(10) NULL,/*��ʼ����*/
	enddate char(10) NULL, /*��������*/
	status int NULL/*״̬*/
	
) 
GO
/* 2003-5-6 �����������˱� */
DROP TABLE HrmByCheckPeople
GO
CREATE TABLE HrmByCheckPeople (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	checkid int  NULL ,/*����id*/
	resourceid int NULL,/*��������ID*/
	checkercount int NULL,/*������ID*/
	proportion int  NULL ,/*Ȩ��*/
        checkresourcetype int NULL,/*����*/
	result decimal (10,2) NULL,/*�ɼ�*/
	lastmodifydate char(10) NULL/*����޸ĵ�ʱ��*/
	
) 
GO

/* 2003-5-6 �������˳ɼ��� */
DROP TABLE HrmCheckGrade
GO
CREATE TABLE HrmCheckGrade (
	id int IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	checkpeopleid int  NULL ,/*����id*/
	checkitemid int NULL,/*��ĿID*/
	result int  NULL, /*�ɼ�*/
	checkitemproportion int NULL/*Ȩ��*/
			
) 
GO

/*2003-4-28�޸Ŀ��˸�λ�洢����*/
CREATE PROCEDURE HrmCheckPost_Update
(@id_1 int,
 @checktypeid_2 int,
 @jobid_3 int,
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmCheckPost set
checktypeid = @checktypeid_2,
jobid = @jobid_3
WHERE
 id = @id_1
GO

/*2003-4-28�޸Ŀ���������Ŀ�洢����*/
CREATE PROCEDURE HrmCheckKindItem_Update
(@id_1 int,
 @checktypeid_2 int,
 @checkitemid_3 int,
 @checkitemproportion_4 int,
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmCheckKindItem set
checktypeid = @checktypeid_2,
checkitemid = @checkitemid_3,
checkitemproportion = @checkitemproportion_4
WHERE
 id = @id_1
GO

/*2003-4-28�޸Ŀ��˲����˴洢����*/
CREATE PROCEDURE HrmCheckActor_Update
(@id_1 int,
 @checktypeid_2 int,
 @typeid_3 int,
 @resourceid_4 int,
 @checkproportion_5 int,
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmCheckActor set
checktypeid = @checktypeid_2,
typeid = @typeid_3,
resourceid = @resourceid_4,
checkproportion = @checkproportion_5
WHERE
 id = @id_1
GO

 
 /* 2003-4-25���������˳ɼ������� */

CREATE PROCEDURE HrmCheckGrade_Insert
(@checkpeopleid_2 int,
 @checkitemid_3 int,
 @result_4 int,
 @checkitemproportion_5 int,
 @flag int output, @msg varchar(60) output)
 AS
   insert into HrmCheckGrade (checkpeopleid,checkitemid,result,checkitemproportion) values (@checkpeopleid_2,@checkitemid_3,
   @result_4,@checkitemproportion_5)
 GO

 /*2003-4-28�޸Ŀ����˳ɼ��洢����*/

CREATE PROCEDURE HrmCheckGrade_Update
(@id_1 int,
 @checkpeopleid_2 int,
 @checkitemid_3 int,
 @result_4 int,
 @checkitemproportion_5 int,
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmCheckGrade set
checkpeopleid = @checkpeopleid_2,
checkitemid = @checkitemid_3,
result = @result_4,
checkitemproportion = @checkitemproportion_5
WHERE
 id = @id_1
GO

 /* 2003-5-6�������˱����� */
CREATE PROCEDURE HrmCheckList_Insert
(@checkname_2 varchar (60),
 @checktypeid_3 int,
 @startdate_4 char(10),
 @enddate_5 char(10),
 @status_6 int,
 @flag int output, @msg varchar(60) output)
 AS
   insert into HrmCheckList (checkname,checktypeid,startdate,enddate,status) values (@checkname_2,@checktypeid_3,
   @startdate_4,@enddate_5,@status_6)
   select max(id) from HrmCheckList 
 GO

/* 2003-5-6������������洢���� */
DROP PROCEDURE HrmCheckKind_Insert
GO
CREATE PROCEDURE HrmCheckKind_Insert
(@kindname_2 varchar(60),
 @checkcycle_3 char(1),
 @checkexpecd_4 int,
 @checkstartdate_5 char(10),
 @flag int output, @msg varchar(60) output)
 AS
   insert into HrmCheckKind (kindname,checkcycle,checkexpecd,checkstartdate) values (@kindname_2,@checkcycle_3,
   @checkexpecd_4, @checkstartdate_5)
 GO  
  
  /*2003-5-6�޸Ŀ�������洢����*/
DROP PROCEDURE HrmCheckKind_Update
GO
CREATE PROCEDURE HrmCheckKind_Update
(@id_1 int,
 @kindname_2 varchar(60),
 @checkcycle_3 char(1),
 @checkexpecd_4 int,
 @checkstartdate_5 char(10),
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmCheckKind set
kindname = @kindname_2,
checkcycle = @checkcycle_3,
checkexpecd = @checkexpecd_4,
checkstartdate= @checkstartdate_5
WHERE
 id = @id_1
GO

/*2003-05-9�����������˱�洢����*/

CREATE PROCEDURE HrmByCheckPeople_Insert
(@checkid_2 int,
 @resourceid_3 int,
 @checkercount_4 int,
 @proportion_5 int,
 @checkresourcetype_6 int,
 @result_7 decimal (10,2),
 @flag int output, @msg varchar(60) output)
 AS
   insert into HrmByCheckPeople (checkid,resourceid,checkercount,proportion,checkresourcetype
   ,result) values (@checkid_2,@resourceid_3,@checkercount_4, @proportion_5,@checkresourcetype_6,
   @result_7)
   select max(id) from HrmByCheckPeople
GO  

 /* 2003-5-9�������˲����˱�Ĵ洢���� */
alter PROCEDURE HrmCheckActor_Insert
(@checktypeid_2 int,
 @typeid_3 int,
 @resourceid_4 int,
 @checkproportion_5 int,
 @flag int output, @msg varchar(60) output)
 AS
   insert into HrmCheckActor (checktypeid,typeid,resourceid,checkproportion) values (@checktypeid_2,
   @typeid_3,@resourceid_4,@checkproportion_5)
 GO
 /*2003-5-10�޸ı������˱�Ĵ洢����*/
CREATE PROCEDURE HrmByCheckPeople_Update
(@id_1 int,
 @result_2 decimal(10,2),
 @lastmodifydate_3 char(10),
 @flag int output, @msg varchar(60) output)
AS UPDATE HrmByCheckPeople set
result = @result_2,
lastmodifydate= @lastmodifydate_3
WHERE
 id = @id_1
GO


insert into HtmlLabelInfo (indexid,labelname,languageid) values (7014,'����ʵʩ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7014,'',8)
GO



insert into HtmlLabelInfo (indexid,labelname,languageid) values (7015,'���Ϳ���',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (7015,'',8)
GO


CREATE TABLE CRM_PayInfo
(
id int IDENTITY(1,1) primary key,
payid int null,
factprice decimal(10,2) null,
factdate char(10) null,
creater int null
)
GO

CREATE  PROCEDURE CRM_PayInfo_Insert
	@id_1		int,
	@factprice_1	decimal(10,2),
	@factdate_1 char(10),
	@creater_1 int,
	@flag		int	output, 
	@msg		varchar(80) output
as
	insert into CRM_PayInfo
	(payid,factprice,factdate,creater)
	values
	(	@id_1,@factprice_1,	@factdate_1 ,@creater_1)
GO

CREATE  PROCEDURE CRM_PayInfo_SelectAll
	@id_1		int,
	@flag		int	output, 
	@msg		varchar(80) output
as
	select * from CRM_PayInfo WHERE payid=@id_1 order by factdate desc
GO


CREATE  PROCEDURE CRM_PayInfo_update
	@id_1		int,
	@factprice_1	decimal(10,2),
	@factdate_1 char(10),
	@creater_1 int,
	@flag		int	output, 
	@msg		varchar(80) output
as
	update  CRM_PayInfo set
	factprice=@factprice_1,
	factdate=@factdate_1,
	creater=@creater_1
	WHERE id=@id_1
GO

CREATE  PROCEDURE CRM_PayInfo_del
	@id_1		int,
	@flag		int	output, 
	@msg		varchar(80) output
as
	delete from CRM_PayInfo WHERE id =@id_1
GO



/*crm-proj-fna����*/
 alter table CRM_Contract add projid int null
 go



 ALTER PROCEDURE CRM_Contract_Insert 
	(@name_1  varchar (100)   ,
	 @typeId_1  int  ,	
	 @docId_1  varchar (100)   ,
	 @price_1  decimal(10, 2)  ,
	 @crmId_1  int  ,
	 @contacterId_1  int  ,
	 @startDate_1  char (10)   ,
	 @endDate_1  char (10)   ,
	 @manager_1  int  ,
	 @status_1  int  ,
	 @isRemind_1  int  ,
	 @remindDay_1  int  ,
	 @creater_1  int  ,
	 @createDate_1  char (10)   ,
	 @createTime_1  char (10)  ,
	 @prjid_1 int,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO CRM_Contract 
	 (name , 
	 typeId , 
	 docId , price , crmId , contacterId , startDate , endDate , manager , status , isRemind , remindDay , creater , createDate , createTime,projid) 
 
VALUES 
	( @name_1,
	 @typeId_1,
	 @docId_1, @price_1 , @crmId_1 , @contacterId_1 , @startDate_1 , @endDate_1 , @manager_1 , @status_1 , @isRemind_1 , @remindDay_1 , @creater_1 , @createDate_1 , @createTime_1,@prjid_1)
select top 1 * from CRM_Contract order by id desc
GO


ALTER PROCEDURE CRM_Contract_Update 
	(@id_1 	int ,
	 @name_1  varchar (100)   ,
	 @typeId_1  int  ,	
	 @docId_1  varchar (100)   ,
	 @price_1  decimal(10, 2)  ,
	 @crmId_1  int  ,
	 @contacterId_1  int  ,
	 @startDate_1  char (10)   ,
	 @endDate_1  char (10)   ,
	 @manager_1  int  ,
	 @status_1  int  ,
	 @isRemind_1  int  ,
	 @remindDay_1  int  ,
	 @prjid_1 int,
	 @flag integer output,
	 @msg varchar(80) output)

AS
UPDATE CRM_Contract SET name = @name_1, typeId = @typeId_1 , docId = @docId_1 , price = @price_1 , crmId = @crmId_1 , contacterId = @contacterId_1 , startDate = @startDate_1 , endDate = @endDate_1 , manager = @manager_1 , status = @status_1 , isRemind = @isRemind_1 , remindDay = @remindDay_1 ,projid=@prjid_1  where id = @id_1
GO


alter table CRM_ContractPayMethod add feetypeid int null
go


alter PROCEDURE CRM_ContractPayMethod_Insert 
	(
	 @contractId_1  int  ,	
	 @prjName_1  varchar (100)   ,
	 @typeId_1  int  ,
	 @payPrice_1  decimal(10, 2)  ,
	 @payDate_1  char (10)   ,
	 @factPrice_1  decimal(10, 2)  ,
	 @factDate_1  char (10)  ,
	 @qualification_1 varchar (200) ,
	 @isFinish_1  int  ,
	 @isRemind_1  int  ,
	 @feetypeid_1 int,
	 @flag integer output,
	 @msg varchar(80) output)

AS INSERT INTO CRM_ContractPayMethod 
	 (contractId , 
	 prjName , 
	 typeId , payPrice , payDate , factPrice , factDate , qualification , isFinish , isRemind,feetypeid ) 
 
VALUES 
	(@contractId_1,
	 @prjName_1,
	 @typeId_1, @payPrice_1 , @payDate_1 , @factPrice_1 , @factDate_1 , @qualification_1 , @isFinish_1 , @isRemind_1,@feetypeid_1)
GO


alter table FnaAccountLog add iscontractid char(1) default 0
go


alter PROCEDURE FnaAccountLog_Insert
(
@feetypeid_1 int,
@resourceid_2 int,
@departmentid_3 int,
@crmid_4 int,
@projectid_5 int,
@amount_6 decimal,
@description_7 varchar(250),
@occurdate_8 char(10),
@releatedid_9 char(10),
@releatedname_10 varchar(255),
@iscontractid_1 char(1),
@flag          integer output,
@msg           varchar(80) output)

AS INSERT INTO FnaAccountLog
( feetypeid,
resourceid,
departmentid,
crmid,
projectid,
amount,
description,
occurdate,
releatedid,
releatedname,
iscontractid
)

VALUES
(
@feetypeid_1,
@resourceid_2,
@departmentid_3,
@crmid_4,
@projectid_5,
@amount_6,
@description_7,
@occurdate_8,
@releatedid_9,
@releatedname_10,
@iscontractid_1
)
select max(id) from FnaAccountLog
GO

alter table CRM_ContractPayMethod add fnalogid int null
go



create PROCEDURE FnaAccountLog_Update
(
@fnalogid_1 int,
@amount_6 decimal,
@projectid_5 int,
@flag          integer output,
@msg           varchar(80) output)
AS Update FnaAccountLog set 
amount=@amount_6,
projectid = @projectid_5
WHERE id = @fnalogid_1
GO




create TRIGGER Tri_Update_HrmresourceShare ON Hrmresource WITH ENCRYPTION
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

CREATE TABLE Bill_HrmAwardInfo (
	id int IDENTITY (1, 1) NOT NULL  ,
	rptitle varchar (60)  NULL ,
	resource_n int   NULL ,
	rpdate  char(10) NULL,
	rptypeid int NULL ,
	rpexplain varchar (200) NULL,
	rptransact varchar (200) NULL ,
	requestid  int
) 
GO

CREATE TABLE Bill_HrmRedeploy (
	id int IDENTITY (1, 1) NOT NULL  ,
	resource_n int   NULL ,
	redeploydate  char(10) NULL,
	oldjob int NULL ,
	newjob int NULL ,
	oldjoblevel int NULL ,
	newjoblevel int NULL ,
	redeployreason varchar (200) NULL,
	ischangesalary	int NULL ,
	requestid  int
) 
GO

CREATE TABLE Bill_HrmDismiss (
	id int IDENTITY (1, 1) NOT NULL  ,
	resource_n int   NULL ,
	dismissdate  char(10) NULL,
	docid int NULL ,
	dismissreason varchar (200) NULL,
	requestid  int
) 
GO

CREATE TABLE Bill_HrmHire (
	id int IDENTITY (1, 1) NOT NULL  ,
	resource_n int   NULL ,
	hiredate  char(10) NULL,
	hirereason varchar (200) NULL,
	requestid  int
) 
GO

CREATE TABLE Bill_HrmScheduleHoliday (
	id int IDENTITY (1, 1) NOT NULL  ,
	diffid  int   NULL ,
	resource_n int   NULL ,
	startdate  char(10) NULL,
	starttime  char(8) NULL,
	enddate  char(10) NULL,
	endtime  char(8) NULL,
	reason varchar (255) NULL,
	requestid  int
) 
GO

CREATE TABLE Bill_HrmScheduleOvertime (
	id int IDENTITY (1, 1) NOT NULL  ,
	diffid  int   NULL ,
	resource_n int   NULL ,
	startdate  char(10) NULL,
	starttime  char(8) NULL,
	enddate  char(10) NULL,
	endtime  char(8) NULL,
	reason varchar (255) NULL,
	requestid  int
) 
GO


CREATE TABLE Bill_HrmUseDemand (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[resource_n] int   NULL ,
	[demandjobtitle] [int] NULL ,
	[demandnum] [int] NULL ,
	[demandkind] [int] NULL ,
	[leastedulevel] [int] NULL ,
	[demandregdate] [char] (10)  NULL ,
	[otherrequest] [text]  NULL ,
	[refermandid] [int] NULL ,
	[referdate] [char] (10)  NULL ,
	[status] [int] NULL ,
	[createkind] [int] NULL ,
	[demanddep] [int] NULL ,
	requestid  int
)
GO

CREATE TABLE Bill_HrmTrainplan (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[resource_n] [int]   NULL ,
	[trainplanid] [int] NULL ,
	[reason] [text]  NULL ,
	[createdate] [char] (10)  NULL ,
	requestid  int
)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6107	,'��������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6107,'��������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6107,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6109	,'��������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6109,'��������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6109,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6110	,'ְλ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6110,'ְλ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6110,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6111	,'��������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6111,'��������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6111,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6112	,'ԭ��λ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6112,'ԭ��λ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6112,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6113	,'�¸�λ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6113,'�¸�λ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6113,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6114	,'ԭְ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6114,'ԭְ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6114,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6115	,'��ְ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6115,'��ְ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6115,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6116	,'����ԭ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6116,'����ԭ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6116,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6119	,'��ְ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6119,'��ְ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6119,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6120	,'��ְ��ͬ')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6120,'��ְ��ͬ',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6120,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6121	,'ת������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6121,'ת������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6121,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6122	,'ת������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6122,'ת������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6122,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6123	,'ת����ע')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6123,'ת����ע',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6123,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6150	,'��������')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6150,'��������',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6150,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6151	,'�Ӱ�')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6151,'�Ӱ�',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6151,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6152	,'����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6152,'����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6152,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6153	,'��λʱ��')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6153,'��λʱ��',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6153,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6155	,'��ѵ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6155,'��ѵ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6155,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6156	,'��ѵ����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6156,'��ѵ����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6156,'',8)
GO

insert into HtmlLabelIndex (id,indexdesc) values (6157	,'�Ƿ��������û�׼����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6157,'�Ƿ��������û�׼����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6157,'',8)
GO

/*�����������*/
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6099,'int','/systeminfo/BrowserMain.jsp?url=/hrm/award/AwardTypeBrowser.jsp?awardtype=0','HrmAwardType','name','id','/hrm/award/HrmAwardTypeEdit.jsp?id=')
GO
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 818,'int','/systeminfo/BrowserMain.jsp?url=/hrm/educationlevel/EduLevelBrowser.jsp','HrmEducationLevel','name','id','/hrm/educationlevel/HrmEduLevelEdit.jsp?id=')
GO
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 804,'int','/systeminfo/BrowserMain.jsp?url=/hrm/usekind/UseKindBrowser.jsp','HrmUseKind','name','id','/hrm/usekind/HrmUseKindEdit.jsp?id=')
GO
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6156,'int','/systeminfo/BrowserMain.jsp?url=/hrm/train/trainplan/HrmTrainPlanBroswer.jsp','HrmTrainPlan','planname','id','/hrm/train/trainplan/HrmTrainPlanEdit.jsp?id=')
GO
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 6159,'int','/systeminfo/BrowserMain.jsp?url=/hrm/schedule/HrmScheduleDiffBrowser.jsp?difftype=0','HrmScheduleDiff','diffname','id','/hrm/schedule/HrmScheduleDiffEdit.jsp?id=')
GO
INSERT INTO workflow_browserurl (labelid,fielddbtype,browserurl,tablename,columname,keycolumname,linkurl) VALUES ( 1881,'int','/systeminfo/BrowserMain.jsp?url=/hrm/schedule/HrmScheduleDiffBrowser.jsp?difftype=1','HrmScheduleDiff','diffname','id','/hrm/schedule/HrmScheduleDiffEdit.jsp?id=')
GO

/*��������*/
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(39,6150,'Bill_HrmAwardInfo','AddBillHrmAwardInfo.jsp','ManageBillHrmAwardInfo.jsp','','','') 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptitle',344,'varchar(60)',1,1,3,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'resource_n',368,'int',3,1,1,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptypeid',6099,'int',3,29,4,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rpexplain',791,'varchar(200)',2,0,5,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rptransact',1008,'varchar(200)',2,0,6,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (39,'rpdate',855,'char(10)',3,2,2,0)
GO

/*ְλ����*/
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(40,6110,'Bill_HrmRedeploy','BillHrmRedeployAdd.jsp','BillHrmRedeployManage.jsp','','','') 
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'resource_n',368,'int',3,1,1,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'redeploydate',6111,'char(10)',3,2,2,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'oldjob',6112,'int',3,24,3,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'newjob',6113,'int',3,24,4,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'oldjoblevel',6114,'int',1,2,5,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'newjoblevel',6115,'int',1,2,6,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'redeployreason',6116,'varchar(200)',2,0,8,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (40,'ischangesalary',6157,'int',4,0,7,0) 
GO


/* ��ְ���� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(41,6119,'Bill_HrmDismiss','BillHrmDismissAdd.jsp','BillHrmDismissManage.jsp','','','') 
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'resource_n',368,'int',3,1,1,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'dismissdate',898,'char(10)',3,2,2,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'docid',6120,'int',3,9,3,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (41,'dismissreason',1978,'varchar(200)',2,0,4,0) 
GO

/* ת������ */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(42,6121,'Bill_HrmHire','BillHrmHireAdd.jsp','BillHrmHireManage.jsp','','','') 
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'resource_n',368,'int',3,1,1,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'hiredate',6122,'char(10)',3,2,2,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (42,'hirereason',6123,'varchar(200)',2,0,3,0) 
GO
/* �Ӱ� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(45,6151,'Bill_HrmScheduleOvertime','BillHrmScheduleOvertimeAdd.jsp','BillHrmScheduleOvertimeManage.jsp','','','') 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'resource_n',368,'int',3,1,1,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'startdate',740,'char(10)',3,2,3,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'starttime',742,'char(8)',3,19,4,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'enddate',741,'char(10)',3,2,5,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'endtime',743,'char(8)',3,19,6,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'reason',791,'varchar(255)',2,0,7,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (45,'diffid',6159,'int',3,33,2,0) 
GO

/* ��� */
INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(46,670,'Bill_HrmScheduleHoliday','BillHrmScheduleHolidayAdd.jsp','BillHrmScheduleHolidayManage.jsp','','','') 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'resource_n',368,'int',3,1,1,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'startdate',740,'char(10)',3,2,3,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'starttime',742,'char(8)',3,19,4,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'enddate',741,'char(10)',3,2,5,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'endtime',743,'char(8)',3,19,6,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'reason',791,'varchar(255)',2,0,7,0) 
GO
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (46,'diffid',1881,'int',3,34,2,0) 
GO
 


/* �ù����� */

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(47,6131,'Bill_HrmUseDemand','BillHrmDemandAdd.jsp','BillHrmDemandManage.jsp','','','') 
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandjobtitle',6086,'int',3,24,2,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandnum',1859,'int',1,2,3,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandkind',6152,'int',3,31,4,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'leastedulevel',1860,'int',3,30,5,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'demandregdate',6153,'char(10)',3,2,6,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'otherrequest',1847,'text',2,0,7,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (47,'resource_n',368,'int',3,1,1,0) 
GO

/* ��ѵ���� */

INSERT INTO workflow_bill ( id, namelabel, tablename, createpage, managepage, viewpage, detailtablename, detailkeyfield) VALUES(48,6155,'Bill_HrmTrainplan','BillHrmTrainplanAdd.jsp','BillHrmTrainplanManage.jsp','','','') 
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'resource_n',368,'int',3,1,1,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'trainplanid',6156,'int',3,32,2,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'reason',85,'text',2,0,3,0)
GO 
INSERT INTO workflow_billfield ( billid, fieldname, fieldlabel, fielddbtype, fieldhtmltype, type, dsporder, viewtype) VALUES (48,'createdate',855,'char(10)',3,2,4,0) 
GO


insert into HtmlLabelIndex (id,indexdesc) values (6159	,'�Ӱ�����')
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6159,'�Ӱ�����',7)
GO
insert into HtmlLabelInfo (indexid,labelname,languageid) values (6159,'',8)
GO



