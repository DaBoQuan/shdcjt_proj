/*���� LeftMenuInfo ��ĸ��ģ����������û� LeftMenuConfig ������Ϣ*/
ALTER TRIGGER Tri_ULeftMenuConfig_ByInfo ON LeftMenuInfo
FOR INSERT, UPDATE, DELETE 
AS
Declare @id_1 int,
        @defaultIndex_1 int,
        @countdelete   int,
        @countinsert   int,
        @userId int,
		@isCustom char(1),
		@useCustomName char(1),
		@customName varchar(100)


SELECT @countdelete = count(*) FROM deleted
SELECT @countinsert = count(*) FROM inserted

/*����ʱ @countinsert >0 AND @countdelete = 0 */
/*ɾ��ʱ @countinsert =0 */
/*����ʱ @countinsert >0 AND @countdelete > 0 */

/*����*/
IF (@countinsert > 0 AND @countdelete = 0) BEGIN

    SELECT @id_1 = id,@defaultIndex_1 = defaultIndex,@isCustom=isCustom,@useCustomName=useCustomName,@customName=customName FROM inserted

    if(@isCustom = 0 OR @isCustom IS NULL) BEGIN
    
	    /*�ܲ�*/
	    DECLARE hrmCompany_cursor CURSOR FOR
	    SELECT id FROM HrmCompany order by id
	
	    OPEN hrmCompany_cursor
	    FETCH NEXT FROM hrmCompany_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName,customName) VALUES(0,@id_1,1,@defaultIndex_1,@userId,'1',0,0,@useCustomName,@customName)
	        FETCH NEXT FROM hrmCompany_cursor INTO @userId
	    END
	    CLOSE hrmCompany_cursor
	    DEALLOCATE hrmCompany_cursor
    
    
	    /*�ֲ�*/
	    DECLARE hrmSubCompany_cursor CURSOR FOR
	    SELECT id FROM HrmSubCompany order by id
	
	    OPEN hrmSubCompany_cursor
	    FETCH NEXT FROM hrmSubCompany_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName,customName) VALUES(0,@id_1,1,@defaultIndex_1,@userId,'2',0,0,@useCustomName,@customName)
	        FETCH NEXT FROM hrmSubCompany_cursor INTO @userId
	    END
	    CLOSE hrmSubCompany_cursor
	    DEALLOCATE hrmSubCompany_cursor
    
    
	    /*ϵͳ����Ա*/
	    DECLARE hrmResourcemanager_cursor CURSOR FOR
	    SELECT id FROM HrmResourceManager order by id
	
	    OPEN hrmResourcemanager_cursor
	    FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName,customName) VALUES(@userId,@id_1,1,@defaultIndex_1,@userId,'3',0,0,@useCustomName,@customName)
	        FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId
	    END
	    CLOSE hrmResourcemanager_cursor
	    DEALLOCATE hrmResourcemanager_cursor
	
	
	    /*�û�*/    
	    DECLARE hrmResource_cursor CURSOR FOR
	    SELECT id FROM HrmResource order by id
	
	    OPEN hrmResource_cursor
	    FETCH NEXT FROM hrmResource_cursor INTO @userId
	
	    WHILE @@FETCH_STATUS = 0
	    BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName,customName) VALUES(@userId,@id_1,1,@defaultIndex_1,@userId,'3',0,0,@useCustomName,@customName)
	        FETCH NEXT FROM hrmResource_cursor INTO @userId
	    END
	    CLOSE hrmResource_cursor
	    DEALLOCATE hrmResource_cursor
     end
END

/*ɾ��*/
IF (@countinsert = 0) BEGIN

    SELECT @id_1 = id FROM deleted
    
    DELETE FROM LeftMenuConfig WHERE infoId = @id_1
END

GO


alter PROCEDURE LeftMenuConfig_Insert_All(
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
DECLARE @id_1 int,
        @defaultIndex_1 int,
        @userId int

    /*�ܲ�*/
    DECLARE hrmCompany_cursor CURSOR FOR
    SELECT id FROM HrmCompany order by id

    OPEN hrmCompany_cursor
    FETCH NEXT FROM hrmCompany_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id, defaultIndex FROM LeftMenuInfo
    	
	    OPEN leftMenuInfo_cursor
	    FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	
        WHILE @@FETCH_STATUS = 0
        BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName) VALUES(0,@id_1,1,@defaultIndex_1,@userId,'1',0,0,0)
	        FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	END

	    CLOSE leftMenuInfo_cursor
	    DEALLOCATE leftMenuInfo_cursor

		FETCH NEXT FROM hrmCompany_cursor INTO @userId
	END
    CLOSE hrmCompany_cursor
    DEALLOCATE hrmCompany_cursor


    /*�ֲ�*/
    DECLARE hrmSubCompany_cursor CURSOR FOR
    SELECT id FROM HrmSubCompany order by id

    OPEN hrmSubCompany_cursor
    FETCH NEXT FROM hrmSubCompany_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id, defaultIndex FROM LeftMenuInfo
    	
	    OPEN leftMenuInfo_cursor
	    FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	
        WHILE @@FETCH_STATUS = 0
        BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName) VALUES(0,@id_1,1,@defaultIndex_1,@userId,'2',0,0,0)
	        FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	END

	    CLOSE leftMenuInfo_cursor
	    DEALLOCATE leftMenuInfo_cursor

		FETCH NEXT FROM hrmSubCompany_cursor INTO @userId
	END
    CLOSE hrmSubCompany_cursor
    DEALLOCATE hrmSubCompany_cursor

    /*ϵͳ����Ա*/
    DECLARE hrmResourceManager_cursor CURSOR FOR
    SELECT id FROM HrmResourceManager order by id

    OPEN hrmResourceManager_cursor
    FETCH NEXT FROM hrmResourceManager_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id, defaultIndex FROM LeftMenuInfo
    	
	    OPEN leftMenuInfo_cursor
	    FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	
        WHILE @@FETCH_STATUS = 0
        BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName) VALUES(@userId,@id_1,1,@defaultIndex_1,@userId,'3',0,0,0)
	        FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	END

	    CLOSE leftMenuInfo_cursor
	    DEALLOCATE leftMenuInfo_cursor

		FETCH NEXT FROM hrmResourceManager_cursor INTO @userId
	END
    CLOSE hrmResourceManager_cursor
    DEALLOCATE hrmResourceManager_cursor
	

    /*�û�*/
    DECLARE hrmResource_cursor CURSOR FOR
    SELECT id FROM HrmResource order by id

    OPEN hrmResource_cursor
    FETCH NEXT FROM hrmResource_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id, defaultIndex FROM LeftMenuInfo
    	
	    OPEN leftMenuInfo_cursor
	    FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	
        WHILE @@FETCH_STATUS = 0
        BEGIN
	        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex,resourceid,resourcetype,locked,lockedById,useCustomName) VALUES(@userId,@id_1,1,@defaultIndex_1,@userId,'3',0,0,0)
	        FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
    	END

	    CLOSE leftMenuInfo_cursor
	    DEALLOCATE leftMenuInfo_cursor

		FETCH NEXT FROM hrmResource_cursor INTO @userId
	END
    CLOSE hrmResource_cursor
    DEALLOCATE hrmResource_cursor

GO
