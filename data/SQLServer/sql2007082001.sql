delete from HtmlLabelIndex where id in(15126,365,11,91,18214)
GO
delete from HtmlLabelInfo where indexid in(15126,365,119,91,18214)
GO

INSERT INTO HtmlLabelIndex values(15126,'�����Ľ��̫���޷���ʾ! ���ṩ����ȷ�Ĺؼ�������') 
GO
INSERT INTO HtmlLabelInfo VALUES(15126,'�����Ľ��̫���޷���ʾ! ���ṩ����ȷ�Ĺؼ�������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(15126,'Result is too much to list,Pls search again by more precise Keyword',8) 
GO

INSERT INTO HtmlLabelIndex values(365,'�½�') 
GO
INSERT INTO HtmlLabelInfo VALUES(365,'�½�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(365,'New',8) 
GO

INSERT INTO HtmlLabelIndex values(119,'����') 
GO
INSERT INTO HtmlLabelInfo VALUES(119,'Share',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(119,'����',7) 
GO
 
INSERT INTO HtmlLabelIndex values(91,'ɾ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(91,'Delete',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(91,'ɾ��',7) 
GO

INSERT INTO HtmlLabelIndex values(18214,'��ѡ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18214,'��ѡ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18214,'PlEASE CHOOSE',8) 
GO