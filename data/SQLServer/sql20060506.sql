INSERT INTO HtmlLabelIndex values(18880,'ǩ������ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18880,'ǩ������ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18880,'Opinion Field',8) 
GO

INSERT INTO HtmlLabelIndex values(18882,'��ǩ(Ӣ��)') 
GO
INSERT INTO HtmlLabelInfo VALUES(18882,'��ǩ(Ӣ��)',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18882,'Label_EN',8) 
GO
INSERT INTO HtmlLabelIndex values(18881,'��ǩ(����)') 
GO
INSERT INTO HtmlLabelInfo VALUES(18881,'��ǩ(����)',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18881,'Label_CN',8) 
GO

INSERT INTO HtmlLabelIndex values(18887,'�ڵ���ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18887,'�ڵ���ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18887,'node form field',8) 
GO

INSERT INTO HtmlLabelIndex values(18888,'�ڵ�ǩ������ֶ�') 
GO
INSERT INTO HtmlLabelInfo VALUES(18888,'�ڵ�ǩ������ֶ�',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18888,'Node Opinion Field',8) 
GO


INSERT INTO HtmlLabelIndex values(18895,'ǩ������ֶ�����') 
GO
INSERT INTO HtmlLabelInfo VALUES(18895,'ǩ������ֶ�����',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18895,'Opinion Field Name',8) 
GO

INSERT INTO HtmlLabelIndex values(18896,'�Ƿ��ʹ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18896,'�Ƿ��ʹ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18896,'isUse',8) 
GO

INSERT INTO HtmlLabelIndex values(18897,'�Ƿ���鿴Ȩ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18897,'�Ƿ���鿴Ȩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18897,'isView',8) 
GO

INSERT INTO HtmlLabelIndex values(18898,'�Ƿ���༭Ȩ��') 
GO
INSERT INTO HtmlLabelInfo VALUES(18898,'�Ƿ���༭Ȩ��',7) 
GO
INSERT INTO HtmlLabelInfo VALUES(18898,'isEdit',8) 
GO

insert into SequenceIndex (indexdesc,currentid) values ('wfopinionfieldid',0)
GO

CREATE TABLE WFOpinionField
(
	id int not null,
	workflowid int not null,
	label_cn varchar(40) null,
	label_en varchar(40) null,
	type_cn int null,
	orderid int null
)
GO

CREATE TABLE WFOpinionNodeField
(
	workflowid int not null,
	nodeid int null,
	isUse int null,
	isMust int null,
	isView int null,
	isEdit int null,
	fieldid int null
)
GO