delete from HtmlLabelIndex where id in(20770,20771,20772)
GO
delete from HtmlLabelInfo where indexId in(20770,20771,20772)
GO
INSERT INTO HtmlLabelIndex values(20770,'�ַ�����') 
GO
INSERT INTO HtmlLabelIndex values(20772,'���ŵ�����ˮ') 
GO
INSERT INTO HtmlLabelIndex values(20771,'�ַ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(20770,'�ַ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20770,'String Six',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20771,'�ַ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20771,'String Seven',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20772,'���ŵ�����ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20772,'Department Sequence Alone',8) 
GO
