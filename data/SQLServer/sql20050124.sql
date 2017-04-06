/*�ĵ���ֱ�*/
CREATE TABLE DocMark (
	id int  IDENTITY (1, 1) NOT NULL,
	docId int NULL  ,
	markHrmType int NULL  ,
    markHrmId int null,
    mark int null,
    remark varchar(500) NULL,    
    markDate Char(10) NULL
) 
GO


/*��ID(�ĵ���ֱ�)ѡ����Ӧ�Ķ�����Ϣ*/

CREATE PROCEDURE DocMark_SelectById(
    @id int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	select * from DocMark where id =  @id
 GO


 /*��(�ĵ���ID)ѡ����Ӧ�Ĵ����Ϣ*/

CREATE   PROCEDURE DocMark_SelectByDocId(
    @docId int ,	
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	select * from DocMark where docid =  @docId
 GO


/*���ĵ���ֱ����в���*/

CREATE   PROCEDURE  DocMark_Insert(
    @docId int ,	
    @markHrmType int ,	
    @markHrmId int,
    @mark int,
    @remark varchar(500),
    @markDate char(10),
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	insert into  DocMark(docId,markHrmType,markHrmId,mark,remark,markDate) values (@docId,@markHrmType,@markHrmId,@mark,@remark,@markDate)
    select max(id) from  DocMark
 GO


 /*���ĵ���ֱ������޸�*/

CREATE  PROCEDURE  DocMark_update(
    @id int ,
    @docId int ,	
    @markHrmType int ,	
    @markHrmId int,
    @mark int,
    @remark varchar(500),
    @markDate char(10),
    @flag integer output , 
    @msg varchar(80) output
    )
    AS
	update  docmark set docId = @docId,markHrmType = @markHrmType,markHrmId = @markHrmId,mark = @mark,remark = @remark,markDate = @markDate where id = @id
    select max(id) from  DocMark
 GO


alter table DocSecCategory add  markable char(1)  /*�����Ƿ�ɴ���ֶΡ�1,�ɴ�� 0,���ɴ��*/
go
alter table DocSecCategory add markAnonymity char(1)  /*���ʱ�Ƿ����������1,���� 0,������*/
go

/*�������´洢����*/

  ALTER   PROCEDURE Doc_SecCategory_Insert 
  ( @subcategoryid 	[int],
  @categoryname 	[varchar](200), 
  @docmouldid 	[int],
  @publishable 	[char](1), 
  @replyable 	[char](1),
  @shareable 	[char](1),
  @cusertype 	[int], 
  @cuserseclevel 	[tinyint], 
  @cdepartmentid1 	[int], 
  @cdepseclevel1 	[tinyint],
  @cdepartmentid2 	[int],
  @cdepseclevel2 	[tinyint],
  @croleid1	 		[int], 
  @crolelevel1	 	[char](1), 
  @croleid2	 	[int], 
  @crolelevel2 	[char](1),
  @croleid3	 	[int], 
  @crolelevel3 	[char](1),
  @hasaccessory	 	[char](1),
  @accessorynum	 	[tinyint], 
  @hasasset		 	[char](1),
  @assetlabel	 	[varchar](200), 
  @hasitems	 	[char](1),
  @itemlabel 	[varchar](200), 
  @hashrmres 	[char](1),
  @hrmreslabel 	[varchar](200), 
  @hascrm	 	[char](1),
  @crmlabel	 	[varchar](200), 
  @hasproject 	[char](1),
@projectlabel 	[varchar](200), 
@hasfinance 	[char](1), 
@financelabel 	[varchar](200), 
@approveworkflowid	int,
@markable  [char](1),
@markAnonymity [char](1),
@flag	int output, 
@msg	varchar(80)	output)

as insert into docseccategory values( @subcategoryid, @categoryname, @docmouldid, @publishable, @replyable, @shareable, @cusertype, @cuserseclevel, @cdepartmentid1, @cdepseclevel1, @cdepartmentid2, @cdepseclevel2, @croleid1, @crolelevel1, @croleid2, @crolelevel2, @croleid3, @crolelevel3, @hasaccessory, @accessorynum, @hasasset, @assetlabel, @hasitems, @itemlabel, @hashrmres, @hrmreslabel, @hascrm, @crmlabel, @hasproject, @projectlabel, @hasfinance, @financelabel, @approveworkflowid,@markable,@markAnonymity) 

select max(id) from docseccategory 
GO



ALTER  PROCEDURE Doc_SecCategory_Update (@id	int, @subcategoryid 	[int], @categoryname 	[varchar](200), @docmouldid 	[int], @publishable 	[char](1), @replyable 	[char](1), @shareable 	[char](1), @cusertype 	[int], @cuserseclevel 	[tinyint], @cdepartmentid1 	[int], @cdepseclevel1 	[tinyint], @cdepartmentid2 	[int], @cdepseclevel2 	[tinyint], @croleid1	 		[int], @crolelevel1	 	[char](1), @croleid2	 	[int], @crolelevel2 	[char](1), @croleid3	 	[int], @crolelevel3 	[char](1), @hasaccessory	 	[char](1), @accessorynum	 	[tinyint], @hasasset		 	[char](1), @assetlabel	 	[varchar](200), @hasitems	 	[char](1), @itemlabel 	[varchar](200), @hashrmres 	[char](1), @hrmreslabel 	[varchar](200), @hascrm	 	[char](1), @crmlabel	 	[varchar](200), @hasproject 	[char](1), @projectlabel 	[varchar](200), @hasfinance 	[char](1), @financelabel 	[varchar](200), @approveworkflowid	int, @markable  [char](1),@markAnonymity [char](1),@flag	int output, @msg	varchar(80)	output) as update docseccategory set subcategoryid=@subcategoryid, categoryname=@categoryname, docmouldid=@docmouldid, publishable=@publishable, replyable=@replyable, shareable=@shareable, cusertype=@cusertype, cuserseclevel=@cuserseclevel, cdepartmentid1=@cdepartmentid1, cdepseclevel1=@cdepseclevel1, cdepartmentid2=@cdepartmentid2, cdepseclevel2=@cdepseclevel2, croleid1=@croleid1, crolelevel1=@crolelevel1, croleid2=@croleid2, crolelevel2=@crolelevel2, croleid3=@croleid3, crolelevel3=@crolelevel3, approveworkflowid=@approveworkflowid, hasaccessory=@hasaccessory, accessorynum=@accessorynum, hasasset=@hasasset, assetlabel=@assetlabel, hasitems=@hasitems, itemlabel=@itemlabel, hashrmres=@hashrmres, hrmreslabel=@hrmreslabel, hascrm=@hascrm, crmlabel=@crmlabel, hasproject=@hasproject, projectlabel=@projectlabel, hasfinance=@hasfinance, financelabel=@financelabel,markable=@markable ,markAnonymity=@markAnonymity where id=@id 
GO

/*�� docdetail �� ���������ֶ�,�Ա��ں�����������*/
alter table docdetail add  countMark int  default 0
go
alter table docdetail add  sumMark int default 0
go
alter table docdetail add  sumReadCount int default 0
go
/*�� docdetail �� countMark sumMark sumReadCount �����ֶν��г�ʼ��*/
Create PROCEDURE initDocdetailMarkRead 
    @flag integer output , 
    @msg varchar(80) output    
AS
    Declare @docid int,@countIds int,@sumMark int,@sumReadCount int,@mark_cursor cursor,@readtag_cursor cursor
    SET @mark_cursor = CURSOR FORWARD_ONLY STATIC FOR
	select docid,count(id) as countIds,sum(mark) as sumMark from docmark group by docid 
	OPEN @mark_cursor 
	FETCH NEXT FROM @mark_cursor INTO @docid,@countIds,@sumMark
	WHILE @@FETCH_STATUS = 0
	begin
        update docdetail set countMark=@countIds,sumMark=@sumMark where id = @docid
        FETCH NEXT FROM @mark_cursor INTO @docid,@countIds,@sumMark
	end 
	CLOSE @mark_cursor
	DEALLOCATE @mark_cursor 


    SET @readtag_cursor = CURSOR FORWARD_ONLY STATIC FOR
	select docid,sum(readcount) as sumReadCount from docreadtag group by docid 
	OPEN @readtag_cursor 
	FETCH NEXT FROM @readtag_cursor INTO @docid,@sumReadCount
	WHILE @@FETCH_STATUS = 0
	begin
        update docdetail set sumReadCount=@sumReadCount where id = @docid
        FETCH NEXT FROM @readtag_cursor INTO @docid,@sumReadCount
	end 
	CLOSE @readtag_cursor
	DEALLOCATE @readtag_cursor 
Go

/*ִ�����潨���Ĵ洢����*/
initDocdetailMarkRead '',''
go


/*��docReadTag��,�����޸ĺͲ���ʱ��trigger*/
CREATE  TRIGGER Tri_insert_docreadtag ON docreadtag WITH ENCRYPTION
FOR INSERT,update
AS
Declare	
@docid int,
@sumreadcount int
    select distinct @docid=docid from  inserted 
    update docdetail set sumreadcount = ISNULL(sumreadcount,0)+1 where  id =@docid
Go
/*��docmark��,�����޸ĺͲ���ʱ��trigger*/
CREATE   TRIGGER Tri_U_I_docmark ON docmark WITH ENCRYPTION
FOR INSERT,update
AS
Declare	
@id int,
@docid int,
@markold int,
@marknew int
    select distinct @id=id,@markold=mark from  deleted
    select distinct @docid=docid,@marknew=mark from inserted
    if (@id is null)   /*insert*/       
            update docdetail set countmark = ISNULL(countmark,0)+1,summark=ISNULL(summark,0)+@marknew where  id =@docid        
    else
         update docdetail set summark = summark-@markold+@marknew where  id =@docid    
Go


