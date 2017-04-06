INSERT INTO HtmlLabelIndex values(17616,'�����ϴ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(17616,'�����ϴ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17616,'accessory upload',8) 
GO

/*�޸�workflow_base��ṹ����¼�����ϴ�Ŀ¼id*/
ALTER TABLE workflow_base
ADD docCategory text NULL 
GO

/*�޸�workflow_base��ṹ����¼�����ϴ�Ŀ¼����*/
ALTER TABLE workflow_base
ADD docPath varchar(100) NULL
GO

/*��ѯ�������Ƿ����"�����ϴ�"�ֶ�*/
CREATE PROCEDURE workflow_field6_SByWfid 
(@workflowid 	int, @flag integer output, @msg varchar(80) output) AS 
select c.fieldname
from workflow_base a, workflow_formfield b, workflow_formdict c
where a.formid=b.formid and a.isbill=0
and b.fieldid=c.id and c.fieldhtmltype=6
and a.id=@workflowid
GO

