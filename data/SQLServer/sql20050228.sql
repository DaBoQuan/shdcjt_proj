INSERT INTO HtmlLabelIndex values(17598,'�����ύ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17598,'�����ύ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17598,'Multi Submit',8) 
GO
INSERT INTO HtmlLabelIndex values(17601,'�Ƿ������ύ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17601,'�Ƿ������ύ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17601,'is Multi Submit',8) 
GO

/*�޸�workflow_base��ṹ����¼�Ƿ��ܹ������ύ*/
ALTER TABLE workflow_base
ADD multiSubmit int NULL
GO