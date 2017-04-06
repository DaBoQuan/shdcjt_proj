/* FOR ID:4 ������Դ����Ա�Ľ�ɫҳ�治����ʾȨ���� BY ���� */
CREATE or REPLACE PROCEDURE HrmRoles_SystemRight 
  (roleid_1 integer, 
  flag out integer, 
  msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
as
 rightid_1 integer ; 
 rolelevel_1 varchar(8);
 rightgroupname_1 varchar(80); 
 countgroupid_1 integer ; 
begin 
for right_cursor1 in(select rightid,rolelevel from systemrightroles where roleid= roleid_1)
loop
    rightid_1 :=right_cursor1.rightid ;
    rolelevel_1 :=right_cursor1.rolelevel ;
    insert into TM_HrmRoles_SystemRight(rightid,rightlevel) values( rightid_1, rolelevel_1) ;
    rightgroupname_1 := '' ;
    countgroupid_1 := 0 ;
    select count(rightgroupname) into countgroupid_1 from Systemrightgroups a, SystemRightToGroup b where rightid =  rightid_1 and a.id=b.groupid ;
    if countgroupid_1 = 1 then
        select rightgroupname into rightgroupname_1 from Systemrightgroups a, SystemRightToGroup b where rightid =  rightid_1 and a.id=b.groupid ;
    else
        if countgroupid_1 > 1 then
            select rightgroupname into rightgroupname_1 from (select  distinct rightgroupname from Systemrightgroups a, SystemRightToGroup b where rightid =  rightid_1 and a.id=b.groupid ) where rownum<2 ;
        end if ;
    end if ;
    update TM_HrmRoles_SystemRight set rightgroup =  rightgroupname_1 where rightid =  rightid_1;
end loop;
open thecursor for
select rightgroup,rightlevel,rightid from TM_HrmRoles_SystemRight order by rightgroup ;

 end;
/

/*for id=69 by ������*/
update SystemRightsLanguage set rightdesc='�ֲ����½����༭����ʾ��ɾ�����鿴��־' where id=18 and languageid=7
/

/*
BUG 79 ����ְ�����Ȩ�޵��û���û��Ȩ�޲鿴ְ��������־��Ϣ.����ϵͳ����Ա���Բ鿴��־��Ϣ-����
*/
Delete From SystemRightDetail Where rightid = 126
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (426,'ְ��������','HrmJobGroupsAdd:Add',126) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (427,'ְ�����༭','HrmJobGroupsEdit:Edit',126) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (428,'ְ�����ɾ��','HrmJobGroupsEdit:Delete',126) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (429,'ְ�������־�鿴','HrmJobGroups:Log',126) 
/

/*bug:92 �޸�112��Ȩ�޵�Ĭ������ by hy */
DELETE FROM SystemRights WHERE id = 112
/
DELETE FROM SystemRightsLanguage WHERE id = 112
/
DELETE FROM SystemRightDetail WHERE rightid = 112
/
insert into SystemRights (id,rightdesc,righttype) values (112,'������Ϣά��','3') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,8,'other info maintenance','other info maintenance') 
/
insert into SystemRightsLanguage (id,languageid,rightname,rightdesc) values (112,7,'������Ϣά��','������Ϣά��') 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (391,'������Ϣ���','HrmOtherInfoTypeAdd:Add',112) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (392,'������Ϣ�༭','HrmOtherInfoTypeEdit:Edit',112) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (393,'������Ϣɾ��','HrmOtherInfoTypeEdit:Delete',112) 
/
insert into SystemRightDetail (id,rightdetailname,rightdetail,rightid) values (394,'������Ϣ��־�鿴','HrmOtherInfoType:Log',112) 
/
/*����Ĭ��Ȩ��Ϊ������Դ���ܲ�����*/
DELETE FROM systemrighttogroup WHERE GroupID = 3 and rightid=112
/
INSERT INTO systemrighttogroup (GroupID,RightID) VALUES (3,112)
/
DELETE FROM SystemRightRoles WHERE RightID = 112 and RoleID = 4
/
INSERT INTO SystemRightRoles (RightID,RoleID,RoleLevel) VALUES (112,4,2)
/
