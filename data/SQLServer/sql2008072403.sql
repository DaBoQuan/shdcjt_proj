alter  PROCEDURE workflow_requestbase_MyRequest 
@userid		int, 
@usertype	int, 
@flag integer output ,
@msg varchar(80) output  
as  


select count(distinct t1.requestid) typecount,t2.workflowtype ,t1.workflowid,t1.currentnodetype
from workflow_requestbase t1, workflow_base t2 
where t1.creater = @userid and t1.creatertype=@usertype 
and t1.workflowid=t2.id  and t2.isvalid='1' and exists (select 1 from workflow_currentoperator where workflow_currentoperator.requestid=t1.requestid) group by t2.workflowtype,t1.workflowid,t1.currentnodetype

go