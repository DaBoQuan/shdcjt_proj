/*td:667  by ������ for  ����ϸ�ֶ��½�ҳ���ҳͷ�ǡ��ֶι���:��ӡ��޸�Ϊ�� �½�����ϸ�ֶ� ��*/
delete HtmlLabelInfo   where indexid = 17463
go
delete HtmlLabelIndex   where id = 17463
go
delete HtmlLabelInfo   where indexid = 6074
go
delete HtmlLabelIndex   where id = 6074
go
INSERT INTO HtmlLabelIndex values(6074,'��') 
GO
INSERT INTO HtmlLabelInfo VALUES(6074,'��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(6074,'Main',8) 
GO
INSERT INTO HtmlLabelIndex values(17463,'��ϸ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17463,'��ϸ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17463,'Detail',8) 
GO
/* td:708 �½����߱༭���������Ʋ��ܳ���60���ַ������򷵻�500���������޸�Ϊ�½����߱༭���������ƣ�����������50����ĸ����*/
alter table workflow_base alter column workflowname varchar(100)
go
alter table workflow_base alter column workflowdesc varchar(200)
go

/* td:848 ���пͻ���Ƭ�༭Ȩ�޵��û�������༭�˵�������Ȩ�޵�ҳ��*/
CREATE PROCEDURE CRM_ShareEditToManager(
@crmId int, @managerId int, @flag integer output,@msg varchar(80) output)
AS
IF EXISTS(SELECT id FROM CRM_ShareInfo WHERE relateditemid = @crmId 
AND sharetype = 1 AND userid = @managerId)
UPDATE CRM_ShareInfo SET sharelevel = 2 WHERE relateditemid = @crmId 
AND sharetype = 1 AND userid = @managerId
ELSE 
INSERT INTO CRM_ShareInfo(relateditemid, sharetype, sharelevel, userid) 
VALUES(@crmId, 1, 2, @managerId)
GO
/*td:949 �����������û��������������� */
update workflow_bill set operationpage = 'BillLoanOperation.jsp' where id = 13
GO