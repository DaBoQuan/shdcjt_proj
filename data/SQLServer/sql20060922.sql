INSERT INTO HtmlLabelIndex values(19747,'��ȷ�Ϲرմ�Ԫ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19747,'��ȷ�Ϲرմ�Ԫ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19747,'The element isn''t reconver after it deleted,are you sure?',8) 
GO

update HtmlLabelIndex set indexdesc='����/չ��' where id=19652
GO

update HtmlLabelInfo set labelname='����/չ��' where indexid=19652 and languageid=7
GO

update HtmlLabelInfo set labelname='Collapse/Expand' where indexid=19652 and languageid=8
GO
