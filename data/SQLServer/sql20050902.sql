alter PROCEDURE workflow_CurrentOperator_I
@requestid  int, @userid int, @groupid   int, @workflowid    int,
@workflowtype  int, @usertype  int, @isremark  char(1),
@nodeid  int,@agentorbyagentid  int,@agenttype  char(1),@showorder int,
@flag integer output , @msg varchar(80) output
AS
declare @workflowtype1 integer
if @workflowtype = ''
   begin
        select @workflowtype1 = workflowtype from workflow_base where id = @workflowid
        insert into workflow_currentoperator(requestid,userid,groupid, workflowid,workflowtype,usertype,isremark,nodeid,agentorbyagentid,agenttype,showorder)
        values
       (@requestid,@userid,@groupid, @workflowid,@workflowtype1,@usertype,@isremark,@nodeid,@agentorbyagentid,@agenttype,@showorder)
   end
else
  begin
       insert into workflow_currentoperator(requestid,userid,groupid, workflowid,workflowtype,usertype,isremark,nodeid,agentorbyagentid,agenttype,showorder)
       values
       (@requestid,@userid,@groupid, @workflowid,@workflowtype,@usertype,@isremark,@nodeid,@agentorbyagentid,@agenttype,@showorder)
 end
 
go
 
/*����ɾ������ԭ���û�ɾ��������*/
delete workflow_currentoperator where requestid in (select requestid from workflow_requestbase where deleted=1) 
GO
delete workflow_form where requestid in (select requestid from workflow_requestbase where deleted=1) 
GO
delete workflow_requestLog where requestid in (select requestid from workflow_requestbase where deleted=1 ) 
GO
delete workflow_requestViewLog where id in (select requestid from workflow_requestbase where deleted=1) 
GO
delete workflow_requestbase where deleted=1
GO



/*������鵵�Ĳ�����״̬����Ϊ4������������ܲ鿴�������ǹ浵��,��ʷ�����˵�isremark='2'��¼����*/
update  workflow_currentoperator  set isremark='4'  
where  requestid in (select requestid  from workflow_requestbase where currentnodetype = '3' )
and isremark='0'
GO

/*ɾ������workflow_currentoperator���е���workflow_requestbase��û�е�requestid����ת��Ϊoracleʱ������*/
delete workflow_currentoperator where requestid in (select t2.requestid
from  workflow_requestbase t1 right join workflow_currentoperator t2 on t1.requestid=t2.requestid
where t1.requestid is null)
GO

create PROCEDURE UpdateWFOperator
as
declare @workflowid_1 int, @workflowtype_1 int

declare all_cursor cursor for 
(select id, workflowtype  from workflow_base)
open all_cursor 
fetch next from all_cursor into @workflowid_1 , @workflowtype_1
while @@fetch_status=0 
begin     
    
    update workflow_currentoperator set workflowtype = @workflowtype_1 where workflowid = @workflowid_1 and workflowtype != @workflowtype_1  

    fetch next from all_cursor into  @workflowid_1 , @workflowtype_1
end 
close all_cursor 
deallocate all_cursor 
GO

exec UpdateWFOperator
go

drop PROCEDURE UpdateWFOperator
go
 