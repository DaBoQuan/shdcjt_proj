
INSERT INTO HtmlLabelIndex values(19677,'��ʾ����״̬') 
GO
INSERT INTO HtmlLabelIndex values(19678,'��������״̬') 
GO
INSERT INTO HtmlLabelIndex values(19676,'��������ͼ') 
GO
INSERT INTO HtmlLabelIndex values(19675,'��ʾ����ͼ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19675,'��ʾ����ͼ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19675,'Show Workflow Chart',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19676,'��������ͼ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19676,'Hide Workflow Chart',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19677,'��ʾ����״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19677,'Show Workflow Status',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19678,'��������״̬',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19678,'Hide Workflow Status',8) 
GO

update HtmlLabelInfo set  labelName='Workflow Status' where indexid=19061 and languageid=8
GO