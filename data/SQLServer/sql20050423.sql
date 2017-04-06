/*�����û� id ���ӵ��û����˵�������Ϣ*/
CREATE PROCEDURE LeftMenuConfig_InsertByUserId(
    @userId_1       int,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
DECLARE @id_1 int,
        @defaultIndex_1 int

    DECLARE leftMenuInfo_cursor CURSOR FOR
    SELECT id, defaultIndex FROM LeftMenuInfo

    OPEN leftMenuInfo_cursor
    FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(@userId_1,@id_1,1,@defaultIndex_1)
        FETCH NEXT FROM leftMenuInfo_cursor INTO @id_1,@defaultIndex_1
        
    END

    CLOSE leftMenuInfo_cursor
    DEALLOCATE leftMenuInfo_cursor

GO

/*�����û� id ���ӵ��û����˵�������Ϣ*/
CREATE PROCEDURE MainMenuConfig_InsertByUserId(
    @userId_1         int,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
DECLARE @id_1 int,
        @defaultParentId_1 int,
        @defaultIndex_1 int,
        @defaultLevel_1 int

    DECLARE mainMenuInfo_cursor CURSOR FOR
    SELECT id,defaultParentId, defaultIndex, defaultLevel FROM MainMenuInfo

    OPEN mainMenuInfo_cursor
    FETCH NEXT FROM mainMenuInfo_cursor INTO @id_1,@defaultParentId_1,@defaultIndex_1,@defaultLevel_1

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(@userId_1,@id_1,1,@defaultParentId_1,@defaultIndex_1,@defaultLevel_1)
        FETCH NEXT FROM mainMenuInfo_cursor INTO @id_1,@defaultParentId_1,@defaultIndex_1,@defaultLevel_1
        
    END

    CLOSE mainMenuInfo_cursor
    DEALLOCATE mainMenuInfo_cursor

GO

/*���� LeftMenuInfo ������ӣ��� LeftMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� LeftMenuConfig ���ӵļ�¼�� defaultIndex �� LeftMenuConfig viewIndex ������Ϣ*/
CREATE PROCEDURE LeftMenuConfig_U_ByInfoInsert(
    @menuLevel_1      int,
    @parentId_1      int,
    @defaultIndex_1     int,
    @flag            int	output, 
    @msg             varchar(80)	output) 
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

/*ѡ����˹������˵�������Ϣ ���� Id*/
CREATE PROCEDURE LeftMenuInfo_SelectById(
    @id_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    SELECT id,labelId,iconUrl,linkAddress,menuLevel,parentId,defaultIndex,relatedModuleId 
      FROM LeftMenuInfo 
     WHERE id = @id_1
       SET @flag = 1 
       SET @msg = 'ok'
GO

/*ѡ����˹������˵�������Ϣ ���� menuLevel*/
CREATE PROCEDURE LeftMenuInfo_SelectByLevel(
    @menuLevel_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    SELECT id,labelId,iconUrl,linkAddress,menuLevel,parentId,defaultIndex,relatedModuleId 
      FROM LeftMenuInfo 
     WHERE menuLevel = @menuLevel_1
     ORDER BY id
       SET @flag = 1 
       SET @msg = 'ok'
GO

/*ѡ����˹������˵�������Ϣ ���� parentId ���Ƕ����˵�*/
CREATE PROCEDURE LeftMenuInfo_SelectByParentId(
    @parentId_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    SELECT id,labelId,iconUrl,linkAddress,menuLevel,parentId,defaultIndex,relatedModuleId 
      FROM LeftMenuInfo 
     WHERE parentId = @parentId_1
     ORDER BY id
       SET @flag = 1 
       SET @msg = 'ok'
GO


/*���Ӹ��˹������˵�������Ϣ*/
CREATE PROCEDURE LeftMenuInfo_Insert(
    @id_1 		int ,
    @labelId_1 		int ,
    @iconUrl_1		varchar(100),
    @linkAddress_1      varchar(100),
    @menuLevel_1	int,
    @parentId_1		int,
    @defaultIndex_1	int,
    @relatedModuleId_1  int,
    @flag		int	output, 
    @msg		varchar(80)	output) 
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
 

    SET @flag = 1 
    SET @msg = 'ok'
	
GO

/*ɾ�����˹������˵�������Ϣ*/
CREATE PROCEDURE LeftMenuInfo_DeleteById(
    @id_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    DECLARE @menuLevel int
    DECLARE @updateId int
    DECLARE @updateIndex int
    DECLARE @defaultIndex int
    DECLARE @parentId int

    SELECT @menuLevel = menuLevel ,@parentId = parentId,@defaultIndex = defaultIndex 
      FROM LeftMenuInfo 
     WHERE id = @id_1

    DELETE FROM LeftMenuInfo 
     WHERE id = @id_1

       SET @updateIndex = @defaultIndex;

    /*�����˵�*/
    IF (@menuLevel = 1) BEGIN
        /*���´��ڲ����¼Index �� defaultIndex ��1*/

	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId IS NULL
	       AND defaultIndex > @defaultIndex 
         ORDER BY defaultIndex

	    OPEN leftMenuInfo_cursor
        FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId 

        WHILE @@FETCH_STATUS = 0
        BEGIN

            UPDATE LeftMenuInfo 
               SET defaultIndex = @updateIndex
             WHERE id = @updateId
            
            SET @updateIndex = @updateIndex + 1;

            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
        END

        CLOSE leftMenuInfo_cursor
        DEALLOCATE leftMenuInfo_cursor
    END
    ELSE 
    BEGIN

        /*���´��ڲ����¼Index �� defaultIndex ��1*/
	    DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId = @parentId
	       AND defaultIndex > @defaultIndex 
         ORDER BY defaultIndex

	    OPEN leftMenuInfo_cursor
        FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId

        WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE LeftMenuInfo 
               SET defaultIndex = @updateIndex
             WHERE id = @updateId

            SET @updateIndex = @updateIndex + 1;

            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId 
        END

        CLOSE leftMenuInfo_cursor
        DEALLOCATE leftMenuInfo_cursor
    END
       
    SET @flag = 1 
    SET @msg = 'ok'

GO
/*���¸��˹������˵�������Ϣ*/
CREATE PROCEDURE LeftMenuInfo_Update(
    @id_1 		int,
    @oldIndex_1		int,
    @labelId_1 		int,
    @iconUrl_1		varchar(100),
    @linkAddress_1      varchar(100),
    @menuLevel_1	int,
    @parentId_1		int,
    @defaultIndex_1	int,
    @relatedModuleId_1  int,
    @flag		int	output, 
    @msg		varchar(80)	output) 
AS


        DECLARE @updateId int;
        DECLARE @updateIndex int;
	

    
    /*�����˵�*/
    IF (@menuLevel_1 = 1) BEGIN

        /*���� ���¼�¼ defaultIndex ��ԭ��¼ defaultIndex֮�� �� defaultIndex ��1*/

	IF (@defaultIndex_1<@oldIndex_1) BEGIN

	    SET @updateIndex = @defaultIndex_1;
 
            DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId IS NULL
	       AND defaultIndex >= @defaultIndex_1 
	       AND defaultIndex <  @oldIndex_1
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

             UPDATE LeftMenuInfo 
                SET labelId = @labelId_1,
                    defaultIndex = @defaultIndex_1,
                    relatedModuleId = @relatedModuleId_1 
              WHERE id = @id_1
    END
	IF (@defaultIndex_1>@oldIndex_1) BEGIN

	    SET @updateIndex = @oldIndex_1;

            DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId IS NULL
	       AND defaultIndex > @oldIndex_1 
	       AND defaultIndex <= @defaultIndex_1
         ORDER BY defaultIndex

            OPEN leftMenuInfo_cursor
            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId

            WHILE @@FETCH_STATUS = 0
            BEGIN
                UPDATE LeftMenuInfo 
                   SET defaultIndex = @updateIndex
                 WHERE id = @updateId
	        SET @updateIndex = @updateIndex + 1;
                FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
            END

            CLOSE leftMenuInfo_cursor
            DEALLOCATE leftMenuInfo_cursor

             UPDATE LeftMenuInfo 
                SET labelId = @labelId_1,
                    defaultIndex = @defaultIndex_1-1,
                    relatedModuleId = @relatedModuleId_1 
              WHERE id = @id_1
	END
    END
    ELSE 
    BEGIN

        /*���� ���¼�¼ defaultIndex ��ԭ��¼ defaultIndex ֮��� defaultIndex ��1*/

	IF (@defaultIndex_1<@oldIndex_1) BEGIN

	    SET @updateIndex = @defaultIndex_1;
 
            DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId = @parentId_1 
	       AND defaultIndex >= @defaultIndex_1 
	       AND defaultIndex <  @oldIndex_1
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
            UPDATE LeftMenuInfo 
               SET labelId = @labelId_1,
                   iconUrl = @iconUrl_1,
                   linkAddress = @linkAddress_1,
                   parentId = @parentId_1,
                   defaultIndex = @defaultIndex_1,
                   relatedModuleId = @relatedModuleId_1 
             WHERE id = @id_1	
	END
	IF (@defaultIndex_1>@oldIndex_1) BEGIN

	    SET @updateIndex = @oldIndex_1;

            DECLARE leftMenuInfo_cursor CURSOR FOR
	    SELECT id FROM LeftMenuInfo 
	     WHERE parentId = @parentId_1
	       AND defaultIndex > @oldIndex_1 
	       AND defaultIndex <= @defaultIndex_1
         ORDER BY defaultIndex

	    OPEN leftMenuInfo_cursor
            FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
 
            WHILE @@FETCH_STATUS = 0
            BEGIN

                UPDATE LeftMenuInfo 
                   SET defaultIndex = @updateIndex
                 WHERE id = @updateId
	        SET @updateIndex = @updateIndex + 1;
                FETCH NEXT FROM leftMenuInfo_cursor INTO @updateId
            END

            CLOSE leftMenuInfo_cursor
            DEALLOCATE leftMenuInfo_cursor

            UPDATE LeftMenuInfo 
               SET labelId = @labelId_1,
                   iconUrl = @iconUrl_1,
                   linkAddress = @linkAddress_1,
                   parentId = @parentId_1,
                   defaultIndex = @defaultIndex_1-1,
                   relatedModuleId = @relatedModuleId_1 
             WHERE id = @id_1	
    END


    END
 

    SET @flag = 1 
    SET @msg = 'ok'

GO

/*ѡ�����˵�������Ϣ ���� id*/
CREATE PROCEDURE MainMenuInfo_SelectById(
    @id_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS    
    SELECT id,labelId,menuName,linkAddress,parentFrame,defaultParentId,
     defaultLevel,defaultIndex,needRightToVisible,rightDetailToVisible,needRightToView,rightDetailToView,
     needSwitchToVisible,switchClassNameToVisible,switchMethodNameToVisible,
     needSwitchToView,switchClassNameToView,switchMethodNameToView,relatedModuleId 
      FROM MainMenuInfo 
     WHERE id = @id_1
       SET @flag = 1 
       SET @msg = 'ok'

GO

/*ѡ�����˵�������Ϣ ���� menuLevel*/
CREATE PROCEDURE MainMenuInfo_SelectByLevel(
    @menuLevel_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    SELECT id,labelId,menuName,linkAddress,parentFrame,defaultParentId,
     defaultLevel,defaultIndex,needRightToVisible,rightDetailToVisible,needRightToView,rightDetailToView,
     needSwitchToVisible,switchClassNameToVisible,switchMethodNameToVisible,
     needSwitchToView,switchClassNameToView,switchMethodNameToView,relatedModuleId 
      FROM MainMenuInfo 
     WHERE defaultLevel = @menuLevel_1
     ORDER BY id
       SET @flag = 1 
       SET @msg = 'ok'
GO

/*ѡ�����˵�������Ϣ ���� parentId ����ϵͳ���˵�*/
CREATE PROCEDURE MainMenuInfo_SelectByParentId(
    @parentId_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    SELECT id,labelId,menuName,linkAddress,parentFrame,defaultParentId,
     defaultLevel,defaultIndex,needRightToVisible,rightDetailToVisible,needRightToView,rightDetailToView,
     needSwitchToVisible,switchClassNameToVisible,switchMethodNameToVisible,
     needSwitchToView,switchClassNameToView,switchMethodNameToView,relatedModuleId 
      FROM MainMenuInfo 
     WHERE defaultParentId = @parentId_1
     ORDER BY id
       SET @flag = 1 
       SET @msg = 'ok'
GO

/*���� MainMenuInfo ������ӣ��� MainMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� MainMenuConfig ���ӵļ�¼�� defaultIndex �� MainMenuConfig viewIndex ������Ϣ*/
CREATE PROCEDURE MainMenuConfig_U_ByInfoInsert(
    @defaultParentId_1      int,
    @defaultIndex_1     int,
    @flag            int	output, 
    @msg             varchar(80)	output) 
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

/*�������˵�������Ϣ*/
CREATE PROCEDURE MainMenuInfo_Insert(
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
    @relatedModuleId_1 int, 
    @flag	int	output, 
    @msg	varchar(80)	output) 
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
    

    SET @flag = 1 
    SET @msg = 'ok'

GO
/*ɾ�����˵��˵�������Ϣ*/
CREATE PROCEDURE MainMenuInfo_DeleteById(
    @id_1 	int ,
    @flag	int	output, 
    @msg	varchar(80)	output) 
AS
    DECLARE @defaultLevel int
    DECLARE @updateId int
    DECLARE @updateIndex int
    DECLARE @defaultIndex int
    DECLARE @defaultParentId int

    SELECT @defaultLevel = defaultLevel ,@defaultParentId = defaultParentId , @defaultIndex = defaultIndex 
      FROM MainMenuInfo 
     WHERE id = @id_1


    DELETE FROM MainMenuInfo 
     WHERE id = @id_1

    SET @updateIndex = @defaultIndex;


    /*���´���ɾ����¼Index �� defaultIndex ��1*/
    DECLARE mainMenuInfo_cursor CURSOR FOR
    SELECT id FROM MainMenuInfo 
     WHERE defaultParentId = @defaultParentId
       AND defaultIndex > @defaultIndex 
     ORDER BY defaultIndex

    OPEN mainMenuInfo_cursor
    FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE MainMenuInfo 
           SET defaultIndex = @updateIndex
         WHERE id = @updateId

        SET @updateIndex = @updateIndex + 1;

        FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId
    END

    CLOSE mainMenuInfo_cursor
    DEALLOCATE mainMenuInfo_cursor
GO

/*�������˵�������Ϣ*/
CREATE PROCEDURE MainMenuInfo_Update(
        @id_1 		int,
        @oldIndex_1     int,
        @labelId_1	int,
        @menuName_1	Varchar(100),
        @linkAddress_1  Varchar(100),
        @parentFrame_1  Varchar(100),
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
        @relatedModuleId_1 int,
    @flag		int	output, 
    @msg		varchar(80)	output) 
AS


    DECLARE @updateId int;
    DECLARE @updateIndex int;
	

    
    /*���� ���¼�¼ defaultIndex ��ԭ��¼ defaultIndex֮�� �� defaultIndex ��1*/

	IF (@defaultIndex_1<@oldIndex_1) BEGIN

	    SET @updateIndex = @defaultIndex_1;
 
            DECLARE mainMenuInfo_cursor CURSOR FOR
	    SELECT id FROM MainMenuInfo 
	     WHERE defaultParentId = @defaultParentId_1
	       AND defaultIndex >= @defaultIndex_1 
	       AND defaultIndex <  @oldIndex_1
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
	END
	IF (@defaultIndex_1>@oldIndex_1) BEGIN

	    SET @updateIndex = @oldIndex_1;

            DECLARE mainMenuInfo_cursor CURSOR FOR
	    SELECT id FROM MainMenuInfo 
	     WHERE defaultParentId = @defaultParentId_1
	       AND defaultIndex > @oldIndex_1 
	       AND defaultIndex <= @defaultIndex_1
         ORDER BY defaultIndex

            OPEN mainMenuInfo_cursor
            FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId

            WHILE @@FETCH_STATUS = 0
            BEGIN
                UPDATE MainMenuInfo 
                   SET defaultIndex = @updateIndex
                 WHERE id = @updateId
	        SET @updateIndex = @updateIndex + 1;
                FETCH NEXT FROM mainMenuInfo_cursor INTO @updateId
            END

            CLOSE mainMenuInfo_cursor
            DEALLOCATE mainMenuInfo_cursor
	END

        UPDATE MainMenuInfo 
	   SET labelId = @labelId_1,
	       menuName = @menuName_1,
	       linkAddress = @linkAddress_1 ,
	       parentFrame = @parentFrame_1 ,
	       defaultParentId = @defaultParentId_1 ,
	       defaultLevel = @defaultLevel_1 ,
	       defaultIndex = @defaultIndex_1-1 ,
	       needRightToVisible = @needRightToVisible_1 ,
	       rightDetailToVisible = @rightDetailToVisible_1 ,
	       needRightToView = @needRightToView_1 ,
	       rightDetailToView = @rightDetailToView_1 ,
	       needSwitchToVisible = @needSwitchToVisible_1 ,
	       switchClassNameToVisible = @switchClassNameToVisible_1 ,
	       switchMethodNameToVisible = @switchMethodNameToVisible_1, 
	       needSwitchToView = @needSwitchToView_1 ,
	       switchClassNameToView = @switchClassNameToView_1 ,
    	   switchMethodNameToView = @switchMethodNameToView_1, 
	       relatedModuleId = @relatedModuleId_1 

	 WHERE id = @id_1


    SET @flag = 1 
    SET @msg = 'ok'

GO


/*����ϵͳģ����Ϣ*/
CREATE PROCEDURE SystemModule_Insert(
        @id_1 int,
	    @moduleName_1     Varchar(100),
        @moduleReleased_1   char(1),
        @flag		int	output, 
        @msg		varchar(80)	output) 

AS
    INSERT INTO SystemModule (
        id,
        moduleName,
        moduleReleased
        ) 
    VALUES (
        @id_1,
        @moduleName_1,
        @moduleReleased_1
    ) 
    
    SET @flag = 1 
    SET @msg = 'ok'
GO

/*ɾ��ϵͳģ����Ϣ*/
CREATE PROCEDURE SystemModule_Delete(
        @id_1       int,
        @flag		int	output, 
        @msg		varchar(80)	output) 
        

AS

    DELETE FROM SystemModule WHERE id = @id_1

    SET @flag = 1 
    SET @msg = 'ok'

GO
/*����ϵͳģ����Ϣ*/
CREATE PROCEDURE SystemModule_UPDATE(
        @id_1       int,
	    @moduleName_1     Varchar(100),
        @moduleReleased_1   char(1),
        @flag		int	output, 
        @msg		varchar(80)	output) 
        
AS

    UPDATE SystemModule 
	   SET moduleName = @moduleName_1,
	       moduleReleased = @moduleReleased_1

	 WHERE id = @id_1


    SET @flag = 1 
    SET @msg = 'ok'
GO