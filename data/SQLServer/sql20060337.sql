
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


                    fetch next from temp_cursor into @sameDepartUserId 
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


UPDATE license set cversion = '3.150'
go