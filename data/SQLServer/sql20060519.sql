
alter table workflow_currentoperator add wfreminduser varchar(200)
GO

alter table workflow_currentoperator add wfusertypes varchar(100)
GO

INSERT INTO HtmlLabelIndex values(19046,'û���ҵ������ˣ��޷����������ڵ㣡') 
GO
INSERT INTO HtmlLabelInfo VALUES(19046,'û���ҵ������ˣ��޷����������ڵ㣡',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19046,'no next operator,can not move the node!',8) 
GO


alter table workflow_currentoperator add preisremark char(1)
GO

alter PROCEDURE workflow_CurrentOperator_I(
@requestid  int, @userid int, @groupid   int, @workflowid    int,
@workflowtype  int, @usertype  int, @isremark  char(1),
@nodeid  int,@agentorbyagentid  int,@agenttype  char(1),@showorder int, @groupdetailid int,
@flag integer output , @msg varchar(80) output)
AS
declare @workflowtype1 integer,
	@receivedate char(10),
    @receivetime char(8)

set @receivedate=convert(char(10),getdate(),20)
set @receivetime=convert(char(8),getdate(),108)

update workflow_currentoperator set islasttimes=0 where requestid=@requestid and userid=@userid and usertype = @usertype

if @workflowtype = ''
   begin
        select @workflowtype1 = workflowtype from workflow_base where id = @workflowid
        insert into workflow_currentoperator(requestid,userid,groupid, workflowid,workflowtype,usertype,isremark,nodeid,agentorbyagentid,agenttype,showorder,receivedate,receivetime,viewtype
	                            
					     ,iscomplete,islasttimes,groupdetailid,preisremark)
        values
       (@requestid,@userid,@groupid, @workflowid,@workflowtype1,@usertype,@isremark,@nodeid,@agentorbyagentid,@agenttype,@showorder,@receivedate,@receivetime,0

       ,0,1,@groupdetailid,@isremark)
   end
else
  begin
       insert into workflow_currentoperator(requestid,userid,groupid, workflowid,workflowtype,usertype,isremark,nodeid,agentorbyagentid,agenttype,showorder,receivedate,receivetime,viewtype
     
       ,iscomplete,islasttimes,groupdetailid,preisremark)
       values
       (@requestid,@userid,@groupid, @workflowid,@workflowtype,@usertype,@isremark,@nodeid,@agentorbyagentid,@agenttype,@showorder,@receivedate,@receivetime,0

       ,0,1,@groupdetailid,@isremark)
 end
 
go


