update CptCapitalState set name='����',description='���õ��ʲ�' where id=2
GO
delete from HtmlLabelIndex where id=19665
go
delete from HtmlLabelInfo where indexid=19665
go
INSERT INTO HtmlLabelIndex values(19665,'Interface Setting')
go
INSERT INTO HtmlLabelInfo VALUES(19665,'�ӿ�����',7)
go
INSERT INTO HtmlLabelInfo VALUES(19665,'Interface Setting',8)
go