Alter   PROCEDURE Doc_SecCategory_Insert ( 
  @subcategoryid 	int,
  @categoryname 	varchar(200), 
  @docmouldid 	int,
  @publishable 	char(1), 
  @replyable 	char(1),
  @shareable 	char(1),
  @cusertype 	int, 
  @cuserseclevel 	tinyint, 
  @cdepartmentid1 	int, 
  @cdepseclevel1 	tinyint,
  @cdepartmentid2 	int,
  @cdepseclevel2 	tinyint,
  @croleid1	 		int, 
  @crolelevel1	 	char(1), 
  @croleid2	 	int, 
  @crolelevel2 	char(1),
  @croleid3	 	int, 
  @crolelevel3 	char(1),
  @hasaccessory	 	char(1),
  @accessorynum	 	tinyint, 
  @hasasset		 	char(1),
  @assetlabel	 	varchar(200), 
  @hasitems	 	char(1),
  @itemlabel 	varchar(200), 
  @hashrmres 	char(1),
  @hrmreslabel 	varchar(200), 
  @hascrm	 	char(1),
  @crmlabel	 	varchar(200), 
  @hasproject 	char(1),
  @projectlabel 	varchar(200), 
  @hasfinance 	char(1), 
  @financelabel 	varchar(200), 
  @approveworkflowid	int,
  @markable  char(1),
  @markAnonymity char(1),
  @orderable char(1),
  @defaultLockedDoc int,
  @allownModiMShareL int,
  @allownModiMShareW int,
  @flag	int output, 
  @msg	varchar(80)	output)
as 
insert into docseccategory values( @subcategoryid, @categoryname, @docmouldid, @publishable, @replyable, @shareable, @cusertype, @cuserseclevel, @cdepartmentid1, @cdepseclevel1, @cdepartmentid2, @cdepseclevel2, @croleid1, @crolelevel1, @croleid2, @crolelevel2, @croleid3, @crolelevel3, @hasaccessory, @accessorynum, @hasasset, @assetlabel, @hasitems, @itemlabel, @hashrmres, @hrmreslabel, @hascrm, @crmlabel, @hasproject, @projectlabel, @hasfinance, @financelabel, @approveworkflowid,@markable,@markAnonymity,@orderable,@defaultLockedDoc,@allownModiMShareL,@allownModiMShareW) 
select max(id) from docseccategory 
GO

ALTER   PROCEDURE Doc_SecCategory_Update (
@id	int,
@subcategoryid 	[int], 
@categoryname 	[varchar](200), 
@docmouldid 	[int], 
@publishable 	[char](1),
@replyable 	[char](1),
@shareable 	[char](1),
@cusertype 	[int],
@cuserseclevel 	[tinyint],
@cdepartmentid1 [int], 
@cdepseclevel1 	[tinyint],
@cdepartmentid2 [int],
@cdepseclevel2 	[tinyint],
@croleid1	[int],
@crolelevel1	[char](1), 
@croleid2	[int],
@crolelevel2 	[char](1),
@croleid3	[int], 
@crolelevel3 	[char](1), 
@hasaccessory	[char](1), 
@accessorynum	[tinyint], 
@hasasset	[char](1),
@assetlabel	[varchar](200),
@hasitems	[char](1), 
@itemlabel 	[varchar](200),
@hashrmres 	[char](1),
@hrmreslabel 	[varchar](200),
@hascrm	 	[char](1), 
@crmlabel	[varchar](200),
@hasproject 	[char](1), 
@projectlabel 	[varchar](200),
@hasfinance 	[char](1), 
@financelabel 	[varchar](200), 
@approveworkflowid	int, 
@markable  [char](1),
@markAnonymity [char](1),
@orderable [char](1),
@defaultLockedDoc int ,
@allownModiMShareL int,
@allownModiMShareW int,
@flag	int output, @msg	varchar(80)	output) 
as update docseccategory set subcategoryid=@subcategoryid, categoryname=@categoryname, docmouldid=@docmouldid, publishable=@publishable, replyable=@replyable, shareable=@shareable, cusertype=@cusertype, cuserseclevel=@cuserseclevel, cdepartmentid1=@cdepartmentid1, cdepseclevel1=@cdepseclevel1, cdepartmentid2=@cdepartmentid2, cdepseclevel2=@cdepseclevel2, croleid1=@croleid1, crolelevel1=@crolelevel1, croleid2=@croleid2, crolelevel2=@crolelevel2, croleid3=@croleid3, crolelevel3=@crolelevel3, approveworkflowid=@approveworkflowid, hasaccessory=@hasaccessory, accessorynum=@accessorynum, hasasset=@hasasset, assetlabel=@assetlabel, hasitems=@hasitems, itemlabel=@itemlabel, hashrmres=@hashrmres, hrmreslabel=@hrmreslabel, hascrm=@hascrm, crmlabel=@crmlabel, hasproject=@hasproject, projectlabel=@projectlabel, hasfinance=@hasfinance, financelabel=@financelabel,markable=@markable ,markAnonymity=@markAnonymity,orderable=@orderable,defaultLockedDoc=@defaultLockedDoc,allownModiMShareL=@allownModiMShareL,allownModiMShareW=@allownModiMShareW where id=@id 


GO

Create    PROCEDURE Doc_setDocShareByHrm (
    @resourceid_1  int,
    @seclevel_1 int,
    @departmentid_1 int,
    @subcompanyid_1 int,
    @flag int output, 
    @msg varchar(80) output 
)
AS
     Declare @docid_1 int, @sharelevel_1  int,@countrec int 
    /* ɾ��ԭ�еĸ��˵������ĵ�������Ϣ */
    delete from DocShareDetail where userid = @resourceid_1 and usertype = 1

    /* ������ʱ����� */
    Declare @temptablevalue  table(docid int,sharelevel int)
    
    /*���ڶ��ĵ���Ȩ�޴���������޸� ���Ѳ�����Ĭ�϶��Լ����ĵ�������ȫ����Ȩ��,Ҳ����Ĭ�϶����ѵ��¼����в鿴Ȩ��*/
    /*�Բ����Լ��������ĵ������������Լ����ĵ�������ȫ����Ȩ��*/
     declare docid_cursor cursor for
     select id from docdetail where doccreaterid!= ownerid  and ownerid=@resourceid_1    
    open docid_cursor  fetch next from docid_cursor into @docid_1 
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, 3)
        fetch next from docid_cursor into @docid_1
    end
    close docid_cursor deallocate docid_cursor
         
    /*��shareTypeΪ80�� ��ʾ���Լ����ĵ��Ŀ���Ȩ��*/
    declare docid_cursor cursor for
    select distinct docid,sharelevel from docshare where sharetype=80 and userid=@resourceid_1
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1 
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor
    
    /*��shareTypeΪ81�� ��ʾ���Լ���ֱ���¼����ĵ�*/
    declare docid_cursor cursor for
    select  distinct docid,sharelevel from docshare  where sharetype=81 and userid in ( select id from hrmresource where managerid =@resourceid_1)
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor
    
    /*��shareTypeΪ82��  ��ʾ���Լ�������*/ 
    declare docid_cursor cursor for
    select  distinct docid,sharelevel from docshare  where sharetype=82 and userid in ( select id from hrmresource where ','+managerstr like '%,'+char(@resourceid_1)+',%')
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor      
    
    /*��shareTypeΪ83��  ��ʾ���Լ��ļ���ϼ�*/  
    declare @managerIds varchar(50),@sepindex int, @managerId int
    select @managerIds=managerstr+'0' from  hrmresource where id =@resourceid_1
    select @sepindex = CHARINDEX(',',@managerIds)
    while  @sepindex != 0 
    begin 
        set @managerId = convert(int,SUBSTRING(@managerIds,1,@sepindex-1)) 
        set @managerIds = SUBSTRING(@managerIds,@sepindex+1,LEN(@managerIds)-@sepindex)
        set @sepindex = CHARINDEX(',',@managerIds)    
        
            declare docid_cursor cursor for
            select  distinct docid,sharelevel from docshare  where sharetype=83 and userid =@managerId and  seclevel<=@seclevel_1
            open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
            while @@fetch_status=0
            begin 
                insert into @temptablevalue values(@docid_1, @sharelevel_1)
                fetch next from docid_cursor into @docid_1 , @sharelevel_1
            end
            close docid_cursor deallocate docid_cursor         
    end         
    
    /*��shareTypeΪ84�� ������ͬ�ֲ�*/    
    declare docid_cursor cursor for
    select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and d1.sharetype=84  and  d1.seclevel<=@seclevel_1 and d1.subcompanyid = @subcompanyid_1
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor   
    
    /*��shareTypeΪ85�� ������ͬ����*/    
    declare docid_cursor cursor for
    select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and d1.sharetype=85  and  d1.seclevel<=@seclevel_1 and d1.departmentid = @departmentid_1
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor   
    
    /*��shareTypeΪ-81�� �����˵�ֱ�ӿͻ�*/ 
    declare docid_cursor cursor for
    select  distinct docid,sharelevel from docshare   where sharetype=-81 and  userid in (select id  from CRM_CustomerInfo   where manager=@resourceid_1)
    open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_1, @sharelevel_1)
        fetch next from docid_cursor into @docid_1 , @sharelevel_1
    end
    close docid_cursor deallocate docid_cursor 
    
    
    /*��shareTypeΪ-82�� �����˵��¼��Ŀͻ�*/ 
    declare @tempDownOwnerId int
    declare downOwner_cursor cursor for
    select id from hrmresource where managerid=@resourceid_1
    open downOwner_cursor  fetch next from downOwner_cursor into @tempDownOwnerId
     while @@fetch_status=0
    begin   
            declare docid_cursor cursor for
            select  distinct docid,sharelevel from docshare   where sharetype=-82 and  userid in (select id  from CRM_CustomerInfo   where manager=@resourceid_1)
            open docid_cursor  fetch next from docid_cursor into @docid_1 , @sharelevel_1
            while @@fetch_status=0
            begin 
                insert into @temptablevalue values(@docid_1, @sharelevel_1)
                fetch next from docid_cursor into @docid_1 , @sharelevel_1
            end
            close docid_cursor deallocate docid_cursor
        fetch next from downOwner_cursor into @tempDownOwnerId
    end
    close downOwner_cursor deallocate downOwner_cursor     


    /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
    declare sharedocid_cursor cursor for
    select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= @seclevel_1 ) 
     or ( userid= @resourceid_1 ) or (departmentid= @departmentid_1 and seclevel<= @seclevel_1 ) 
     and sharetype not in (80,81,82,83,84,85,-80,-81,-82) 
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
    select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 
    where t1.id=t2.docid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel
     and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= @departmentid_1 ) 
     or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
     and t2.sharetype not in (80,81,82,83,84,85,-80,-81,-82) 
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
    select docid ,max(sharelevel) as sharelevel from @temptablevalue group by docid
    open alldocid_cursor 
    fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into docsharedetail values(@docid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from alldocid_cursor into @docid_1 , @sharelevel_1
    end
    close alldocid_cursor deallocate alldocid_cursor
 GO


 /*��һ�����˵�һƪ�ĵ����в���*/
Create    PROCEDURE Doc_setDocShareByHrmAndDoc (    
    @resourceid_1  int,
    @docid_1 int,
    @usertype_1 int,
    @seclevel_1 int,
    @departmentid_1 int,
    @subcompanyid_1 int,
    @flag int output, 
    @msg varchar(80) output 
)
AS
     Declare @docid_temp int, @sharelevel_1  int,@countrec int 
    /* ɾ��ԭ�еĸ��˴��ĵ�������Ϣ */
    delete from DocShareDetail where userid = @resourceid_1 and usertype = @usertype_1 and docid=@docid_1

    /* ������ʱ����� */
    Declare @temptablevalue  table(docid int,sharelevel int,usertype int)


     /*�Բ����Լ��������ĵ������������Լ����ĵ�������ȫ����Ȩ��*/
     declare docid_cursor cursor for
     select id from docdetail where doccreaterid!= ownerid  and ownerid=@resourceid_1 and id=@docid_1 and usertype=@usertype_1
    open docid_cursor  fetch next from docid_cursor into @docid_temp 
    while @@fetch_status=0
    begin 
        insert into @temptablevalue values(@docid_temp, 3,@usertype_1)
        fetch next from docid_cursor into @docid_temp
    end
    close docid_cursor deallocate docid_cursor


    if @usertype_1=1 /*�ڲ��û�*/
    begin
        /*���ڶ��ĵ���Ȩ�޴���������޸� ���Ѳ�����Ĭ�϶��Լ����ĵ�������ȫ����Ȩ��,Ҳ����Ĭ�϶����ѵ��¼����в鿴Ȩ��*/   
        /*��shareTypeΪ80�� ��ʾ���Լ����ĵ��Ŀ���Ȩ��*/
        declare docid_cursor cursor for
        select distinct docid,sharelevel from docshare where sharetype=80 and userid=@resourceid_1 and docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1 
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor
        
        /*��shareTypeΪ81�� ��ʾ���Լ���ֱ���¼����ĵ�*/
        declare docid_cursor cursor for
        select  distinct docid,sharelevel from docshare  where sharetype=81 and userid in ( select id from hrmresource where managerid =@resourceid_1) and docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor
        
        /*��shareTypeΪ82��  ��ʾ���Լ�������*/ 
        declare docid_cursor cursor for
        select  distinct docid,sharelevel from docshare  where sharetype=82 and userid in ( select id from hrmresource where ','+managerstr like '%,'+char(@resourceid_1)+',%') and docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor      
        
        /*��shareTypeΪ83��  ��ʾ���Լ��ļ���ϼ�*/  
        declare @managerIds varchar(50),@sepindex int, @managerId int
        select @managerIds=managerstr+'0' from  hrmresource where id =@resourceid_1
        select @sepindex = CHARINDEX(',',@managerIds)
        while  @sepindex != 0 
        begin 
            set @managerId = convert(int,SUBSTRING(@managerIds,1,@sepindex-1)) 
            set @managerIds = SUBSTRING(@managerIds,@sepindex+1,LEN(@managerIds)-@sepindex)
            set @sepindex = CHARINDEX(',',@managerIds)    
            
                declare docid_cursor cursor for
                select  distinct docid,sharelevel from docshare  where sharetype=83 and userid =@managerId and  seclevel<=@seclevel_1 and docid=@docid_1
                open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
                while @@fetch_status=0
                begin 
                    insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
                    fetch next from docid_cursor into @docid_temp , @sharelevel_1
                end
                close docid_cursor deallocate docid_cursor         
        end         
        
        /*��shareTypeΪ84�� ������ͬ�ֲ�*/    
        declare docid_cursor cursor for
        select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and d1.sharetype=84  and  d1.seclevel<=@seclevel_1 and d1.subcompanyid = @subcompanyid_1 and d1.docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor   
        
        /*��shareTypeΪ85�� ������ͬ����*/    
        declare docid_cursor cursor for
        select  distinct d1.docid,d1.sharelevel from docshare d1,hrmresource h1   where d1.userid=h1.id and d1.sharetype=85  and  d1.seclevel<=@seclevel_1 and d1.departmentid = @departmentid_1 and d1.docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor   
        
        /*��shareTypeΪ-81�� �����˵�ֱ�ӿͻ�*/ 
        declare docid_cursor cursor for
        select  distinct docid,sharelevel from docshare   where sharetype=-81 and  userid in (select id  from CRM_CustomerInfo   where manager=@resourceid_1) and docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor 
        
        
        /*��shareTypeΪ-82�� �����˵��¼��Ŀͻ�*/ 
        declare @tempDownOwnerId int
        declare downOwner_cursor cursor for
        select id from hrmresource where managerid=@resourceid_1
        open downOwner_cursor  fetch next from downOwner_cursor into @tempDownOwnerId
         while @@fetch_status=0
        begin   
                declare docid_cursor cursor for
                select  distinct docid,sharelevel from docshare   where sharetype=-82 and  userid in (select id  from CRM_CustomerInfo   where manager=@resourceid_1) and docid=@docid_1
                open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
                while @@fetch_status=0
                begin 
                    insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
                    fetch next from docid_cursor into @docid_temp , @sharelevel_1
                end
                close docid_cursor deallocate docid_cursor
            fetch next from downOwner_cursor into @tempDownOwnerId
        end
        close downOwner_cursor deallocate downOwner_cursor     


        /* ���ĵ��Ĺ����õ�Ȩ�� , ������ֳ���������, ��ɫ����һ������.����һ������,�����ѯ̫��*/
        declare sharedocid_cursor cursor for
        select distinct docid , sharelevel from DocShare  where  (foralluser=1 and seclevel<= @seclevel_1 ) 
         or ( userid= @resourceid_1 ) or (departmentid= @departmentid_1 and seclevel<= @seclevel_1 ) 
         and sharetype not in (80,81,82,83,84,85,-80,-81,-82)  and docid=@docid_1
        open sharedocid_cursor 
        fetch next from sharedocid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from @temptablevalue where docid = @docid_temp  
            if @countrec = 0  
            begin
                insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update @temptablevalue set sharelevel = 2 where docid=@docid_temp /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
            end
            fetch next from sharedocid_cursor into @docid_temp , @sharelevel_1
        end 
        close sharedocid_cursor deallocate sharedocid_cursor

        declare sharedocid_cursor cursor for
        select distinct t2.docid , t2.sharelevel from DocDetail t1 ,  DocShare  t2,  HrmRoleMembers  t3 , hrmdepartment  t4 
        where t1.id=t2.docid and t3.resourceid= @resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel
         and t2.seclevel<= @seclevel_1 and ( (t2.rolelevel=0  and t1.docdepartmentid= @departmentid_1 ) 
         or (t2.rolelevel=1 and t1.docdepartmentid=t4.id and t4.subcompanyid1= @subcompanyid_1 ) or (t3.rolelevel=2) )
         and t2.sharetype not in (80,81,82,83,84,85,-80,-81,-82) and t2.docid=@docid_1
        open sharedocid_cursor 
        fetch next from sharedocid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            select @countrec = count(docid) from @temptablevalue where docid = @docid_temp  
            if @countrec = 0  
            begin
                insert into @temptablevalue values(@docid_temp, @sharelevel_1,@usertype_1)
            end
            else if @sharelevel_1 = 2  
            begin
                update @temptablevalue set sharelevel = 2 where docid=@docid_temp /* �����ǿ��Ա༭, ���޸�ԭ�м�¼    */   
            end
            fetch next from sharedocid_cursor into @docid_temp , @sharelevel_1
        end 
        close sharedocid_cursor deallocate sharedocid_cursor  
    end
    else  /*�ⲿ�û�*/
    begin
         /*��shareTypeΪ-80�� �����˵�ֱ�ӿͻ�*/ 
        declare docid_cursor cursor for
        select  distinct docid,sharelevel from docshare   where sharetype=-80 and  userid= @resourceid_1 and docid=@docid_1
        open docid_cursor  fetch next from docid_cursor into @docid_temp , @sharelevel_1
        while @@fetch_status=0
        begin 
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,9)
            fetch next from docid_cursor into @docid_temp , @sharelevel_1
        end
        close docid_cursor deallocate docid_cursor 

        /*���Ƿ��д��ⲿ�û���������ҵ*/
        declare @crmtype int
        select @crmtype=type from CRM_CustomerInfo where id=@resourceid_1
        select @countrec = count(id) from docshare where sharetype=(-1)*@crmtype and seclevel<=@seclevel_1 and docid=@docid_1
        if @countrec=1 
        begin
            insert into @temptablevalue values(@docid_temp, @sharelevel_1,9)
        end
    end


    /* ����ʱ���е�����д�빲��� */
    declare alldocid_cursor cursor for
    select docid ,max(sharelevel) as sharelevel from @temptablevalue group by docid
    open alldocid_cursor 
    fetch next from alldocid_cursor into @docid_temp , @sharelevel_1
    while @@fetch_status=0
    begin 
        if @usertype_1=1 
        begin
            insert into docsharedetail (docid,userid,usertype,sharelevel) values(@docid_temp, @resourceid_1,1,@sharelevel_1)
        end
        else
        begin
            insert into docsharedetail (docid,userid,usertype,sharelevel) values(@docid_temp, @resourceid_1,9,@sharelevel_1)
        end
        
        fetch next from alldocid_cursor into @docid_temp , @sharelevel_1
    end
    close alldocid_cursor deallocate alldocid_cursor
 GO

 ALTER  PROCEDURE DocShare_FromDocSecCategoryI (@docid  int, @sharetype	int, @seclevel	tinyint, @rolelevel	tinyint, 
@sharelevel	tinyint, @userid	int, @subcompanyid	int, @departmentid	int, @roleid	int, 
@foralluser	tinyint, @crmid	int,@sharesource int, @flag	int output, @msg	varchar(80)	output) as 

declare @count_1 int 

select @count_1=count(*)  
from DocShare 
where docid=@docid and sharetype=@sharetype and seclevel=@seclevel and rolelevel=@rolelevel and sharelevel<=@sharelevel 
and userid=@userid and subcompanyid=@subcompanyid and departmentid=@departmentid and roleid=@roleid and foralluser=@foralluser 
and crmid=@crmid and sharesource=@sharesource

if @count_1=0 begin 
	insert into DocShare(docid,sharetype,seclevel,rolelevel,sharelevel,userid,subcompanyid,departmentid,roleid,foralluser,crmid,sharesource) 
	values(@docid,@sharetype,@seclevel,@rolelevel,@sharelevel,@userid,@subcompanyid,@departmentid,@roleid,@foralluser,@crmid,@sharesource)   
end else begin
	update DocShare 
	set docid=@docid , sharetype=@sharetype , seclevel=@seclevel , rolelevel=@rolelevel , 
	sharelevel=@sharelevel , userid=@userid , subcompanyid=@subcompanyid , departmentid=@departmentid 
	, roleid=@roleid , foralluser=@foralluser , crmid=@crmid , sharesource=@sharesource
	where docid=@docid and sharetype=@sharetype and seclevel=@seclevel and rolelevel=@rolelevel and 
	sharelevel<@sharelevel and userid=@userid and subcompanyid=@subcompanyid and departmentid=@departmentid 
	and roleid=@roleid and foralluser=@foralluser and crmid=@crmid and sharesource=@sharesource
end

GO


Alter PROCEDURE DocShare_IFromDocSecCategory (
@docid          int, 
@sharetype	int, 
@seclevel	tinyint, 
@rolelevel	tinyint,
@sharelevel	tinyint,
@userid	int,
@subcompanyid	int, 
@departmentid	int, 
@roleid	int, 
@foralluser	tinyint,
@crmid	int, 
@flag	int output, 
@msg	varchar(80)	output
) 
as 
insert into 
   DocShare(docid,sharetype,seclevel,rolelevel,sharelevel,userid,subcompanyid,departmentid,roleid,foralluser,crmid)
values
   (@docid,@sharetype,@seclevel,@rolelevel,@sharelevel,@userid,@subcompanyid,@departmentid,@roleid,@foralluser,@crmid)   

select @@IDENTITY
GO
Alter  PROCEDURE DocShareDetail_SetByDoc (
@docid_1  int ,
@createrid_2  int ,
@owenerid_3  int , 
@usertype_4  int ,
@replydocid_5  int ,
@departmentid_6  int ,
@subcompanyid_7  int , 
@managerid_8 int ,
@considermanager_9 int ,
@flag int output, 
@msg varchar(80) output )
AS
Declare 
@recordercount int ,
@allmanagerid varchar(255), 
@tempuserid int, 
@tempsharelevel int ,
@tempsharelevelold int ,
@tempsharetype int ,
@sepindex int,
@crmManagerId int,
@crmManagerUpIds varchar(100),
@hrmManager int,
@hrmJmangers varchar(50),
@hrmallmanagerid varchar(255),
@tempseclevel int
/* ������ʱ����� */
Declare @temptablevalue  table(userid int,usertype int,sharelevel int)  
/*
  �����ڲ��û�:
  ȥ������ǰ�����ĵ������ߺ�������Ĭ��Ϊ�༭Ȩ�޵�����.����ȥ������ȫ���ϼ�Ĭ�Ͼ��в鿴Ȩ�޵Ŀ���
  1.�ĵ��Ĵ����߾��е�Ȩ�޸��� DocShare ���й�������Ϊ:80�� sharelevel(��������ȷ��)
  2.��������ߺ��ĵ���������ͬһ���˵Ļ�,ֻ�����ô����ߵ�Ȩ��,�������������ߵ�Ȩ��
  3.��������ߺ��ĵ������߲���ͬһ���˵Ļ�,�ĵ������߰���ص�Ȩ�޴���,�ĵ���������Ĭ�ϵ�Ȩ��ӦΪ:��ȫ����Ȩ�� 
  4.�����������ط���ͬһ�ĵ���ͬһ���˸�Ȩ��ʱ��,��ȡ����Ȩ�޵�ԭ��
  5.���ڻظ��ĵ�,Ӧ������Ĭ��Ȩ�޼̳б��ظ��ĵ���Ȩ��,�����Զ���Ȩ�޽��н�һ�����޸�
  
   ����ǰ���������ĵ��Ĵ����ߺ������߾��б༭��Ȩ��
   ��ǰ�Ļظ��ĵ�,��������,�����µĻظ��ĵ���������
   80:�����˱��� 81:������ֱ���ϼ�   82:�����˼���ϼ�   83:����������   84:������ͬ�ֲ���Ա   85:������ͬ���ų�Ա
   -80:�ⲿ�û������˱���   -81:�ⲿ�û������˾���     -82:�ⲿ�û������˾�����ϼ�
*/    
if (@usertype_4 <>1) /*�����ⲿ�û��Ĳ��� -80 ~ -82*/
 begin
         declare shareuserid_cursor cursor for select  sharetype,sharelevel,userid from  docshare  where docid=@docid_1 and  sharetype between  -82 and -80
         open shareuserid_cursor fetch next from shareuserid_cursor into @tempsharetype, @tempsharelevel,@tempuserid 
         while @@fetch_status=0 
         begin
           if (@tempsharetype=-80)   /*�ⲿ�û������˱���*/
            begin
                if (@tempsharelevel!=0) 
                    begin
                        insert into @temptablevalue values (@tempuserid,2, @tempsharelevel)
                        if @createrid_2!=@owenerid_3  /*����ĵ������ߺ��ĵ������߲���һ���� ���ĵ�������Ĭ��Ϊ��ȫ����Ȩ��*/
                        begin
                            insert into @temptablevalue values (@owenerid_3,2, @tempsharelevel) 
                        end
                    end                  
            end
            else if (@tempsharetype=-81)  /*�ⲿ�û������˾���*/
            begin 
                 select @crmManagerId=manager from CRM_CustomerInfo  where id=@tempuserid
                 
                     if (@tempsharelevel!=0) 
                        insert into @temptablevalue(userid,usertype,sharelevel) values (@crmManagerId,1, @tempsharelevel)          
            end   
            else if (@tempsharetype=-82)   /*�ⲿ�û������˾���������ϼ�*/
            begin        
                select @crmManagerId=manager from CRM_CustomerInfo  where id=@tempuserid
                select @crmManagerUpIds=managerstr+'0' from  hrmresource where id =@crmManagerId
                select @sepindex = CHARINDEX(',',@crmManagerUpIds)
                while  @sepindex != 0 
                begin 
                    set @tempuserid = convert(int,SUBSTRING(@crmManagerUpIds,1,@sepindex-1)) 
                    set @crmManagerUpIds = SUBSTRING(@crmManagerUpIds,@sepindex+1,LEN(@crmManagerUpIds)-@sepindex)
                    set @sepindex = CHARINDEX(',',@crmManagerUpIds)  
                    
                    if @tempsharelevel != 0 
                        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel) 
                end 
            end  
            fetch next from shareuserid_cursor into @tempsharetype, @tempsharelevel,@tempuserid
         end
         close shareuserid_cursor 
         deallocate shareuserid_cursor
 end
else   /*�����ڲ��û��Ĳ��� +80 ~ +85*/
 begin
        declare shareuserid_cursor cursor for select  sharetype,sharelevel,userid,seclevel from  docshare  where docid=@docid_1 and  sharetype  between  80 and 85
        open shareuserid_cursor fetch next from shareuserid_cursor into @tempsharetype, @tempsharelevel,@tempuserid,@tempseclevel 
         while @@fetch_status=0 
         begin           
            if (@tempsharetype=80)   /*�ڲ��û������˱���*/
            begin
                if (@tempsharelevel!=0)
                begin       
                   set @tempsharelevelold=0
                   select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempuserid   and usertype=1   
                   if (@tempsharelevelold=0) /*��������*/
                      insert into  @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel) 
                   else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                      update @temptablevalue  set sharelevel=@tempsharelevel where userid=@tempuserid  and usertype=1   

                   if @createrid_2!=@owenerid_3  /*����ĵ������ߺ��ĵ������߲���һ���� ���ĵ�������Ĭ��Ϊ��ȫ����Ȩ��*/
                     begin
                         set @tempsharelevelold=0
                         select @tempsharelevelold=sharelevel from @temptablevalue where userid=@owenerid_3   and usertype=1   
                         if (@tempsharelevelold=0) /*��������*/
                            insert into  @temptablevalue(userid,usertype,sharelevel) values(@owenerid_3,1,@tempsharelevel) 
                         else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                            update @temptablevalue  set sharelevel=@tempsharelevel where userid=@owenerid_3  and usertype=1
                     end
                end
            end
            else if (@tempsharetype=81)   /*�ڲ��û�������ֱ���ϼ�*/  
            begin               
                if (@tempsharelevel!=0)
                begin   
                    select @hrmManager=managerid from hrmresource where id=@tempuserid                                      
                    if @hrmManager is not null                   
                    begin
                       set @tempsharelevelold=0
                       select @tempsharelevelold=sharelevel from @temptablevalue where userid=@hrmManager  and usertype=1   
                       if (@tempsharelevelold=0) /*��������*/
                          insert into  @temptablevalue(userid,usertype,sharelevel) values(@hrmManager,1,@tempsharelevel) 
                       else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                          update @temptablevalue  set sharelevel=@tempsharelevel where userid=@hrmManager 
                    end
                end            
            end
            else if (@tempsharetype=82)   /*�ڲ��û������˱��˼���ϼ�*/
            begin
                if (@tempsharelevel!=0)
                begin   
                    declare @hrmallmanagerid_re varchar(255),@temppos int,@tempHrmManager int
                    select   @hrmallmanagerid=managerstr  from hrmresource where id=@tempuserid
                    set @hrmallmanagerid_re =  REVERSE(@hrmallmanagerid) 
                    set @temppos = CHARINDEX( ',',@hrmallmanagerid_re) 
                    set @temppos = CHARINDEX(',', @hrmallmanagerid_re, @temppos+1)
                    if  @temppos <>0 
                        set @hrmallmanagerid_re = SUBSTRING(@hrmallmanagerid_re,@temppos,len(@hrmallmanagerid_re)) /*@hrmJmangersΪ�����ϼ�*/
                    set @hrmJmangers = REVERSE(@hrmallmanagerid_re)
                     
                    select @sepindex = CHARINDEX(',',@hrmJmangers)
                    while  (@sepindex != 0)
                    begin 
                         set @tempHrmManager = convert(int,SUBSTRING(@hrmJmangers,1,@sepindex-1)) 
                         set @hrmJmangers = SUBSTRING(@hrmJmangers,@sepindex+1,LEN(@hrmJmangers)-@sepindex)                     
                         set @sepindex = CHARINDEX(',',@hrmJmangers)  

                         set @tempsharelevelold=0
                         select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempHrmManager  and usertype=1   
                         if (@tempsharelevelold=0) /*��������*/
                            insert into  @temptablevalue(userid,usertype,sharelevel) values(@tempHrmManager,1,@tempsharelevel) 
                         else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                            update @temptablevalue  set sharelevel=@tempsharelevel where userid=@tempHrmManager and usertype=1 
                    end   
                end
             end
             else if (@tempsharetype=83)   /*�ڲ��û�����������*/
             begin
                if (@tempsharelevel!=0)
                begin
                    declare @tempDownUserId int
                    declare temp_cursor cursor for select id from  hrmresource where ','+managerstr like '%,'+convert(char,@tempuserid)+',%' and seclevel>=@tempseclevel and loginid is not null and loginid !=''
                    open temp_cursor fetch next from temp_cursor into @tempDownUserId 
                    while @@fetch_status=0 
                    begin
                         set @tempsharelevelold=0
                         select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempDownUserId and usertype=1   
                         if (@tempsharelevelold=0) /*��������*/
                            insert into  @temptablevalue(userid,usertype,sharelevel) values(@tempDownUserId,1,@tempsharelevel) 
                         else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                            update @temptablevalue  set sharelevel=@tempsharelevel where userid=@tempDownUserId  and usertype=1 
                         fetch next from temp_cursor into @tempDownUserId 
                    end
                    close temp_cursor 
                    deallocate temp_cursor
                end
            end
            else if (@tempsharetype=84)   /*�ڲ��û�������ͬ�ֲ�*/
            begin
                if (@tempsharelevel!=0)
                    begin
                    declare @subCompId int,@sameSubUserId int
                    select @subCompId=subcompanyid1  from  hrmresource where id=@tempuserid
                    declare temp_cursor cursor for select id from  hrmresource where subcompanyid1=@subCompId and seclevel>=@tempseclevel   and loginid is not null and loginid !=''
                    open temp_cursor fetch next from temp_cursor into @sameSubUserId 
                    while @@fetch_status=0 
                    begin
                         set @tempsharelevelold=0
                         select @tempsharelevelold=sharelevel from @temptablevalue where userid=@sameSubUserId  and usertype=1   
                         if (@tempsharelevelold=0) /*��������*/
                            insert into  @temptablevalue(userid,usertype,sharelevel) values(@sameSubUserId,1,@tempsharelevel) 
                         else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                            update @temptablevalue  set sharelevel=@tempsharelevel where userid=@sameSubUserId and usertype=1 
                    fetch next from temp_cursor into @sameSubUserId 
                    end
                    close temp_cursor 
                    deallocate temp_cursor
               end
           end
           else if (@tempsharetype=85)   /*�ڲ��û�������ͬ����*/
           begin
                if (@tempsharelevel!=0)
                    begin
                    declare @departmentId int,@sameDepartUserId int
                    select @departmentId=departmentid  from  hrmresource where id=@tempuserid
                    declare temp_cursor cursor for select id from  hrmresource where departmentid=@departmentId and seclevel>=@tempseclevel  and loginid is not null and loginid !=''
                    open temp_cursor fetch next from temp_cursor into @sameDepartUserId 
                    while @@fetch_status=0 
                    begin
                         set @tempsharelevelold=0
                         select @tempsharelevelold=sharelevel from @temptablevalue where userid=@sameDepartUserId  and usertype=1   
                         if (@tempsharelevelold=0) /*��������*/
                            insert into  @temptablevalue(userid,usertype,sharelevel) values(@sameDepartUserId,1,@tempsharelevel) 
                         else if (@tempsharelevel>@tempsharelevelold) /*��������*/
                            update @temptablevalue  set sharelevel=@tempsharelevel where userid=@sameDepartUserId and usertype=1 
                    fetch next from temp_cursor into @sameSubUserId 
                    end
                    close temp_cursor 
                    deallocate temp_cursor
                 end
             end
            fetch next from shareuserid_cursor into  @tempsharetype, @tempsharelevel,@tempuserid,@tempseclevel
         end
         close shareuserid_cursor 
         deallocate shareuserid_cursor
end

/* �ĵ�������Ϣ (�ڲ��û�) ���漰��ɫ���� */ 
 declare shareuserid_cursor cursor for select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2 where  t1.loginid is not null and t1.loginid <> '' and t2.docid = @docid_1 and ( (t2.foralluser=1 and t2.seclevel<=t1.seclevel)  or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and t2.seclevel<=t1.seclevel)) and t2.sharetype not in(-80,-81,-82,80,81,82,83,84,85)  and t1.loginid is not null and t1.loginid !=''
 
 open shareuserid_cursor fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
 while @@fetch_status=0 
 begin 

 set @tempsharelevelold=0
 select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempuserid  and usertype=1   
 if (@tempsharelevelold=0) /*��������*/
    insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel) 
 else if (@tempsharelevel>@tempsharelevelold) /*��������*/
    update @temptablevalue set sharelevel = @tempsharelevel where userid=@tempuserid and usertype = 1 

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel 
end
close shareuserid_cursor 
deallocate shareuserid_cursor  

    
/* �ĵ�������Ϣ (�ڲ��û�) �漰��ɫ���� */ 
declare shareuserid_cursor cursor for select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2,  HrmRoleMembers  t3 where  t1.loginid is not null and t1.loginid <> '' and t2.docid = @docid_1 and (  t3.resourceid=t1.id and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and ( (t3.rolelevel=2) or (t3.rolelevel=0  and t1.departmentid=@departmentid_6) or (t3.rolelevel=1 and t1.subcompanyid1=@subcompanyid_7) ) ) and t2.sharetype not in(-80,-81,-82,80,81,82,83,84,85) and t1.loginid is not null and t1.loginid !=''
open shareuserid_cursor fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel 
while    @@fetch_status=0
begin

     set @tempsharelevelold=0
     select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempuserid  and usertype=1   
     if (@tempsharelevelold=0) /*��������*/
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel) 
     else if (@tempsharelevel>@tempsharelevelold) /*��������*/
        update @temptablevalue set sharelevel = @tempsharelevel where userid=@tempuserid and usertype = 1 

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
end
close shareuserid_cursor 
deallocate shareuserid_cursor  

/* �ĵ�������Ϣ �ⲿ�û� ( ���� ) */
declare shareuserid_cursor cursor for select distinct sharetype , seclevel, sharelevel from DocShare where sharetype < 0 and docid = @docid_1 and sharetype not in(-80,-81,-82,80,81,82,83,84,85)
open shareuserid_cursor fetch next from shareuserid_cursor into @tempsharetype , @tempuserid, @tempsharelevel while @@fetch_status=0 
begin 

     set @tempsharelevelold=0
     select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempuserid and usertype = @tempsharetype   
     if (@tempsharelevelold=0) /*��������*/
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,@tempsharetype,@tempsharelevel)
     else if (@tempsharelevel>@tempsharelevelold) /*��������*/
        update @temptablevalue set sharelevel = @tempsharelevel where userid=@tempuserid and usertype = @tempuserid    

     fetch next from shareuserid_cursor into @tempsharetype , @tempuserid, @tempsharelevel   
end
close shareuserid_cursor 
deallocate shareuserid_cursor


/* �ĵ�������Ϣ �ⲿ�û� ( �û�id ) */ 
declare shareuserid_cursor cursor for select distinct crmid , sharelevel from DocShare where crmid <> 0 and sharetype = '9' and docid = @docid_1 and sharetype not in(-80,-81,-82,80,81,82,83,84,85)
open shareuserid_cursor fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
while @@fetch_status=0 
begin 

    
    set @tempsharelevelold=0
     select @tempsharelevelold=sharelevel from @temptablevalue where userid=@tempuserid and usertype = 9   
     if (@tempsharelevelold=0) /*��������*/
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,9,@tempsharelevel)
     else if (@tempsharelevel>@tempsharelevelold) /*��������*/
       update @temptablevalue set sharelevel = @tempsharelevel where userid=@tempuserid and usertype = 9   

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel 
end
close shareuserid_cursor 
deallocate shareuserid_cursor


/* ����ʱ���е�����д�빲��� */ 
delete docsharedetail where docid = @docid_1
insert into docsharedetail (docid,userid,usertype,sharelevel) select @docid_1 , userid,usertype,sharelevel from @temptablevalue
GO







