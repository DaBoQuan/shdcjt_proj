/*�������˵�������Ϣ*/
CREATE PROCEDURE MMInfo_Insert(
    @id_1 int,
    @labelId_1 int,
    @menuName_1 Varchar(100),
    @linkAddress_1 Varchar(100),
    @parentFrame_1 Varchar(100),
    @defaultParentId_1 int,
    @defaultLevel_1 int,
    @defaultIndex_1 int,
    @needRightToVisible_1 char(1),
    @rightDetailToVisible_1 Varchar(100),
    @needRightToView_1 char(1),
    @rightDetailToView_1 Varchar(100),
    @needSwitchToVisible_1 char(1),
    @switchClassNameToVisible_1 Varchar(100),
    @switchMethodNameToVisible_1 Varchar(100),
    @needSwitchToView_1 char(1),
    @switchClassNameToView_1 Varchar(100),
    @switchMethodNameToView_1 Varchar(100),
    @relatedModuleId_1 int) 
AS

    DECLARE @updateId int;
    DECLARE @updateIndex int;

    SET @updateIndex = @defaultIndex_1;


    /*���´��ڲ����¼Index �� defaultIndex ��1*/
    DECLARE @updateId_1 int
    DECLARE @updateIndex_1 int
    DECLARE mainMenuInfo_cursor CURSOR FOR
    SELECT id FROM MainMenuInfo 
     WHERE defaultParentId = @defaultParentId_1
       AND defaultIndex >= @defaultIndex_1 
     ORDER BY defaultIndex

    OPEN mainMenuInfo_cursor
    FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId

    WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @updateIndex = @updateIndex + 1;
        UPDATE MainMenuInfo 
           SET defaultIndex = @updateIndex
         WHERE id = @updateId
        FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId
    END

    CLOSE mainMenuInfo_cursor
    DEALLOCATE mainMenuInfo_cursor

    IF(@linkAddress_1 = '')
    BEGIN
    INSERT INTO MainMenuInfo (
        id,
        labelId,
        menuName,
        linkAddress,
        parentFrame,
        defaultParentId,
        defaultLevel,
        defaultIndex,
        needRightToVisible,
        rightDetailToVisible,
        needRightToView,
        rightDetailToView,
        needSwitchToVisible,
        switchClassNameToVisible,
        switchMethodNameToVisible,
        needSwitchToView,
        switchClassNameToView,
        switchMethodNameToView,
        relatedModuleId) 
    VALUES (
        @id_1,
        @labelId_1,
        @menuName_1,
        NULL ,
        @parentFrame_1 ,
        @defaultParentId_1 ,
        @defaultLevel_1 ,
        @defaultIndex_1 ,
        @needRightToVisible_1 ,
        @rightDetailToVisible_1 ,
        @needRightToView_1 ,
        @rightDetailToView_1 ,
        @needSwitchToVisible_1 ,
        @switchClassNameToVisible_1 ,
        @switchMethodNameToVisible_1 ,
        @needSwitchToView_1 ,
        @switchClassNameToView_1 ,
        @switchMethodNameToView_1 ,
        @relatedModuleId_1
    ) 
    END
    ELSE
    BEGIN
    INSERT INTO MainMenuInfo (
        id,
        labelId,
        menuName,
        linkAddress,
        parentFrame,
        defaultParentId,
        defaultLevel,
        defaultIndex,
        needRightToVisible,
        rightDetailToVisible,
        needRightToView,
        rightDetailToView,
        needSwitchToVisible,
        switchClassNameToVisible,
        switchMethodNameToVisible,
        needSwitchToView,
        switchClassNameToView,
        switchMethodNameToView,
        relatedModuleId) 
    VALUES (
        @id_1,
        @labelId_1,
        @menuName_1,
        @linkAddress_1 ,
        @parentFrame_1 ,
        @defaultParentId_1 ,
        @defaultLevel_1 ,
        @defaultIndex_1 ,
        @needRightToVisible_1 ,
        @rightDetailToVisible_1 ,
        @needRightToView_1 ,
        @rightDetailToView_1 ,
        @needSwitchToVisible_1 ,
        @switchClassNameToVisible_1 ,
        @switchMethodNameToVisible_1 ,
        @needSwitchToView_1 ,
        @switchClassNameToView_1 ,
        @switchMethodNameToView_1 ,
        @relatedModuleId_1
    ) 
    END

GO


/*���� MainMenuInfo ������ӣ��� MainMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� MainMenuConfig ���ӵļ�¼�� defaultIndex �� MainMenuConfig viewIndex ������Ϣ*/
CREATE PROCEDURE MMConfig_U_ByInfoInsert(
    @defaultParentId_1      int,
    @defaultIndex_1     int) 
AS
DECLARE @userId int;
    
DECLARE @updateId int;
DECLARE @updateIndex int;

    
       
        /*ϵͳ����Ա*/
        SET @updateIndex = @defaultIndex_1;

        DECLARE mainMenuConfig_cursor CURSOR FOR
        SELECT t2.id FROM MainMenuInfo t1,MainMenuConfig t2 
	     WHERE t1.id = t2.infoId 
           AND t2.userId = 1
           AND t1.defaultParentId = @defaultParentId_1
           AND t2.viewIndex >= @defaultIndex_1 
         ORDER BY defaultIndex
        
        OPEN mainMenuConfig_cursor
        FETCH NEXT FROM mainMenuConfig_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @updateIndex = @updateIndex + 1;

            UPDATE MainMenuConfig 
               SET viewIndex = @updateIndex
             WHERE id = @updateId
	       

            FETCH NEXT FROM mainMenuConfig_cursor INTO @updateId

        END

        CLOSE mainMenuConfig_cursor
        DEALLOCATE mainMenuConfig_cursor

        /*�û�*/


        DECLARE hrmResource_cursor CURSOR FOR
        SELECT id FROM HrmResource order by id

        OPEN hrmResource_cursor
        FETCH NEXT FROM hrmResource_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            
            SET @updateIndex = @defaultIndex_1;
            DECLARE mainMenuConfig_cursor_1 CURSOR FOR
            SELECT t2.id FROM MainMenuInfo t1,MainMenuConfig t2 
	         WHERE t1.id = t2.infoId 
               AND t2.userId = @userId
               AND t1.defaultParentId = @defaultParentId_1
               AND t2.viewIndex >= @defaultIndex_1 
             ORDER BY defaultIndex
        
            OPEN mainMenuConfig_cursor_1
            FETCH NEXT FROM mainMenuConfig_cursor_1 INTO @updateId 

            WHILE @@FETCH_STATUS = 0
            BEGIN
		SET @updateIndex = @updateIndex + 1;
                UPDATE MainMenuConfig 
                   SET viewIndex = @updateIndex
                 WHERE id = @updateId
                FETCH NEXT FROM mainMenuConfig_cursor_1 INTO @updateId
            END

            CLOSE mainMenuConfig_cursor_1
            DEALLOCATE mainMenuConfig_cursor_1
        
            FETCH NEXT FROM hrmResource_cursor INTO @userId
        END
        CLOSE hrmResource_cursor
        DEALLOCATE hrmResource_cursor


GO


/*���Ӹ��˹������˵�������Ϣ*/
CREATE PROCEDURE LMInfo_Insert(
    @id_1 		int ,
    @labelId_1 		int ,
    @iconUrl_1		varchar(100),
    @linkAddress_1      varchar(100),
    @menuLevel_1	int,
    @parentId_1		int,
    @defaultIndex_1	int,
    @relatedModuleId_1  int) 
AS


        DECLARE @updateId int;
        DECLARE @updateIndex int;

    /*�����˵�*/
    IF (@menuLevel_1 = 1) BEGIN

	SET @updateIndex = @defaultIndex_1;
        /*���´��ڲ����¼Index �� defaultIndex ��1*/

	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId IS NULL
	       AND defaultIndex >= @defaultIndex_1 
             ORDER BY defaultIndex

	    OPEN leftMenuInfo_cursor
        FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
	    SET @updateIndex = @updateIndex + 1;
            UPDATE LeftMenuInfo 
               SET defaultIndex = @updateIndex
             WHERE id = @updateId
            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
        END

        CLOSE leftMenuInfo_cursor
        DEALLOCATE leftMenuInfo_cursor

	    INSERT INTO LeftMenuInfo (
            id,
	        labelId,
	        iconUrl,
	        linkAddress,
	        menuLevel,
	        parentId,
	        defaultIndex,
	        relatedModuleId) 
	    VALUES (
            @id_1,
	        @labelId_1,
	        NULL,
	        NULL,
	        @menuLevel_1,
	        NULL,
	        @defaultIndex_1,
	        @relatedModuleId_1
	    )
    END
    ELSE 
    BEGIN

    	SET @updateIndex = @defaultIndex_1;
    /*���´��ڲ����¼Index �� defaultIndex ��1*/
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId = @parentId_1
	       AND defaultIndex >= @defaultIndex_1
             ORDER BY defaultIndex

	    OPEN leftMenuInfo_cursor
        FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
	    SET @updateIndex = @updateIndex + 1;

            UPDATE LeftMenuInfo 
               SET defaultIndex = @updateIndex
             WHERE id = @updateId
            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
        END

        CLOSE leftMenuInfo_cursor
        DEALLOCATE leftMenuInfo_cursor

	    INSERT INTO LeftMenuInfo (
            id,
	        labelId,
	        iconUrl,
	        linkAddress,
	        menuLevel,
	        parentId,
	        defaultIndex,
	        relatedModuleId) 
	    VALUES (
            @id_1,
	        @labelId_1,
	        @iconUrl_1,
	        @linkAddress_1,
	        @menuLevel_1,
	        @parentId_1,
	        @defaultIndex_1,
	        @relatedModuleId_1
    	) 
    END
 	
GO


/*���� LeftMenuInfo ������ӣ��� LeftMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� LeftMenuConfig ���ӵļ�¼�� defaultIndex �� LeftMenuConfig viewIndex ������Ϣ*/
CREATE PROCEDURE LMConfig_U_ByInfoInsert(
    @menuLevel_1      int,
    @parentId_1      int,
    @defaultIndex_1     int) 
AS
DECLARE @userId int;
    
DECLARE @updateId int;
DECLARE @updateIndex int;

    
    /*�����˵�*/
    IF (@menuLevel_1 = 1) BEGIN
        
       
        /*ϵͳ����Ա*/
        SET @updateIndex = @defaultIndex_1;

        DECLARE leftMenuConfig_cursor CURSOR FOR
        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	     WHERE t1.id = t2.infoId 
           AND t2.userId = 1
           AND t1.parentId IS NULL
           AND t2.viewIndex >= @defaultIndex_1 
         ORDER BY defaultIndex
        
        OPEN leftMenuConfig_cursor
        FETCH NEXT FROM leftMenuConfig_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @updateIndex = @updateIndex + 1;

            UPDATE LeftMenuConfig 
               SET viewIndex = @updateIndex
             WHERE id = @updateId
	       

            FETCH NEXT FROM leftMenuConfig_cursor INTO @updateId

        END

        CLOSE leftMenuConfig_cursor
        DEALLOCATE leftMenuConfig_cursor

        /*�û�*/


        DECLARE hrmResource_cursor CURSOR FOR
        SELECT id FROM HrmResource order by id

        OPEN hrmResource_cursor
        FETCH NEXT FROM hrmResource_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            
            SET @updateIndex = @defaultIndex_1;
            DECLARE leftMenuConfig_cursor_1 CURSOR FOR
            SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	         WHERE t1.id = t2.infoId 
               AND t2.userId = @userId
               AND t1.parentId IS NULL
               AND t2.viewIndex >= @defaultIndex_1 
             ORDER BY defaultIndex
        
            OPEN leftMenuConfig_cursor_1
            FETCH NEXT FROM leftMenuConfig_cursor_1 INTO @updateId 

            WHILE @@FETCH_STATUS = 0
            BEGIN
		SET @updateIndex = @updateIndex + 1;
                UPDATE LeftMenuConfig 
                   SET viewIndex = @updateIndex
                 WHERE id = @updateId
                FETCH NEXT FROM leftMenuConfig_cursor_1 INTO @updateId
            END

            CLOSE leftMenuConfig_cursor_1
            DEALLOCATE leftMenuConfig_cursor_1
        
            FETCH NEXT FROM hrmResource_cursor INTO @userId
        END
        CLOSE hrmResource_cursor
        DEALLOCATE hrmResource_cursor

    END
    ELSE
    BEGIN
        
        /*ϵͳ����Ա*/
        SET @updateIndex = @defaultIndex_1;
        DECLARE leftMenuConfig_cursor CURSOR FOR
        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	     WHERE t1.id = t2.infoId 
           AND t2.userId = 1
           AND t1.parentId = @parentId_1
           AND t2.viewIndex >= @defaultIndex_1 
         ORDER BY defaultIndex
        
        OPEN leftMenuConfig_cursor
        FETCH NEXT FROM leftMenuConfig_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @updateIndex = @updateIndex + 1;
            UPDATE LeftMenuConfig 
               SET viewIndex = @updateIndex 
             WHERE id = @updateId
            FETCH NEXT FROM leftMenuConfig_cursor INTO @updateId
        END

        CLOSE leftMenuConfig_cursor
        DEALLOCATE leftMenuConfig_cursor

        /*�û�*/
        DECLARE hrmResource_cursor CURSOR FOR
        SELECT id FROM HrmResource order by id

        OPEN hrmResource_cursor
        FETCH NEXT FROM hrmResource_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @updateIndex = @defaultIndex_1;

            DECLARE leftMenuConfig_cursor_1 CURSOR FOR
            SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	         WHERE t1.id = t2.infoId 
               AND t2.userId = @userId
               AND t1.parentId = @parentId_1
               AND t2.viewIndex >= @defaultIndex_1 
             ORDER BY defaultIndex
        
            OPEN leftMenuConfig_cursor_1
            FETCH NEXT FROM leftMenuConfig_cursor_1 INTO @updateId

            WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @updateIndex = @updateIndex + 1
                UPDATE LeftMenuConfig 
                   SET viewIndex = @updateIndex
                 WHERE id = @updateId
                FETCH NEXT FROM leftMenuConfig_cursor_1 INTO @updateId
            END

            CLOSE leftMenuConfig_cursor_1
            DEALLOCATE leftMenuConfig_cursor_1
        
            FETCH NEXT FROM hrmResource_cursor INTO @userId
        END
        CLOSE hrmResource_cursor
        DEALLOCATE hrmResource_cursor

    END

GO