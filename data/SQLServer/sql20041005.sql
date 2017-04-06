/*td:699 */
update SystemRightsLanguage set rightname = '�ֶζ���' ,rightdesc ='�ֶζ���' where id = 92  and languageid= 7 
go
update SystemRights set rightdesc ='�ֶζ���',righttype='6' where id =92
go
/*td:701 ɾ�����õ���Ŀά��Ȩ�ޣ��ƻ�����ά�����ƻ�����ά������Ŀ״̬ά�����������ά������Ŀά������Ŀ�鿴����Ŀ��Աά��*/
delete SystemRights where  id = 56 or  id = 57 or  id = 58 or  id = 59 or  id = 98 or  id = 99 or  id = 100
go
delete SystemRightsLanguage where  id = 56 or  id = 57 or  id = 58 or  id = 59 or  id = 98 or  id = 99 or  id = 100
go
delete systemrighttogroup where rightid = 56 or  rightid = 57 or  rightid = 58 or  rightid = 59 or  rightid = 98 or  rightid = 99 or  rightid = 100
go
delete systemrightroles where rightid = 56 or  rightid = 57 or  rightid = 58 or  rightid = 59 or  rightid = 98 or  rightid = 99 or  rightid = 100
go
/*td��720 ��ѵ�������ѵ�滮����ʾҳ������½���־*/
ALTER  PROCEDURE HrmTrainType_Insert
(@name_2 varchar(60),
 @description_3 varchar(60),
 @typecontent_4 text ,
 @typeaim_5 text ,
 @typedocurl_6 varchar(200) ,
 @typetesturl_7 varchar(200) ,
 @typeoperator_8 varchar(200) ,
 @flag int output, @msg varchar(60) output)
AS INSERT into HrmTrainType
( name,
  description ,
  typecontent ,
  typeaim ,
  typedocurl ,
  typetesturl,
  typeoperator)
VALUES
( @name_2,
  @description_3,
  @typecontent_4,
  @typeaim_5,
  @typedocurl_6,
  @typetesturl_7,
  @typeoperator_8)
  select max(id) from HrmTrainType
GO      

ALTER  procedure HrmTrainLayout_Insert
(@layoutname_1 varchar(60),
 @typeid_2 int,
 @layoutstartdate_3 char(10),
 @layoutenddate_4 char(10),
 @layoutcontent_5 text,
 @layoutaim_6 text,
 @layouttestdate_7 char(10),
 @layoutassessor_8 varchar(200),
 @flag int output, @msg varchar(60) output)
as insert into HrmTrainLayout
 (layoutname ,
 typeid ,
 layoutstartdate ,
 layoutenddate,
 layoutcontent,
 layoutaim,
 layouttestdate,
 layoutassessor
)
values
(@layoutname_1 ,
 @typeid_2 ,
 @layoutstartdate_3 ,
 @layoutenddate_4 ,
 @layoutcontent_5 ,
 @layoutaim_6 ,
 @layouttestdate_7 ,
 @layoutassessor_8 
 )
 select max(id) from HrmTrainLayout
GO

/* td��721 ����ά��Ȩ�޺�ʡ��ά��Ȩ�����Ĭ�Ϸ����ɫ���ܲ������ϵͳ����Ա */
create PROCEDURE doInitInsert
as 
declare @result int

select @result = count(id) from SystemRightRoles  where rightid = 135 and roleid = 2
if  @result = 0 
	insert into SystemRightRoles (rightid,roleid,rolelevel) values (135,2,2) 

select @result = count(id) from SystemRightRoles  where rightid = 134 and roleid = 2
if  @result = 0 
	insert into SystemRightRoles (rightid,roleid,rolelevel) values (134,2,2) 
Go
exec doInitInsert 
GO
drop PROCEDURE doInitInsert
GO

/* td:724 �½���ѵ���ţ��޷�����Ԥ�����*/
alter table HrmTrainPlan alter COLUMN planbudgettype varchar(4)
go

/*td:1110 ȱ��:�ղؼ������ظ�����ͬһһ��ҳ�棬�����ղؼ������ֻ������15��ҳ�档�����޸�Ϊ�ղؼп�����������ӣ����ǲ��ܼ���ͬһҳ�� */
INSERT INTO HtmlLabelIndex values(17552,'��ҳ���Ѿ����ڣ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17552,'��ҳ���Ѿ����ڣ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17552,'The page has exist',8) 
GO
alter PROCEDURE SysFavourite_Insert 
 (@Resourceid int,
 @Adddate char(10),
 @Addtime char(8),
 @Pagename    varchar(150),
 @URL     varchar(100),
 @flag int  output,
 @msg  varchar(80) output) AS declare    @totalcount   int 
 select @totalcount=count(*) from sysfavourite where URL=@URL 
 if @totalcount<=0 begin
 INSERT INTO SysFavourite ( Resourceid,
 Adddate,
 Addtime,
 Pagename,
 URL) VALUES ( @Resourceid,
 @Adddate,
 @Addtime,
 @Pagename,
 @URL) 
select 1
 end
else
select 0
GO
INSERT INTO HtmlLabelIndex values(17037,'�Զ����ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17037,'�Զ����ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17037,'User Definition',8) 
GO
delete HtmlLabelIndex where id = 16676
GO
delete HtmlLabelInfo where indexid = 16676
GO
insert into HtmlLabelIndex values(16676,'������ٵ�')
GO
insert into HtmlLabelInfo values(16676,'������ٵ�',7)
GO
insert into HtmlLabelInfo values(16676,'',8)
GO
ALTER  PROCEDURE Workflow_ReportType_Delete 
(@id_1 	[int], @flag	[int]	output, @msg	[varchar](80)	output) 
AS 
declare @count integer 
select @count = count(id) from Workflow_Report where reporttype = @id_1  
if (@count > 0)
begin
    select 0  
    return
end
else
begin
    DELETE [Workflow_ReportType] WHERE ( [id]	 = @id_1) 
end
GO
UPDATE license set cversion = '2.643'
go