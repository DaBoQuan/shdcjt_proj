Alter PROCEDURE Share_forDoc
(
    @docid int ,
    @flag int output, 
    @msg varchar(80) output 
)
AS 
declare @sharetype int
declare @newsharetype int
declare @sharecontent varchar(10)

declare @sharelevel int
declare @foralluser int
declare @departmentid int
declare @subcompanyid int
declare @userid int
declare @ownerid int
declare @createrid int
declare @crmid int
declare @orgGroupId int
declare @temp_userid int
declare @srcfrom int
declare @opuser int
declare @temp_departmentid int 

declare @roleid int
declare @rolelevel int
declare @rolevalue int
declare @seclevel int
declare @sharesource int

declare @isExistInner int
declare @isExistOuter int

declare @isSysadmin int
declare @downloadlevel int
BEGIN
    /*ѡɾ���������*/
    DELETE ShareinnerDoc  WHERE  sourceid=@docid
    DELETE ShareouterDoc  WHERE  sourceid=@docid
    

    /*�ٲ����������*/
    declare docid_cursor cursor for   
    select docid,sharetype,seclevel,userid,subcompanyid,departmentid,foralluser,sharelevel,roleid,rolelevel,crmid,orgGroupId,sharesource,downloadlevel 
    from docshare where docid=@docid and docid>0

    open docid_cursor fetch next from docid_cursor into @docid,@sharetype,@seclevel,@userid,@subcompanyid,@departmentid,@foralluser,@sharelevel,@roleid,@rolelevel,@crmid,@orgGroupId,@sharesource,@downloadlevel

     while @@fetch_status=0 
      begin  
           set @isExistInner=0
           set @isExistOuter=0
           if @downloadlevel is null set @downloadlevel=0
           /*�õ�ֵ*/         
            if @sharetype=1   /*������Դ*/ 
                begin
                    set @newsharetype=1
                    set @sharecontent=@userid 
                    set @seclevel=0
                    set @srcfrom=1
                    set @opuser=@userid

                    set @isExistInner=1
                end

            else if  @sharetype=2  /*�ֲ�*/            
                begin
                    set @newsharetype=2
                    set @sharecontent=@subcompanyid 
                    set @seclevel=@seclevel
                    set @srcfrom=2
                    set @opuser=@subcompanyid
                    set @isExistInner=1
                end  

            else if  @sharetype=3  /*����*/
                begin
                    set @newsharetype=3
                    set @sharecontent=@departmentid 
                    set @seclevel=@seclevel
                    set @srcfrom=3
                    set @opuser=@departmentid

                    set @isExistInner=1
                end  
           else if  @sharetype=6  /*Ⱥ��*/
                begin
                    set @newsharetype=6
                    set @sharecontent=@orgGroupId
                    set @seclevel=@seclevel
                    set @srcfrom=6
                    set @opuser=@orgGroupId

                    set @isExistInner=1
                end 
           else if  @sharetype=5  /*������*/
                begin
                    set @newsharetype=5
                    set @sharecontent=1 
                    set @seclevel=@seclevel
                    set @srcfrom=5
                    set @opuser=0

                    set @isExistInner=1
                end 
           else if  @sharetype=80  /*�����˱���*/
                begin
                    set @newsharetype=1
                    set @sharecontent=@userid 
                    set @seclevel=0
                    set @srcfrom=80
                    set @opuser=@userid                    
                    set @isExistInner=1
                    
                    /*����ĵ��Ĵ����ߺ��ĵ����������������ͬһ�˵Ļ������ǵ�Ȩ�޽�����һ��*/
				    select @ownerid=ownerid, @createrid=doccreaterid  from docdetail where id=@docid    
				    if (@ownerid!=@createrid) begin
                         insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) 
                         values(@docid,1,@ownerid,0,@sharelevel,86,0,0,@downloadlevel)  
                    end                    
                end 
          else if  @sharetype=81  /*������ֱ���ϼ�*/
              begin
                  select @isSysadmin=count(*) from hrmresourcemanager where id=@userid
                  if (@isSysadmin!=1)    
                  begin                
	                  set @newsharetype=1
	                  /*���ϼ�*/
	                  SELECT  @sharecontent=managerid FROM HrmResource where id=@userid
	                  set @seclevel=0
	                  set @srcfrom=81
	                  set @opuser=@userid
	
	                  set @isExistInner=1
                   end
              end 
         else if  @sharetype=84  /*ͬ�ֲ�*/
              begin
                  select @isSysadmin=count(*) from hrmresourcemanager where id=@userid                    
                  if (@isSysadmin!=1)   
                  begin 
	                  set @newsharetype=2
	                  /*��ֲ�*/                  
	                  SELECT  @temp_departmentid=departmentid  FROM HrmResource where id=@userid
	                  select @sharecontent=subcompanyid1   from  HrmDepartment where id=@temp_departmentid
	
	                  set @seclevel=@seclevel
	                  set @srcfrom=84
	                  set @opuser=@userid
	
	                  set @isExistInner=1
                   end
              end 
         else if  @sharetype=85  /*ͬ����*/
              begin
                  select @isSysadmin=count(*) from hrmresourcemanager where id=@userid  
                  if (@isSysadmin!=1)    
                  begin 
	                  set @newsharetype=3
	                  /*����*/
	                  SELECT @sharecontent=departmentid  FROM HrmResource where id=@userid
	                  set @seclevel=@seclevel
	                  set @srcfrom=85
	                  set @opuser=@userid
	
	                  set @isExistInner=1
                  end
              end 

       else if  @sharetype=-81  /*�ͻ��ľ���*/
          begin
              set @newsharetype=1             
              select @sharecontent=manager from CRM_CustomerInfo where id=@userid /*��ͻ��ľ���*/
              set @seclevel=0
              set @srcfrom=-81
              set @opuser=@userid

              set @isExistInner=1
          end 
       else if  @sharetype=9  /*�ͻ�*/
          begin
              set @newsharetype=9             
              select @sharecontent=@crmid
              set @seclevel=0
              set @srcfrom=9
              set @opuser=@crmid

              set @isExistOuter=1
          end 

         else if  @sharetype=-80  /*�ͻ�����*/
          begin
              set @newsharetype=9             
              select @sharecontent=@userid
              set @seclevel=0
              set @srcfrom=-80
              set @opuser=@userid

              set @isExistOuter=1
          end 
          else if  @sharetype<0 and @sharetype>-80 /*�ͻ�����*/
          begin
              set @newsharetype=10             
              select @sharecontent=STR(@sharetype*-1)
              set @srcfrom=10
              set @opuser=@sharetype

              set @isExistOuter=1
          end 
          else if  @sharetype=4  /*��ɫ ��ɫ���͵Ĵ���Ƚ�����*/
                begin  
                    set @newsharetype=4    
                    set @srcfrom=4
                    set @opuser=@roleid

                     if @docid is null set @docid=0
                     if @newsharetype is null set @newsharetype=0
                     if @sharecontent is null set @sharecontent=0
                     if @seclevel is null set @seclevel=0
                     if @sharelevel is null set @sharelevel=0
                     if @srcfrom is null set @srcfrom=0
                     if @opuser is null set @opuser=0
                     if @sharesource is null set @sharesource=0


                    IF @rolelevel=0 /*���� �ܲ�,�ֲ�,�����ܿ�*/
                    BEGIN
                     set @sharecontent=CAST(STR(@roleid,9)+STR(0,1) AS INT) 
                     insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                     set @sharecontent=CAST(STR(@roleid,9)+STR(1,1) AS INT) 
                     insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                     set @sharecontent=CAST(STR(@roleid,9)+STR(2,1) AS INT) 
                     insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                    END
                    else  IF @rolelevel=1 /*��ֲ� �ܲ�,�ֲ��ܿ�*/                        
                    BEGIN
                     set @sharecontent=CAST(STR(@roleid,9)+STR(1,1) AS INT) 
                     insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                     set @sharecontent=CAST(STR(@roleid,9)+STR(2,1) AS INT) 
                     insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                    END
                    else IF @rolelevel=2 /*���ܲ� �ܲ��ܿ�*/
                    BEGIN
                      set @sharecontent=CAST(STR(@roleid,9)+STR(2,1) AS INT) 
                      insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values  (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel )     
                    END
                    set @isExistInner=0  /*����Ҫ���������������*/
                end   
         IF  @isExistInner=1
         BEGIN
             if @docid is null set @docid=0
             if @newsharetype is null set @newsharetype=0
             if @sharecontent is null set @sharecontent=0
             if @seclevel is null set @seclevel=0
             if @sharelevel is null set @sharelevel=0
             if @srcfrom is null set @srcfrom=0
             if @opuser is null set @opuser=0
             if @sharesource is null set @sharesource=0

             /*��������*/                         
             insert into ShareinnerDoc  (sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values       
             (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel)             
         END             

         IF  @isExistOuter=1 
         BEGIN
             if @docid is null set @docid=0
             if @newsharetype is null set @newsharetype=0
             if @sharecontent is null set @sharecontent=0
             if @seclevel is null set @seclevel=0
             if @sharelevel is null set @sharelevel=0
             if @srcfrom is null set @srcfrom=0
             if @opuser is null set @opuser=0
             if @sharesource is null set @sharesource=0

             /*��������*/
             insert into ShareouterDoc(sourceid,type,content,seclevel,sharelevel,srcfrom,opuser,sharesource,downloadlevel) values        
             (@docid,@newsharetype,@sharecontent,@seclevel,@sharelevel,@srcfrom,@opuser,@sharesource,@downloadlevel)
         END          

        /*������һѭ��*/    
        fetch next from docid_cursor into  @docid,@sharetype,@seclevel,@userid,@subcompanyid,@departmentid,@foralluser,@sharelevel,@roleid,@rolelevel,@crmid,@orgGroupId,@sharesource,@downloadlevel
      end 
    close docid_cursor deallocate docid_cursor	
END
GO
