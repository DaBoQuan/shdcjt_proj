INSERT INTO HtmlLabelIndex values(17995,'�Ƿ��ʼ�����')
/
INSERT INTO HtmlLabelInfo VALUES(17995,'�Ƿ��ʼ�����',7)
/
INSERT INTO HtmlLabelInfo VALUES(17995,'mail reminding or not',8)
/


ALTER TABLE workflow_base ADD mailMessageType integer
/
update workflow_base set mailMessageType = 0
/