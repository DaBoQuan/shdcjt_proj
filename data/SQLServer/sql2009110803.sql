alter table CRM_ShareInfo add isdefault char(1)
GO
create table CRMshareinittable (isinitialized char(1))
GO
insert into CRMshareinittable(isinitialized) values('0')
GO

alter table WorkPlanShare add isdefault char(1)
GO
create table shareinittable (isinitialized char(1) default '0')
GO
insert into shareinittable(isinitialized) values('0')
GO

ALTER PROCEDURE CRM_ShareInfo_SbyRelateditemid (@relateditemid int , @flag integer output , @msg varchar(80) output ) AS select * from CRM_ShareInfo where ( relateditemid = @relateditemid and (isdefault is null or (isdefault=1 and sharelevel=3 and sharetype=1))) order by sharetype set  @flag = 1 set  @msg = 'ok'

GO

ALTER PROCEDURE HrmResourceShare(@resourceid_1 int, @departmentid_1 int, @subcompanyid_1 int, @managerid_1 int, @seclevel_1 int, @managerstr_1 varchar(200), @olddepartmentid_1 int, @oldsubcompanyid_1 int, @oldmanagerid_1 int, @oldseclevel_1 int, @oldmanagerstr_1 varchar(200), @flag_1 int, @flag int output, @msg varchar(80) output)  AS
/*					��ԱID		����ID			�ֲ�ID		����ID			��ȫ����		�����ϼ�																		��־λ�����Ϊ0���޸�Ϊ1*/
declare
	@supresourceid_1	int,
	@docid_1		int,
	@crmid_1		int,
	@prjid_1		int,
	@cptid_1		int,
	@sharelevel_1		int,
	@countrec		int,
	@countdelete		int,
	@contractid_1		int,
	@contractroleid_1	int,
	@sharelevel_Temp	int,
	@workPlanId_1		int

/* ������źͰ�ȫ������Ϣ���޸� */
if(
	(@flag_1 = 1 and (
			@departmentid_1 <> @olddepartmentid_1 
			or @oldsubcompanyid_1 <> @subcompanyid_1
			or @seclevel_1 <> @oldseclevel_1 
			or @oldseclevel_1 is null
			)
	) or @flag_1 = 0
)
begin

    /* �޸�Ŀ¼��ɱ� */
    if (@flag_1=1 and ((@olddepartmentid_1 <> @departmentid_1) or (@oldseclevel_1 <> @seclevel_1))) begin
        execute Doc_DirAcl_DUserP_BasicChange @resourceid_1, @olddepartmentid_1, @oldsubcompanyid_1, @oldseclevel_1
    end
    if ((@olddepartmentid_1 <> @departmentid_1) or (@oldseclevel_1 <> @seclevel_1)) begin
        execute Doc_DirAcl_GUserP_BasicChange @resourceid_1, @departmentid_1, @subcompanyid_1, @seclevel_1
    end

    /* �����½��ĵ�Ŀ¼���б� */
    exec DocUserCategory_InsertByUser @resourceid_1,'0','',''
    
           
    
	/* ------- DOC ���� -------  */
	/*����������˸��� ��Ҫ���ĵ�������е�ͬ���ż�¼���޸�*/
	if ((@flag_1 = 1 and @departmentid_1<>@olddepartmentid_1) or @flag_1 = 0)
	begin		
		update shareinnerdoc set content=@departmentid_1 where type=3 and  srcfrom=85 and opuser=@resourceid_1
	end 
	
	/*����ֲ����˱仯����Ҫ���ĵ�������е�ͬ�ֲ���صļ�¼���޸�*/
	if ((@flag_1 = 1 and @subcompanyid_1<>@oldsubcompanyid_1) or @flag_1 = 0)
	begin
		update shareinnerdoc set content=@subcompanyid_1 where type=2 and srcfrom=84 and opuser=@resourceid_1
	end 

    /* ------- CRM  ���� -----�µĹ���ʽ�£��޸Ĳ��ţ��ֲ��͵ȼ���Ӱ�칲��-- */
    declare @managerstr_11 varchar(200)
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

    /*  �ʲ������޸��� */
    declare cptid_cursor cursor for
    select id from CptCapital where lastmoderid = @resourceid_1 
    open cptid_cursor 
    fetch next from cptid_cursor into @cptid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevalueCpt values(@cptid_1, 1)
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


     /* ------- �ͻ���ͬ����2003-11-06����� ------- */

    /* ������ʱ����� */
    Declare @temptablevaluecontract  table(contractid int,sharelevel int)

    /*  �����е���Ϣ�ַŵ� @temptablevaluecontract �� */

    /* �Լ��¼��Ŀͻ���ͬ 3 */
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcontractid_cursor cursor for
    select id from CRM_Contract where ( manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) )
    open subcontractid_cursor 
    fetch next from subcontractid_cursor into @contractid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(contractid) from @temptablevaluecontract where contractid = @contractid_1
        if @countrec = 0  insert into @temptablevaluecontract values(@contractid_1, 3)
        fetch next from subcontractid_cursor into @contractid_1
    end
    close subcontractid_cursor deallocate subcontractid_cursor

 
    /*  �Լ��� manager �Ŀͻ���ͬ 2 */
    declare contractid_cursor cursor for
    select id from CRM_Contract where manager = @resourceid_1 
    open contractid_cursor 
    fetch next from contractid_cursor into @contractid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluecontract values(@contractid_1, 2)
        fetch next from contractid_cursor into @contractid_1
    end
    close contractid_cursor deallocate contractid_cursor



    /* ��Ϊ�ͻ���ͬ����Ա�ܿ����� */
    declare roleids_cursor cursor for
    select roleid from SystemRightRoles where rightid = 396
    open roleids_cursor 
    fetch next from roleids_cursor into @contractroleid_1
    while @@fetch_status=0
    begin 

       declare rolecontractid_cursor cursor for
       select distinct t1.id from CRM_Contract  t1, hrmrolemembers  t2  where t2.roleid=@contractroleid_1 and t2.resourceid=@resourceid_1 and (t2.rolelevel=2 or (t2.rolelevel=0 and t1.department=@departmentid_1 ) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1 ));
       
        open rolecontractid_cursor 
        fetch next from rolecontractid_cursor into @contractid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(contractid) from @temptablevaluecontract where contractid = @contractid_1
            if @countrec = 0  
            begin
                insert into @temptablevaluecontract values(@contractid_1, 2)
            end
            else
            begin
                select @sharelevel_1 = sharelevel from ContractShareDetail where contractid = @contractid_1 and userid = @resourceid_1 and usertype = 1
                if @sharelevel_1 = 1
                begin
                     update ContractShareDetail set sharelevel = 2 where contractid = @contractid_1 and userid = @resourceid_1 and usertype = 1  
                end 
            end
            fetch next from rolecontractid_cursor into @contractid_1
        end
        close rolecontractid_cursor deallocate rolecontractid_cursor
        
     fetch next from roleids_cursor into @contractroleid_1
     end
     close roleids_cursor deallocate roleids_cursor  


    /* �ɿͻ���ͬ�Ĺ����õ�Ȩ�� 1 2 */
    declare sharecontractid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from Contract_ShareInfo  t2  where  ( (t2.foralluser=1 and t2.seclevel<=@seclevel_1)  or ( t2.userid=@resourceid_1 ) or (t2.departmentid=@departmentid_1 and t2.seclevel<=@seclevel_1)  )
    open sharecontractid_cursor 
    fetch next from sharecontractid_cursor into @contractid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(contractid) from @temptablevaluecontract where contractid = @contractid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecontract values(@contractid_1, @sharelevel_1)
        end
        else
        begin
            select @sharelevel_Temp = sharelevel from @temptablevaluecontract where contractid = @contractid_1
            if ((@sharelevel_Temp = 1) and (@sharelevel_1 = 2)) 
            update @temptablevaluecontract set sharelevel = @sharelevel_1 where contractid = @contractid_1
        end
        fetch next from sharecontractid_cursor into @contractid_1 , @sharelevel_1
    end 
    close sharecontractid_cursor deallocate sharecontractid_cursor



    declare sharecontractid_cursor cursor for
    select distinct t2.relateditemid , t2.sharelevel from CRM_Contract t1 ,  Contract_ShareInfo  t2,  HrmRoleMembers  t3  where  t1.id = t2.relateditemid and t3.resourceid=@resourceid_1 and t3.roleid=t2.roleid and t3.rolelevel>=t2.rolelevel and t2.seclevel<=@seclevel_1 and ( (t2.rolelevel=0  and t1.department=@departmentid_1) or (t2.rolelevel=1 and t1.subcompanyid1=@subcompanyid_1) or (t3.rolelevel=2) ) 
    open sharecontractid_cursor 
    fetch next from sharecontractid_cursor into @contractid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        select @countrec = count(contractid) from @temptablevaluecontract where contractid = @contractid_1  
        if @countrec = 0  
        begin
            insert into @temptablevaluecontract values(@contractid_1, @sharelevel_1)
        end
        else
        begin
            select @sharelevel_Temp = sharelevel from @temptablevaluecontract where contractid = @contractid_1
            if ((@sharelevel_Temp = 1) and (@sharelevel_1 = 2)) 
            update @temptablevaluecontract set sharelevel = @sharelevel_1 where contractid = @contractid_1
        end
        fetch next from sharecontractid_cursor into @contractid_1 , @sharelevel_1
    end 
    close sharecontractid_cursor deallocate sharecontractid_cursor


    /* �Լ��¼��Ŀͻ���ͬ  (�ͻ�����������)*/
     
    set @managerstr_11 = '%,' + convert(varchar(5),@resourceid_1) + ',%' 

    declare subcontractid_cursor cursor for
    select t2.id from CRM_CustomerInfo t1 , CRM_Contract t2 where ( t1.manager in (select distinct id from HrmResource where ','+managerstr like @managerstr_11 ) ) and (t2.crmId = t1.id)
    open subcontractid_cursor 
    fetch next from subcontractid_cursor into @contractid_1
    while @@fetch_status=0
    begin 
        select @countrec = count(contractid) from @temptablevaluecontract where contractid = @contractid_1
        if @countrec = 0  insert into @temptablevaluecontract values(@contractid_1, 1)
        fetch next from subcontractid_cursor into @contractid_1
    end
    close subcontractid_cursor deallocate subcontractid_cursor

 
    /*  �Լ��� manager �Ŀͻ� (�ͻ�����������) */
    declare contractid_cursor cursor for
    select t2.id from CRM_CustomerInfo t1 , CRM_Contract t2 where (t1.manager = @resourceid_1 ) and (t2.crmId = t1.id)
    open contractid_cursor 
    fetch next from contractid_cursor into @contractid_1
    while @@fetch_status=0
    begin 
        insert into @temptablevaluecontract values(@contractid_1, 1)
        fetch next from contractid_cursor into @contractid_1
    end
    close contractid_cursor deallocate contractid_cursor


    /* ɾ��ԭ�е������Ա��ص�����Ȩ */
    delete from ContractShareDetail where userid = @resourceid_1 and usertype = 1

    /* ����ʱ���е�����д�빲��� */
    declare allcontractid_cursor cursor for
    select * from @temptablevaluecontract
    open allcontractid_cursor 
    fetch next from allcontractid_cursor into @contractid_1 , @sharelevel_1
    while @@fetch_status=0
    begin 
        insert into ContractShareDetail( contractid, userid, usertype, sharelevel) values(@contractid_1, @resourceid_1,1,@sharelevel_1)
        fetch next from allcontractid_cursor into @contractid_1 , @sharelevel_1
    end
    close allcontractid_cursor deallocate allcontractid_cursor


    /*================== �����ճ� ==================*/
    /*�µĹ���ʽ�£��޸���Ա�Ĳ��ţ��ֲ��͵ȼ���Ӱ�칲��*/
    /* �ճ̹������ */



end        /* �����޸��˲��źͰ�ȫ�������� */

/* �����޸��˾����ֶ� */           
/* ------- DOC ���� -------  */
/*ֻ��Ҫ��docshareinner������Ӧ�ľ������Ķ��Ϳ����� 81���������ϼ�*/
if (@flag_1 = 1 and @managerid_1 <> @oldManagerid_1)
begin
update shareinnerdoc set content=@managerid_1 where srcfrom=81 and opuser=@resourceid_1
end 
       
/* �����޸��˾����ֶ� */
if ( (@flag_1 = 1 and @managerstr_1 <> @oldmanagerstr_1) or @flag_1 = 0 )
begin
    if ( @managerstr_1 is not null and len(@managerstr_1) > 1 )  /* ���ϼ����� */
    begin

        set @managerstr_1 = ',' + @managerstr_1

    /* ------- CRM ���� -----�µĹ���ʽ�£��޸ľ�����weaver.crm.CrmShareBase.setShareForNewManager�д���-- */
      

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

         /* ------- �ͻ���ͬ���� ����ı� 2003-11-06�����------- */
        declare supuserid_cursor cursor for
        select distinct t1.id , t2.id from HrmResource t1, CRM_Contract t2 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and  t2.manager = @resourceid_1  ;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @contractid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(contractid) from ContractShareDetail where contractid = @contractid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into ContractShareDetail( contractid, userid, usertype, sharelevel) values(@contractid_1,@supresourceid_1,1,3)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @contractid_1
        end
        close supuserid_cursor deallocate supuserid_cursor

        declare supuserid_cursor cursor for
        select distinct t1.id , t3.id from HrmResource t1, CRM_CustomerInfo t2 ,CRM_Contract t3 where @managerstr_1 like '%,'+convert(varchar(5),t1.id)+',%' and  t2.manager = @resourceid_1  and t2.id = t3.crmId;
        open supuserid_cursor 
        fetch next from supuserid_cursor into @supresourceid_1, @contractid_1
        while @@fetch_status=0
        begin 
            select @countrec = count(contractid) from ContractShareDetail where contractid = @contractid_1 and userid= @supresourceid_1 and usertype= 1
            if @countrec = 0  
            begin
                insert into ContractShareDetail( contractid, userid, usertype, sharelevel) values(@contractid_1,@supresourceid_1,1,1)
            end
            fetch next from supuserid_cursor into @supresourceid_1, @contractid_1
        end
        close supuserid_cursor deallocate supuserid_cursor


    /* for work plan */ 
    /* added by lupeng 2004-07-22 */
    /*�µĹ���ʽ�£��޸ľ�����weaver.WorkPlan.WorkPlanShareBase.setShareForNewManager�д���*/
    /* end */


    end             /* ���ϼ������ж����� */
end   /* �޸ľ�����ж����� */

GO
