create TRIGGER Tri_U_workflow_createlist_I ON HrmResource WITH ENCRYPTION
FOR insert
AS
Declare @workflowid int,
	@type int,
 	@objid int,
	@level_n int,
    	@level2_n int,
	@userid int,
	@resourceid_1 int,
	@loginid_1 varchar(60),
	@olddepartmentid_1 int,
	@subcompanyid1_1 int,
	@departmentid_1 int,
	@oldseclevel_1	 int,
	@seclevel_1	 int,
	@all_cursor cursor,
	@detail_cursor cursor


select @resourceid_1 = id , @loginid_1 = loginid , @departmentid_1 = departmentid, @seclevel_1 = seclevel from inserted
select @subcompanyid1_1 = subcompanyid1 from HrmDepartment where id = @departmentid_1

if (@departmentid_1 is not null)
begin 
    delete from workflow_createrlist where userid = @resourceid_1 and usertype = 0 
    
   
    begin 
        SET @all_cursor = CURSOR FORWARD_ONLY STATIC FOR				
        select workflowid,type,objid,level_n,level2_n from workflow_flownode t1,workflow_nodegroup t2,workflow_groupdetail t3 where t1.nodetype='0' and t1.nodeid = t2.nodeid and t2.id = t3.groupid

        OPEN @all_cursor 
        FETCH NEXT FROM @all_cursor INTO @workflowid ,	@type ,@objid ,@level_n ,@level2_n
        WHILE @@FETCH_STATUS = 0 
        begin 
            if @type=1 
            begin
                if @departmentid_1 is not null and @departmentid_1 = @objid and @seclevel_1 >= @level_n and @seclevel_1 <= @level2_n 
                    insert into workflow_createrlist(workflowid,userid,usertype) values(@workflowid,@resourceid_1,0)
            end
            else if @type=2
            begin
                SELECT @userid = count(resourceid) FROM HrmRoleMembers where roleid =  @objid and rolelevel >=@level_n and resourceid = @resourceid_1 
                if @userid > 0  
                    insert into workflow_createrlist(workflowid,userid,usertype) values(@workflowid,@resourceid_1,0)
            end
            else if @type=3
            begin
                if @resourceid_1 = @objid 
                    insert into workflow_createrlist(workflowid,userid,usertype) values(@workflowid,@resourceid_1,0)
            end
            else if @type=30
            begin
                if @subcompanyid1_1 = @objid and @seclevel_1 >= @level_n and @seclevel_1 <= @level2_n
                insert into workflow_createrlist(workflowid,userid,usertype) values(@workflowid,@resourceid_1,0)
            end
            FETCH NEXT FROM @all_cursor INTO @workflowid ,	@type ,@objid ,@level_n,@level2_n
        end 
        CLOSE @all_cursor 
        DEALLOCATE @all_cursor  
    end
end
go
