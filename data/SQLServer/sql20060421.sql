alter PROCEDURE SystemRight_selectRightGroup @flag int output, @msg varchar(80) output as 
declare @id int,@groupname varchar(200),@count int 

create table #temp( id  int, groupname varchar(200), cnt int ) 
select @count=count(*) from SystemRights insert into #temp values(-1,'ȫ��',@count)  

declare right_cursor cursor for 
	select id , rightgroupname from SystemRightGroups where id<>-2 order by id  
	open right_cursor 
	fetch next from right_cursor into @id,@groupname 
	while @@fetch_status=0 begin 
		select @count = count(rightid) from SystemRightToGroup where groupid= @id 
		insert into #temp values(@id,@groupname,@count) 
		fetch next from right_cursor into @id,@groupname 
	end close right_cursor 

select @count=count(distinct a.id) from SystemRights a left join SystemRightToGroup b on a.id=b.rightid where b.rightid is null insert into #temp values(-2,'����Ȩ����',@count)  

deallocate right_cursor  select id,groupname,cnt from #temp

GO

delete from SystemRightToGroup where groupid=(select id from SystemRightGroups where rightgroupmark='OTHADM')
GO

delete from SystemRightGroups where rightgroupmark='OTHADM'
GO

SET IDENTITY_INSERT SystemRightGroups on

insert into SystemRightGroups(id,rightgroupmark,rightgroupname,rightgroupremark)
values (-2,'OTHADM','����Ȩ����','����δ�����Ȩ��')

SET IDENTITY_INSERT SystemRightGroups off
GO

INSERT INTO HtmlLabelIndex values(18871,'�����Ŀ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18871,'�����Ŀ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18871,'Relative Project Task',8) 
GO

