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

