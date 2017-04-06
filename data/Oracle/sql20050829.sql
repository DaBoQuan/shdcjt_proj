CREATE GLOBAL TEMPORARY TABLE temp_table
(id integer, 
rolesmark varchar2(60),
rolesname varchar2(200),
temptype integer, 
subcomid integer,
cnt integer null) 
ON COMMIT DELETE ROWS
/
CREATE GLOBAL TEMPORARY TABLE temptree
(num integer,
id integer,
supsubcomid integer)
ON COMMIT DELETE ROWS
/
create sequence temptree_num
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger temptree_tri
before insert on temptree
for each row
begin
select temptree_num.nextval into :new.num from dual;
end;
/
/*����Ȩ����ʱ��,�ó�����Ȩ�޽���*/
CREATE GLOBAL TEMPORARY TABLE temptree1
(id integer,
operateType_Range integer) 
ON COMMIT DELETE ROWS
/
/*����Ȩ����ʱ��,��Ӹ�id�ֶ�*/
CREATE GLOBAL TEMPORARY TABLE temptree2
(id integer,
parent_id integer,
operateType_Range integer) 
ON COMMIT DELETE ROWS
/
/*����Ȩ����ʱ��,��ӽڵ������ֶΣ�nodetype=0����ʾ�ڵ㡢nodetype=1�����ýڵ�*/
CREATE GLOBAL TEMPORARY TABLE temptree3
(id integer,
parent_id integer,
nodetype integer,
operateType_Range integer) 
ON COMMIT DELETE ROWS
/
/*���������ù���Ȩ�޵Ļ�������ʱ��*/
CREATE GLOBAL TEMPORARY TABLE temptree4
(rightid integer,
subcomid integer,
rightlevel integer) 
ON COMMIT DELETE ROWS
/

create table SysRoleSubcomRight (
	id integer  not null ,
	roleid integer not null,
	subcompanyid integer not null,
	rightlevel integer null	
)
/
create sequence SysRoleSubcomRight_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger SRSubRight_Trigger
before insert on SysRoleSubcomRight
for each row
begin
select SysRoleSubcomRight_id.nextval into :new.id from dual;
end;
/


alter table SystemSet add detachable integer
/ 

alter table hrmroles add type integer
/
update hrmroles set type=0 
/
alter table hrmroles add subcompanyid integer
/
update hrmroles set subcompanyid=0 
/

alter table HrmResourceManager add creator integer
/
update HrmResourceManager set creator=1
/

update MainMenuInfo set linkAddress='/hrm/roles/HrmRoles_frm.jsp' where id=353
/

INSERT INTO HtmlLabelIndex values(17861,'�ܷ��Ȩ') 
/
INSERT INTO HtmlLabelInfo VALUES(17861,'�ܷ��Ȩ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17861,'could detach right',8) 
/

INSERT INTO HtmlLabelIndex values(17863,'�Ƿ��Ȩ') 
/
INSERT INTO HtmlLabelIndex values(17862,'Ȩ��ϵͳ����') 
/
INSERT INTO HtmlLabelInfo VALUES(17862,'Ȩ��ϵͳ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17862,'right config',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17863,'�Ƿ��Ȩ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17863,'is detach right',8) 
/

INSERT INTO HtmlLabelIndex values(17864,'����Ȩ��') 
/
INSERT INTO HtmlLabelIndex values(17865,'����Ȩ��') 
/
INSERT INTO HtmlLabelInfo VALUES(17864,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17864,'function right',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17865,'����Ȩ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17865,'structure right',8) 
/

INSERT INTO HtmlLabelIndex values(17866,'��Ȩ��ɫ') 
/
INSERT INTO HtmlLabelIndex values(17867,'��Ȩ��ɫ') 
/
INSERT INTO HtmlLabelInfo VALUES(17866,'��Ȩ��ɫ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17866,'config right role',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17867,'��Ȩ��ɫ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17867,'detach right role',8) 
/

INSERT INTO HtmlLabelIndex values(17868,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17868,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17868,'belong structure',8) 
/

INSERT INTO HtmlLabelIndex values(17871,'������') 
/
INSERT INTO HtmlLabelIndex values(17872,'��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17871,'������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17871,'structure tree',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17872,'��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17872,'operate level',8) 
/

INSERT INTO HtmlLabelIndex values(17873,'ֻ��') 
/
INSERT INTO HtmlLabelIndex values(17875,'��ֹ') 
/
INSERT INTO HtmlLabelIndex values(17874,'��ȫ����') 
/
INSERT INTO HtmlLabelInfo VALUES(17873,'ֻ��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17873,'read only',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17874,'��ȫ����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17874,'control all',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17875,'��ֹ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17875,'forbid',8) 
/

INSERT INTO HtmlLabelIndex values(17876,'�¼�����') 
/
INSERT INTO HtmlLabelInfo VALUES(17876,'�¼�����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17876,'child synchronization',8) 
/

INSERT INTO HtmlLabelIndex values(17888,'����Ա����') 
/
INSERT INTO HtmlLabelInfo VALUES(17888,'����Ա����',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17888,'admin name',8) 
/

CREATE type obj_tree as object (id integer,supsubcomid integer)
/
CREATE type tab_tree as table of obj_tree
/
CREATE OR REPLACE FUNCTION getSubComParentTree 
(subcom_id integer)
RETURN tab_tree
AS
parent_id integer;

tab_tree_1 tab_tree := tab_tree();
BEGIN 
	select  supsubcomid into parent_id from hrmsubcompany where id=subcom_id;
	while parent_id!=0 loop
		insert into temptree(id,supsubcomid) (select id,supsubcomid from hrmsubcompany where id=parent_id);
		select supsubcomid into parent_id from (select supsubcomid from temptree order by num desc) WHERE rownum =1;
	end loop;
	select obj_tree(id,supsubcomid) bulk collect into tab_tree_1 from temptree order by num desc;
	return tab_tree_1;
END;
/
CREATE or replace  procedure HrmRoleSR_SByURCId
(userid integer,
rightstr varchar2,
subcompanyid integer,
flag out integer,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor)
AS
begin
	open thecursor for
	select min(rightlevel) as rightlevel
	from SysRoleSubcomRight 
	where roleid in(select a.roleid 
			from HrmRoleMembers a,SystemRightRoles b
			where a.roleid=b.roleid and a.resourceid=userid 
			and b.rightid =(select rightid from SystemRightDetail where rightdetail=rightstr)
			)and subcompanyid=subcompanyid	group by subcompanyid;
end;
/


CREATE or replace procedure HrmRoleSR_SeByURId
	(userid integer,
	rightstr varchar2,
	flag out integer,
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
AS
begin
    open thecursor for
	select subcompanyid,min(rightlevel) as rightlevel
	from SysRoleSubcomRight 
	where roleid in(select a.roleid 
			from HrmRoleMembers a,SystemRightRoles b
			where a.roleid=b.roleid and a.resourceid=userid 
			and b.rightid =(select rightid from SystemRightDetail where rightdetail=rightstr)
			)group by subcompanyid;
end;
/

CREATE or replace PROCEDURE hrmroles_selBynameSubcom
	(rolesname_2 varchar2,
	subcomid_2 integer,
	flag out integer,
    msg out varchar2,
    thecursor IN OUT cursor_define.weavercursor)
as
 id_1 integer;
 rolesmark_1 varchar2(60);
 rolesname_1 varchar2(200);
 temptype_1 integer;
 subcomid_1 integer;
 cnt_1 integer;
 id_2 integer;
CURSOR all_cursor is select id,rolesmark,rolesname,type,subcompanyid from hrmroles ;
CURSOR roles_cursor is select id from hrmroles;
begin 
	open all_cursor;
		loop
			fetch all_cursor INTO id_1,rolesmark_1,rolesname_1,temptype_1,subcomid_1; 	
			exit when all_cursor%NOTFOUND;	
			insert into temp_table(id,rolesmark,rolesname,temptype,subcomid) values (id_1,rolesmark_1,rolesname_1,temptype_1,subcomid_1);
		end loop;

	open roles_cursor;
		loop
			fetch roles_cursor INTO id_2;
			exit when roles_cursor%NOTFOUND;
			select count(id) into cnt_1 from HrmRoleMembers where roleid = id_2; 
			update  temp_table set cnt = cnt_1 where id = id_2;
		end loop;
	
	if rolesname_2 <>'!#$' 
		then
			open thecursor for
			select id,rolesmark,rolesname,temptype,subcomid,cnt from temp_table where rolesname like concat(concat('%',rolesname_2),'%') and subcomid=subcomid_1 order by rolesname;
		else
			open thecursor for
			select id,rolesmark,rolesname,temptype,subcomid,cnt from temp_table where subcomid=subcomid_1 order by rolesname;
	end if;
	close all_cursor ;
	close roles_cursor ;
end;
/

CREATE or REPLACE PROCEDURE HrmRoleStrRight_Sel
(roleid_1 integer, 
flag out integer ,
msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )
as
begin
open thecursor for
select * from SysRoleSubcomRight where roleid=roleid_1;
end;
/

/*
  ����������洢����
  ���룺userid ��ǰ�û���roleid ��ǰ��ɫ
  �������ǰ��ɫ���û���Ȩ��ʱ�Ļ�����Χ
*/
create or replace  procedure RoleStrTree_SByURId (
	userid_1 integer,
	roleid_2 integer,
	flag out integer,
	msg out varchar2,
	thecursor IN OUT cursor_define.weavercursor)
AS
 rowcount integer;
 id_1 integer;

begin
/*�鿴��ǰ��ɫ�Ƿ��Ѿ����ù���Ȩ��*/
select count(roleid) into rowcount from SystemRightRoles where roleid=roleid_2;
if rowcount>0 then
	/*�����ǰ��ɫ�Ѿ������˹���Ȩ�ޣ�ȡ�����Щ����Ȩ�޶�Ӧ�Ļ���Ȩ�޺ϼ�����ȡ��Щ����Ȩ�޺ϼ�֮��Ľ�������������ǰ��ɫ*/
	/*��ͬһ����Ȩ��,ȡ����Ȩ�޵����ֵ*/
	insert into temptree4(rightid,subcomid,rightlevel)
	select b.rightid,c.subcompanyid,max(c.rightlevel)
	from HrmRoleMembers a,SystemRightRoles b,SysRoleSubcomRight c
	where a.roleid=b.roleid and a.roleid=c.roleid and a.resourceid=userid_1 
	and b.rightid in(select rightid from SystemRightRoles where roleid=roleid_2)
	and b.roleid<>roleid_2
	group by b.rightid,c.subcompanyid;
	/*�Բ�ͬ����Ȩ��,ȡ����Ȩ�޵���Сֵ*/
	insert into temptree1(id,operateType_Range)
	select subcomid,min(rightlevel)
	from temptree4 
	group by subcomid
	having count(subcomid)=(select count(distinct(rightid)) from temptree4);
else
/*�����ǰ��ɫδ���ù���Ȩ�ޣ����ҵ�ǰ�û�����Ȩ����Ȩ�����н�ɫ�Ļ���Ȩ�޽�������������ǰ��ɫ*/
	/*������ͨ��having count��minʵ�֣�:
		ͨ��having count == �ĶԱȣ�ȥ�����еĽ�ɫ�и���û�еĻ���
		ͨ��min��ȡ���н�ɫ�ж��еĻ�������СȨ��
	*/
	insert into temptree1(id,operateType_Range)
	select subcompanyid,min(rightlevel)
	from SysRoleSubcomRight 
	where roleid in(select roleid from HrmRoleMembers where resourceid=userid_1)
	and roleid<>roleid_2
	group by subcompanyid
	having count(subcompanyid)=(select count(roleid) from HrmRoleMembers where resourceid=userid_1 and roleid<>roleid_2);
end if;

/*��Ӹ�id*/
insert into temptree2(id,parent_id,operateType_Range) select a.id,b.supsubcomid,a.operateType_Range from temptree1 a,hrmsubcompany b where a.id=b.id ;

/*���ݻ����б��в��ڶ����Ľڵ㣬��������ϼ���·��*/
FOR c1 in( 
select id from temptree2 where parent_id<>0 and parent_id not in(select id from temptree2))
loop 
    id_1 := c1.id;
	select count(id) into rowcount from temptree3 where id=(select id from table(cast(getSubComParentTree(id_1) as tab_tree)));
	if rowcount=0 then
	insert into temptree3(id,parent_id,nodetype,operateType_Range) select id,supsubcomid,0,0 from table(cast(getSubComParentTree(id_1) as tab_tree));
	end if;
end loop;

/*��ӱ������¼��ڵ�*/
insert into temptree3(id,parent_id,nodetype,operateType_Range) select id ,parent_id ,1,operateType_Range from temptree2;
open thecursor for
select * from temptree3;
end;
/


CREATE or replace PROCEDURE HrmRoleStrRight_Del
	(roleid_1 integer,
	flag out integer ,
	msg out varchar2,
	thecursor in out cursor_define.weavercursor)
as 
begin 
	delete SysRoleSubcomRight where roleid=roleid_1;
end;
/

CREATE or replace PROCEDURE HrmRoleStrRight_Ins
(roleid_1 integer,
subcompanyid_2 integer,
rightlevel_3 integer,
flag out integer ,
msg out varchar2,
thecursor in out cursor_define.weavercursor)
as 
begin
insert into SysRoleSubcomRight(roleid,subcompanyid,rightlevel) values(roleid_1,subcompanyid_2,rightlevel_3);
end;
/


create or replace PROCEDURE hrmroles_selectallbyname 
(rolesnameq_1 varchar2,
flag out integer ,
msg out varchar2,
thecursor in out cursor_define.weavercursor)
as
 id_1 integer;
 rolesmark_1 varchar2(60);
 rolesname_1 varchar2(200);
 temptype_1 integer;
 id_2 integer;
 cnt_2 integer;
CURSOR all_cursor is select id,rolesmark,rolesname,type from hrmroles ;
CURSOR roles_cursor is select id from hrmroles ;
begin  
	open all_cursor;
		loop
		fetch all_cursor INTO id_1,rolesmark_1,rolesname_1,temptype_1;
		exit when all_cursor%NOTFOUND;	
	 insert into temp_table(id,rolesmark,rolesname,temptype)
	 values (id_1,rolesmark_1,rolesname_1,temptype_1);
	end  loop;
	open roles_cursor;
		loop
			fetch roles_cursor into id_2;
			exit when roles_cursor%NOTFOUND;
			select count(id) into cnt_2 from HrmRoleMembers where roleid=id_2;
			update temp_table set cnt=cnt_2 where id=id_2;
		end loop;
		if rolesnameq_1<>'!@#$' then
		open thecursor for
		select id,rolesmark,rolesname,temptype,cnt from temp_table where rolesname like concat(concat('%',rolesnameq_1),'%') order by rolesname;
		else
		open thecursor for
		select id,rolesmark,rolesname,temptype,cnt from temp_table order by rolesname;
		end if;
	close roles_cursor;
end;
/

CREATE or replace PROCEDURE HrmRoles_insert
(rolesmark_1 varchar2, 
rolesname_1 varchar2, 
docid_1 in out integer,
type_1 integer,
subcompanyid_1 integer,
flag out integer, 
msg out varchar2, 
thecursor IN OUT cursor_define.weavercursor)
as 
begin 
	if docid_1 = 0 then
		docid_1:=null;
	end if;
	insert into HrmRoles(rolesmark,rolesname,docid,type,subcompanyid) values(rolesmark_1,rolesname_1,docid_1,type_1,subcompanyid_1);
	open thecursor for 
	select id from hrmroles where rolesmark=rolesmark_1 and rolesname=rolesname_1 and docid = docid_1 and type=type_1 and subcompanyid=subcompanyid_1;
end;
/

CREATE or REPLACE PROCEDURE hrmroles_update 
 (
 id1 integer,
 rolesmark1 varchar2,
 rolesname1 varchar2, 
 docid1 IN OUT  integer,
 type_1 integer,
 subcompanyid_1 integer,
 flag out integer ,
 msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )
as
begin
if  docid1 = 0  then
 docid1 := null ;
end if;
  update hrmroles set rolesmark=rolesmark1,rolesname=rolesname1,docid=docid1,type=type_1, subcompanyid=subcompanyid_1 where id=id1;
end;
/

 CREATE or REPLACE PROCEDURE hrmroles_selectSingle 
 (
 id1 integer, flag out integer ,
 msg out varchar2,
thecursor IN OUT cursor_define.weavercursor )as

begin 
open thecursor for

select rolesmark,rolesname,docid,type,subcompanyid from hrmroles where id=id1 ;
end;
/