INSERT INTO HtmlLabelIndex values(17606,'�Ƿ�Ĭ��˵��') 
GO
INSERT INTO HtmlLabelInfo VALUES(17606,'�Ƿ�Ĭ��˵��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17606,'is Default Name',8) 
GO

/*�޸�workflow_base��ṹ����¼�Ƿ�����Ĭ��˵��*/
ALTER TABLE workflow_base
ADD defaultName int NULL
GO

UPDATE workflow_base
SET defaultName=1
GO