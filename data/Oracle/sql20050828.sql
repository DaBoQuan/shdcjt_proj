
INSERT INTO HtmlLabelIndex VALUES(17869,'����Ա����') 
/
INSERT INTO HtmlLabelInfo VALUES(17869,'����Ա����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17869,'SysadminSet',8) 
/

CALL MMConfig_U_ByInfoInsert(11,9)
/
CALL MMInfo_Insert (383,17869,'����Ա����','/systeminfo/sysadmin/sysadminList.jsp','mainFrame',11,1,9,0,'',0,'',0,'','',0,'','',9)
/

INSERT INTO HtmlLabelIndex VALUES(17870,'����Ա�ʺ�') 
/
INSERT INTO HtmlLabelInfo VALUES(17870,'����Ա�ʺ�',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17870,'Manager Account',8) 
/

alter table HrmResourceManager add description varchar2(255)
/
update HrmResourceManager set description='e-cologyĬ��ϵͳ����Ա' where loginid='sysadmin'
/

insert into HtmlNoteIndex (id,indexdesc) VALUES (64,'�ʺ��ظ�') 
/
insert into HtmlNoteInfo (indexid,notename,languageid) VALUES (64, '���ʺ��Ѿ����ڣ�����дһ���µ��ʺţ�', 7) 
/
insert into HtmlNoteInfo (indexid,notename,languageid) VALUES (64, 'Sorry,this account has bean registered.Please choose a new one!', 8) 
/



 CREATE or replace PROCEDURE HrmResource_SByLoginIDPass 
 ( loginid_1   varchar2, 
   password_1  varchar2, 
   flag	out integer,
   msg out varchar2,
   thecursor IN OUT cursor_define.weavercursor)
AS
count_1 integer; 
begin
    select count(id)  into count_1 from HrmResource where loginid= loginid_1;
    if count_1 != 0 
    then
        select count(id)  into count_1 from HrmResource where loginid= loginid_1 and password = password_1 ;
        if count_1 != 0 
        then
            open thecursor for
            select * from HrmResource where loginid= loginid_1 ;
        else 
            open thecursor for
            select 0 from dual ;
        end if;
	else 
		select count(id)  into count_1 from HrmResourceManager where loginid = loginid_1;
		if count_1 != 0
		then
			select count(id)  into count_1 from HrmResourceManager where loginid = loginid_1 and password = password_1;
			if count_1 != 0 
			then
				open thecursor for
				select * from HrmResourceManager where loginid= loginid_1 ;
			else 
				open thecursor for
				select 0 from dual;
			end if;
		end if;
	end if;
end;
/

/*���� LeftMenuInfo ������ӣ��� LeftMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� LeftMenuConfig ���ӵļ�¼�� defaultIndex �� LeftMenuConfig viewIndex ������Ϣ*/
CREATE or replace  PROCEDURE LMConfig_U_ByInfoInsert
(   menuLevel_1      integer,
    parentId_1      integer,
    defaultIndex_1     integer,
	flag out integer,
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
AS
 userId_1 integer;
 updateId integer;
 updateIndex integer;
begin    
    /*�����˵�*/
    IF (menuLevel_1 = 1)
	then        
        for hrmResourcemanager_cursor IN(
        SELECT id FROM HrmResourceManager order by id)
        LOOP
		   userId_1 := hrmResourcemanager_cursor.id;
        /*ϵͳ����Ա*/
	        updateIndex := defaultIndex_1;
	        FOR leftMenuConfig_cursor IN( 
	        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
		     WHERE t1.id = t2.infoId 
	           AND t2.userId = userId_1
	           AND t1.parentId IS NULL
	           AND t2.viewIndex >= defaultIndex_1 
	         ORDER BY defaultIndex)
	        LOOP
	            updateId := leftMenuConfig_cursor.id;
			  updateIndex := updateIndex + 1;
	            UPDATE LeftMenuConfig 	SET viewIndex = updateIndex	WHERE id = updateId;
	        END LOOP;
        END LOOP;
        /*�û�*/
        FOR hrmResource_cursor IN (
        SELECT id FROM HrmResource order by id)
        LOOP
            userId_1 := hrmResource_cursor.id;
            updateIndex := defaultIndex_1;
            FOR leftMenuConfig_cursor_1 IN (
            SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	         WHERE t1.id = t2.infoId 
               AND t2.userId = userId_1
               AND t1.parentId IS NULL
               AND t2.viewIndex >= defaultIndex_1 
             ORDER BY defaultIndex)
            LOOP 
			  updateId :=leftMenuConfig_cursor_1.id;
			  updateIndex := updateIndex + 1;
                UPDATE LeftMenuConfig 
                   SET viewIndex = updateIndex
                 WHERE id = updateId;
            END LOOP;
        END LOOP;
    ELSE
        FOR hrmResourcemanager_cursor IN( 
        SELECT id FROM HrmResourceManager order by id)
        LOOP
        	 userId_1 := hrmResourcemanager_cursor.id;
	        /*ϵͳ����Ա*/
	        updateIndex := defaultIndex_1;
	        FOR leftMenuConfig_cursor IN (
	        SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
		     WHERE t1.id = t2.infoId 
	           AND t2.userId = userId_1
	           AND t1.parentId = parentId_1
	           AND t2.viewIndex >= defaultIndex_1 
	         ORDER BY defaultIndex)
	        LOOP
	            updateId:= leftMenuConfig_cursor.id;
	            updateIndex := updateIndex + 1;
	            UPDATE LeftMenuConfig 
	               SET viewIndex = updateIndex 
	             WHERE id = updateId;
	        END LOOP;   
        END LOOP;

        /*�û�*/
        FOR hrmResource_cursor IN( 
        SELECT id FROM HrmResource order by id)
        LOOP
        		userId_1 :=hrmResource_cursor.id;
              updateIndex := defaultIndex_1;

            FOR leftMenuConfig_cursor_1 in( 
            SELECT t2.id FROM LeftMenuInfo t1,LeftMenuConfig t2 
	         WHERE t1.id = t2.infoId 
               AND t2.userId = userId_1
               AND t1.parentId = parentId_1
               AND t2.viewIndex >= defaultIndex_1 
             ORDER BY defaultIndex)
            LOOP
            	  updateId :=leftMenuConfig_cursor_1.id;
                updateIndex := updateIndex + 1;
                UPDATE LeftMenuConfig 
                   SET viewIndex = updateIndex
                 WHERE id = updateId;
            END LOOP;
        END LOOP;
    END if;
end;
/

/*���� MainMenuInfo ������ӣ��� MainMenuConfig ���ӡ�һ����¼ 
  ���������û� ViewIndex ���� MainMenuConfig ���ӵļ�¼�� defaultIndex �� MainMenuConfig viewIndex ������Ϣ*/
  


CREATE or replace PROCEDURE MMConfig_U_ByInfoInsert
	(defaultParentId_1   integer,
    defaultIndex_1     integer)
AS
 userId_1 integer;   
 updateId integer;
 updateIndex integer;
begin   
	FOR hrmResourcemanager_cursor IN( 
	SELECT id FROM HrmResourceManager order by id)
	LOOP
		userId_1 := hrmResourcemanager_cursor.id;
		/*ϵͳ����Ա*/
		updateIndex := defaultIndex_1;
		FOR mainMenuConfig_cursor IN(
		SELECT t2.id FROM MainMenuInfo t1,MainMenuConfig t2 
		 WHERE t1.id = t2.infoId 
		   AND t2.userId = userId_1
		   AND t1.defaultParentId = defaultParentId_1
		   AND t2.viewIndex >= defaultIndex_1 
		 ORDER BY defaultIndex)
		LOOP
			updateId := mainMenuConfig_cursor.id;
			updateIndex := updateIndex + 1;
			UPDATE MainMenuConfig 
			   SET viewIndex = updateIndex
			 WHERE id = updateId;
		END LOOP;
	END LOOP;
   
	/*�û�*/

    FOR hrmResource_cursor in( 
	SELECT id FROM HrmResource order by id)
	loop
		userId_1:=hrmResource_cursor.id;
		updateIndex := defaultIndex_1;
		FOR mainMenuConfig_cursor_1 in( 
		SELECT t2.id FROM MainMenuInfo t1,MainMenuConfig t2 
		WHERE t1.id = t2.infoId 
		  AND t2.userId = userId_1
		  AND t1.defaultParentId = defaultParentId_1
		  AND t2.viewIndex >= defaultIndex_1 
		 ORDER BY defaultIndex)
		loop
			updateId :=mainMenuConfig_cursor_1.id;
			updateIndex := updateIndex + 1;
			UPDATE MainMenuConfig 
					   SET viewIndex = updateIndex
					 WHERE id = updateId;
		END loop;
	END loop;
end;
/


/*���� �½�����Ա HrmResourceManager ��ĸ��� �����¸ù���Ա LeftMenuConfig MainMenuConfig ������Ϣ*/
CREATE or REPLACE TRIGGER Tri_UMMInfo_ByHRManager after insert  ON  HrmResourceManager
FOR each row
    DECLARE 
	userId_1 integer;
	flag_1 integer;
	msg_1 varchar2(80);
	id_1 integer;
	defaultIndex_1 integer;
	id_2 integer;
	defaultParentId_2 integer;
	defaultIndex_2 integer;
	defaultLevel_2 integer;

BEGIN
	userId_1 := :new.id;
	FOR leftMenuInfo_cursor in( 
    SELECT id, defaultIndex FROM LeftMenuInfo)
    loop
		id_1:=leftMenuInfo_cursor.id;
		defaultIndex_1:=leftMenuInfo_cursor.defaultIndex;
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(userId_1,id_1,1,defaultIndex_1);
    END loop;

    FOR mainMenuInfo_cursor in( 
    SELECT id,defaultParentId, defaultIndex, defaultLevel FROM MainMenuInfo)
    loop
        id_2 :=mainMenuInfo_cursor.id;
        defaultParentId_2 :=mainMenuInfo_cursor.defaultParentId;
        defaultIndex_2 :=mainMenuInfo_cursor.defaultIndex;
        defaultLevel_2 :=mainMenuInfo_cursor.defaultLevel;
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(userId_1,id_2,1,defaultParentId_2,defaultIndex_2,defaultLevel_2);
    END loop;
END;
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
        userId_1 integer;
begin

    countdelete := :old.id;
    countinsert := :new.id;
/*����ʱ countinsert >0 AND countdelete = 0 */
/*ɾ��ʱ countinsert =0 */
/*����ʱ countinsert >0 AND countdelete > 0 */

/*����*/
IF (countdelete is null) then
    
    id_1 := :new.id;
    defaultParentId_1 := :new.defaultParentId;
    defaultIndex_1 := :new.defaultIndex;
    defaultLevel_1 := :new.defaultLevel;
    /*ϵͳ����Ա*/
	
	FOR hrmResourcemanager_cursor in( 
    SELECT id FROM HrmResourceManager order by id)
    loop
		userId_1 := hrmResourcemanager_cursor.id;
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(userId_1,id_1,1,defaultParentId_1,defaultIndex_1,defaultLevel_1);
    END loop;
 
    /*�û�*/    
    FOR hrmResource_cursor in( 
    SELECT id FROM HrmResource order by id)

    loop
        userId_1 :=hrmResource_cursor.id;
        INSERT INTO MainMenuConfig (userId,infoId,visible,parentId,viewIndex,menuLevel) VALUES(userId_1,id_1,1,defaultParentId_1,defaultIndex_1,defaultLevel_1);

    END loop;
END if;

/*ɾ��*/
IF (countinsert is null) then

    id_1 := :old.id; 
    
    DELETE FROM MainMenuConfig WHERE infoId = id_1;
END if;
end;
/

/*���� LeftMenuInfo ��ĸ��ģ����������û� LeftMenuConfig ������Ϣ*/
CREATE or replace TRIGGER Tri_ULeftMenuConfig_ByInfo after  insert or update or delete ON LeftMenuInfo 
for each row
Declare 
        id_1 integer;
        defaultIndex_1 integer;
        countdelete   integer;
        countinsert   integer;
        userId_1 integer;
begin
    countdelete := :old.id;
    countinsert := :new.id;
    /*����ʱ countinsert >0 AND countdelete is null */
    /*ɾ��ʱ countinsert is null */
    /*����ʱ countinsert >0 AND countdelete > 0 */

    /*����*/
    IF (countinsert > 0 AND countdelete is null) then
        id_1 := :new.id;
        defaultIndex_1 := :new.defaultIndex;
          /*ϵͳ����Ա*/
		FOR hrmResourcemanager_cursor in( 
		SELECT id FROM HrmResourceManager order by id)
		loop
			userId_1 := hrmResourcemanager_cursor.id;
			INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(userId_1,id_1,1,defaultIndex_1);
		END loop; 
		
		
		/*�û�*/    
        FOR hrmResource_cursor in( 
        SELECT id FROM HrmResource order by id)   
        loop
            userId_1:=hrmResource_cursor.id;
            INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(userId_1,id_1,1,defaultIndex_1);
        END loop;
    END if;

    /*ɾ��*/
    IF (countinsert is null) then
       id_1 := :old.id;            
       DELETE FROM LeftMenuConfig WHERE infoId = id_1;
    END if;
end;
/