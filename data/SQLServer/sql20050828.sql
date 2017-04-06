
INSERT INTO HtmlLabelIndex values(17869,'����Ա����') 
GO
INSERT INTO HtmlLabelInfo VALUES(17869,'����Ա����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17869,'SysadminSet',8) 
GO

EXECUTE MMConfig_U_ByInfoInsert 11,9
GO
EXECUTE MMInfo_Insert 383,17869,'����Ա����','/systeminfo/sysadmin/sysadminList.jsp','mainFrame',11,1,9,0,'',0,'',0,'','',0,'','',9
GO

INSERT INTO HtmlLabelIndex values(17870,'����Ա�ʺ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17870,'����Ա�ʺ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17870,'Manager Account',8) 
GO

alter table HrmResourceManager add description varchar(255)
GO
update HrmResourceManager set description='e-cologyĬ��ϵͳ����Ա' where loginid='sysadmin'
GO

insert into HtmlNoteIndex (id,indexdesc) values (64,'�ʺ��ظ�') 
GO
insert into HtmlNoteInfo (indexid,notename,languageid) values (64, '���ʺ��Ѿ����ڣ�����дһ���µ��ʺţ�', 7) 
GO
insert into HtmlNoteInfo (indexid,notename,languageid) values (64, 'Sorry,this account has bean registered.Please choose a new one!', 8) 
GO



alter PROCEDURE HrmResource_SByLoginIDPass ( @loginid   varchar(60), @password  varchar(100), @flag	int	output, @msg	varchar(80)	output ) AS declare @count int 
begin 
	select @count = count(id) from HrmResource where loginid= @loginid 
	if @count <> 0 
		begin 
			select @count = count(id) from HrmResource where loginid= @loginid and password = @password 
			if @count <> 0 
				select * from HrmResource where loginid= @loginid 
			else 
				select 0 
		end 
	else 
		begin 
			select @count = count(id) from HrmResourceManager where loginid= @loginid 
			if @count <> 0 
				begin 
					select @count = count(id) from HrmResourceManager where loginid = @loginid and password = @password 
					if @count <> 0 
						select * from HrmResourceManager where loginid= @loginid 
					else 
						select 0 
				end 
		end 
end
GO

/*���� LeftMenuInfo ������ӣ��� LeftMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� LeftMenuConfig ���ӵļ�¼�� defaultIndex �� LeftMenuConfig viewIndex ������Ϣ*/



alter PROCEDURE LMConfig_U_ByInfoInsert(
    @menuLevel_1      int,
    @parentId_1      int,
    @defaultIndex_1     int) 
AS
DECLARE @userId int;
    
DECLARE @updateId int;
DECLARE @updateIndex int;

    
    /*�����˵�*/
    IF (@menuLevel_1 = 1) BEGIN
        
        DECLARE hrmResourcemanager_cursor CURSOR FOR
        SELECT id FROM HrmResourceManager order by id

        OPEN hrmResourcemanager_cursor
        FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
        /*ϵͳ����Ա*/
	        SET @updateIndex = @defaultIndex_1;
	
	        DECLARE leftMenuConfig_cursor CURSOR FOR
	        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
		     WHERE t1.id = t2.infoId 
	           AND t2.userId = @userId
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
    
        DECLARE hrmResourcemanager_cursor CURSOR FOR
        SELECT id FROM HrmResourceManager order by id

        OPEN hrmResourcemanager_cursor
        FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
	        /*ϵͳ����Ա*/
	        SET @updateIndex = @defaultIndex_1;
	        DECLARE leftMenuConfig_cursor CURSOR FOR
	        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
		     WHERE t1.id = t2.infoId 
	           AND t2.userId = @userId
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

/*���� MainMenuInfo ������ӣ��� MainMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� MainMenuConfig ���ӵļ�¼�� defaultIndex �� MainMenuConfig viewIndex ������Ϣ*/
  


alter PROCEDURE MMConfig_U_ByInfoInsert(
    @defaultParentId_1      int,
    @defaultIndex_1     int) 
AS
DECLARE @userId int;
    
DECLARE @updateId int;
DECLARE @updateIndex int;

    
        DECLARE hrmResourcemanager_cursor CURSOR FOR
        SELECT id FROM HrmResourceManager order by id

        OPEN hrmResourcemanager_cursor
        FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId

        WHILE @@FETCH_STATUS = 0
        BEGIN
	        /*ϵͳ����Ա*/
	        SET @updateIndex = @defaultIndex_1;
	
	        DECLARE mainMenuConfig_cursor CURSOR FOR
	        SELECT t2.id FROM MainMenuInfo t1,MainMenuConfig t2 
		     WHERE t1.id = t2.infoId 
	           AND t2.userId = @userId
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

/*���� �½�����Ա HrmResourceManager ��ĸ��� �����¸ù���Ա LeftMenuConfig MainMenuConfig ������Ϣ*/
CREATE TRIGGER Tri_UMMInfo_ByHrmResourceManager ON HrmResourceManager WITH ENCRYPTION
FOR INSERT 
AS
    DECLARE @userId_1 int
	DECLARE @flag_1 int
	DECLARE @msg_1 varchar(80)


    SELECT @userId_1 = id FROM inserted

    EXEC LeftMenuConfig_InsertByUserId @userId_1,@flag = @flag_1 OUTPUT,@msg = @msg_1 OUTPUT

    EXEC MainMenuConfig_InsertByUserId @userId_1,@flag = @flag_1 OUTPUT,@msg = @msg_1 OUTPUT

GO

/*���� MainMenuInfo ��ĸ��ģ����������û� MainMenuConfig ������Ϣ*/
ALTER TRIGGER Tri_UMainMenuConfig_ByInfo ON MainMenuInfo WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS
Declare @id_1 int,
        @defaultParentId_1 int,
        @defaultIndex_1 int,
        @defaultLevel_1 int,
        @countdelete   int,
        @countinsert   int,
        @userId int


SELECT @countdelete = count(*) FROM deleted
SELECT @countinsert = count(*) FROM inserted

/*����ʱ @countinsert >0 AND @countdelete = 0 */
/*ɾ��ʱ @countinsert =0 */
/*����ʱ @countinsert >0 AND @countdelete > 0 */

/*����*/
IF (@countinsert > 0 AND @countdelete = 0) BEGIN

    SELECT @id_1 = id , @defaultParentId_1 = defaultParentId , @defaultIndex_1 = defaultIndex ,@defaultLevel_1 = defaultLevel 
      FROM inserted
    /*ϵͳ����Ա*/
    DECLARE hrmResourcemanager_cursor CURSOR FOR
    SELECT id FROM HrmResourceManager order by id

    OPEN hrmResourcemanager_cursor
    FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(@userId,@id_1,1,@defaultParentId_1,@defaultIndex_1,@defaultLevel_1)
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
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(@userId,@id_1,1,@defaultParentId_1,@defaultIndex_1,@defaultLevel_1)
        FETCH NEXT FROM hrmResource_cursor INTO @userId
    END
    CLOSE hrmResource_cursor
    DEALLOCATE hrmResource_cursor

END

/*ɾ��*/
IF (@countinsert = 0) BEGIN

    SELECT @id_1 = id FROM deleted
    
    DELETE FROM MainMenuConfig WHERE infoId = @id_1
END

GO

/*���� LeftMenuInfo ��ĸ��ģ����������û� LeftMenuConfig ������Ϣ*/
AlTER TRIGGER Tri_ULeftMenuConfig_ByInfo ON LeftMenuInfo WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS
Declare @id_1 int,
        @defaultIndex_1 int,
        @countdelete   int,
        @countinsert   int,
        @userId int


SELECT @countdelete = count(*) FROM deleted
SELECT @countinsert = count(*) FROM inserted

/*����ʱ @countinsert >0 AND @countdelete = 0 */
/*ɾ��ʱ @countinsert =0 */
/*����ʱ @countinsert >0 AND @countdelete > 0 */

/*����*/
IF (@countinsert > 0 AND @countdelete = 0) BEGIN

    SELECT @id_1 = id , @defaultIndex_1 = defaultIndex FROM inserted
    /*ϵͳ����Ա*/
    DECLARE hrmResourcemanager_cursor CURSOR FOR
    SELECT id FROM HrmResourceManager order by id

    OPEN hrmResourcemanager_cursor
    FETCH NEXT FROM hrmResourcemanager_cursor INTO @userId

    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(@userId,@id_1,1,@defaultIndex_1)
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
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(@userId,@id_1,1,@defaultIndex_1)
        FETCH NEXT FROM hrmResource_cursor INTO @userId
    END
    CLOSE hrmResource_cursor
    DEALLOCATE hrmResource_cursor

END

/*ɾ��*/
IF (@countinsert = 0) BEGIN

    SELECT @id_1 = id FROM deleted
    
    DELETE FROM LeftMenuConfig WHERE infoId = @id_1
END

GO