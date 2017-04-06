create PROCEDURE DocShareDetail_SetByDoc
(
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
@msg varchar(80) output
) 
AS 
Declare @recordercount int ,@allmanagerid varchar(255), @tempuserid int, @tempsharelevel int , @tempsharetype int , @sepindex int /* �������ڵ�λ�� */

/* ������ʱ����� */
Declare @temptablevalue  table(userid int,usertype int,sharelevel int) 

/* ����ǻظ�ĳһ���ĵ��Ļظ��ĵ�����ԭ�ĵ��Ĺ�����뱾�ظ��ĵ��Ĺ��� */
if @replydocid_5 != 0 
    insert into @temptablevalue(userid,usertype,sharelevel) 
    select userid,usertype,sharelevel from DocShareDetail where docid = @replydocid_5 

/* �����ڲ��û� */
if @usertype_4 = 1  
begin
    /* �ĵ��Ĵ����ߺ������߾��б༭��Ȩ�� */
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@createrid_2 and usertype = 1
    if @recordercount = 0 
        insert into @temptablevalue(userid,usertype,sharelevel) values(@createrid_2,1,2)
    else 
        update @temptablevalue set sharelevel = 2 where userid=@createrid_2 and usertype = 1
    
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@owenerid_3 and usertype = 1
    if @recordercount = 0 
        insert into @temptablevalue(userid,usertype,sharelevel) values(@owenerid_3,1,2)
    else 
        update @temptablevalue set sharelevel = 2 where userid=@owenerid_3 and usertype = 1
    
    /* �����Ҫ�������о��������ߣ������ϼ������в鿴Ȩ�� */
    if @considermanager_9 = 1
    begin
        select @allmanagerid = managerstr+'0' from HrmResource where id = @createrid_2  
        select @sepindex = CHARINDEX(',',@allmanagerid) 
        while  @sepindex != 0 
        begin
            set @tempuserid = convert(int,SUBSTRING(@allmanagerid,1,@sepindex-1))
            set @allmanagerid = SUBSTRING(@allmanagerid,@sepindex+1,LEN(@allmanagerid)-@sepindex)
            set @sepindex = CHARINDEX(',',@allmanagerid) 

            select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 1
            if @recordercount = 0 
                insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,1)
        end
        
        if @owenerid_3 != @createrid_2
        begin
            select @allmanagerid = managerstr+'0' from HrmResource where id = @owenerid_3  
            select @sepindex = CHARINDEX(',',@allmanagerid) 
            while  @sepindex != 0 
            begin
                set @tempuserid = convert(int,SUBSTRING(@allmanagerid,1,@sepindex-1))
                set @allmanagerid = SUBSTRING(@allmanagerid,@sepindex+1,LEN(@allmanagerid)-@sepindex)
                set @sepindex = CHARINDEX(',',@allmanagerid) 

                select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 1
                if @recordercount = 0 
                    insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,1)
            end
        end
    end
end
/* �����ⲿ�û� */
else  
begin
    /* �ĵ��Ĵ����ߣ��ͻ����ʹ����ߣ��ͻ����ľ�����б༭��Ȩ�� */
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@createrid_2 and usertype = 9
    if @recordercount = 0 
        insert into @temptablevalue(userid,usertype,sharelevel) values(@createrid_2,9,2)
    else 
        update @temptablevalue set sharelevel = 2 where userid=@createrid_2 and usertype = 9
    
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@managerid_8 and usertype = 1
    if @recordercount = 0 
        insert into @temptablevalue(userid,usertype,sharelevel) values(@managerid_8,1,2)
    else 
        update @temptablevalue set sharelevel = 2 where userid=@managerid_8 and usertype = 1
    
    /* �����Ҫ�������о��������ߣ������ϼ������в鿴Ȩ�� */
    if @considermanager_9 = 1
    begin
        select @allmanagerid = managerstr+'0' from HrmResource where id = @managerid_8  
        select @sepindex = CHARINDEX(',',@allmanagerid) 
        while  @sepindex != 0 
        begin
            set @tempuserid = convert(int,SUBSTRING(@allmanagerid,1,@sepindex-1))
            set @allmanagerid = SUBSTRING(@allmanagerid,@sepindex+1,LEN(@allmanagerid)-@sepindex)
            set @sepindex = CHARINDEX(',',@allmanagerid) 

            select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 1
            if @recordercount = 0 
                insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,1)
        end
    end
end

/* �ĵ�������Ϣ (�ڲ��û�) ���漰��ɫ���� */
declare shareuserid_cursor cursor for
select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2 where  t1.loginid is not null and t1.loginid <> '' and t2.docid = @docid_1 and ( (t2.foralluser=1 and t2.seclevel<=t1.seclevel)  or ( t2.userid= t1.id ) or (t2.departmentid=t1.departmentid and t2.seclevel<=t1.seclevel))
open shareuserid_cursor 
fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
while @@fetch_status=0
begin 
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 1
    if @recordercount = 0  
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel)
    else if @tempsharelevel = 2
        update @temptablevalue set sharelevel = 2 where userid=@tempuserid and usertype = 1

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
end
close shareuserid_cursor deallocate shareuserid_cursor

/* �ĵ�������Ϣ (�ڲ��û�) �漰��ɫ���� */
declare shareuserid_cursor cursor for
select distinct t1.id , t2.sharelevel from HrmResource t1 ,  DocShare  t2,  HrmRoleMembers  t3 where  t1.loginid is not null and t1.loginid <> '' and t2.docid = @docid_1 and (  t3.resourceid=t1.id and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and ( (t3.rolelevel=2) or (t3.rolelevel=0  and t1.departmentid=@departmentid_6) or (t3.rolelevel=1 and t1.subcompanyid1=@subcompanyid_7) ) )
open shareuserid_cursor 
fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
while @@fetch_status=0
begin 
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 1
    if @recordercount = 0  
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,1,@tempsharelevel)
    else if @tempsharelevel = 2
        update @temptablevalue set sharelevel = 2 where userid=@tempuserid and usertype = 1

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
end
close shareuserid_cursor deallocate shareuserid_cursor


/* �ĵ�������Ϣ �ⲿ�û� ( ���� ) */
declare shareuserid_cursor cursor for
select distinct sharetype , seclevel, sharelevel from DocShare where sharetype < 0 and docid = @docid_1
open shareuserid_cursor 
fetch next from shareuserid_cursor into @tempsharetype , @tempuserid, @tempsharelevel
while @@fetch_status=0
begin 
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = @tempsharetype
    if @recordercount = 0  
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,@tempsharetype,@tempsharelevel)
    else if @tempsharelevel = 2
        update @temptablevalue set sharelevel = 2 where userid=@tempuserid and usertype = @tempsharetype

    fetch next from shareuserid_cursor into @tempsharetype , @tempuserid, @tempsharelevel
end
close shareuserid_cursor deallocate shareuserid_cursor

/* �ĵ�������Ϣ �ⲿ�û� ( �û�id ) */
declare shareuserid_cursor cursor for
select distinct crmid , sharelevel from DocShare where crmid <> 0 and sharetype = '9' and docid = @docid_1
open shareuserid_cursor 
fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
while @@fetch_status=0
begin 
    select @recordercount = count(sharelevel) from @temptablevalue where userid=@tempuserid and usertype = 9
    if @recordercount = 0  
        insert into @temptablevalue(userid,usertype,sharelevel) values(@tempuserid,9,1)
    else if @tempsharelevel = 2
        update @temptablevalue set sharelevel = 2 where userid=@tempuserid and usertype = 9

    fetch next from shareuserid_cursor into @tempuserid, @tempsharelevel
end
close shareuserid_cursor deallocate shareuserid_cursor


/* ����ʱ���е�����д�빲��� */
delete docsharedetail where docid = @docid_1
insert into docsharedetail (docid,userid,usertype,sharelevel) 
    select @docid_1 , userid,usertype,sharelevel from @temptablevalue
GO





/* �����Ƕ�Ӧ��oracle �ű� */


