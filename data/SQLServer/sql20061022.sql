update HtmlLabelIndex set indexDesc='�ұ����' where id=19124
GO

update HtmlLabelInfo  set labelName='�ұ����' where indexId=19124 and languageId=7
GO

update HtmlLabelInfo  set labelName='Room Code' where indexId=19124 and languageId=8
GO

update HtmlLabelIndex set indexDesc='��ֹ����' where id=19128
GO

update HtmlLabelInfo  set labelName='��ֹ����' where indexId=19128 and languageId=7
GO

update HtmlLabelInfo  set labelName='BeginEnd Archival Code' where indexId=19128 and languageId=8
GO

INSERT INTO HtmlLabelIndex values(19933,'��������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19933,'��������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19933,'Borrow Date',8) 
GO

INSERT INTO HtmlLabelIndex values(19942,'������ѯ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19942,'������ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19942,'For Reference Inquiry',8) 
GO

INSERT INTO HtmlLabelIndex values(19963,'���ĵ�Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(19963,'���ĵ�Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19963,'By Catalog',8) 
GO


delete from HtmlLabelIndex  where id=19689
GO

delete from HtmlLabelInfo   where indexId=19689
GO

INSERT INTO HtmlLabelIndex values(19689,'����ѡ������ļ�¼��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19689,'����ѡ������ļ�¼��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19689,'Please choose the operated record first!',8) 
GO
delete from HtmlLabelIndex where id=18412
GO
delete from HtmlLabelInfo where indexId=18412
GO
INSERT INTO HtmlLabelIndex values(18412,'��ϲ�ѯ') 
GO
INSERT INTO HtmlLabelInfo VALUES(18412,'��ϲ�ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18412,'Condition Search',8) 
GO