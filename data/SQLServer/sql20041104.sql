
CREATE TABLE workflow_formprop (
	formid int NOT NULL ,
	objid int NULL ,
	objtype int NULL ,
	fieldid int NULL ,
	isdetail int NULL ,
	ptx int NULL ,
	pty int NULL ,
	width int NULL ,
	height int NULL ,
	defvalue varchar (255)  NULL ,
	attribute1 varchar (255)  NULL ,
	attribute2 varchar (255)  NULL ,
) 
GO


INSERT INTO HtmlLabelIndex values(17555,'����Ʒ�ʽ') 
GO
INSERT INTO HtmlLabelInfo VALUES(17555,'����Ʒ�ʽ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17555,'Form Design Way',8) 
GO
INSERT INTO HtmlLabelIndex values(17556,'�ı��ͱ������') 
GO
INSERT INTO HtmlLabelIndex values(17557,'ͼ�λ��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17556,'�ı��ͱ������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17556,'Text Way',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(17557,'ͼ�λ��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17557,'Draw Way',8) 
GO
INSERT INTO HtmlLabelIndex values(17558,'�������ʹ������') 
GO
INSERT INTO HtmlLabelInfo VALUES(17558,'ע�⣺ʹ��ͼ�λ�����������б���ƺ󣬽�������ʹ���ı��ͱ�������Ա����б༭��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17558,'Notice: You can''t use Text Way to design after Draw Way!',8) 
GO

