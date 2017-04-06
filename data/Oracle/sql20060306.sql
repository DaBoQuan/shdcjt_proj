create or replace  PROCEDURE LeftMenuConfig_InsertByUserId
(
userId_1   integer,
flag out 	integer,
msg out	varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS

id_1 integer;
defaultIndex_1 integer;
begin
    FOR leftMenuInfo_cursor in( 
    /*ֻ���ϵͳ�������˵�*/
    SELECT id, defaultIndex FROM LeftMenuInfo WHERE isCustom='0' OR isCustom IS NULL)
    loop
		id_1 := leftMenuInfo_cursor.defaultIndex;
		defaultIndex_1 := leftMenuInfo_cursor.id;
		if userId_1 is not null 
        then
        INSERT INTO LeftMenuConfig (userId,infoId,visible,viewIndex) VALUES(userId_1,id_1,1,defaultIndex_1);
        end if;
    END loop;
end;
/
