

/* �����Ƕ�Ӧ�� oracle ��� , �������sql �ű���ɾ��*/

CREATE TABLE workflow_formprop (
	formid integer NOT NULL ,
	objid integer NULL ,
	objtype integer NULL ,
	fieldid integer NULL ,
	isdetail integer NULL ,
	ptx integer NULL ,
	pty integer NULL ,
	width integer NULL ,
	height integer NULL ,
	defvalue varchar2 (255)  NULL ,
	attribute1 varchar2 (255)  NULL ,
	attribute2 varchar2 (255)  NULL 
) 
/


INSERT INTO HtmlLabelIndex values(17555,'����Ʒ�ʽ') 
/
INSERT INTO HtmlLabelInfo VALUES(17555,'����Ʒ�ʽ',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17555,'Form Design Way',8) 
/
INSERT INTO HtmlLabelIndex values(17556,'�ı��ͱ������') 
/
INSERT INTO HtmlLabelIndex values(17557,'ͼ�λ��������') 
/
INSERT INTO HtmlLabelInfo VALUES(17556,'�ı��ͱ������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17556,'Text Way',8) 
/
INSERT INTO HtmlLabelInfo VALUES(17557,'ͼ�λ��������',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17557,'Draw Way',8) 
/
INSERT INTO HtmlLabelIndex values(17558,'�������ʹ������') 
/
INSERT INTO HtmlLabelInfo VALUES(17558,'ע�⣺ʹ��ͼ�λ�����������б���ƺ󣬽�������ʹ���ı��ͱ�������Ա����б༭��',7) 
/
INSERT INTO HtmlLabelInfo VALUES(17558,'Notice: You can''t use Text Way to design after Draw Way!',8) 
/
