/*td:872 �����ʲ����ʲ�����Ͳ�ѯ�ʲ�ҳ�棬�޼���״̬*/
UPDATE HtmlLabelIndex SET indexdesc = '��������' WHERE id = 1406
GO
UPDATE HtmlLabelInfo SET labelname = '��������' WHERE indexid = 1406 AND languageid = 7
GO

UPDATE HtmlLabelIndex SET indexdesc = '����' WHERE id = 1385
GO
UPDATE HtmlLabelInfo SET labelname = '����' WHERE indexid = 1385 AND languageid = 7
GO

DROP TABLE CptCapitalState

CREATE TABLE [CptCapitalState] (
[id] [int] NOT NULL,
[name] [varchar] (60) NULL,
[description] [varchar] (200) NULL,
[issystem] [char] (1) NULL,
PRIMARY KEY([id])
)
GO

INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-7, '����', '������ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-6, '�ƽ�', '�ƽ����ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-5, '����', '�������ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-4, '����', '������ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-3, '����', '������ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-2, '�̿�', '�̿����ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (-1, '��Ӯ', '��Ӯ���ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (0, '�黹', '�黹���ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (1, '���', '�����ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (2, 'ʹ��', 'ʹ�õ��ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (3, '����', '���õ��ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (4, 'ά��', 'ά�޵��ʲ�', '1')
GO
INSERT INTO CptCapitalState (id, name, description, issystem) VALUES (5, '����', '���ϵ��ʲ�', '1')
GO