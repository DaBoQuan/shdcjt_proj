/*����û��Ȩ�����͵�Ȩ��*/
declare @mcount int
declare @mid int

select @mcount = count(*) from SystemRightGroups where rightgroupmark='OTHADM'
if @mcount=0 begin
	insert into SystemRightGroups(rightgroupmark,rightgroupname,rightgroupremark)
	values ('OTHADM','����Ȩ����','�����ʱδ�����Ȩ��')
end

select @mid = id from SystemRightGroups where rightgroupmark='OTHADM'

insert into SystemRightToGroup(groupid,rightid) 
select @mid,id from SystemRights where id not in(select rightid from SystemRightToGroup)

