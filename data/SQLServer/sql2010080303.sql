alter PROCEDURE WorkFlowPending_Get 
@sqlStr_1	varchar(4000), 
@flag 		integer 	output, 
@msg 		varchar(80) output 
AS 
exec ('
SELECT TOP 100 PERCENT userid as userid, COUNT(requestid) AS counts
FROM  workflow_currentoperator
WHERE workflowtype > 0  and
isremark IN (''0'', ''1'', ''5'',''8'',''9'',''7'')
AND islasttimes = 1
AND usertype = ''0''
and exists (select 1 from hrmresource where hrmresource.id=workflow_currentoperator.userid and hrmresource.status in (0,1,2,3))
and exists (select 1 from workflow_requestbase where requestid = workflow_currentoperator.requestid and (deleted=0 or deleted is null))
AND EXISTS (SELECT 1 FROM workflow_base WHERE id = workflow_currentoperator.workflowid AND (isvalid = 1))
'+@sqlStr_1+'
GROUP BY userid
ORDER BY COUNT(requestid) desc
') 
go
