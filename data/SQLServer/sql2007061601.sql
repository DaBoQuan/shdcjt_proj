delete from HtmlLabelIndex where id in(20489,20490,20491,20492,20493)
GO
delete from HtmlLabelInfo where indexId in(20489,20490,20491,20492,20493)
GO
INSERT INTO HtmlLabelIndex values(20491,'������ʾ����ѯ��') 
GO
INSERT INTO HtmlLabelIndex values(20489,'�Ƿ��ѯ') 
GO
INSERT INTO HtmlLabelIndex values(20490,'��ѯ˳��') 
GO
INSERT INTO HtmlLabelInfo VALUES(20489,'�Ƿ��ѯ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20489,'Search Or Not',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20490,'��ѯ˳��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20490,'Search Order',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20491,'������ʾ����ѯ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20491,'The Showed Or Searched Item Of The Report',8) 
GO

INSERT INTO HtmlLabelIndex values(20493,'��Ŀ¼������ˮ') 
GO
INSERT INTO HtmlLabelIndex values(20492,'��Ŀ¼������ˮ') 
GO
INSERT INTO HtmlLabelInfo VALUES(20492,'��Ŀ¼������ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20492,'MainCategory Sequence Alone',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(20493,'��Ŀ¼������ˮ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(20493,'SubCategory Sequence Alone',8) 
GO
