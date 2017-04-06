INSERT INTO HtmlLabelIndex values(19334,'���ı�') 
GO
INSERT INTO HtmlLabelIndex values(19335,'ά������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19334,'���ı�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19334,'Document Form',8) 
GO
INSERT INTO HtmlLabelInfo VALUES(19335,'ά������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19335,'Edit Document',8) 
GO

CREATE TABLE workflow_docshow(
	flowId int NULL,
	selectItemId int NULL,
	secCategoryID varchar(500),
	modulId int NULL,
	fieldId int NULL
) 

GO

CREATE TABLE workflow_createdoc(
	id int IDENTITY(1,1) NOT NULL,
	workflowId int NULL,
	status char(1)  NULL,
	flowCodeField int NULL,
	flowDocField int NULL,
	flowDocCatField int NULL,
	defaultView varchar(500) NULL
) 

GO

INSERT INTO HtmlLabelIndex values(19331,'���̴����ĵ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19331,'���̴����ĵ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19331,'Create Document through WorkFlow',8) 
GO

INSERT INTO HtmlLabelIndex values(19332,'�߼�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19332,'�߼�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19332,'Advanced Config',8) 
GO

INSERT INTO HtmlLabelIndex values(19337,'�ĵ���������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19337,'�ĵ���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19337,'Document Basic Attribute',8) 
GO

INSERT INTO HtmlLabelIndex values(19338,'���̱����ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19338,'���̱����ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19338,'Work Flow Coding Field',8) 
GO

INSERT INTO HtmlLabelIndex values(19339,'�����ĵ��ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19339,'�����ĵ��ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19339,'Create Document Field',8) 
GO

INSERT INTO HtmlLabelIndex values(19340,'Ĭ����ʾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19340,'Ĭ����ʾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19340,'Default Display Attribute',8) 
GO

INSERT INTO HtmlLabelIndex values(19341,'ѡ����ʾ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19341,'ѡ����ʾ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19341,'Choose Display Attribute',8) 
GO

INSERT INTO HtmlLabelIndex values(19342,'��ϸ����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19342,'��ϸ����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19342,'Particular Config',8) 
GO

INSERT INTO HtmlLabelIndex values(19360,'����Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(19360,'����Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19360,'Associate Calatog',8) 
GO

INSERT INTO HtmlLabelIndex values(19367,'�����ĵ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(19367,'�����ĵ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19367,'Create Document Attribute',8) 
GO

INSERT INTO HtmlLabelIndex values(19368,'�ĵ�����Ŀ¼') 
GO
INSERT INTO HtmlLabelInfo VALUES(19368,'�ĵ�����Ŀ¼',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19368,'Document Catalog',8) 
GO

INSERT INTO HtmlLabelIndex values(19369,'�ĵ���ʾģ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19369,'�ĵ���ʾģ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19369,'Document Display Template',8) 
GO

INSERT INTO HtmlLabelIndex values(19370,'�ĵ���������') 
GO
INSERT INTO HtmlLabelInfo VALUES(19370,'�ĵ���������',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19370,'Document Parameter Config',8) 
GO

INSERT INTO HtmlLabelIndex values(19371,'��ʾģ���ǩ') 
GO
INSERT INTO HtmlLabelInfo VALUES(19371,'��ʾģ���ǩ',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19371,'Display Template Label',8) 
GO

INSERT INTO HtmlLabelIndex values(19372,'�����ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(19372,'�����ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19372,'Work Flow Field',8) 
GO

INSERT INTO HtmlLabelIndex values(19373,'Ŀ¼δѡ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(19373,'Ŀ¼δѡ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(19373,'No Choosing Folder',8) 
GO
