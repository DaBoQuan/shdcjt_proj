delete ofgroupprop
GO
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.displayName','1')
GO
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.groupList','')
GO
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.showInRoster','everybody')
GO

CREATE TRIGGER Tri_Update_HrmMessager ON HrmResource
FOR INSERT, UPDATE, DELETE 
AS
DECLARE 
        @id_1 	    	int,
        @countinsert   int,
        @countdelete   	int,
        @loginid    	varchar(100),
        @groupname  	int,
        @groupcount 	int
begin
	SELECT @countdelete = count(*) FROM deleted
	SELECT @countinsert = count(*) FROM inserted
    
    /*����ʱ idinsert >0 AND iddelete is null */
    /*ɾ��ʱ idinsert is null */
    /*����ʱ idinsert >0 AND iddelete > 0 */

    /*����*/
    IF (@countinsert>0) BEGIN
	    
	    SELECT @id_1 = id,@loginid = loginid FROM inserted
        
        select @groupcount = count(0) from HrmMessagerGroupUsers where userloginid = @loginid
        select @groupname = groupname from HrmMessagerGroup
        
        if (@id_1 > 0 and @groupname > 0 and @groupcount = 0) begin
        	insert into HrmMessagerGroupUsers(userloginid,groupname,isadmin) values(@loginid,@groupname,'N')
        end
    END

    /*ɾ��*/
    IF (@countinsert = 0) BEGIN
	   
	   SELECT @id_1 = id,@loginid = loginid FROM deleted

       DELETE FROM HrmMessagerGroupUsers WHERE userloginid = @loginid
    END
end

GO
