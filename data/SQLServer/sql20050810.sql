/*��������ҳ�ı仯 DocFrontpage ��ĸ��ģ����� MainMenuInfo ������Ϣ*/
drop TRIGGER Tri_UMMInfo_ByDocFrontpage
go
create TRIGGER Tri_UMMInfo_ByDocFrontpage ON DocFrontpage WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS
Declare @id_1 int,
        @frontpagename_1 varchar(200),
        @isactive_1 char(1),
        @publishtype_1 int,
        @linkAddress_1 varchar(100),
        @defaultIndex_1 int,
        @countdelete   int,
        @countinsert   int,
        @updateId int,
        @updateIndex int
       

SELECT @countdelete = count(*) FROM deleted
SELECT @countinsert = count(*) FROM inserted

/*����ʱ @countinsert >0 AND @countdelete = 0 */
/*ɾ��ʱ @countinsert =0 */
/*����ʱ @countinsert >0 AND @countdelete > 0 */

/*���� �� ���� ������ӡ����µ�����ҳ �ǻ�Ծ״̬(isactive = 1) �����Ƿ����������û�(publishType = 1) ��ô�� MainMenuInfo ������һ�� ����ҳ�Ĳ˵� ��Ϣ*/
IF (@countinsert > 0 and  @countdelete = 0) BEGIN

    SELECT @id_1 = id , @frontpagename_1 = frontpagename , @isactive_1 = isactive ,@publishtype_1 = publishtype 
      FROM inserted

    SELECT @defaultIndex_1 = COUNT(defaultIndex) 
      FROM MainMenuInfo 
     WHERE defaultparentId =1   
    IF (@isactive_1 = 1 AND @publishtype_1 = 1) BEGIN
        
        SET @linkAddress_1 = '/docs/news/NewsDsp.jsp?id='+CAST(@id_1 AS varchar(12))

   
        
        INSERT INTO MainMenuInfo (
            id,
            menuName , 
            linkAddress , 
            parentFrame ,
            defaultParentId ,
            defaultLevel , 
            defaultIndex , 
            needRightToVisible , 
            needRightToView , 
            needSwitchToVisible , 
            relatedModuleId
        )
        VALUES (
            @id_1*-1,
            @frontpagename_1,
            @linkAddress_1,
            'mainFrame',
            1,
            1,
            @defaultIndex_1,
            0,
            0,
            0,
            9
        ) 

        /*�����������õ�˳���*/
        UPDATE MainMenuInfo
           SET defaultIndex = @defaultIndex_1 + 1
         WHERE defaultparentId =1
           AND labelId IS NOT NULL

    END
END

/*�����update����*/

IF (@countinsert > 0 and  @countdelete >0) BEGIN

    SELECT @id_1 = id , @frontpagename_1 = frontpagename , @isactive_1 = isactive ,@publishtype_1 = publishtype 
      FROM inserted

    SELECT @defaultIndex_1 = COUNT(defaultIndex) 
      FROM MainMenuInfo 
     WHERE defaultparentId =1   

        SET @linkAddress_1 = '/docs/news/NewsDsp.jsp?id='+CAST(@id_1 AS varchar(12))
        update  MainMenuInfo set menuName=@frontpagename_1,linkAddress=@linkAddress_1,defaultIndex=@defaultIndex_1 where id =  @id_1*-1      

END

/*ɾ�� ���ɾ��������ҳ �ǻ�Ծ״̬(isactive = 1) �����Ƿ����������û�(publishType = 1) ��ô�� MainMenuInfo ��ɾ����Ӧ�� ����ҳ�Ĳ˵� ��Ϣ*/
IF (@countinsert = 0) BEGIN

    SELECT @id_1 = id FROM deleted

    SELECT @defaultIndex_1 = defaultIndex 
      FROM MainMenuInfo 
     WHERE linkAddress = '/docs/news/NewsDsp.jsp?id='+CAST(@id_1 AS varchar(12))
    
    DELETE FROM MainMenuInfo WHERE linkAddress = '/docs/news/NewsDsp.jsp?id='+CAST(@id_1 AS varchar(12))

    /*���´���ɾ����¼Index �� defaultIndex ��1*/
    DECLARE mainMenuInfo_cursor CURSOR FOR
    SELECT id FROM MainMenuInfo 
     WHERE defaultParentId = 1
       AND defaultIndex > @defaultIndex_1 

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

GO
