INSERT INTO HtmlLabelIndex values(17995,'�Ƿ��ʼ�����')
GO
INSERT INTO HtmlLabelInfo VALUES(17995,'�Ƿ��ʼ�����',7)
GO
INSERT INTO HtmlLabelInfo VALUES(17995,'mail reminding or not',8)
GO


ALTER TABLE workflow_base ADD mailMessageType int
GO
update workflow_base set mailMessageType = 0
GO