/*td:872 �����ʲ����ʲ�����Ͳ�ѯ�ʲ�ҳ�棬�޼���״̬*/
UPDATE HtmlLabelIndex SET indexdesc = '��������' WHERE id = 1406
/
UPDATE HtmlLabelInfo SET labelname = '��������' WHERE indexid = 1406 AND languageid = 7
/

UPDATE HtmlLabelIndex SET indexdesc = '����' WHERE id = 1385
/
UPDATE HtmlLabelInfo SET labelname = '����' WHERE indexid = 1385 AND languageid = 7
/

DROP TABLE CptCapitalState
/
CREATE TABLE CptCapitalState (
	id integer NOT NULL ,
	name varchar2 (60)  NULL ,
	description varchar2 (200)  NULL ,
	issystem char (1)  NULL,
    PRIMARY KEY(id)
)
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-7, '����', '������ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-6, '�ƽ�', '�ƽ����ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-5, '����', '�������ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-4, '����', '������ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-3, '����', '������ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-2, '�̿�', '�̿����ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-1, '��Ӯ', '��Ӯ���ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (0, '�黹', '�黹���ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (1, '���', '�����ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (2, 'ʹ��', 'ʹ�õ��ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (3, '����', '���õ��ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (4, 'ά��', 'ά�޵��ʲ�', '1')
/
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (5, '����', '���ϵ��ʲ�', '1')
/
