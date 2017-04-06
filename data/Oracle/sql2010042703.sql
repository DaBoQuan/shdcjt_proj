delete ofgroupprop
/
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.displayName','1')
/
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.groupList','1')
/
insert into ofgroupprop(groupname,name,propvalue) values ('1','sharedRoster.showInRoster','everybody')
/

CREATE or replace TRIGGER Tri_Update_HrmMessager after insert or update or delete ON HrmResource 
for each row
Declare 
        id_1 	   	  integer;
        countdelete   integer;
        countinsert   integer;
        loginid	      varchar(100);
        groupname     integer;
        groupcount    integer;
begin
    countdelete := :old.id;
    countinsert := :new.id;
    /*����ʱ countinsert >0 AND countdelete is null */
    /*ɾ��ʱ countinsert is null */
    /*����ʱ countinsert >0 AND countdelete > 0 */

    /*����*/
    IF (countinsert > 0 AND countdelete is null) then
        id_1 := :new.id;
        loginid := :new.loginid;
        
        select count(0) into groupcount from HrmMessagerGroupUsers where userloginid = loginid;
        select groupname into groupname from HrmMessagerGroup;
        
        if groupname > 0 and groupcount = 0 then
        	insert into HrmMessagerGroupUsers(userloginid,groupname,isadmin) values(loginid,groupname,'N');
        end if;
    END if;

    /*ɾ��*/
    IF (countinsert is null) then
       id_1 := :old.id;
       loginid := :old.loginid;
       DELETE FROM HrmMessagerGroupUsers WHERE userloginid = loginid;
    END if;
end;
/
