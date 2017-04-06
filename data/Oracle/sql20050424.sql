/*���� LeftMenuInfo ��ĸ��ģ����������û� LeftMenuConfig ������Ϣ*/
CREATE or replace TRIGGER Tri_ULeftMenuConfig_ByInfo after  insert or update or delete ON LeftMenuInfo 
for each row
Declare 
        id_1 integer;
        defaultIndex_1 integer;
        countdelete   integer;
        countinsert   integer;
        userId integer;
begin
    countdelete := :old.id;
    countinsert := :new.id;
    /*����ʱ countinsert >0 AND countdelete = 0 */
    /*ɾ��ʱ countinsert =0 */
    /*����ʱ countinsert >0 AND countdelete > 0 */

    /*����*/
    IF (countinsert > 0 AND countdelete = 0) then
        id_1 := :new.id;
        defaultIndex_1 := :new.defaultIndex;
          /*ϵͳ����Ա*/
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(1,id_1,1,defaultIndex_1);
        /*�û�*/    
        FOR hrmResource_cursor in( 
        SELECT id FROM HrmResource order by id)   
        loop
            userId:=hrmResource_cursor.id;
            INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(userId,id_1,1,defaultIndex_1);
        END loop;
    END if;

    /*ɾ��*/
    IF (countinsert = 0) then
       id_1 := :old.id;            
       DELETE FROM LeftMenuConfig WHERE infoId = id_1;
    END if;
end;
/

/*���� MainMenuInfo ��ĸ��ģ����������û� MainMenuConfig ������Ϣ*/
CREATE or replace TRIGGER Tri_UMainMenuConfig_ByInfo after  insert or update or delete ON MainMenuInfo 
for each row
Declare 
        id_1 integer;
        defaultParentId_1 integer;
        defaultIndex_1 integer;
        defaultLevel_1 integer;
        countdelete   integer;
        countinsert   integer;
        userId integer;
begin

    countdelete := :old.id;
    countinsert := :new.id;
/*����ʱ countinsert >0 AND countdelete = 0 */
/*ɾ��ʱ countinsert =0 */
/*����ʱ countinsert >0 AND countdelete > 0 */

/*����*/
IF (countinsert > 0 AND countdelete = 0) then
    
    id_1 := :new.id;
    defaultParentId_1 := :new.defaultParentId;
    defaultIndex_1 := :new.defaultIndex;
    defaultLevel_1 := :new.defaultLevel;
    /*ϵͳ����Ա*/

    INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(1,id_1,1,defaultParentId_1,defaultIndex_1,defaultLevel_1);

    /*�û�*/    
    FOR hrmResource_cursor in( 
    SELECT id FROM HrmResource order by id)

    loop
        userId :=hrmResource_cursor.id;
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(userId,id_1,1,defaultParentId_1,defaultIndex_1,defaultLevel_1);

    END loop;
END if;

/*ɾ��*/
IF (countinsert = 0) then

    id_1 := :old.id; 
    
    DELETE FROM MainMenuConfig WHERE infoId = id_1;
END if;
end;
/

/*��������ҳ�ı仯 DocFrontpage ��ĸ��ģ����� MainMenuInfo ������Ϣ*/
CREATE or replace TRIGGER Tri_UMMInfo_ByDocFrontpage after  insert or update or delete ON DocFrontpage 
for each row
Declare id_1 integer;
        frontpagename_1 varchar2(200);
        isactive_1 char(1);
        publishtype_1 integer;
        linkAddress_1 varchar2(100);
        defaultIndex_1 integer;
        countdelete   integer;
        countinsert   integer;
        updateId integer;
        updateIndex integer;
begin
    countdelete :=:old.id;
    countinsert :=:new.id;

/*����ʱ countinsert >0 AND countdelete = 0 */
/*ɾ��ʱ countinsert =0 */
/*����ʱ countinsert >0 AND countdelete > 0 */

/*���� �� ���� ������ӡ����µ�����ҳ �ǻ�Ծ״̬(isactive = 1) �����Ƿ����������û�(publishType = 1) ��ô�� MainMenuInfo ������һ�� ����ҳ�Ĳ˵� ��Ϣ*/
IF (countinsert > 0) then
 
  id_1:= :new.id;
  frontpagename_1:= :new.frontpagename;
  isactive_1:= :new.isactive;
  publishtype_1:= :new.publishtype;

    SELECT COUNT(defaultIndex) into defaultIndex_1
      FROM MainMenuInfo 
     WHERE defaultparentId =1;
       

    IF (isactive_1 = 1 AND publishtype_1 = 1) then
        
        linkAddress_1 := concat('/docs/news/NewsDsp.jsp?id=',trunc(id_1));
        INSERT INTO MainMenuInfo (
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
            frontpagename_1,
            linkAddress_1,
            'mainFrame',
            1,
            1,
            defaultIndex_1,
            0,
            0,
            0,
            9
        );

        /*�����������õ�˳���*/
        UPDATE MainMenuInfo
           SET defaultIndex = defaultIndex_1 + 1
         WHERE defaultparentId =1
           AND labelId IS NOT NULL;

    END if;
END if;

/*ɾ�� ���ɾ��������ҳ �ǻ�Ծ״̬(isactive = 1) �����Ƿ����������û�(publishType = 1) ��ô�� MainMenuInfo ��ɾ����Ӧ�� ����ҳ�Ĳ˵� ��Ϣ*/
IF (countinsert = 0) then

    id_1 :=:old.id;
    
    SELECT defaultIndex into defaultIndex_1 
      FROM MainMenuInfo 
     WHERE linkAddress = concat('/docs/news/NewsDsp.jsp?id=',trunc(id_1));
    
    DELETE FROM MainMenuInfo WHERE linkAddress = concat('/docs/news/NewsDsp.jsp?id=',trunc(id_1));

    /*���´���ɾ����¼Index �� defaultIndex ��1*/
    FOR mainMenuInfo_cursor in(
    SELECT id FROM MainMenuInfo 
     WHERE defaultParentId = 1
       AND defaultIndex > defaultIndex_1 )


    loop
        updateId:=mainMenuInfo_cursor.id;
        UPDATE MainMenuInfo 
           SET defaultIndex = updateIndex
         WHERE id = updateId;

        updateIndex := updateIndex + 1;

    END loop;
END if;
end;
/


