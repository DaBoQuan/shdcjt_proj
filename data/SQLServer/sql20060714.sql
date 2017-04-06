INSERT INTO HtmlLabelIndex values(19394,'����������ϸ') 
GO
INSERT INTO HtmlLabelIndex values(19395,'�����޸�������ϸ') 
GO
INSERT INTO HtmlLabelIndex values(19396,'����ɾ��������ϸ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19394,'����������ϸ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19394,'can add new row',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19395,'�����޸�������ϸ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19395,'can edit old row',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19396,'����ɾ��������ϸ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19396,'can delete old row',8) 
GO


CREATE TABLE workflow_NodeFormGroup (
	nodeid int NULL ,
	groupid int NULL ,
	isadd char (1)  NULL ,
	isedit char (1)  NULL ,
	isdelete char (1)  NULL 
) 
GO

insert into workflow_NodeFormGroup 
select distinct b.nodeid,c.groupid,1,1,1
from workflow_base a,workflow_flownode b,workflow_formfield c 
where a.id=b.workflowid and a.formid= c.formid and a.isbill=0 and c.groupid is not null
GO



