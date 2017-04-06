create table workflow_function_manage (
workflowid int ,
typeview    char(1) ,
dataview   char(1),
automatism char(1),
manual char(1),
transmit char(1),
retract char(1),
pigeonhole char(1),
operatortype int
)
GO

INSERT INTO HtmlLabelIndex values(18357,'�Զ��߰�') 
GO
INSERT INTO HtmlLabelIndex values(18359,'ǿ���ջ�') 
GO
INSERT INTO HtmlLabelIndex values(18360,'ǿ�ƹ鵵') 
GO
INSERT INTO HtmlLabelIndex values(18358,'�ֶ��߰�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18357,'�Զ��߰�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18357,'automatism urgency',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18358,'�ֶ��߰�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18358,'manual',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18359,'ǿ���ջ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18359,'compellent retract',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18360,'ǿ�ƹ鵵',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18360,'compellent over',8) 
GO
INSERT INTO HtmlLabelIndex values(18361,'���ܹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(18361,'���ܹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18361,'function manage',8) 
GO

INSERT INTO HtmlLabelIndex values(18365,'�鿴ǰ�ջ�') 
GO
INSERT INTO HtmlLabelIndex values(18364,'�����ջ�') 
GO
INSERT INTO HtmlLabelIndex values(18366,'�鿴���ջ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18364,'�����ջ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18364,'cann''t draw back',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18365,'�鿴ǰ�ջ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18365,'draw back before view',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(18366,'�鿴���ջ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18366,'draw back after viewing',8) 
GO
INSERT INTO HtmlLabelIndex values(18095,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18095,'����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18095,'OPEN',8) 
GO

ALTER PROCEDURE workflow_requeststatus_Select
@userid		int, 
@requestid	int, 
@workflowid	int, 
@flag 		integer 	output , 
@msg 		varchar(80) 	output 
AS
declare @mcount int 
declare @viewnodeidstmp varchar(1000)
declare @viewnodeids varchar(5000)
declare @c1 cursor

select @mcount=count(*) from workflow_monitor_bound where monitorhrmid=@userid and workflowid=@workflowid

if @mcount>0 begin 
	select a.nodeid,b.nodename,a.userid,a.isremark,a.usertype,a.agentorbyagentid,
	a.agenttype,a.receivedate,a.receivetime,a.operatedate,a.operatetime
	from (SELECT distinct requestid
      ,userid
      ,workflowid
      ,workflowtype
      ,isremark
      ,usertype
      ,nodeid
      ,agentorbyagentid
      ,agenttype
     
      ,receivedate
      ,receivetime
      ,viewtype
      ,orderdate
      ,ordertime
      ,iscomplete
 
      ,operatedate
      ,operatetime
  FROM workflow_currentoperator  where requestid=@requestid) a,workflow_nodebase b
	where a.nodeid=b.id
	and requestid=@requestid and a.agenttype<>1
	order by a.receivedate,a.receivetime

end else begin
	
	set @viewnodeids=''
	SET @c1 = CURSOR FORWARD_ONLY STATIC FOR
	select b.viewnodeids 
	from (SELECT distinct requestid
      ,userid
      ,workflowid
      ,workflowtype
      ,isremark
      ,usertype
      ,nodeid
      ,agentorbyagentid
      ,agenttype
     
      ,receivedate
      ,receivetime
      ,viewtype
      ,orderdate
      ,ordertime
      ,iscomplete
 
      ,operatedate
      ,operatetime
  FROM workflow_currentoperator  where requestid=@requestid) a,workflow_flownode b
	where a.workflowid=b.workflowid and a.nodeid=b.nodeid
	and a.requestid=@requestid and a.userid=@userid and a.usertype=0
	OPEN @c1
	FETCH NEXT FROM @c1 INTO @viewnodeidstmp
	WHILE @@FETCH_STATUS = 0 
	begin 
		if @viewnodeidstmp='-1' begin 
			set @viewnodeids='-1'
			break
		end else begin
			set @viewnodeids=@viewnodeids+@viewnodeidstmp
		end
		FETCH NEXT FROM @c1 INTO @viewnodeidstmp
	end 


	if(@viewnodeids='-1') begin
		select a.nodeid,b.nodename,a.userid,a.isremark,a.usertype,a.agentorbyagentid,
		a.agenttype,a.receivedate,a.receivetime,a.operatedate,a.operatetime
		from (SELECT distinct requestid
      ,userid
      ,workflowid
      ,workflowtype
      ,isremark
      ,usertype
      ,nodeid
      ,agentorbyagentid
      ,agenttype
     
      ,receivedate
      ,receivetime
      ,viewtype
      ,orderdate
      ,ordertime
      ,iscomplete
 
      ,operatedate
      ,operatetime
  FROM workflow_currentoperator  where requestid=@requestid) a,workflow_nodebase b
		where a.nodeid=b.id
		and requestid=@requestid and a.agenttype<>1
		order by a.receivedate,a.receivetime
	end else begin
		set @viewnodeids=rtrim(ltrim(@viewnodeids))
		set @viewnodeids=substring(@viewnodeids,1,len(@viewnodeids)-1)
		select a.nodeid,b.nodename,a.userid,a.isremark,a.usertype,a.agentorbyagentid,
		a.agenttype,a.receivedate,a.receivetime,a.operatedate,a.operatetime
		from (SELECT distinct requestid
      ,userid
      ,workflowid
      ,workflowtype
      ,isremark
      ,usertype
      ,nodeid
      ,agentorbyagentid
      ,agenttype
     
      ,receivedate
      ,receivetime
      ,viewtype
      ,orderdate
      ,ordertime
      ,iscomplete
 
      ,operatedate
      ,operatetime
  FROM workflow_currentoperator  where requestid=@requestid) a,workflow_nodebase b
		where a.nodeid=b.id
		and requestid=@requestid and a.nodeid in(@viewnodeids) and a.agenttype<>1
		order by a.receivedate,a.receivetime
	end
end
GO


