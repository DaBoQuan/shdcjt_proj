INSERT INTO HtmlLabelIndex values(17606,'�Ƿ�Ĭ��˵��') 
/
INSERT INTO HtmlLabelInfo VALUES(17606,'�Ƿ�Ĭ��˵��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17606,'is Default Name',8) 
/

/*�޸�workflow_base��ṹ����¼�Ƿ�����Ĭ��˵��*/
ALTER TABLE workflow_base ADD defaultName integer NULL
/
UPDATE workflow_base SET defaultName=1
/