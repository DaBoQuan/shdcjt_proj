INSERT INTO HtmlLabelIndex values(19314,'�ʲ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19314,'�ʲ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19314,'capital auto loading',8) 
GO
INSERT INTO HtmlLabelIndex values(19316,'���������ڴ����ʲ����룬���Ե�...') 
GO
INSERT INTO HtmlLabelIndex values(19317,'�ʲ�����ɹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19316,'���������ڴ����ʲ����룬���Ե�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19316,'capital loading,please wait...',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19317,'�ʲ�����ɹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19317,'capital load success!',8) 
GO
INSERT INTO HtmlLabelIndex values(19320,'�ʲ����ϵ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19320,'�ʲ����ϵ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19320,'capital type load',8) 
GO
INSERT INTO HtmlLabelIndex values(19322,'�ʲ����ϱ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19322,'�ʲ����ϱ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19322,'capital type no',8) 
GO
INSERT INTO HtmlLabelIndex values(19326,'�ʲ����ϵ���ɹ���') 
GO
INSERT INTO HtmlLabelInfo VALUES(19326,'�ʲ����ϵ���ɹ���',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19326,'capital type load success!',8) 
GO

INSERT INTO HtmlLabelIndex values(19364,'���������ڴ����ʲ����ϵ��룬���Ե�...') 
GO
INSERT INTO HtmlLabelInfo VALUES(19364,'���������ڴ����ʲ����ϵ��룬���Ե�...',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19364,'capital type loading,please wait...',8) 
GO

INSERT INTO HtmlLabelIndex values(17342,'��ⵥ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(17342,'��ⵥ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(17342,'',8) 
GO


EXECUTE MMConfig_U_ByInfoInsert 8,4
GO
EXECUTE MMInfo_Insert 511,19320,'�ʲ����ϵ���','/cpt/capital/CapitalExcelToDB.jsp','mainFrame',8,1,4,0,'',1,'Capital:Maintenance',0,'','',0,'','',7
GO

ALTER table cptcapital ALTER COLUMN capitalnum DECIMAL(18,1)
GO

